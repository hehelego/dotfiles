#!/usr/bin/python

import argparse

from spinach_qutepy import Helper, Qute

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('direction', action='store', choices=['next', 'prev'])
    args = parser.parse_args()

    qute = Qute()
    selected_text = qute.get_env('selected_text')
    direction = args.direction
    Helper.log('selected', selected_text)
    Helper.log('direction', direction)

    if selected_text:
        qute.exec(f':search {selected_text}')
    qute.exec(f':search-{direction}')
