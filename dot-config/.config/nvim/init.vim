scriptencoding utf-8

" Remap leader key to ,
let g:mapleader=','

set completeopt="menu,menuone,preview"

lua require("plugins")
lua require("jorres")
lua require("packer.luarocks").install_commands()

" Map russian key commands
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Ability to move to any symbol position
set virtualedit=all

" Natural behavior when splitting windows
set splitbelow
set splitright

" Set column where error appears to avoid shift on error
set signcolumn=yes

" set foldmethod=marker

" Don't show last command
set noshowcmd

" Yank and paste with the system clipboard
set clipboard=unnamedplus

" === TAB/Space settings === "
" Insert spaces when TAB is pressed.
set expandtab
" Change number of spaces that a <Tab> counts for during editing ops
set tabstop=2
" Indentation amount for < and > commands.
set shiftwidth=2

" do not wrap long lines by default
set nowrap

" Timeout for UI refresh in some cases, default 4000, feels bad
set updatetime=500

" === Completion Settings === "
set shortmess+=c

set ignorecase
" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
" Automatically re-read file if a change was detected outside of vim
set autoread
" This reloads files when you re-focus vim
au FocusGained,WinEnter,BufEnter * :silent! !

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
set termguicolors
function! MyHighlight() abort
    lua package.loaded["jorres.colorbuddy"] = nil 
    lua require("jorres.colorbuddy")

    hi VertSplit guifg=Gray

    hi DiffAdd guifg=Green
    hi DiffDelete guifg=Red guibg=NONE
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlight()
augroup END

" Change splits separator to be a nice vertical bar
set fillchars+=vert:│

" Set colorscheme
set background=dark
try
  let g:everforest_background = 'hard'
  " let g:sonokai_style = 'atlantis'
  " let g:sonokai_enable_italic = 1
  " let g:sonokai_disable_italic_comment = 1
  colorscheme everforest
catch
  colorscheme slate
endtry

" === Mappings ===

tnoremap <c-[> <c-\><c-n>
nnoremap Y yg_

nnoremap J mzJ`z

" Undo break points
inoremap , ,<c-g>u
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u

" Include relative jumps into jump stack for c-i\c-o
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Quickfixlist remaps
nmap [ :cnext<CR>
nmap ] :cprev<CR>
nmap <leader>q :cclose<CR>
nmap <leader>o :copen 5<CR>

" Telescope
nnoremap <leader>gs :lua require('telescope.builtin').live_grep({hidden = true})<CR>
nnoremap <leader>gc :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>t :lua require('telescope.builtin').git_files({hidden=true})<CR>

nnoremap <leader>j :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>br :lua require('jorres.telescope').git_branches()<CR>
nnoremap <leader>vrc :lua require('jorres.telescope').search_dotfiles()<CR>
nnoremap <leader>y :lua require('telescope').extensions.neoclip.default()<CR>

" Keep notes
nnoremap <leader>kt :GkeepToggle<CR>
nnoremap <leader>kl :GkeepLogin<CR>
nnoremap <leader>kb :GkeepBrowse<CR>
nnoremap <leader>kn :GkeepNew<CR>

" Fugitive
nnoremap <leader>gfh <cmd>0Gclog<CR>
nnoremap <leader>ge <cmd>Gedit<CR>
nnoremap <leader>pr <cmd>Prettier<CR>

" Persistent highlight from hlsearch distracts.
nnoremap <silent> <CR> :noh<CR><CR>

nmap <silent> <leader>n :NvimTreeFindFileToggle<CR>

" Magma mappings
nnoremap <silent><expr> <leader>m  :MagmaEvaluateOperator<CR>
nnoremap <silent>       <leader>mr :MagmaEvaluateLine<CR>
xnoremap <silent>       <leader>m  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent>       <leader>mc :MagmaReevaluateCell<CR>
nnoremap <silent>       <leader>md :MagmaDelete<CR>
nnoremap <silent>       <leader>mo :MagmaShowOutput<CR>
let g:magma_automatically_open_output = v:false

tnoremap <Esc> <C-\><C-n>
tnoremap <c-[> <C-\><C-n>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

noremap <silent> U :vertical resize +5<CR>
noremap <silent> <leader>u :resize +5<CR>

nnoremap <leader>ls :source $MYVIMRC<CR>
nnoremap <leader>pki :PackerInstall<CR>
nnoremap <leader>pkc :PackerClean<CR>

" Starts an async psql job, prompting for the psql arguments.
" Also opens a scratch buffer where output from psql is directed.
noremap <leader>po :VipsqlOpenSession<CR>
" Terminates psql (happens automatically if the output buffer is closed).
noremap <silent> <leader>pk :VipsqlCloseSession<CR>
" In normal-mode, prompts for input to psql directly.
nnoremap <leader>ps :VipsqlShell<CR>
" In visual-mode, sends the selected text to psql.
vnoremap <leader>ps :VipsqlSendSelection<CR>

nnoremap <leader><leader>t :TestFile<CR>

" === Goyo ===
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Plugin changes to default settings
let g:prettier#autoformat = 0
let g:prettier#autoformat_require_pragma = 0

let g:python3_host_prog = '/usr/bin/python3'

let g:closetag_filenames = '*.html,*.jsx,*.tsx'
let g:closetag_regions =  {
\ 'typescript.tsx': 'jsxRegion,tsxRegion',
\ 'javascript.jsx': 'jsxRegion',
\ }

let g:session_autosave = 'no'
let g:session_autoload = 'no'

let g:terraform_fmt_on_save = 1
let g:terraform_align = 1

" Whether or not to clear the output buffer on each send
let g:vipsql_auto_clear_enabled = 1
" What `vim` command to use when opening the output buffer
let g:vipsql_new_buffer_cmd = "vsplit"

set shell=/bin/bash
