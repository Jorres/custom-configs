" migrate these settings later to nvim-tree, once available 
let g:nvim_tree_special_files = { 'README.md': 0, 'Makefile': 0 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = { 'git': 0, 'folders': 1, 'files': 1, 'folder_arrows': 1 }
let g:nvim_tree_indent_markers = 1

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
set termguicolors
function! MyHighlight() abort

hi TelescopeBorder guifg=#252525 guibg=#252525
hi TelescopeNormal guibg=#252525

hi TelescopePromptTitle guifg=#252525 guibg=#C6393D
hi TelescopePromptBorder guifg=#303030 guibg=#303030
hi TelescopePromptNormal guifg=#FFFFFF guibg=#303030
hi TelescopePromptPrefix guifg=#C6393D guibg=#303030

hi TelescopePreviewTitle guifg=#252525 guibg=#393DC6

hi TelescopeResultsTitle guifg=#252525 guibg=#3DC639

hi TelescopeSelection guibg=#404040

hi VertSplit guifg=Gray

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
  let g:sonokai_style = 'atlantis'
  let g:sonokai_enable_italic = 1
  let g:sonokai_disable_italic_comment = 1
  colorscheme sonokai
catch
  colorscheme slate
endtry

" show custom message after writing to a buffer                                                             
" autocmd BufWritePost * redraw | echomsg 'Wanna bet?'

" autocmd CursorHold * lua require'lspsaga.diagnostic'.show_cursor_diagnostics()

" autocmd BufEnter,FocusGained,WinEnter * :NvimTreeRefresh

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

" Location list remaps
nmap <leader>, :cnext<CR>
nmap <leader>. :cprev<CR>
nmap <leader>q :copen<CR>

" Telescope
nnoremap <leader>gs :lua require('telescope.builtin').live_grep{}<CR>
nnoremap <leader>gc :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>t :lua require('telescope.builtin').git_files()<CR>

nnoremap <leader>j :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>br :lua require('jorres.telescope').git_branches()<CR>
nnoremap <leader>vrc :lua require('jorres.telescope').search_dotfiles()<CR>
nnoremap <leader>y :lua require('telescope').extensions.neoclip.default()<CR>

" Gitsigns
nnoremap <silent> <leader>bl :Gitsigns toggle_current_line_blame<CR>
nnoremap <leader>hs :Gitsigns stage_hunk<CR>
nnoremap <leader>hr :Gitsigns reset_hunk<CR>
nnoremap <leader>hu :Gitsigns undo_stage_hunk<CR>
nnoremap <leader>hp :Gitsigns preview_hunk<CR>
vnoremap <leader>hs :Gitsigns stage_hunk<CR>
vnoremap <leader>hr :Gitsigns reset_hunk<CR>
vnoremap <leader>hu :Gitsigns undo_stage_hunk<CR>
vnoremap <leader>hp :Gitsigns preview_hunk<CR>

nnoremap <leader>pr :Prettier<CR>

" Persistent highlight from hlsearch distracts.
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

" Magma mappings
nnoremap <silent><expr> <leader>r  :MagmaEvaluateOperator<CR>
nnoremap <silent>       <leader>rr :MagmaEvaluateLine<CR>
xnoremap <silent>       <leader>r  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent>       <leader>rc :MagmaReevaluateCell<CR>
nnoremap <silent>       <leader>rd :MagmaDelete<CR>
nnoremap <silent>       <leader>ro :MagmaShowOutput<CR>
let g:magma_automatically_open_output = v:false

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
