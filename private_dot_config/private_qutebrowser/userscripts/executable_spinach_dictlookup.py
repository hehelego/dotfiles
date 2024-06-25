#!/usr/bin/python
#!/usr/bin/python

from spinach_qutepy import Helper, Qute

# look up the selected word in Merriam-Webster dictionary
if __name__ == '__main__':
    qute = Qute()
    selected_text = qute.get_env('selected_text')
    query_url = rf'open -tr https://www.merriam-webster.com/dictionary/{selected_text}'
    if selected_text:
        Helper.log('selected:', selected_text)
        qute.exec(query_url)
