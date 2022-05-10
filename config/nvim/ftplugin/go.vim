setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4 nolist

" if has_treesitter
setlocal nofoldenable
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldmethod()
