from __future__ import annotations
from abc import ABC, abstractmethod
import argparse
from datetime import datetime
from pprint import pprint
import subprocess
import tempfile
from typing import Any, Callable, IO, TypeVar, Optional


class Config:
    logfile_path = '/tmp/spinach_fzfmenu.py.log'


class Helper:

    @staticmethod
    def log_file() -> IO[str]:
        return open(Config.logfile_path, 'a')

    @staticmethod
    def log(pre: str, msg: Any) -> None:
        with Helper.log_file() as f:
            print(pre, file=f, end=':\n')
            pprint(msg, stream=f)
            print('', file=f)

    @staticmethod
    def info(summary: str, message: Any) -> None:
        ts = datetime.now().strftime('%H:%M:%S')
        Helper.log(f'INFO(ts={ts}): {summary}', message)

    @staticmethod
    def err(summary: str, message: Any) -> None:
        ts = datetime.now().strftime('%H:%M:%S')
        Helper.log(f'ERROR(ts={ts}): {summary}', message)

    @staticmethod
    def readfile(path: str) -> str:
        with open(path) as f:
            return f.read()

    @staticmethod
    def shell_run(cmd: str) -> None:
        subprocess.check_call(['fish', '-c', cmd])

    T = TypeVar('T')

    @staticmethod
    def fzf_select(src: list[T],
                   multi: Optional[bool] = True,
                   preview_cmd: Optional[str] = None,
                   prompt: Optional[str] = '> ') -> list[T]:

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
        if preview_cmd:
            fzf_opts.append(f"--preview '{preview_cmd}'")
        fzf_opts.append(f'--prompt "{prompt}"')

        fzf_cmd = ' '.join(fzf_opts)
        Helper.log('fzf command', fzf_cmd)

        subprocess.check_call([
            'fish', '-c',
            f'cat {input_file.name} | {fzf_cmd} > {output_file.name}'
        ])

        output_file.seek(0)
        selected = [
            src_map[i] for i in output_file.read().split('\n') if i in src_map
        ]
        Helper.log('selected:', selected)

        output_file.close()
        input_file.close()

        return selected


class Action:

    def __init__(self, cmd: str) -> None:
        self.cmd = cmd

    def run(self) -> None:
        '''
        see https://stackoverflow.com/questions/10408816/how-do-i-use-the-nohup-command-without-getting-nohup-out
        see https://stackoverflow.com/questions/20646519/how-to-spawn-a-new-independent-process-in-python
        '''
        if self.cmd:
            Helper.info('running', self.cmd)
            subprocess.Popen(
                [
                    'nohup',
                    'fish',
                    '-c',
                    self.cmd,
                ],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )


class MenuEntry:

    def __init__(self, key: str, desc: str) -> None:
        assert ('/' not in key and len(key) > 0)
        self.key = key
        self.desc = desc

    def is_inner(self) -> bool:
        return False

    def is_leaf(self) -> bool:
        return False

    def get_son(self) -> list[MenuEntry]:
        return []

    def get_action(self) -> Action:
        return Action('')

    def expand(
            self, path: EntryPath,
            cond: Callable[[MenuEntry], bool]) -> dict[EntryPath, MenuEntry]:
        path = path.join(EntryPath.from_key(self.key))
        result: dict[EntryPath, MenuEntry] = {}
        if cond(self):
            result |= {path: self}
        for son in self.get_son():
            result |= son.expand(path, cond)
        return result

    def expand_leafs(self) -> dict[EntryPath, MenuEntry]:
        return self.expand(EntryPath.empty_path(), lambda e: e.is_leaf())

    def expand_all(self) -> dict[EntryPath, MenuEntry]:
        return self.expand(EntryPath.empty_path(), lambda _: True)


