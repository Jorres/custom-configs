" tab-space settings, expand stands for always change tabs to spaces
set tabstop=4
set shiftwidth=4
set expandtab

" enable string where your command is shown
set showcmd

" transfers indentation from current line to next
set autoindent

" shows row numbers
set number

" ability to move to any symbol position
set virtualedit=all

" natural behavior when splitting windows
set splitbelow
set splitright

set nowrap
set sidescroll=10

" crutch to make auto {
"
" }
inoremap { {<CR>}<Esc>ko

nnoremap tr :NERDTreeFocusToggle

" one press splits navigation
nmap <C-h> <C-w>h 
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

syntax enable
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tomtom/tcomment_vim' " commenting shortcuts

Plugin 'vim-airline/vim-airline' " bottom line
Plugin 'vim-airline/vim-airline-themes'

Plugin 'preservim/nerdtree' " filesystem tree
Plugin 'jistr/vim-nerdtree-tabs' " achieving desired behaviour for nerdtree
Plugin 'mkitt/tabline.vim' " tabs made prettier
Plugin 'pseewald/anyfold' " language agnostic folder
Plugin 'chiel92/vim-autoformat' " autoformat upon save

call vundle#end()

filetype plugin indent on

" custom plagin settings
let NERDTreeShowHidden=1
autocmd Filetype * AnyFoldActivate
" au BufWrite * :Autoformat " proven to be harmful if not from the beginning
" of the project
set foldlevel=99
let g:airline_theme='bubblegum'
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_autofind=1
