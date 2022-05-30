#!/usr/bin/python

# see https://github.com/alphapapa/solarized-everything-css
# see https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/qutebrowser/config.py
# see qute://help/settings.html#content.user_stylesheets

import os
import subprocess

from spinach_qutepy import Fzf, Helper, Qute


def get_themes(search: str) -> list[str]:
    themes = [
        path for path in subprocess.check_output([
            'fd', '--type', 'file', '--extension', 'css', search, 'userstyles/'
        ]).decode().split('\n') if os.path.isfile(path)
    ]
    Helper.log('all available themes', themes)
    return themes


if __name__ == '__main__':
    qute = Qute()

    os.chdir(qute.config_dir)
    themes = get_themes('all-site')
    selected = Fzf.fzf_select(themes, prompt='theme> ')

    def set_theme(thm):
        qute.exec(f':set -tp content.user_stylesheets {thm}')

    if len(selected) > 0:
        set_theme(repr(selected[0]))
    else:
        set_theme(repr(''))
