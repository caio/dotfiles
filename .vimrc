" Simple .vimrc file assembled by Caio Romão
"
" Most of it has come from ciaranm's with
" some slight changes to fit my taste
" 
" Please check http://github.com/ciaranm/dotfiles-ciaranm
" for the original
scriptencoding utf-8

"-----------------------------------------------------------------------
" terminal setup
"-----------------------------------------------------------------------

" Extra terminal things
if (&term =~ "xterm") && (&termencoding == "")
    set termencoding=utf-8
endif

"-----------------------------------------------------------------------
" settings
"-----------------------------------------------------------------------

" Map leader to <space>
let mapleader=' '

" Enable mouse
set mouse=a

" Don't wrap lines
set nowrap

" Don't be compatible with vi
set nocompatible

" Enable a nice big viminfo file
set viminfo='1000,f1,:1000,/1000
set history=500

" Make backspace delete lots of things
set backspace=indent,eol,start

" Create backups
set backup
set backupdir=./.backup,/tmp,.
set directory=.,./.backup,/tmp

" Show us the command we're typing
set showcmd

" Highlight matching parens
set showmatch

" Search options: incremental search, highlight search
set hlsearch
set incsearch

" Selective case insensitivity
set ignorecase
set smartcase

" Don't inherit title
set title

" Show full tags when doing search completion
set showfulltag

" Speed up macros
set lazyredraw

" No annoying error noises
set noerrorbells
set visualbell t_vb=
if has("autocmd")
    autocmd GUIEnter * set visualbell t_vb=
endif

" Use the cool tab complete menu
set wildmenu
set wildmode=list:longest
set wildignore+=*.o,*~,.lo
set suffixes+=.in,.a

" List tabs and trailling spaces with <leader>s
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Don't bug me with silly 'continue' messages
set shortmess=atI

" Allow edit buffers to be hidden
set hidden

" Enable syntax highlighting
if has("syntax")
    syntax on
endif

if has("gui_running")
"    set guifont=Bitstream\ Vera\ Sans\ Mono\ 8 
    set guifont=Inconsolata\ 10 
endif

" Try to load a nice colourscheme
if has("gui_running")
    set background=dark
    colorscheme moria
else
    set background=dark
    colorscheme moria
endif

" No icky toolbar, menu or scrollbars in the GUI
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set columns=100
    set lines=50
end

" By default, go for an indent of 4
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set softtabstop=4

" Do clever indent things. Don't make a # force column zero.
set autoindent
set smartindent

" Syntax when printing
set popt+=syntax:y

" Enable filetype settings
if has("eval")
    filetype on
    filetype plugin on
    filetype indent on
endif

" Nice statusbar
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

" Nice window title
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                     " file name
    set titlestring+=%h%m%r%w                " flags
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}        " working directory
endif

" Include $HOME in cdpath
if has("file_in_path")
    let &cdpath=','.expand("$HOME").','.expand("$HOME").'/work'
endif

" Better include path
set path+=src/
" set path+=/usr/lib/gcc/*/4.*/include/g++-v4/

set fillchars=fold:-

"-----------------------------------------------------------------------
" completion
"-----------------------------------------------------------------------
" set dictionary=/usr/share/dict/words

"-----------------------------------------------------------------------
" autocmds
"-----------------------------------------------------------------------

"setlocal foldcolumn=2
set nonumber

"-----------------------------------------------------------------------
" mappings
"-----------------------------------------------------------------------

" Make <space> in normal mode go down a page rather than left a
" character
noremap <space> <C-f>

" Commonly used commands
nmap <silent> <F3> :silent nohlsearch<CR>
imap <silent> <F3> <C-o>:silent nohlsearch<CR>

" tab completion
if has("eval")
    function! CleverTab()
        if pumvisible()
            return "\<C-N>"
        endif
        if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
            return "\<Tab>"
        elseif exists('&omnifunc') && &omnifunc != ''
            return "\<C-X>\<C-O>"
        else
            return "\<C-N>"
        endif
    endfunction

    inoremap <Tab> <C-R>=CleverTab()<CR>
    inoremap <S-Tab> <C-R>=CleverTab()<CR> 
endif

function! s:SmartHome()
    let ll = strpart(getline('.'), -1, col('.'))
    if ll =~ '^\s\+$' | normal! 0
    else	      | normal! ^
    endif
endfunction

inoremap <silent><HOME> <C-O>:call <SID>SmartHome()<CR>
nnoremap <silent><HOME> :call <SID>SmartHome()<CR>

imap <F2> <C-O>\be
nmap <F2> \be

imap <silent><F1> <C-O>:NERDTreeToggle<CR>
nmap <silent><F1> :NERDTreeToggle<CR>

nmap <silent><F5> :Tlist<CR>
imap <silent><F5> <C-O>:Tlist<CR>

imap <F4> <C-O>:A<CR>
nmap <F4> :A<CR>

nmap <silent><F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>

" Buffer management
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>

"-----------------------------------------------------------------------
" plugin / script / app settings
"-----------------------------------------------------------------------

if has("eval")
    " Vim specific options
    let g:vimsyntax_noerror=1
    let g:vimembedscript=0

    " c specific options
    let g:c_gnu=1
    let g:c_no_curly_error=1

    " doxygen
    let g:load_doxygen_syntax=1
    let g:doxygen_end_punctuation='[.?]'

    " Settings for taglist.vim
    let Tlist_Use_Right_Window=1
    let Tlist_Auto_Open=0
    let Tlist_Enable_Fold_Column=0
    let Tlist_Compact_Format=1
    let Tlist_WinWidth=28
    let Tlist_Exit_OnlyWindow=1
    let Tlist_File_Fold_Auto_Close = 1

    " Settings for :TOhtml
    let html_number_lines=1
    let html_use_css=1
    let use_xhtml=1
endif

" % matches on if/else, html tags, etc.
runtime macros/matchit.vim

"-----------------------------------------------------------------------
" final commands
"-----------------------------------------------------------------------

" turn off any existing search
if has("autocmd")
    au VimEnter * nohls
endif

" OmniCPPComplete settings
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 2
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_SelectFirstItem = 2

" Close the preview window automatically
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"-----------------------------------------------------------------------
" vim: set shiftwidth=4 softtabstop=4 expandtab tw=120                 :
