import os
import sys
import traceback
from typing import Any

import vim


def notify_send(msg: Any, level: str, expire_time: int) -> None:
    import subprocess
    try:
        subprocess.run(['notify-send',
                        '-u', level,
                        '-t', f'{expire_time}',
                        '-a', '[load plugin]',
                        f'{msg}'],
                       timeout=0.5)
    except Exception as e:
        print(f'[error] {e}')


def py_log(msg): return notify_send(msg, 'low', 1000)
def py_err(msg): return notify_send(msg, 'critical', 5000)


def load_plugin_configs(black_list: list[str]) -> None:
    py_log('loading plugin configurations')
    conf_dir = os.path.expandvars(r'$HOME/.config/nvim/plugin_config')
    confs = sorted([
        x
        for x in os.listdir(conf_dir)
        if x not in black_list
    ])
    for conf in confs:
        try:
            path = os.path.join(conf_dir, conf)
            if path.endswith('.vim'):
                vim.command(f'source {path}')
            elif path.endswith('.py'):
                vim.command(f'py3file {path}')
            elif path.endswith('.lua'):
                vim.command(f'luafile {path}')
            else:
                py_err(f'unknown plug-conf {path}')
        except Exception:
            py_err(f'failed {conf}')
            traceback.print_exc(file=sys.stderr)


if __name__ == '__main__':
    load_plugin_configs([])
