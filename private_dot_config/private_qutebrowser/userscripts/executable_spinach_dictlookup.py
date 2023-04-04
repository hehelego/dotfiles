#!/usr/bin/python

from subprocess import run, DEVNULL

from spinach_qutepy import Helper, Qute

# look up the selected word in YouDao dictionary
# using [ydcv-rs](https://github.com/farseerfc/ydcv-rs)
if __name__ == '__main__':
    qute = Qute()
    selected_text = qute.get_env('selected_text')
    if selected_text:
        Helper.log('selected:', selected_text)
        run(['fish', '-c', 'dict_lookup_sel'],
            stdin=DEVNULL,
            stdout=DEVNULL,
            stderr=DEVNULL,
            timeout=5)