class EntryPath:

    def __init__(self, path: list[str]) -> None:
        self.path = path

    def __str__(self) -> str:
        return '/'.join(self.path)

    def __repr__(self) -> str:
        return f'EntryPath({str(self)})'

    def __hash__(self) -> int:
        return hash(str(self))

    def __eq__(self, obj: object) -> bool:
        if isinstance(obj, EntryPath):
            return obj.path == self.path
        return False

    @staticmethod
    def from_key(key: str) -> EntryPath:
        return EntryPath([key])

    @staticmethod
    def from_rawpath(raw_path: str) -> EntryPath:
        return EntryPath(raw_path.split('/'))

    @staticmethod
    def from_list(keys: list[str]) -> EntryPath:
        return EntryPath(keys)

    @staticmethod
    def empty_path() -> EntryPath:
        return EntryPath([])

    def join_inplace(self, other: EntryPath) -> None:
        self.path.extend(other.path)

    def join(self, other: EntryPath) -> EntryPath:
        return EntryPath(self.path + other.path)

    def pop_head(self) -> EntryPath:
        return EntryPath.from_list(self.path[1:])

    def as_list(self) -> list[str]:
        return self.path[:]

    def _find(self, cur: MenuEntry, idx: int) -> Optional[MenuEntry]:
        if idx >= len(self.path) or self.path[idx] != cur.key:
            return None
        idx += 1
        if idx == len(self.path):
            return cur
        for i in cur.get_son():
            res = self._find(i, idx)
            if res is not None:
                return res
        return None

    def find(self, menu: MenuEntry) -> Optional[MenuEntry]:
        return self._find(menu, 0)


class MenuParser:

    @staticmethod
    def from_object(doc: dict[str, Any]) -> MenuEntry:
        keys = list(doc.keys())
        assert len(keys) == 1
        key = keys[0]
        obj = doc[key]
        assert 'desc' in obj
        assert ('son' in obj) ^ ('action' in obj)

        desc = obj['desc']
        if 'son' in obj:
            son = [MenuParser.from_object(i) for i in obj['son']]
            return EntryInner(key, desc, son)
        return EntryLeaf(key, desc, Action(obj['action']))


class EntryLeaf(MenuEntry):

    def __init__(self, key: str, desc: str, action: Action) -> None:
        super().__init__(key, desc)
        self.act = action

    def is_leaf(self) -> bool:
        return True

    def get_action(self) -> Action:
        return self.act


class EntryInner(MenuEntry):

    def __init__(self, key: str, desc: str, son: list[MenuEntry]) -> None:
        super().__init__(key, desc)
        self.son = son

    def is_inner(self) -> bool:
        return True

    def get_son(self) -> list[MenuEntry]:
        return self.son


class Navigator(ABC):

    def __init__(self, root: MenuEntry) -> None:
        self.root = root
        return

    def get_root(self) -> MenuEntry:
        return self.root

    def re_root(self, new_root_path: EntryPath) -> None:
        root = new_root_path.find(self.root)
        assert root is not None
        self.root = root

    @abstractmethod
    def get_cur_path(self) -> EntryPath:
        return

    @abstractmethod
    def choices(self) -> list[str]:
        return

    @abstractmethod
    def full_path(self, choice: str) -> EntryPath:
        return

    @abstractmethod
    def select(self, choice: str) -> MenuEntry:
        return


class ExpandedMode(Navigator):

    def __init__(self, root: MenuEntry) -> None:
        super().__init__(root)
        self.root = root
        self.subs = self.root.expand_leafs()

    def re_root(self, _: EntryPath) -> None:
        return

    def get_cur_path(self) -> EntryPath:
        return EntryPath.empty_path()

    def choices(self) -> list[str]:
        return [str(i) for i in self.subs.keys()]

    def full_path(self, choice: str) -> EntryPath:
        return EntryPath.from_rawpath(choice)

    def select(self, choice: str) -> MenuEntry:
        path = EntryPath.from_rawpath(choice)
        return self.subs[path]


class LevelMode(Navigator):

    def __init__(self, root: MenuEntry) -> None:
        super().__init__(root)
        self.cur = self.root
        self.path = EntryPath.from_key(self.cur.key)
        self.subs = {i.key: i for i in self.cur.get_son()}

    def re_root(self, new_root_path: EntryPath) -> None:
        super().re_root(new_root_path)
        self.cur = self.root
        self.path = EntryPath.from_key(self.cur.key)
        self.subs = {i.key: i for i in self.cur.get_son()}

    def get_cur_path(self) -> EntryPath:
        return self.path

    def choices(self) -> list[str]:
        return [str(i) for i in self.subs.keys()]

    def full_path(self, choice: str) -> EntryPath:
        return self.path.join(EntryPath.from_key(choice))

    def select(self, choice: str) -> MenuEntry:

        Helper.info('level-mode join current', self.path)
        Helper.info('level-mode join choice', EntryPath.from_key(choice))

        self.path.join_inplace(EntryPath.from_key(choice))
        self.cur = self.subs[choice]
        self.subs = {i.key: i for i in self.cur.get_son()}
        return self.cur


