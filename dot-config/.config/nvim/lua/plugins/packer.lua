local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_repo = 'https://github.com/wbthomason/packer.nvim'
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({ { 'Installing packer.nvim', 'Type' } }, true, {})
  execute(install_cmd)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use, use_rocks)
  use 'wbthomason/packer.nvim'
  -- === Language agnostic editing plugins ===
  use { 'jiangmiao/auto-pairs' } -- auto-close brackets plugin
  use { 'alvan/vim-closetag' } -- auto close html tags
  use { 'tpope/vim-surround' } -- cs<surrounding1><surrounding2> ds<surrounding1>
  use { 'b3nj5m1n/kommentary' } -- visual select + gc
  use { 'SirVer/ultisnips' } -- :UltiSnips...
  use { 'wellle/targets.vim' } -- Additional text objects: e.g. inside *, inside comma-separated list etc.
  use { 'godlygeek/tabular' } -- Adds :Tabularize command

  use { 'prettier/vim-prettier' } -- :Prettier
  use { 'ggandor/lightspeed.nvim' } -- Ultimate screen-jumping plugin
  use { 'tpope/vim-repeat' } -- zero-config, allows to repeat complex commands
  use { 'AndrewRadev/splitjoin.vim' } -- gJ and gS to split\join statements in multiple languages 
  use { 'AndrewRadev/sideways.vim' } -- :SidewaysLeft and :SidewaysRight to swap list items 
  -- use {'matze/vim-move'} -- Allows to move lines up and down with Alt
  use { 'sk1418/HowMuch' } -- https://github.com/sk1418/HowMuch
  use { 'ThePrimeagen/harpoon' } -- Keep track of latest files you work with
  use { 'L3MON4D3/LuaSnip' } -- Snippets engine!
  use { 'ThePrimeagen/refactoring.nvim' }

  -- === Vim utilities ===
  use { 'lambdalisue/suda.vim' } -- reenter sudo editing with :Suda

  use { 'nanotee/luv-vimdocs' } -- docs for libuv
  use { 'milisims/nvim-luaref' } -- docs for lua

  -- === Git ===
  use { 'tpope/vim-fugitive' } -- :G
  use { -- Enable git changes to be shown in sign column
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }

  -- === UI === --
  use { 'junegunn/goyo.vim' } -- distractionless mode
  use { 'junegunn/limelight.vim' } -- highlight only current paragraph
  use { 'hoob3rt/lualine.nvim' }
  use { 'glepnir/galaxyline.nvim' } -- someday.. you will write your own
  use { 'karb94/neoscroll.nvim' } -- smooth scroll
  use { 'edluffy/specs.nvim' } -- cursor jump landing visualization 
  use { 'kyazdani42/nvim-tree.lua' } --File explorer
  use { 'dbeniamine/cheat.sh-vim' } -- Cheat sheet plugin
  use { 'azabiong/vim-highlighter' } -- Highlight words on a whim
  use { 'vifm/vifm.vim' } -- Double side file manager
  use { 'qxxxb/vim-searchhi' } -- Highlight current hlsearch pattern differently
  use { 'rcarriga/nvim-notify' } -- Cool notifications!
  use { 'goolord/alpha-nvim' } -- cool startup screen!
  use { 'ellisonleao/carbon-now.nvim' } -- take code screenshots!
  use { 'akinsho/toggleterm.nvim' } -- toggle terminal per session
  use { 'lewis6991/nvim-treesitter-context' } -- accumulates context at the 1-2 lines of the file
  use { 'folke/which-key.nvim' }
  use { 'lukas-reineke/indent-blankline.nvim' }

  -- Now, I do not use this as vimwiki, but does nice markdown
  -- per-line formatting (highlights `` and hides tildas itself)
  -- use {'vimwiki/vimwiki'}

  -- === Colorschemes === --
  use { 'morhetz/gruvbox' }
  -- use {'savq/melange'}
  -- use {'sainnhe/everforest'}
  -- use {'sainnhe/sonokai'}

  -- === TMUX === --
  use { 'christoomey/vim-tmux-navigator' } -- Allows to use <C-hjkl> to move to/from tmux panes
  use { 'sjl/vitality.vim' } -- Restore FocusGained, FocusLost

  -- === LSP and completion ===
  use { 'neovim/nvim-lspconfig' }
  -- completion core and completion sources
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  use { 'andersevenrud/cmp-tmux' }
  use { 'saadparwaiz1/cmp_luasnip' }


  -- === Treesitter ===
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground' }
  use { 'p00f/nvim-ts-rainbow' }

  -- === Telescope ===
  use { 'nvim-telescope/telescope.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- === Language specific ===
  use { 'hashivim/vim-terraform' }
  use { 'psf/black' } -- Black

  -- === DevOps specific ===
  -- use {'chipsenkbeil/distant.nvim'} -- TODO try again, some major update happened, maybe itll work now

  -- === Plugin \ Lua development ===
  use { '/home/jorres/hobbies/plugins/showmethat' }

  use { 'tjdevries/colorbuddy.nvim' }

  -- === Actual programming ==
  use { 'vim-test/vim-test' }

  -- === Dependencies ===
  use { 'tami5/sqlite.lua' }
  use { 'ryanoasis/vim-devicons' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'xolox/vim-misc' }
  use { 'onsails/lspkind-nvim' }

  -- === Removed due to being unused ===
  -- use { 'Jorres/best-diff-ever.nvim' } -- if using from GitHub
  -- use { '/home/jorres/hobbies/plugins/best-diff-ever.nvim' } -- if using locally
end)