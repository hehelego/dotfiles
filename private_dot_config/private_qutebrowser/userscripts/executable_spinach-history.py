#!/usr/bin/python

from datetime import datetime
import os
import sqlite3
import argparse

from spinach_qutepy import Fzf, Qute


class History:

    def __init__(self, url: str, title: str, atime: int, redirect: int):
        self.url = url
        self.title = title
        self.time = datetime.fromtimestamp(atime)
        self.redirect = bool(redirect)

    def __str__(self) -> str:
        return f'{self.url[:20]:<20}  {self.title}'

    def __repr__(self) -> str:
        return f'<History({self.url}, {self.title})>'


if __name__ == '__main__':
    qute = Qute()

    def get_hist() -> list[History]:
        hist_db = os.path.join(qute.data_dir, 'history.sqlite')
        connection = sqlite3.connect(hist_db)
        cursor = connection.cursor()
        return [History(*i) for i in cursor.execute('SELECT * FROM history')]

    def newtab() -> bool:
        parser = argparse.ArgumentParser()
        parser.add_argument('--tab', action='store_true', dest='tab')
        return bool(parser.parse_args().tab)

    hist = get_hist()
    picked = Fzf.fzf_select(hist, False, None, 'history>')
    if len(picked) > 0:
        sel = picked[0]
        nt = '-t' if newtab() else ''
        qute.exec(f'open {nt} {sel.url}')
    pass
