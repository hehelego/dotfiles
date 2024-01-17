# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401

config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103

leader: str = r','
qutekey: str = r'8BBE37A279A254F28ED88F6B6E524D8368913D57'
proxy_urls: list[str] = [
    'http://127.0.0.1:8889',
    'socks5://127.0.0.1:1089',
    'none',
]

##################################### PART A: configurations #####################################

# load the autoconfig file: $HOME/.config/qutebrowser/autoconfig.yml
config.load_autoconfig()
# common configurations
config.set('bindings.key_mappings', {})
config.set('scrolling.smooth', True)
config.set('qt.highdpi', True)
config.set('fonts.default_family', 'monospace')
kind_ff_map = {
    'cursive': 'Hack',
    'fantasy': 'Hack',
    'fixed': 'Hack',
    'sans_serif': 'Noto Sans CJK SC',
    'serif': 'Noto Sans CJK SC',
    'standard': 'Hack',
}
for (kind, family) in kind_ff_map.items():
    config.set(f'fonts.web.family.{kind}', family)
config.set('colors.webpage.preferred_color_scheme', 'dark')
config.set('colors.webpage.bg', 'white')
config.set('content.autoplay', False)
config.set('content.javascript.clipboard', 'access-paste')
config.set('content.pdfjs', True)

# prevent IP address leak through WebRTC
config.set('content.webrtc_ip_handling_policy', 'disable-non-proxied-udp')

# disable mouse scroll
config.set('zoom.mouse_divider', 0)

# adblock, requires python-adblock, see https://github.com/ArniDagur/python-adblock
config.set('content.blocking.enabled', True)
config.set('content.blocking.method', 'both')

# start page and homepage
config.set('url.default_page', 'qute://start')
config.set('url.start_pages', 'qute://start')

config.set('tabs.new_position.related', 'next')
config.set('tabs.new_position.unrelated', 'next')
config.set('tabs.new_position.stacking', True)

# close the qutebrowser instance when closing the last tab
config.set('tabs.last_close', 'close')

# flags passing to Qt library
config.set(
    'qt.args',
    [
        # enable GPU acceleration
        # see https://github.com/qutebrowser/qutebrowser/discussions/6573
        # see https://github.com/qutebrowser/qutebrowser/issues/5378
        'ignore-gpu-blocklist',
        'enable-gpu-rasterization',
        'enable-native-gpu-memory-buffers',
        'num-raster-threads=4',
        'enable-accelerated-video-decode',
    ])

# command for external editor
# see https://github.com/qutebrowser/qutebrowser/issues/5340
config.set('editor.command', [
    'alacritty', '-e', 'fish', '-c',
    "nvim -c 'normal {line}G{column0}l' -- {file}"
])

# use default rather than external file selector for HTML file upload form.
config.set('fileselect.handler', 'external')
# command for external file selector
config.set('fileselect.folder.command',
           ['alacritty', '-e', 'ranger', '--choosedir={}'])
config.set('fileselect.single_file.command',
           ['alacritty', '-e', 'ranger', '--choosefile={}'])
config.set('fileselect.multiple_files.command',
           ['alacritty', '-e', 'ranger', '--choosefiles={}'])

##################################### PART B: key bindings #####################################

# remove the default key bindings
config.unbind('H', mode='normal')
config.unbind('J', mode='normal')
config.unbind('K', mode='normal')
config.unbind('L', mode='normal')
config.unbind('<Ctrl-p>', mode='normal')
config.unbind('gm', mode='normal')
config.unbind('gK', mode='normal')
config.unbind('gJ', mode='normal')
config.unbind('co', mode='normal')
config.unbind('gD', mode='normal')
config.unbind('gC', mode='normal')
config.unbind('gt', mode='normal')
# remove the default key bindings: bookmark-add | quickmark-add | bookmark-load
config.unbind('M', mode='normal')
config.unbind('m', mode='normal')
config.unbind('gb', mode='normal')
# remove the default key bindings: download | download-cancel | download-clear
config.unbind('gd', mode='normal')
config.unbind('ad', mode='normal')
config.unbind('cd', mode='normal')
# remove the default key bindings: bookmark-add,quickmark-add,bookmark-load
config.unbind('<Ctrl-e>', mode='insert')

