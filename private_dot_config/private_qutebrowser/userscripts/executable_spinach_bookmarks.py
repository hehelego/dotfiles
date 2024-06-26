#!/usr/bin/python

import argparse
import os
import subprocess
from typing import Optional

import yaml

from spinach_qutepy import Fzf, Helper, Qute


class Bookmark:
    '''
    entires:
        - url
        - name
        - tags
    '''

    def __init__(self, url: str, name: str, tags: list[str]) -> None:
        self.url = url
        self.name = name
        self.tags = tags

    # issue with 'type hinting for static method' (until python 3.10)
    # see https://stackoverflow.com/questions/67522076/python-how-to-type-hint-a-class-argument-in-a-static-method-python
    # see https://stackoverflow.com/questions/61544854/from-future-import-annotations
    # see https://www.python.org/dev/peps/pep-0563/
    @staticmethod
    def load(raw: str):
        obj = yaml.safe_load(raw)
        url, name, tags = obj['url'], obj['name'], obj['tags']

        assert isinstance(url, str)
        assert isinstance(name, str)
        assert isinstance(tags, list)

        return Bookmark(url, name, tags)

    def dump(self) -> str:
        return yaml.dump(self, default_flow_style=False)

    def __str__(self) -> str:
        return f'Bookmark(url={self.url}, name={self.name}, tags={self.tags})'

    def __repr__(self) -> str:
        return str(self)

    def match(self, tags: list[str]) -> bool:
        for t in tags:
            if t not in self.tags:
                return False
        return True


def get_bookmarks_paths_all(bookmarks_directory: str) -> list[str]:
    os.chdir(bookmarks_directory)
    path_raw = subprocess.run(
        ['fd', '--type', 'file', '--extension', 'yaml', '--extension', 'yml'],
        check=True,
        capture_output=True).stdout.decode().strip().split('\n')
    return [path for path in path_raw if os.path.isfile(path)]


def get_tags_all(bookmarks_directory: str) -> list[str]:
    return list({
        j
        for i in get_bookmarks_paths_all(bookmarks_directory)
        for j in Bookmark.load(Helper.readfile(i)).tags
    })


def filter_bookmarks_by_tag(bookmark_file_paths: list[str],
                            tags: list[str]) -> list[str]:
    return [
        i for i in bookmark_file_paths
        if Bookmark.load(Helper.readfile(i)).match(tags)
    ]


def select_mode() -> tuple[bool, bool]:
    all_modes = ['new window', 'new tab', 'inplace']
    selected = Fzf.fzf_select(all_modes,
                              multi=False,
                              preview=None,
                              prompt='mode> ')
    Helper.log('selected-mode', selected)
    nw = 'new window' in selected
    nt = 'new tab' in selected
    return (nt, nw)


def select_tags(all_tags: list[str]) -> list[str]:
    selected = Fzf.fzf_select(all_tags,
                              multi=True,
                              preview=None,
                              prompt='tag> ')
    Helper.log('selected-tags', selected)
    return selected


def select_bookmark(bookmark_file_paths: list[str]) -> Optional[Bookmark]:
    selected = Fzf.fzf_select(bookmark_file_paths, prompt='bookmark> ')
    Helper.log('selected-bookmark-file', selected)
    bmfile = selected[0] if len(selected) > 0 else ''
    if os.path.isfile(bmfile):
        bm = Bookmark.load(Helper.readfile(bmfile))
        Helper.log('selected-bookmark-entry', bm)
        return bm
    return None


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--tab', action='store_true', dest='tab')
    parser.add_argument('--win', action='store_true', dest='win')
    parser.add_argument('--full', action='store_true', dest='full')
    args = parser.parse_args()
    Helper.log('args', args)

    qute = Qute()

    bmdir = os.path.join(qute.config_dir, 'spinach-bookmarks')
    os.chdir(bmdir)
    bms = get_bookmarks_paths_all(bmdir)
    tags = get_tags_all(bmdir)
    Helper.log('bookmarks-directory', bmdir)
    Helper.log('bookmarks', bms)
    Helper.log('tags', tags)

    if args.full:
        tags = select_tags(tags)
        bm = select_bookmark(filter_bookmarks_by_tag(bms, tags))
        if bm is not None:
            nt, nw = select_mode()
            Helper.log('mode', f'tab={nt} win={nw}')
            qute.open_url(bm.url, new_window=nw, new_tab=nt)
    else:
        bm = select_bookmark(bms)
        if bm is not None:
            nt, nw = bool(args.tab), bool(args.win)
            Helper.log('mode', f'tab={nt} win={nw}')
            qute.open_url(bm.url, new_window=nw, new_tab=nt)
