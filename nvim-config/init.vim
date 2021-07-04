call plug#begin('~/.config/nvim/plugged')

" === lang-agnostic editing plugins ===
" auto-close brackets plugin
Plug 'jiangmiao/auto-pairs'
" auto close html tags
Plug 'alvan/vim-closetag'
" surrounding plugin, cs, ds...
Plug 'tpope/vim-surround'
" commenting shortcuts, gc, yeah
Plug 'tomtom/tcomment_vim' 
" Display visual marks (`ma`) in separate column
Plug 'kshenoy/vim-signature'

" === Git Plugins === "
" Global vim :G git manager
Plug 'tpope/vim-fugitive'
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'

" Provides OpenSession and SaveSession
Plug 'xolox/vim-misc' 
Plug 'xolox/vim-session'

" === UI === "
" Fancy starting screen
Plug 'mhinz/vim-startify'
" distractionless mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" File explorer
Plug 'scrooloose/nerdtree'
" Colorschemes
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'morhetz/gruvbox'
" Customized vim status line
" Plug 'vim-airline/vim-airline'

" === Fuzzy finder
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Overrides :Rg command from fzf, outputs to quickfix list. 
" The older behaviour is replicated by Ag `silver finder` now.
Plug 'jremmen/vim-ripgrep'

" You've long been dreaming about box ascii art to create ascii schematics.
Plug 'vim-scripts/DrawIt'

" Allows to use <C-hjkl> to move to/from tmux panes
Plug 'christoomey/vim-tmux-navigator'
" Allows to mimic tmux <pref>Z with <C-W>m
Plug 'dhruvasagar/vim-zoom'

" Snippets engine, run :UltiSnips...
Plug 'SirVer/ultisnips'

" https://github.com/sk1418/HowMuch
Plug 'sk1418/HowMuch'

" Latest LSP experiment
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'p00f/nvim-ts-rainbow'

Plug 'glepnir/lspsaga.nvim'

Plug 'ryanoasis/vim-devicons'

" cool animated status line
Plug 'windwp/windline.nvim'

call plug#end()

lua require("jorres")

scriptencoding utf-8

" Remap leader key to ,
let g:mapleader=','

" Map russian key commands
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Ability to move to any symbol position
set virtualedit=all

" Natural behavior when splitting windows
set splitbelow
set splitright

" Set column where error appears to avoid shift on error
set signcolumn=yes

" Folding 
set foldlevelstart=99

set splitbelow
set splitright

" Don't show last command
set noshowcmd

" Yank and paste with the system clipboard
set clipboard=unnamedplus

" === TAB/Space settings === "
" Insert spaces when TAB is pressed.
set expandtab
" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=4
" Indentation amount for < and > commands.
set shiftwidth=4

" do not wrap long lines by default
set nowrap

" Don't highlight current cursor line
set nocursorline

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=500

" === Completion Settings === "
set shortmess+=c

" ignore case when searching
set ignorecase
" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread
" This reloads files when you re-focus vim
au FocusGained,WinEnter,BufEnter * :silent! !
" This saves file when you lose focus on vim
" https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
au FocusLost,WinLeave * :silent! w

" Enable hybrid line numbers
set number
set relativenumber

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile


" === UI ===
" Enable true color support
set termguicolors
" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.
" Don't dispay mode in command line (airilne already shows it)
set noshowmode
" Editor theme
set background=dark
try
  colorscheme gruvbox
catch
  colorscheme slate
endtry

" show custom message after writing to a buffer                                                             
" autocmd BufWritePost * redraw | echomsg 'Wanna bet?'

" === Mappings ===

" Quickfix list remaps (ripgrep populates it in an interface unknown to me):
nmap <leader>, :cnext<CR>
nmap <leader>. :cprev<CR>
nmap <C-q> :copen<CR>

" distracts :( nohlsearch
" instead of disabling it, hit enter once more when exiting search
nnoremap <CR> :noh<CR><CR>

" Scrolling by blocks of 4, generally faster
nnoremap <C-E> 4<C-E>
nnoremap <C-Y> 4<C-Y>
vnoremap <C-E> 4<C-E>
vnoremap <C-Y> 4<C-Y>

"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nnoremap <leader>t :GFiles<CR>
nnoremap <silent> <leader>j :Ag <C-R><C-W><CR>
nnoremap <silent> <leader>g :Ag

map q: <nop>

" Ultisnips mapping
let g:UltiSnipsExpandTrigger="<M-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Autocompletion mapping 
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

nnoremap <silent> K :Lspsaga hover_doc<CR>
nnoremap <silent> <leader>da <cmd>lua require('lspsaga.codeaction').code_action()<CR>
nnoremap <silent> <leader>dn :Lspsaga rename<CR>
nnoremap <silent> <leader>pp :Lspsaga preview_definition<CR>

nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" === fzf ===
let g:fzf_layout = {'window': {'width': 1, 'height': 1}}
" Ripgrep smart search enable
let g:rg_command = 'rg --vimgrep -S'


"" === Vim airline ==== "
" let g:airline_theme='gruvbox'
" " Enable extensions
" let g:airline_extensions = ['branch', 'hunks']
" " Update section z to just have line number
" let g:airline_section_z = airline#section#create(['linenr'])
" " Do not draw separators for empty sections (only for the active window) >
" let g:airline_skip_empty_sections = 1
" " Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
" let g:airline#extensions#tabline#formatter = 'unique_tail'
" " Custom setup that removes filetype/whitespace from default vim airline bar
" let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]
" " Customize vim airline per filetype
" " 'nerdtree'  - Hide nerdtree status line
" " 'list'      - Only show file type plus current line number out of total
" let g:airline_filetype_overrides = {
"   \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
"   \ 'list': [ '%y', '%l/%L'] }
" " Enable powerline fonts, try to fix
" let g:airline_powerline_fonts = 1
" " Enable caching of syntax highlighting groups
" let g:airline_highlighting_cache = 1
" " Don't show git changes to current file in airline
" let g:airline#extensions#hunks#enabled=0

" === NERDTree === " 
" Show hidden files/directories 
let g:NERDTreeShowHidden = 1     
" Remove bookmarks and help text from NERDTree 
let g:NERDTreeMinimalUI = 1 
" Custom icons for expandable/expanded directories 
let g:NERDTreeDirArrowExpandable = '⬏' 
let g:NERDTreeDirArrowCollapsible = '⬎' 

" === Goyo ===
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Plugin changes to default settings

let g:fzf_preview_use_dev_icons = 1
let g:python3_host_prog = '/usr/bin/python3'
let g:session_autosave = 'no'
let g:signify_sign_delete = '-'
let g:UltiSnipsEditSplit="vertical"
