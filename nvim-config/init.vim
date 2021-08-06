call plug#begin('~/.config/nvim/plugged')

" === lang-agnostic editing plugins ===
" auto-close brackets plugin
Plug 'jiangmiao/auto-pairs'
" auto close html tags
Plug 'alvan/vim-closetag'
" surrounding plugin, cs, ds...
Plug 'tpope/vim-surround'
" commenting shortcuts, gc, yeah
Plug 'tpope/vim-commentary' 
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
" distractionless mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" File explorer
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
                    
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
" Plug 'nvim-treesitter/playground'
Plug 'p00f/nvim-ts-rainbow'

Plug 'glepnir/lspsaga.nvim'

Plug 'ryanoasis/vim-devicons'

" cool animated status line
Plug 'windwp/windline.nvim'

" allows repeating through `.` key complex actions from other plugins
Plug 'tpope/vim-repeat'

Plug 'prettier/vim-prettier'

Plug 'justinmk/vim-sneak'
Plug 'wfxr/minimap.vim'

Plug 'AndrewRadev/splitjoin.vim'

Plug 'matze/vim-move'

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
" set nocursorline

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

" https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
" Automatically re-read file if a change was detected outside of vim
set autoread
" This reloads files when you re-focus vim
au FocusGained,WinEnter,BufEnter * :silent! !
" This saves file when you lose focus on vim

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
set fillchars+=vert:│
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

" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" === Mappings ===

" Location list remaps (ripgrep populates it in an interface unknown to me):
nmap <leader>, :lnext<CR>
nmap <leader>. :lprev<CR>
nmap <leader>q :lopen<CR>

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
nmap <leader>n <Plug>NERDTreeToggle<CR>
nmap <leader>f <Plug>NERDTreeFind<CR>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nnoremap <leader>t :GFiles<CR>
nnoremap <silent> <leader>j :Ag <C-R><C-W><CR>
nnoremap <silent> <leader>g :Ag<C-R> 
nnoremap <leader>ll :lua vim.lsp.diagnostic.set_loclist({open_loclist=false})<CR>

let @r = 'vasy:redir >> /home/jorres/hobbies/diary/personal/neural.md | silent echon @" | redir END'
nnoremap <silent> <leader>an @r<CR>

" Ultisnips mapping
let g:UltiSnipsExpandTrigger="<M-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Autocompletion mapping 
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

nnoremap <silent> K :Lspsaga hover_doc<CR>
nnoremap <silent> <leader>da <cmd>lua require('lspsaga.codeaction').code_action()<CR>
nnoremap <silent> <leader>dn :Lspsaga rename<CR>
nnoremap <silent> <leader>pp :Lspsaga preview_definition<CR>

" " terminal mode remaps
" tnoremap <Esc> <C-\><C-n>
" tnoremap <C-[> <C-\><C-n>
" tnoremap <M-[> <Esc>
" tnoremap <C-v><Esc> <Esc>
"
" tnoremap <M-h> <c-\><c-n><c-w>h
" tnoremap <M-j> <c-\><c-n><c-w>j
" tnoremap <M-k> <c-\><c-n><c-w>k
" tnoremap <M-l> <c-\><c-n><c-w>l
" " Insert mode:
" inoremap <M-h> <Esc><c-w>h
" inoremap <M-j> <Esc><c-w>j
" inoremap <M-k> <Esc><c-w>k
" inoremap <M-l> <Esc><c-w>l
" " Visual mode:
" vnoremap <M-h> <Esc><c-w>h
" vnoremap <M-j> <Esc><c-w>j
" vnoremap <M-k> <Esc><c-w>k
" vnoremap <M-l> <Esc><c-w>l
" " Normal mode:
" nnoremap <M-h> <c-w>h
" nnoremap <M-j> <c-w>j
" nnoremap <M-k> <c-w>k
" nnoremap <M-l> <c-w>l

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" Errors in Red
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
" Warnings in Yellow
hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
" Info and Hints in White
hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White

" Underline the offending code
hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline

" === fzf ===
let g:fzf_layout = {'window': {'width': 1, 'height': 1}}
" Ripgrep smart search enable
let g:rg_command = 'rg --vimgrep -S'

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
let g:prettier#autoformat = 0
let g:prettier#autoformat_require_pragma = 0
let g:fzf_preview_use_dev_icons = 1
let g:python3_host_prog = '/usr/bin/python3'
let g:session_autosave = 'no'
let g:signify_sign_delete = '-'
let g:UltiSnipsEditSplit="vertical"

let g:minimap_width = 15
let g:minimap_highlight_range = 1

let g:closetag_filenames = '*.html,*.jsx,*.tsx'
let g:closetag_regions =  {
\ 'typescript.tsx': 'jsxRegion,tsxRegion',
\ 'javascript.jsx': 'jsxRegion',
\ }
let g:session_autoload = 'no'

