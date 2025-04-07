" fold via treesitter but start with everthing expanded
setlocal nofoldenable
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
