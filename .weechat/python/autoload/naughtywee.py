#!/usr/bin/python
# -*- encoding: utf-8 -*-
"""
  This script is a complete ripoff from:

  weenotify - Leonid Evdokimov (weechat at darkk dot net dot ru)
  http://darkk.net.ru/weechat/weenotify.py

  Don't even think about cretiting me :)

  For issues, contact Caio <caioromao at gmail dot com>
"""

import weechat
import re
import os
import errno
import xml.sax.saxutils as saxutils
from itertools import ifilter, chain
from subprocess import Popen, PIPE
from locale import getlocale

class OsSupport(object):
    def _not_implemented(self):
        raise NotImplementedError, "your OS is not supported"
    def get_environment(self, pid):
        return self._not_implemented()
    def get_exe_fname(self, pid):
        return self._not_implemented()
    def getppid(self, pid = None):
        return self._not_implemented()
    def listpids(self):
        return self._not_implemented()
    def get_parents(self, pid = None):
        if pid is None:
            pid = os.getpid()
        l = [pid]
        while pid != 1:
            pid = self.getppid(pid)
            if pid == 0: # `[kthreadd]` and `init` have ppid == 0 at linux
                break
            l.append(pid)
        return l



class LinuxSupport(OsSupport):
    def get_environment(self, pid):
        return dict((line.split('=', 1) for line in open('/proc/%i/environ' % pid).read().split('\x00') if line))

    def get_exe_fname(self, pid):
        try:
            argv0 = os.readlink('/proc/%i/exe' % pid)
        except OSError, e:
            if e.errno == errno.EACCES:
                argv0 = open('/proc/%i/cmdline' % pid).read().split('\x00', 1)[0]
            else:
                raise
        return os.path.split(argv0)[1]

    def getppid(self, pid):
        for line in open('/proc/%i/status' % pid):
            match = re.match(r'PPid:\s+(\d+)', line)
            if match:
                return int(match.group(1))
        raise Exception, "No parent pid"

    def listpids(self):
        def is_int(s):
            try:
                int(s)
                return True
            except:
                return False
        for pid in (int(s) for s in ifilter(is_int, os.listdir('/proc'))):
            yield pid


class NoNotificationDaemonError(LookupError):
    pass


def build_command(title, message, timeout = None, icon = None, position = None):
    cmd = 'naughty.notify({'
    if title:
        cmd = '%s title = \'%s\',' % (cmd, title)
    if message:
        cmd = '%s text = \'%s\',' % (cmd, message)
    if timeout:
        cmd = '%s timeout = %s,' % (cmd, timeout)
    if icon:
        cmd = '%s icon = \'%s\',' % (cmd, icon)
    if position:
        cmd = '%s position = \'%s\'' % (cmd, position)
    cmd = '%s %s' % (cmd, '})')
    return cmd



def run_notify(nick, chan, message):
    args = []
    timeout = int(weechat.get_plugin_config('timeout'))
    icon = weechat.get_plugin_config('icon')
    position = weechat.get_plugin_config('position')
    if icon and not os.path.exists(icon):
        icon = None
    args.extend([saxutils.escape(s) for s in (u'%s on %s' % (nick, chan), message)])
    args = [s.encode(local_charset) for s in args]

    cmd = build_command(args[0], args[1], timeout, icon, position)
    args = ['echo', cmd]

    weechat.prnt(cmd)
    p1 = Popen(args, stdout = PIPE)
    p2 = Popen(["awesome-client"], stdin = p1.stdout)
    p2.communicate()


def parse_privmsg(server, command):
    # :nick!ident@host PRIVMSG dest :foobarbaz
    l = command.split(' ', 3)
    mask = l[0][1:]
    nick = mask.split("!")[0]
    dest = l[2]
    message = l[3][1:]
    ###########################################
    #nothing, info, message = command.split(":", 2)
    #info = info.split(' ')
    if dest == weechat.get_info('nick', server):
        buffer = nick
    else:
        buffer = dest
    return (nick, buffer, message)

def strip_irc_colors(message):
    # look at src/plugins/irc/irc-color.c to get proper color parser
    # modifiers = ( # one-byte modifiers
    #    ur'\x02',  # IRC_COLOR_BOLD_CHAR
    #    ur'\x03',  # IRC_COLOR_COLOR_CHAR, color defenition follows
    #    ur'\x0F',  # IRC_COLOR_RESET_CHAR
    #    ur'\x11',  # IRC_COLOR_FIXED_CHAR
    #    ur'\x12',  # IRC_COLOR_REVERSE_CHAR
    #    ur'\x16',  # IRC_COLOR_REVERSE2_CHAR
    #    ur'\x1d',  # IRC_COLOR_ITALIC_CHAR
    #    ur'\x1f')  # IRC_COLOR_UNDERLINE_CHAR
    # hope, python regexps are character-aware, not byte-aware
    return re.sub(ur'(?:\x02|\x03(?:\d{1,2})?(?:,\d{1,2})?|\x0F|\x11|\x12|\x16|\x1d|\x1f)', '', message)


# weechat does not fire highlight callback on direct PRIVMSG's (aka, «privates» or «queries»)
# but in case of channel highlight BOTH weechat_pv and weechat_highlight are fired
# Say NO to duplications
last_message = None
def on_msg(server, args):
    nick, buffer, message = [unicode(s, local_charset) for s in parse_privmsg(server, args)]

    global last_message
    if message != last_message:
        last_message = message

        match = re.match(ur'\x01ACTION (.*)\x01', message)
        if match:
            message = u'/me ' + match.group(1)

        message = strip_irc_colors(message)

        if nick == buffer:
            buffer = u'me'

        run_notify(nick, buffer, message)
    return weechat.PLUGIN_RC_OK


def main():
    global weeos, local_charset

    default = {
            "timeout": "3",
            "icon": "/usr/share/pixmaps/gnome-irc.png",
            "position": "bottom_right"
            }

    if weechat.register("naughtywee", "0.1", "", "awesome naughty notification upon hilight"):
        for k, v in default.items():
            if not weechat.get_plugin_config(k):
                weechat.set_plugin_config(k, v)

        local_charset = getlocale()[1]

        if os.uname()[0] == 'Linux':
            weeos = LinuxSupport()
        else:
            weeos = OsSupport()
        
        weechat.add_message_handler("weechat_highlight", "on_msg")
        weechat.add_message_handler("weechat_pv", "on_msg")

main()

# vim:set tabstop=4 softtabstop=4 shiftwidth=4: 
# vim:set foldmethod=marker foldlevel=32 foldmarker={{{,}}}: 
# vim:set expandtab: 