class MixedMode(Navigator):

    def __init__(self, root: MenuEntry) -> None:
        super().__init__(root)
        self.path = EntryPath.from_key(self.root.key)
        self.cur = self.root
        self.subs = self.cur.expand_all()

    def re_root(self, new_root_path: EntryPath) -> None:
        super().re_root(new_root_path)
        self.path = EntryPath.from_key(self.root.key)
        self.cur = self.root
        self.subs = self.cur.expand_all()

    def get_cur_path(self) -> EntryPath:
        return self.path

    def choices(self) -> list[str]:
        groups = [
            f'GROUP\t{k}' for (k, v) in self.subs.items() if v.is_inner()
        ]
        actions = [
            f'ACTION\t{k}' for (k, v) in self.subs.items() if v.is_leaf()
        ]
        return groups + actions

    def full_path(self, choice: str) -> EntryPath:
        path = EntryPath.from_rawpath(choice[choice.index('\t') + 1:])
        return self.path.join(path.pop_head())

    def select(self, choice: str) -> MenuEntry:
        path = EntryPath.from_rawpath(choice[choice.index('\t') + 1:])
        self.path.join_inplace(path.pop_head())
        self.cur = self.subs[path]
        self.subs = self.cur.expand_all()
        return self.cur


def main_select(finder: Navigator, shell_cmd_self: str,
                prompt: Optional[str]) -> None:

    def _update_path(file: IO[str], path: EntryPath) -> None:
        file.seek(0)
        file.truncate(0)
        file.write(str(path))
        file.flush()

    with tempfile.NamedTemporaryFile(
            mode='w+',
            prefix='/tmp/spinach-fzf-menu-path',
    ) as tmpf:
        preview_cmd = f'{shell_cmd_self} --mode preview --pathfile {tmpf.name} --choice {{}}'
        while True:
            _update_path(tmpf.file, finder.get_cur_path())
            choices = finder.choices()
            selected = Helper.fzf_select(choices, False, preview_cmd, prompt)
            if len(selected) > 0:
                path = selected[0]
                entry = finder.select(path)
                if entry.is_leaf():
                    entry.get_action().run()
                    break
            else:
                break


def main_preview(finder: Navigator,
                 preview_callback: Callable[[EntryPath, MenuEntry],
                                            str], pathfile: str, choice: str):
    path = EntryPath.from_rawpath(Helper.readfile(pathfile))
    Helper.info('before re-root', path)
    finder.re_root(path)
    path = finder.full_path(choice)
    entry = finder.select(choice)
    print(preview_callback(path, entry), end='')


def main(argv: list[str],
         load: Callable[[], MenuEntry],
         preview: Callable[[EntryPath, MenuEntry], str],
         log_file: str,
         prompt: str = '> '):
    '''
    - argv:
        arguments passed to fzf-menu
    - load:
        input: nothing
        output: root entry of a menu
    - preview:
        input: the path to the hover entry and the entry itself
        output: preview text
    - log_file:
        path to store the logs
    '''

    Config.logfile_path = log_file
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument(
        '--mode',
        type=str,
        choices=['select', 'preview'],
        default='select',
        metavar='mode',
        help=
        'one of [select, preview]. run for fzf-preview command or selection')
    arg_parser.add_argument(
        '--show',
        type=str,
        choices=['expanded', 'level', 'mixed'],
        default='level',
        metavar='display_mode',
        help='one of [expanded, level, mixed]. how to display the menu tree')
    arg_parser.add_argument('--pathfile',
                    type=str,
                    default='',
                    metavar='pathfile',
                    help='path to file storing the current path of selector')
    arg_parser.add_argument('--choice',
                    type=str,
                    default='',
                    metavar='choice',
                    help='the hover entry path(only used for preview mode)')

    arg = arg_parser.parse_args(argv[1:])
    mode: str = arg.mode
    show: str = arg.show
    pathfile: str = arg.pathfile
    choice: str = arg.choice

    menu = load()
    finder: Navigator = {
        'expanded': ExpandedMode,
        'level': LevelMode,
        'mixed': MixedMode,
    }[show](menu)

    if mode == 'preview':
        main_preview(finder, preview, pathfile, choice)
    else:
        main_select(finder, 'python ' + ' '.join(argv), prompt)
