# -*- coding: utf-8 -*-
# Author: Caio Romão <contact@caioromao.com>
# Original name: notify.py
# Original author: lavaramano <lavaramano AT gmail DOT com>
# Improved by: BaSh - <bash.lnx AT gmail DOT com>
# Ported to Weechat 0.3.0 by: Sharn - <sharntehnub AT gmail DOT com)
# Requires Weechat 0.3.0
# Released under GNU GPL v2

import subprocess
import weechat


weechat.register("kdenotify", "caioromao", "0.0.1", "GPL",
                 "kdenotify: notifications using Kde4 subsystem", "", "")

# script options
settings = dict(
    show_hilights="on",
    show_priv_msg="on",
    timeout="0"
)

# Init everything
for option, default_value in settings.items():
    if weechat.config_get_plugin(option) == "":
        weechat.config_set_plugin(option, default_value)

# Hook privmsg/hilights
weechat.hook_print("", "", "", 1, "knotify_show_hi", "")
weechat.hook_signal("weechat_pv", "knotify_show_priv", "")

# Functions
def knotify_show_hi(data, bufferp, uber_empty, tagsn, isdisplayed, ishilight,
                    prefix, message):
    """Sends highlighted message to be printed on notification"""
    if ishilight == "1" and weechat.config_get_plugin('show_hilights') == "on":
        buff = (weechat.buffer_get_string(befferp, "short_name") or
                weechat.buffer_get_string(bufferp, "name"))
        show_notification(buff, '%s: %s' % (prefix, message))

    return weechat.WEECHAT_RC_OK

def knotify_show_priv(data, signal, message):
    """Sends private message to be printed on notification"""
    if weechat.config_get_plugin('show_priv_msg') == "on":
        show_notification("Private message",  message)
    return weechat.WEECHAT_RC_OK

def show_notification(title, message):
    timeout = weechat.config_get_plugin('timeout')
    subprocess.call(('kdialog', '--title', title, '--passivepopup', message))

# vim: set ts=4 sw=4 tw=79:
