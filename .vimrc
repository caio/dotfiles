" Simple VI configuration file
" Caio Romão <caioromao@gmail.com>

scriptencoding utf-8

syntax on
filetype on
filetype plugin on
filetype indent on

let mapleader=','

set mouse=a
set nowrap
set nocompatible
set shortmess=a
set showcmd
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set showfulltag
set wildmenu
set wildmode=list:longest
set wildignore+=*.o,*~,.lo,*.pyc
set suffixes+=.in,.a
set hidden
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set softtabstop=4
set autoindent
set smartindent
set nonumber
set viminfo='1000,f1,:1000,/1000
set history=500
set backspace=indent,eol,start
set backup
set backupdir=./.backup,/tmp,.
set directory=.,./.backup,/tmp
set nolazyredraw
set noswapfile
set title
set noerrorbells
set novisualbell
set foldmethod=marker
set completeopt=menu,preview,longest,menuone

if has("gui_running")
    set guifont=Envy\ Code\ R\ 9
    colorscheme herald
    " FontSize plugin
    nmap <silent><A-+> :call LargerFont()<CR>
    nmap <silent><A--> :call SmallerFont()<CR>
    " Remove GUI
    set guioptions=a
else
    set t_Co=256
    colorscheme herald
endif

nmap <silent> <F3> :silent nohlsearch<CR>
imap <silent> <F3> <C-o>:silent nohlsearch<CR>
nmap h :bp<CR>
nmap l :bn<CR>
imap h <C-o>:bp<CR>
imap l <C-o>:bn<CR>
imap  
nmap  

nmap <F7> :setlocal spell! spelllang=en<CR>
imap <F7> <C-o>:setlocal spell! spelllang=en<CR>
nmap <F8> :setlocal spell! spelllang=pt_br<CR>
imap <F8> <C-o>:setlocal spell! spelllang=pt_br<CR>

" Fuzzy Finder
nmap <silent><leader>f :FufFile<CR>
nmap <silent><leader>t :FufTag<CR>
nmap <silent><leader>d :FufDir<CR>
nnoremap <leader>g :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>

" List trailing chars
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Strip trailing whitespace
nmap <silent><leader>ws :%s/\s\+$//g<CR>

" IDE-like home key
function! s:SmartHome()
    let ll = strpart(getline('.'), -1, col('.'))
    if ll =~ '^\s\+$' | normal! 0
    else	      | normal! ^
    endif
endfunction
inoremap <silent><HOME> <C-O>:call <SID>SmartHome()<CR>
nnoremap <silent><HOME> :call <SID>SmartHome()<CR>

" Buffer Explorer
imap <F2> <C-O><leader>be
nmap <F2> <leader>be

" Yankring
imap <leader>p <C-O>:YRShow<CR>
nmap <leader>p :YRShow<CR>
let g:yankring_history_file='.yankring_history'

" NERDTree
imap <silent><F4> <C-O>:NERDTreeToggle<CR>
nmap <silent><F4> :NERDTreeToggle<CR>

" Taglist
nmap <silent><F5> :Tlist<CR>
imap <silent><F5> <C-O>:Tlist<CR>
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=1
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1

" TOhtml options
let html_number_lines=1
let html_use_css=1
let use_xhtml=1

" Matchit plugin
runtime macros/matchit.vim

" Python synxtax file
let python_highlight_all=1
let python_slow_sync=1
let python_print_as_function=1

" ANTLR3 Syntax
au BufRead,BufNewFile *.g set syntax=antlr3
" StringTemplate Syntax
au BufRead,BufNewFile *.stg set syntax=stringtemplate
" Markdown Syntax
au BufRead,BufNewFile *.md set ft=mkd

" OmniCPPComplete settings
" let OmniCpp_GlobalScopeSearch = 1
" let OmniCpp_NamespaceSearch = 2
" let OmniCpp_ShowPrototypeInAbbr = 1
" let OmniCpp_SelectFirstItem = 2

" Close the preview window automatically
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


set laststatus=2
set statusline=%2*
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'-'},    " filetype
set statusline+=%{&enc},                     " encoding
set statusline+=%{&ff}]\                     " file format
set statusline+=0x%B\                        " current char
set statusline+=%l,%c\ %O,%P                 " line, column, offset
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                     " file name
    set titlestring+=%h%m%r%w                " flags
    " working directory
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
endif
if (&term =~ "xterm") && (&termencoding == "")
    set termencoding=utf-8
endif

" Append modeline after last line in buffer.
" Use substitute() (not printf()) to handle '%%s' modeline in LaTeX files.
function! AppendModeline()
  let save_cursor = getpos('.')
  let append = ' vim: set ts='.&tabstop.' sw='.&shiftwidth.' tw='.&textwidth.':'
  $put =substitute(&commentstring, '%s', append, '')
  call setpos('.', save_cursor)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" vim: set ts=4 sw=4 tw=72:
