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

Plug 'hoob3rt/lualine.nvim'
" cool animated statusline, for history purposes
" Plug 'windwp/windline.nvim'

" allows repeating through `.` key complex actions from other plugins
Plug 'tpope/vim-repeat'

Plug 'prettier/vim-prettier'

Plug 'justinmk/vim-sneak'

Plug 'AndrewRadev/splitjoin.vim'

Plug 'matze/vim-move'

Plug 'mattn/emmet-vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" violet color scheme
Plug 'wadackel/vim-dogrun'
" green color scheme
Plug 'sainnhe/everforest'

Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }

Plug 'hashivim/vim-terraform'
" A cool diffview, however it messes up with my colorscheme, have to look
" further
" Plug 'sindrets/diffview.nvim'
Plug 'martingms/vipsql'

" An attempt to be professional with debugger enabled
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" A zero-config plugin to give you last used results for telescope by default
Plug 'tami5/sqlite.lua'
Plug 'nvim-telescope/telescope-frecency.nvim'
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
let g:everforest_background = 'hard'
try
  colorscheme gruvbox
catch
  colorscheme slate
endtry

" show custom message after writing to a buffer                                                             
" autocmd BufWritePost * redraw | echomsg 'Wanna bet?'

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" === Mappings ===

" " Location list remaps (ripgrep populates it in an interface unknown to me):
" nmap <leader>, :lnext<CR>
" nmap <leader>. :lprev<CR>
" nmap <leader>q :lopen<CR>

" nnoremap <leader>ll :lua vim.lsp.diagnostic.set_loclist({open_loclist=false})<CR>

nnoremap <leader>gs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>gc :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>t :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>f :Telescope frecency<CR>


nnoremap <leader>j :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>b :lua require('jorres.telescope').git_branches()<CR>
nnoremap <leader>vrc :lua require('jorres.telescope').search_dotfiles()<CR>

nnoremap <leader>pr :Prettier<CR>

" nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
" nnoremap <leader>va :lua require('theprimeagen.telescope').anime_selector()<CR>
" nnoremap <leader>vc :lua require('theprimeagen.telescope').chat_selector()<CR>
" nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
" nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>

" distracts :( nohlsearch
" instead of disabling it, hit enter once more when exiting search
nnoremap <CR> :noh<CR><CR>

" Scrolling by blocks of 4, generally faster
nnoremap <C-E> 4<C-E>
nnoremap <C-Y> 4<C-Y>
vnoremap <C-E> 4<C-E>
vnoremap <C-Y> 4<C-Y>

nmap <silent> <leader>n :NERDTreeFind<CR>
" nmap <silent> <leader>f :NERDTreeFind<CR>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

let @r = 'vasy:redir >> /home/jorres/hobbies/lifelog/personal/neural.md | silent echon @" | redir END'
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

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

nnoremap <silent> Y :vertical resize +5<CR>
nnoremap <silent> U :vertical resize -5<CR>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" define line highlight color
highlight LineHighlight ctermbg=Blue guibg=#ffd787 guifg=Black

nnoremap <leader>src :source $MYVIMRC<CR>
nnoremap <leader>plgi :PlugInstall<CR>
nnoremap <leader>plgc :PlugClean<CR>

" Starts an async psql job, prompting for the psql arguments.
" Also opens a scratch buffer where output from psql is directed.
noremap <leader>po :VipsqlOpenSession<CR>

" Terminates psql (happens automatically if the output buffer is closed).
noremap <silent> <leader>pk :VipsqlCloseSession<CR>

" In normal-mode, prompts for input to psql directly.
nnoremap <leader>ps :VipsqlShell<CR>

" In visual-mode, sends the selected text to psql.
vnoremap <leader>ps :VipsqlSendSelection<CR>

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
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1

" Whether or not to clear the output buffer on each send
let g:vipsql_auto_clear_enabled = 1
" What `vim` command to use when opening the output buffer
let g:vipsql_new_buffer_cmd = "vsplit"
