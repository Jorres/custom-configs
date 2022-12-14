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

  -- To explore more:
  use { 'ThePrimeagen/refactoring.nvim' }

  use 'wbthomason/packer.nvim'
  -- === Language agnostic editing plugins ===
  use { 'windwp/nvim-autopairs' } -- auto-close brackets plugin
  use { 'tpope/vim-surround' } -- cs<surrounding1><surrounding2> ds<surrounding1>
  use { 'b3nj5m1n/kommentary' } -- visual select + gc
  use { 'wellle/targets.vim' } -- Additional text objects: e.g. inside *, inside comma-separated list etc.
  use { 'godlygeek/tabular' } -- Adds :Tabularize command
  use { 'MunifTanjim/prettier.nvim' } -- :Prettier
  use { 'ggandor/lightspeed.nvim' } -- Ultimate screen-jumping plugin
  use { 'tpope/vim-repeat' } -- zero-config, allows to repeat complex commands
  use { 'AndrewRadev/splitjoin.vim' } -- gJ and gS to split\join statements in multiple languages
  use { 'matze/vim-move' } -- Allows to move lines up and down with Alt
  use { 'sk1418/HowMuch' } -- https://github.com/sk1418/HowMuch
  use { 'ThePrimeagen/harpoon' } -- Keep track of latest files you work with
  use { 'L3MON4D3/LuaSnip' } -- Snippets engine!
  use { 'tpope/vim-abolish' } -- :Subvert, coerce to various cases
  use { 'mbbill/undotree' } -- Visualize undotree
  -- A true blessing. Set shiftwidth to what the buffer is using
  -- instead of hardcoded 2 or hardcoded 4.
  use { 'NMAC427/guess-indent.nvim' }
  -- Submodes
  use { 'anuvyklack/hydra.nvim',
    requires = 'anuvyklack/keymap-layer.nvim' -- needed only for pink hydras
  }
  use { "gbprod/yanky.nvim" } -- yank ring-buffer
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
  use {
    "zbirenbaum/copilot.lua",
    config = function()
      vim.defer_fn(function()
        require "plugins.copilot"
      end, 100)
    end,
  }
  use { "zbirenbaum/copilot-cmp", }
  -- use { "github/copilot.vim" }

  -- === Vim utilities ===
  use { 'lambdalisue/suda.vim' } -- reenter sudo editing with :Suda
  use { 'nanotee/luv-vimdocs' } -- docs for libuv
  use { 'milisims/nvim-luaref' } -- docs for lua
  use { "williamboman/mason.nvim" } -- manager for LSP and such
  use { "williamboman/mason-lspconfig.nvim" } -- manager for LSP and such

  -- === Git ===
  use { 'tpope/vim-fugitive' } -- :G
  use { -- Enable git changes to be shown in sign column
    'lewis6991/gitsigns.nvim',
  }
  use { 'sindrets/diffview.nvim' }
  use { 'ruifm/gitlinker.nvim' }

  -- === UI === --
  use { 'hoob3rt/lualine.nvim' }
  use { 'karb94/neoscroll.nvim' } -- smooth scroll
  use { 'edluffy/specs.nvim' } -- cursor jump landing visualization
  use { 'kyazdani42/nvim-tree.lua' } --File explorer
  use { 'luukvbaal/nnn.nvim' }
  -- use { 'azabiong/vim-highlighter' } -- Highlight words on a whim
  use { 'Pocco81/HighStr.nvim' }
  use { 'PeterRincker/vim-searchlight' } -- Highlight current hlsearch pattern differently
  use { 'uga-rosa/ccc.nvim' }

  use { 'goolord/alpha-nvim' } -- cool startup screen!
  use { 'akinsho/toggleterm.nvim' } -- toggle terminal per session
  use { 'lewis6991/nvim-treesitter-context' } -- accumulates context at the 1-2 lines of the file
  use { 'lukas-reineke/indent-blankline.nvim' } -- draws small symbols for indentation
  use { 'jbyuki/venn.nvim' } -- draw some boxes with VBox
  use { 'mvllow/modes.nvim' } -- highlight the current line with a mode color
  use { 'stevearc/dressing.nvim' } -- improved vim.ui interfaces, like (select) and (input)
  use { "beauwilliams/focus.nvim" }
  use { "folke/noice.nvim", requires = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  } }
  use { 'mrjones2014/legendary.nvim' }
  use { 'Eandrju/cellular-automaton.nvim' }


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
  use { 'nacro90/numb.nvim' }

  -- === Treesitter ===
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground' }
  use { 'p00f/nvim-ts-rainbow' }

  -- === Telescope ===
  use { 'nvim-telescope/telescope.nvim', branch = "0.1.x" }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-media-files.nvim' }

  -- === Language specific
  use { 'hashivim/vim-terraform' }

  -- === Plugin \ Lua development ===
  use { 'tjdevries/colorbuddy.nvim' }
  -- use { '/home/jorres/hobbies/plugins/showmethat' }
  -- use { '/home/jorres/hobbies/plugins/academy.nvim' }

  -- === Actual programming ===
  use { 'vim-test/vim-test' }

  -- === neovim as PDE ===
  use { 'renerocksai/telekasten.nvim' }
  use { 'samodostal/image.nvim' }

  -- === Misc ===
  use { 'fladson/vim-kitty' } -- keyword highlighting of kitty.conf

  -- === Dependencies ===
  use { 'tami5/sqlite.lua' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'onsails/lspkind-nvim' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
end)
