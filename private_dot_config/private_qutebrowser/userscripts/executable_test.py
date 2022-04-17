#!/usr/bin/python

from spinach_qutepy import Qute, Helper

if __name__ == '__main__':
    qute = Qute()
    selected_text = qute.get_env('selected_text')
    if selected_text:
        Helper.log('selected:', selected_text)