# tab-manipulation
config.bind('gt', 'tab-next', mode='normal')
config.bind('gT', 'tab-prev', mode='normal')
config.bind('<Alt-j>', 'tab-next', mode='normal')
config.bind('<Alt-k>', 'tab-prev', mode='normal')
config.bind('<Alt-Shift-k>', 'tab-move -', mode='normal')
config.bind('<Alt-Shift-j>', 'tab-move +', mode='normal')
config.bind('<Alt-w>', 'tab-close', mode='normal')
config.bind('<Alt-p>', 'tab-pin', mode='normal')
config.bind('<Alt-m>', 'tab-mute', mode='normal')

# navigating through history
config.bind('<Alt-h>', 'back', mode='normal')
config.bind('<Alt-l>', 'forward', mode='normal')

# open developer tool
config.bind('<F12>', 'devtools', mode='normal')
config.bind('<F12>', 'devtools', mode='insert')

# print page
config.bind('<Ctrl-Alt-p>', 'print', mode='normal')
config.bind('<Ctrl-Shift-p>', 'print', mode='normal')

# toggle proxy
config.bind(f'{leader}tp',
            f'config-cycle -tp content.proxy {" ".join(proxy_urls)}',
            mode='normal')

# edit url in external editor
config.bind(f'{leader}eu', 'edit-url', mode='normal')
# edit command in external editor
config.bind(f'{leader}ec', 'cmd-edit', mode='normal')
# edit text-field in external editor
config.bind('<Alt-e>', 'edit-text', mode='insert')

# play video in MPV
config.bind(f'{leader}m', 'hint links spawn mpv {hint-url}', mode='normal')

# keepassxc integration, see https://github.com/ususdei/qute-keepassxc
config.bind('<Ctrl-Alt-k>',
            f'spawn --userscript qute-keepassxc --key {qutekey}',
            mode='insert')
config.bind(f'{leader}k',
            f'spawn --userscript qute-keepassxc --key {qutekey}',
            mode='normal')

# reload config.py
config.bind(f'{leader}c', 'config-source', mode='normal')
# restart qutebrowser
config.bind(f'{leader}r', 'restart', mode='normal')

# focus (hiding the tab-bar and status-bar)
config.bind(f'{leader}z',
            ';;'.join([
                'config-cycle -tp statusbar.show never always',
                'config-cycle -tp tabs.show never always',
                'clear-messages',
            ]),
            mode='normal')
# quiet (clear notifications)
config.bind(f'{leader}q', 'clear-messages ;; download-clear', mode='normal')

##################################### PART C: userscripts #####################################

# share URL with QR code
config.bind(f'{leader}s', 'spawn --userscript qr', mode='normal')

# spinach's cursor word selector: search for next/previous occurrence
config.bind('*',
            'spawn --userscript spinach_cursorword.py next',
            mode='normal')
config.bind('*', 'spawn --userscript spinach_cursorword.py next', mode='caret')
config.bind('#',
            'spawn --userscript spinach_cursorword.py prev',
            mode='normal')
config.bind('#', 'spawn --userscript spinach_cursorword.py prev', mode='caret')

# spinach's dictionary lookup plugin: search for the selected text in Merriam-Webster dictionary
config.bind(f'{leader}{leader}',
            'spawn --userscript spinach_dictlookup.py',
            mode='normal')
config.bind(f'{leader}{leader}',
            'spawn --userscript spinach_dictlookup.py',
            mode='caret')

# spinach's history searcher: search in history, open in current tab
config.bind(f'{leader}h',
            'spawn --userscript spinach_history.py',
            mode='normal')
# spinach's history searcher: search in history, open in new tab
config.bind(f'{leader}H',
            'spawn --userscript spinach_history.py --tab',
            mode='normal')

# spinach's bookmarks selector: open bookmark, with full feature
config.bind(f'{leader}b',
            'spawn --userscript spinach_bookmarks.py --full',
            mode='normal')
config.bind(f'{leader}B',
            'spawn --userscript spinach_bookmarks.py --full',
            mode='normal')
# override the default key bindings
config.bind('b', 'spawn --userscript spinach_bookmarks.py', mode='normal')
config.bind('B',
            'spawn --userscript spinach_bookmarks.py --tab',
            mode='normal')
