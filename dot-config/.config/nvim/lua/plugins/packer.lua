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

  -- Not using:
  use { 'tpope/vim-abolish' } -- :Subvert, coerce to various cases
  -- Submodes
  use { 'anuvyklack/hydra.nvim',
    requires = 'anuvyklack/keymap-layer.nvim' -- needed only for pink hydras
  }

  -- === Language agnostic editing plugins ===
  use { 'windwp/nvim-autopairs' }     -- auto-close brackets plugin
  use { 'tpope/vim-surround' }        -- cs<surrounding1><surrounding2> ds<surrounding1>
  use { 'b3nj5m1n/kommentary' }       -- visual select + gc
  use { 'wellle/targets.vim' }        -- Additional text objects: e.g. inside *, inside comma-separated list etc.
  use { 'godlygeek/tabular' }         -- Adds :Tabularize command
  use { 'MunifTanjim/prettier.nvim' } -- :Prettier
  use { 'folke/flash.nvim' }          -- Ultimate screen-jumping plugin
  use { 'tpope/vim-repeat' }          -- zero-config, allows to repeat complex commands
  use { 'AndrewRadev/splitjoin.vim' } -- gJ and gS to split\join statements in multiple languages
  use { 'matze/vim-move' }            -- Allows to move lines up and down with Alt
  use { 'sk1418/HowMuch' }            -- https://github.com/sk1418/HowMuch
  use {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
  }                         -- Keep track of latest files you work with

  use { 'mbbill/undotree' } -- Visualize undotree
  -- A true blessing. Set shiftwidth to what the buffer is using
  -- instead of hardcoded 2 or hardcoded 4.
  use { 'NMAC427/guess-indent.nvim' }
  use { "gbprod/yanky.nvim" } -- yank ring-buffer

  use { "ThePrimeagen/refactoring.nvim" }

  -- use { "jackMort/ChatGPT.nvim" }
  use { "Robitx/gp.nvim" }

  -- === Vim utilities ===
  use { 'lambdalisue/suda.vim' }              -- reenter sudo editing with :Suda
  use { 'nanotee/luv-vimdocs' }               -- docs for libuv
  use { 'milisims/nvim-luaref' }              -- docs for lua
  use { "williamboman/mason.nvim" }           -- manager for LSP and such
  use { "williamboman/mason-lspconfig.nvim" } -- manager for LSP and such

  -- === Git ===
  use { 'tpope/vim-fugitive' }      -- :G
  use { 'lewis6991/gitsigns.nvim' } -- Enable git changes to be shown in sign column
  use { 'ruifm/gitlinker.nvim' }

  -- === UI === --
  use { 'hoob3rt/lualine.nvim' }
  use { 'karb94/neoscroll.nvim' }    -- smooth scroll
  use { 'edluffy/specs.nvim' }       -- cursor jump landing visualization
  use { 'kyazdani42/nvim-tree.lua' } --File explorer
  use { 'azabiong/vim-highlighter' }
  -- use { 'Pocco81/HighStr.nvim' } -- highlight words on a whim
  -- use { 'PeterRincker/vim-searchlight' } -- Highlight current hlsearch pattern differently
  use { 'echasnovski/mini.nvim' }
  use { "andrewferrier/wrapping.nvim" }

  use { 'goolord/alpha-nvim' }                  -- cool startup screen!
  use { 'akinsho/toggleterm.nvim' }             -- toggle terminal per session
  use { 'lukas-reineke/indent-blankline.nvim' } -- draws small symbols for indentation
  use { 'mvllow/modes.nvim' }                   -- highlight the current line with a mode color
  use { 'stevearc/dressing.nvim' }              -- improved vim.ui interfaces, like (select) and (input)
  use { "folke/noice.nvim", requires = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  } }
  use { 'mrjones2014/legendary.nvim' }
  use({ "asiryk/auto-hlsearch.nvim", tag = "1.1.0" })

  use {
    'letieu/harpoon-lualine',
    opt = false,
    requires = { { 'ThePrimeagen/harpoon' } }
  }

  use { "lukas-reineke/headlines.nvim" }

  -- === Colorschemes === --
  use { 'morhetz/gruvbox' }
  use { 'savq/melange' }
  use { 'EdenEast/nightfox.nvim' }
  use { 'nyoom-engineering/oxocarbon.nvim' }
  use { 'ribru17/bamboo.nvim' }
  use { 'sainnhe/everforest' }
  use { 'sainnhe/sonokai' }
  use { "rebelot/kanagawa.nvim" }
  use { "folke/tokyonight.nvim" }
  use { 'uloco/bluloco.nvim',
    requires = { 'rktjmp/lush.nvim' }
  }

  -- === TMUX === --
  use { 'christoomey/vim-tmux-navigator' } -- Allows to use <C-hjkl> to move to/from tmux panes
  use { 'sjl/vitality.vim' }               -- Restore FocusGained, FocusLost
  use { 'tpope/vim-obsession' }

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

  -- === Treesitter ===
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground' }
  use { 'hiphish/rainbow-delimiters.nvim' }

  -- === Telescope ===
  use { 'nvim-telescope/telescope.nvim', branch = "0.1.x" }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-media-files.nvim' }

  -- === Language specific
  use { 'hashivim/vim-terraform' } -- just the highlighting
  use { 'towolf/vim-helm' }        -- just the highlighting

  -- === Plugin \ Lua development ===
  use { 'tjdevries/colorbuddy.nvim' }
  use { os.getenv("HOME") .. '/hobbies/plugins/showmethat' }

  -- === neovim as PDE ===
  use { 'renerocksai/telekasten.nvim' }
  use {
    'samodostal/image.nvim',
    requires = {
      'm00qek/baleia.nvim' -- this enables background color
    },
  }
  use { "keaising/im-select.nvim", } -- navigation in normal mode with Japanese

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
