"""
This file is executed when the Python interactive shell is started if
$PYTHONSTARTUP is in your environment and points to this file. It's just
regular Python commands, so do what you will. Your ~/.inputrc file can greatly
complement this file.

Original source: https://github.com/sontek/dotfiles/blob/master/_pythonrc.py

"""
import os

try:
    import readline
except ImportError:
    print("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

    # Enable a History
    HISTFILE="%s/.pyhistory" % os.environ["HOME"]

    # Read the existing history if there is one
    if os.path.exists(HISTFILE):
        readline.read_history_file(HISTFILE)

    # Set maximum number of items that will be written to the history file
    readline.set_history_length(300)

    def savehist():
        readline.write_history_file(HISTFILE)

    import atexit
    atexit.register(savehist)
    del rlcompleter
    del atexit

WELCOME=''
# Color Support
class TermColors(dict):
    """Gives easy access to ANSI color codes. Attempts to fall back to no color
    for certain TERM values. (Mostly stolen from IPython.)"""

    COLOR_TEMPLATES = (
        ("Black"       , "0;30"),
        ("Red"         , "0;31"),
        ("Green"       , "0;32"),
        ("Brown"       , "0;33"),
        ("Blue"        , "0;34"),
        ("Purple"      , "0;35"),
        ("Cyan"        , "0;36"),
        ("LightGray"   , "0;37"),
        ("DarkGray"    , "1;30"), ("LightRed"    , "1;31"),
        ("LightGreen"  , "1;32"),
        ("Yellow"      , "1;33"),
        ("LightBlue"   , "1;34"),
        ("LightPurple" , "1;35"),
        ("LightCyan"   , "1;36"),
        ("White"       , "1;37"),
        ("Normal"      , "0"),
    )

    NoColor = ''
    _base  = '\001\033[%sm\002'

    colored_terms = (
        'xterm-color',
        'xterm-256color',
        'linux',
        'screen',
        'screen-256color',
        'screen-bce',
        'rxvt',
        'rxvt-256color',
    )

    def __init__(self):
        if os.environ.get('TERM') in self.colored_terms:
            self.update(dict([(k, self._base % v)
                              for k,v in self.COLOR_TEMPLATES]))
        else:
            self.update(dict([(k, self.NoColor)
                              for k,v in self.COLOR_TEMPLATES]))
_c = TermColors()



import sys
# Enable Color Prompts
sys.ps1 = '%s>>> %s' % (_c['Green'], _c['Normal'])
sys.ps2 = '%s... %s' % (_c['Red'], _c['Normal'])

# Enable Pretty Printing for stdout
def my_displayhook(value):
    if value is None:
        return

    def formatargs(func):
        from inspect import getargspec
        args, varargs, varkw, defs = getargspec(func)

        # Fill in default values
        if defs:
            last = len(args) - 1
            for i, val in enumerate(reversed(defs)):
                args[last - i] = '%s=%r' % (args[last - i], val)

        # Fill in variable arguments
        if varargs:
            args.append('*%s' % varargs)
        if varkw:
            args.append('**%s' % varkw)

        return ', '.join(args)

    def _ioctl_width(fd):
        from fcntl import ioctl
        from struct import pack, unpack
        from termios import TIOCGWINSZ
        return unpack('HHHH',
                      ioctl(fd, TIOCGWINSZ, pack('HHHH', 0, 0, 0, 0)))[1]

    def get_width():
        width = 0
        try:
            width = _ioctl_width(0)
            if not width:
                width = _ioctl_width(1)
            if not width:
                width = _ioctl_width(2)
        except ImportError:
            pass
        if not width:
            import os
            width = os.environ.get('COLUMNS', 80)
        return width


    import pydoc
    import types
    import pprint

    try:
        import __builtin__
        __builtin__._ = value
        onPy3k = False
    except ImportError:
        __builtins__._ = value
        onPy3k = True

    help_types = (
        types.BuiltinFunctionType, types.BuiltinMethodType,
        types.FunctionType, types.MethodType, types.ModuleType,
        type(list.remove),
    )

    if not onPy3k:
        help_types += (types.TypeType, types.UnboundMethodType)

    if not isinstance(value, help_types):
        width = get_width()
        pprint.pprint(value, width=width)
    else:
        reprstr = repr(value)
        if hasattr(value, 'func_code') or hasattr(value, 'im_func'):
            parts = reprstr.split(' ')
            parts[1] = '%s(%s)' % (parts[1], formatargs(value))
            reprstr = ' '.join(parts)
        print(reprstr)
        if getattr(value, '__doc__', None):
            print()
            print(pydoc.getdoc(value))

    del pprint
    del pydoc
    del types

sys.displayhook = my_displayhook

def my_excepthook(exctype, value, traceback):
    from pygments import highlight
    from pygments.lexers import PythonTracebackLexer
    from pygments.formatters import TerminalFormatter
    try:
        from cStringIO import StringIO
    except ImportError:
        from StringIO import StringIO

    global _old_excepthook

    old_stderr = sys.stderr
    sys.stderr = StringIO()
    try:
        _old_excepthook(exctype, value, traceback)
        s = sys.stderr.getvalue()
        s = highlight(s, PythonTracebackLexer(), TerminalFormatter())
        old_stderr.write(s)
    finally:
        sys.stderr = old_stderr

try:
    import pygments
    del pygments
    _old_excepthook = sys.excepthook
    sys.excepthook = my_excepthook
except ImportError:
    pass

# Django Helpers
def SECRET_KEY():
    "Generates a new SECRET_KEY that can be used in a project settings file."

    from random import choice
    return ''.join(
            [choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)')
                for i in range(50)])

# If we're working with a Django project, set up the environment
if 'DJANGO_SETTINGS_MODULE' in os.environ:
    from django.db.models.loading import get_models
    from django.test.client import Client
    from django.test.utils import (setup_test_environment,
                                   teardown_test_environment)
    from django.conf import settings as S

    class DjangoModels(object):
        """Loop through all the models in INSTALLED_APPS and import them."""
        def __init__(self):
            for m in get_models():
                setattr(self, m.__name__, m)

    A = DjangoModels()
    C = Client()

    WELCOME += """%(Green)s
    Django environment detected.
* Your INSTALLED_APPS models are available as `A`.
* Your project settings are available as `S`.
* The Django test client is available as `C`.
%(Normal)s""" % _c

    setup_test_environment()
    S.DEBUG_PROPAGATE_EXCEPTIONS = True

    WELCOME += """%(LightPurple)s
Warning: the Django test environment has been set up; to restore the
normal environment call `teardown_test_environment()`.

Warning: DEBUG_PROPAGATE_EXCEPTIONS has been set to True.
%(Normal)s""" % _c

# Start an external editor with \e
# http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/438813/

EDITOR = os.environ.get('EDITOR', 'vim')
EDIT_CMD = '\e'

from tempfile import mkstemp
from code import InteractiveConsole

class EditableBufferInteractiveConsole(InteractiveConsole):
    def __init__(self, *args, **kwargs):
        self.last_buffer = [] # This holds the last executed statement
        InteractiveConsole.__init__(self, *args, **kwargs)

    def runsource(self, source, *args):
        self.last_buffer = [ source.encode('latin-1') ]
        return InteractiveConsole.runsource(self, source, *args)

    def raw_input(self, *args):
        line = InteractiveConsole.raw_input(self, *args)
        if line == EDIT_CMD:
            fd, tmpfl = mkstemp('.py')
            os.write(fd, '\n'.join(self.last_buffer))
            os.close(fd)
            os.system('%s %s' % (EDITOR, tmpfl))
            line = open(tmpfl).read()
            os.unlink(tmpfl)
            tmpfl = ''
            lines = line.split( '\n' )
            for i in range(len(lines) - 1): self.push( lines[i] )
            line = lines[-1]
        return line

# clean up namespace
del sys

c = EditableBufferInteractiveConsole(locals=locals())
c.interact(banner=WELCOME)

# Exit the Python shell on exiting the InteractiveConsole
import sys
sys.exit()
