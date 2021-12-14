" migrate these settings later to nvim-tree, once available 
let g:nvim_tree_special_files = { 'README.md': 0, 'Makefile': 0 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = { 'git': 0, 'folders': 1, 'files': 1, 'folder_arrows': 1 }

lua require("plugins")
lua require("jorres")
lua require("packer.luarocks").install_commands()

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

" set foldmethod=marker

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

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
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
" Editor theme
set background=dark
try
  colorscheme melange
catch
  colorscheme slate
endtry

hi DiffRemoved ctermfg=12 ctermbg=NONE guibg=NONE
hi DiffDelete ctermfg=12 ctermbg=NONE guibg=NONE


" show custom message after writing to a buffer                                                             
" autocmd BufWritePost * redraw | echomsg 'Wanna bet?'

" autocmd CursorHold * lua require'lspsaga.diagnostic'.show_cursor_diagnostics()

autocmd BufEnter,FocusGained,WinEnter * :NvimTreeRefresh

" === Mappings ===

tnoremap <c-[> <c-\><c-n>
nnoremap Y yg_

" Make jumps centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
inoremap , ,<c-g>u
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u

" Include relative jumps into jump stack for c-i\c-o
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

"" " Location list remaps
nmap <leader>, :cnext<CR>
nmap <leader>. :cprev<CR>
nmap <leader>q :copen<CR>

nnoremap <leader>f :TroubleToggle<CR>

nnoremap <leader>gs :lua require('telescope.builtin').live_grep{}<CR>
nnoremap <leader>gc :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>t :lua require('telescope.builtin').git_files()<CR>

nnoremap <leader>j :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>b :lua require('jorres.telescope').git_branches()<CR>
nnoremap <leader>vrc :lua require('jorres.telescope').search_dotfiles()<CR>

nnoremap <leader>pr :Prettier<CR>

" distracts :( nohlsearch
nnoremap <CR> :noh<CR><CR>

nmap <silent> <leader>n :NvimTreeFindFileToggle<CR>

nmap <leader>ha :lua require("harpoon.mark").add_file()<CR>
nmap <silent> <leader>hm :lua require("harpoon.ui").toggle_quick_menu()<CR>
nmap <silent> <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nmap <silent> <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nmap <silent> <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nmap <silent> <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
nmap <silent> <leader>5 :lua require("harpoon.ui").nav_file(5)<CR>
nmap <silent> <leader>6 :lua require("harpoon.ui").nav_file(6)<CR>
nmap <silent> <leader>7 :lua require("harpoon.ui").nav_file(7)<CR>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" nnoremap <silent> K :Lspsaga hover_doc<CR>
" nnoremap <silent> <leader>da <cmd>lua require('lspsaga.codeaction').code_action()<CR>
" nnoremap <silent> <leader>dn :Lspsaga rename<CR>
" nnoremap <silent> <leader>pp :Lspsaga preview_definition<CR>

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

noremap <silent> U :vertical resize +5<CR>

nnoremap <leader>src :source $MYVIMRC<CR>
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

" === Goyo ===
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Plugin changes to default settings
let g:prettier#autoformat = 0
let g:prettier#autoformat_require_pragma = 0
let g:python3_host_prog = '/usr/bin/python3'
let g:signify_sign_delete = '-'

let g:minimap_width = 15
let g:minimap_highlight_range = 1

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
