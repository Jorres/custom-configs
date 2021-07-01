scriptencoding utf-8
source ~/.config/nvim/plugins.vim

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

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

augroup both_folds
  au BufReadPre * setlocal foldmethod=syntax
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
augroup END

" Don't show last command
set noshowcmd

" Yank and paste with the system clipboard
set clipboard=unnamedplus

" Hides buffers instead of closing them
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Quickfix list remaps (ripgrep populates it in an interface unknown to me):
nmap <leader>, :cnext<CR>
nmap <leader>. :cprev<CR>
nmap <C-q> :copen<CR>

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

" distracts :(
" set nohlsearch
" instead of disabling it, hit enter once more when exiting search
nnoremap <CR> :noh<CR><CR>

" Scrolling by blocks of 4, generally faster
nnoremap <C-E> 4<C-E>
nnoremap <C-Y> 4<C-Y>

" === Completion Settings === "

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Set show documentation in coc
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Source for show documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

let g:coc_global_extensions = []

" magic that allows auto-completion on <TAB> and 
" auto-import on auto-completion
inoremap <silent><expr> <TAB>    
      \ pumvisible() ? "\<C-n>" :    
      \ <SID>check_back_space() ? "\<TAB>" :           
      \ coc#refresh()               
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"      
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    
" Check if backspace was just pressed      
function! s:check_back_space() abort                    
  let col = col('.') - 1    
  return !col || getline('.')[col - 1]  =~# '\s'    
endfunction   

command! -nargs=0 Prettier :CocCommand prettier.formatFile

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" === NERDTree === " 
" Show hidden files/directories 
let g:NERDTreeShowHidden = 1     
 
" Remove bookmarks and help text from NERDTree 
let g:NERDTreeMinimalUI = 1 
 
" Custom icons for expandable/expanded directories 
let g:NERDTreeDirArrowExpandable = '⬏' 
let g:NERDTreeDirArrowCollapsible = '⬎' 
   
" Wrap in try/catch to avoid errors on initial install before plugin is available
try

" === Vim airline ==== "
" Enable extensions
let g:airline_extensions = ['branch', 'hunks', 'coc']

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Customize vim airline per filetype
" 'nerdtree'  - Hide nerdtree status line
" 'list'      - Only show file type plus current line number out of total
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }

" Enable powerline fonts, try to fix
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

" === vim-jsx === "
" Highlight jsx syntax even in non .jsx files
let g:jsx_ext_required = 0

" === javascript-libraries-syntax === "
let g:used_javascript_libs = 'underscore,requirejs,chai,jquery'

" === Signify === "
let g:signify_sign_delete = '-'

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Enable true color support
set termguicolors

" Vim airline theme
let g:airline_theme='gruvbox'

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" ============================================================================ "
" ===                      CUSTOM COLORSCHEME CHANGES                      === "
" ============================================================================ "
"

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" Editor theme
set background=dark
try
  colorscheme gruvbox
catch
  colorscheme slate
endtry
" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

"   <Space> - PageDown
"   -       - PageUp
noremap <Space> <PageDown>
noremap - <PageUp>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" === coc.nvim === "
"   <leader>dd    - Jump to definition of current symbol
"   <leader>dr    - Jump to references of current symbol
"   <leader>dj    - Jump to implementation of current symbol
"   <leader>dn    - Open refactoring (basically renaming) window
"   <leader>da    - list of possible code actions
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)
nmap <silent> <leader>dn <Plug>(coc-refactor)
nmap <silent> <leader>da <Plug>(coc-action-codeAction)


" Mappings to select in\around function and in\around
" class\structure\declaration
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" === Easy-motion shortcuts ==="
"   w - beginnings of words, e - ends, s - searches for char, a = union(w, e, camelCase, _)
map <leader>w <Plug>(easymotion-bd-w)
map <leader>e <Plug>(easymotion-bd-e)
map <leader>s <Plug>(easymotion-s)
map <leader>a <Plug>(easymotion-jumptoanywhere)

autocmd User EasyMotionPromptBegin silent! CocDisable
autocmd User EasyMotionPromptEnd silent! CocEnable

" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "
"
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" --- fzf ---
let g:fzf_layout = {'window': {'width': 1, 'height': 1}}
nnoremap <leader>t :GFiles<CR>
nnoremap <leader>gc :GBranches<CR>
nnoremap <silent> <leader>j :Ag <C-R><C-W><CR>
nnoremap <silent> <leader>g :Ag

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Enable hybrid line numbers
set number
set relativenumber

" Enable spellcheck for markdown files
" autocmd BufRead,BufNewFile *.md setlocal spell

" Change split separator
set fillchars+=vert:│

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile

let g:fzf_preview_use_dev_icons = 1
let g:rainbow_active = 1
let g:python3_host_prog = '/usr/bin/python3'
let g:session_autosave = 'no'

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" show custom message after writing to a buffer                                                             
" autocmd BufWritePost * redraw | echomsg 'Wanna bet?'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Ripgrep smart search enable
let g:rg_command = 'rg --vimgrep -S'

" Calculating equations with ,bc
vnoremap <leader>bc "ey:call CalcBC()<CR>
function! CalcBC()
  let has_equal = 0
  " remove newlines and trailing spaces
  let @e = substitute (@e, "\n", "", "g")
  let @e = substitute (@e, '\s*$', "", "g")
  " if we end with an equal, strip, and remember for output
  if @e =~ "=$"
    let @e = substitute (@e, '=$', "", "")
    let has_equal = 1
  endif
  " sub common func names for bc equivalent
  let @e = substitute (@e, '\csin\s*(', "s (", "")
  let @e = substitute (@e, '\ccos\s*(', "c (", "")
  let @e = substitute (@e, '\catan\s*(', "a (", "")
  let @e = substitute (@e, "\cln\s*(", "l (", "")
  " escape chars for shell
  let @e = escape (@e, '*()')
  " run bc, strip newline
  let answer = substitute (system ("echo " . @e . " \| bc -l"), "\n", "", "")
  " append answer or echo
  if has_equal == 1
    normal `>
    exec "normal a" . answer
  else
    echo "answer = " . answer
  endif
endfunction


map q: <nop>

" Ultisnips configuration
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<M-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" load changes from vim
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc
