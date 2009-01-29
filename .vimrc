" Simple VI configuration file
" Caio Romão <caioromao@gmail.com>

scriptencoding utf-8

syntax on
filetype on
filetype plugin on
filetype indent on
compiler ruby

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
set lazyredraw
set noswapfile
set title
set noerrorbells
set novisualbell

if has("gui_running")
    set guifont=Envy\ Code\ R\ 9
    colorscheme wombat256
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=b
else
    colorscheme vibrantink
endif

nmap <silent> <F3> :silent nohlsearch<CR>
imap <silent> <F3> <C-o>:silent nohlsearch<CR>
map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
imap <C-h> <C-o>:bp<CR>
imap <C-l> <C-o>:bn<CR>

nmap <F7> :setlocal spell! spelllang=en<CR>
imap <F7> <C-o>:setlocal spell! spelllang=en<CR>
nmap <F8> :setlocal spell! spelllang=pt_br<CR>
imap <F8> <C-o>:setlocal spell! spelllang=pt_br<CR>

" Fuzzy Finder
nmap <silent><leader>f :FuzzyFinderFile<CR>
nmap <silent><leader>t :FuzzyFinderTag<CR>
nmap <silent><leader>d :FuzzyFinderDir<CR>
nnoremap <leader>g :FuzzyFinderFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR> 

" List trailling chars
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

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

" Yarking
imap <leader>p <C-O>:YRShow<CR>
nmap <leader>p :YRShow<CR>

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
let Tlist_File_Fold_Auto_Close = 1

" Yankring
let g:yankring_history_file = '.yankring_history'

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

" Numbermarks plugin
let g:Signs_file_path_corey='/tmp'

" FontSize plugin
nmap <silent>+ :call LargerFont()<CR>
nmap <silent>- :call SmallerFont()<CR>

" ANTLR3 Syntax
au BufRead,BufNewFile *.g set syntax=antlr3
" StringTemplate Syntax
au BufRead,BufNewFile *.stg set syntax=stringtemplate

" OmniCPPComplete settings
" let OmniCpp_GlobalScopeSearch = 1
" let OmniCpp_NamespaceSearch = 2
" let OmniCpp_ShowPrototypeInAbbr = 1
" let OmniCpp_SelectFirstItem = 2
" Close the preview window automatically
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" By http://github.com/ciaranm/dotfiles-ciaranm
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\                " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%2*0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                     " file name
    set titlestring+=%h%m%r%w                " flags
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}        " working directory
endif
if (&term =~ "xterm") && (&termencoding == "")
    set termencoding=utf-8
endif


" vim: set shiftwidth=4 softtabstop=4 expandtab tw=120
