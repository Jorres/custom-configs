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

" vim commands still usable when in russian keyboard
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

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

Plugin 'VundleVim/Vundle.vim' " required for installation of other plugins
Plugin 'tomtom/tcomment_vim' " commenting shortcuts
" gcc - single line, gc<motion>, visual gc also works 

Plugin 'vim-airline/vim-airline' " bottom line
Plugin 'vim-airline/vim-airline-themes' " custom theme selected below

Plugin 'preservim/nerdtree' " filesystem tree
Plugin 'jistr/vim-nerdtree-tabs' " achieving desired behaviour for nerdtree

Plugin 'mkitt/tabline.vim' " tabs made prettier, passive

Plugin 'pseewald/anyfold' " language agnostic folder
" za - toggle fold, zc\zo - close\open;  zA, zC, zO - same behaviour, but 
" with recursive folding

Plugin 'mhinz/vim-startify' " start page with default files and a funny horse
Plugin 'jiangmiao/auto-pairs' " automated insertion of pair brackets
Plugin 'aserebryakov/vim-todo-lists' " funny todo-lists, extension *.todo required

Plugin 'sickill/vim-pasta' " context-aware pasting with auto indentation, passive

Plugin 'kshenoy/vim-signature' " navigating marks
"  m[a-zA-Z]    : Toggle mark
"  m,           : Place the next available mark
"  m[0-9]       : Toggle the corresponding marker !@#$%^&*()
"  ]', ['       : Jump to next\previous
"  m + Space\Backspace : Delete all marks\signs

Plugin 'leafgarland/typescript-vim' " this and following - syntax highlight for typescript
Plugin 'peitalin/vim-jsx-typescript'

call vundle#end()

filetype plugin indent on

set cursorline
hi CursorLine   cterm=NONE ctermbg=8 ctermfg=NONE

" custom plagin settings
let NERDTreeShowHidden=1
autocmd Filetype * AnyFoldActivate
set foldlevel=99
let g:airline_theme='bubblegum'
let g:VimTodoListsMoveItems = 0
let g:nerdtree_tabs_open_on_console_startup=1
