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

" distractionless mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
 
"" === Editing Plugins === "

" auto-close plugin
Plug 'jiangmiao/auto-pairs'

" auto close html tags
Plug 'alvan/vim-closetag'

" surrounding plugin
Plug 'tpope/vim-surround'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Trying fzf once again
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" commenting shortcuts
Plug 'tomtom/tcomment_vim' 

" Display visual marks (`ma`) in separate column
Plug 'kshenoy/vim-signature'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
" commands to view nice two-sided diff
Plug 'tpope/vim-fugitive'

" === Haskell Plugins === "
" Plug 'neovimhaskell/haskell-vim'
" Plug 'mpickering/hlint-refactor-vim'
" Plug 'sdiehl/vim-ormolu'

" Persisting your open tabs, buffers and splits in sessions
Plug 'xolox/vim-session'
" A dependency for vim-session
Plug 'xolox/vim-misc' 

" === Syntax Highlighting === "
Plug 'udalov/kotlin-vim'
Plug 'HerringtonDarkholme/yats.vim'

" === weird plugin for rainbow brackets
Plug 'luochen1990/rainbow'

" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" Improved syntax highlighting and indentation
Plug 'othree/yajs.vim'

" Syntax highlight for Sass
Plug 'cakebaker/scss-syntax.vim'

" === UI === "
" Fancy starting screen
Plug 'mhinz/vim-startify'

" File explorer
Plug 'scrooloose/nerdtree'

" Colorschemes
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'morhetz/gruvbox'

" Customized vim status line
Plug 'vim-airline/vim-airline'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" You've long been dreaming about box ascii art to create ascii schematics.
Plug 'vim-scripts/DrawIt'

Plug 'christoomey/vim-tmux-navigator'

Plug 'dhruvasagar/vim-zoom'

" Overrides :Rg command from fzf, outputs to quickfix list. 
" The older behaviour is replicated by Ag `silver finder` now.
Plug 'jremmen/vim-ripgrep'

" Snippets engine
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'

" Telescope
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

" Initialize plugin system
call plug#end()
