" set spell spelllang=en_us                   " spelling in English
set undofile                                " ??
set undodir=~/.config/nvim/undodir
set encoding=utf-8                          " encoding

" better clipboard
if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

set ignorecase                              " with following line ignore case when lowercasing, don't if uppercase are present
set smartcase
set number relativenumber                   " hybrid line numbers
set nu rnu

set conceallevel=1                          " only one character for concealed text

set expandtab                               " tab are spaces
set autoindent
set softtabstop=4
set shiftwidth=2
set tabstop=4

set history=1000                            " remember 1000 items in vim command history

filetype plugin indent on

let g:python_host_prog="~/.pyenv/versions/neovim2/bin/python"
let g:python3_host_prog="~/.pyenv/versions/neovim3/bin/python"

" plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'ambv/black'
call plug#end()
" end plugins

" folding
set foldmethod=indent
set foldlevel=99

" mouse
set mouse=a                                 " Automatically enable mouse usage
set mousehide                               " Hide the mouse cursor while typing

" nerdtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <C-n> :NERDTreeToggle<CR>
" exit nvim if NERDTree is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" open NERDTree when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" leader key
let mapleader=","

" disable arrow key in normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" move between tabs
nnoremap <silent> È :wincmd k<CR>
nnoremap <silent> Ï :wincmd j<CR>
nnoremap <silent> Ì :wincmd h<CR>
nnoremap <silent> ¬ :wincmd l<CR>