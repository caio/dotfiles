setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal smartindent
setlocal go+=b
setlocal sta
setlocal et
setlocal sts=4
setlocal ai

set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

python << EOF
import os
import sys
import vim
for i in sys.path:
    if os.path.isdir(i):
        vim.command(r"set path+=%s" % (i.replace(" ", r"\ ")))
EOF

