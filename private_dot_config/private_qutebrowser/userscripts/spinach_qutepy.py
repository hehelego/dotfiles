import os
from pprint import pprint
import subprocess
import sys
import tempfile
from typing import Any, Optional, TypeVar


class Qute:

    def __init__(self) -> None:
        self.env = {
            k: v
            for k, v in os.environ.items() if k.startswith('QUTE')
        }
        self.mode = self.get_env('mode')
        self.user_agent = self.get_env('user_agent')
        self.fifo = open(self._ge('fifo'), 'w')
        self.url = self.get_env('url')
        self.title = self.get_env('title')
        self.config_dir = self._ge('config_dir')
        self.data_dir = self._ge('data_dir')
        self.download_dir = self._ge('download_dir')

    def get_env(self, name: str) -> Optional[str]:
        return self.env.get(f'QUTE_{name.upper()}')

    def _ge(self, name: str) -> str:
        return self.env[f'QUTE_{name.upper()}']

    def __del__(self) -> None:
        if self.fifo and not self.fifo.closed:
            self.fifo.close()

    def exec(self, cmd: str) -> bool:
        Helper.log('run command', cmd)
        print(cmd, file=self.fifo)
        return True

    def open_url(self,
                 url: str,
                 new_window: bool = False,
                 new_tab: bool = False) -> bool:
        option = ''
        if new_window:
            option += '-w'
        if new_tab:
            option += '-t'
        return self.exec(f'open {option} {url}')


class Helper:

    @staticmethod
    def log(pre: str, obj: Any):
        print(pre, end=': ', file=sys.stdout)
        pprint(obj, stream=sys.stdout)
        print(f'{pre}: {obj}', file=sys.stderr)

    @staticmethod
    def readfile(path: str) -> str:
        content = None
        with open(path) as f:
            content = f.read()
        return content


class Fzf:
    T_entry = TypeVar('T_entry')
    default_multi = False
    default_prompt = '> '
    default_preview = r'''bat {} \
        --plain \
        --color always \
        --paging never \
        --line-range :500 \
    '''

    @staticmethod
    def fzf_select(src: list[T_entry],
                   multi: bool = default_multi,
                   preview: Optional[str] = default_preview,
                   prompt: str = default_prompt) -> list[T_entry]:

        src_map = {str(i): i for i in src}

        def tmpf():
            return tempfile.NamedTemporaryFile(
                prefix='/tmp/spinach_qutepy.fzf',
                mode='w+',
            )

        input_file = tmpf()
        output_file = tmpf()

        for i in src_map.keys():
            print(i, file=input_file)
        input_file.flush()

        fzf_opts = ['fzf']
        fzf_opts.append('--multi' if multi else '--no-multi')
        fzf_opts.append(f"--preview '{preview}'" if preview else '--no-preview')
        fzf_opts.append(f'--prompt "{prompt}"')

        fzf_cmd = ' '.join(fzf_opts)
        Helper.log('fzf command', fzf_cmd)

        subprocess.run([
            'alacritty', '-e', 'fish', '-c',
            f'cat {input_file.name} | {fzf_cmd} > {output_file.name}'
        ], check=True)

        output_file.seek(0)
        selected = [
            src_map[i] for i in output_file.read().split('\n') if i in src_map
        ]
        Helper.log('selected:', selected)

        output_file.close()
        input_file.close()

        return selected
