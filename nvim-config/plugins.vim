" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" === Editing Plugins === "

" auto-close plugin
Plug 'jiangmiao/auto-pairs'

" surrounding plugin
Plug 'tpope/vim-surround'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Denite - Fuzzy finding, buffer management
Plug 'Shougo/denite.nvim'

" commenting shortcuts
Plug 'tomtom/tcomment_vim' 

" Display visual marks (`ma`) in separate column
Plug 'kshenoy/vim-signature'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
" Plug 'tpope/vim-fugitive' no need yet

" === Haskell Plugins === "
" Plug 'neovimhaskell/haskell-vim'
" Plug 'mpickering/hlint-refactor-vim'
" Plug 'sdiehl/vim-ormolu'

" === Syntax Highlighting === "
Plug 'udalov/kotlin-vim'
Plug 'HerringtonDarkholme/yats.vim'

" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" Improved syntax highlighting and indentation
Plug 'othree/yajs.vim'

" Syntax highlight for Sass
Plug 'cakebaker/scss-syntax.vim'

" Css shortcuts, need to do katas on these
Plug 'rstacruz/vim-hyperstyle/'

" === UI === "
" Fancy starting screen
Plug 'mhinz/vim-startify'

" File explorer
Plug 'scrooloose/nerdtree'

" ctags alternative
Plug 'liuchengxu/vista.vim'

" Colorschemes
Plug 'tyrannicaltoucan/vim-deep-space'

" Customized vim status line
Plug 'vim-airline/vim-airline'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Initialize plugin system
call plug#end()
