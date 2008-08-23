from __future__ import nested_scopes
import sys, os, string, time
# from utils import *

################ Interactive Prompt and Debugging ################

try:
    import readline
except ImportError:
    print "Module readline not available."
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

h = [None]

class Prompt:
    def __init__(self, str='h[%d] >>> '):
        self.str = str;

    def __str__(self):
        try:
            if _ not in [h[-1], None, h]: h.append(_);
        except NameError:
           pass
        return self.str % len(h);

    def __radd__(self, other):
        return str(other) + str(self)


if os.environ.get('TERM') in [ 'xterm', 'vt100' ]:
    sys.ps1 = Prompt('\001\033[0:1;31m\002h[%d] >>> \001\033[0m\002')
else:
    sys.ps1 = Prompt()
sys.ps2 = ''
