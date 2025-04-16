local pluginspec = {
  -- Not using:
  { 'tpope/vim-abolish' }, -- :Subvert, coerce to various cases
  -- Submodes
  {
    'anuvyklack/hydra.nvim',
    dependencies = 'anuvyklack/keymap-layer.nvim' -- needed only for pink hydras
  },

  -- === Language agnostic editing plugins ===
  { 'windwp/nvim-autopairs' },     -- auto-close brackets plugin
  { 'tpope/vim-surround' },        -- cs<surrounding1><surrounding2> ds<surrounding1>
  { 'b3nj5m1n/kommentary' },       -- visual select + gc
  { 'wellle/targets.vim' },        -- Additional text objects: e.g. inside *, inside comma-separated list etc.
  { 'godlygeek/tabular' },         -- Adds :Tabularize command
  { 'MunifTanjim/prettier.nvim' }, -- :Prettier
  { 'folke/flash.nvim' },          -- Ultimate screen-jumping plugin
  { 'tpope/vim-repeat' },          -- zero-config, allows to repeat complex commands
  { 'AndrewRadev/splitjoin.vim' }, -- gJ and gS to split\join statements in multiple languages
  { 'matze/vim-move' },            -- Allows to move lines up and down with Alt
  { 'sk1418/HowMuch' },            -- https://github.com/sk1418/HowMuch
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
  }, -- Keep track of latest files you work with
  { 'kevinhwang91/nvim-bqf' },

  { 'mbbill/undotree' }, -- Visualize undotree
  -- A true blessing. Set shiftwidth to what the buffer is using
  -- instead of hardcoded 2 or hardcoded 4.
  { 'NMAC427/guess-indent.nvim' },
  { "gbprod/yanky.nvim" }, -- yank ring-buffer
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify",
  },
  { "chentoast/marks.nvim" },

  { "ThePrimeagen/refactoring.nvim" },

  -- { "jackMort/ChatGPT.nvim" }
  { "Robitx/gp.nvim" },
  -- { dir = os.getenv("HOME") .. '/hobbies/gp' },

  -- === Vim utilities ===
  { 'lambdalisue/suda.vim' },              -- reenter sudo editing with :Suda
  { 'nanotee/luv-vimdocs' },               -- docs for libuv
  { 'milisims/nvim-luaref' },              -- docs for lua
  { "williamboman/mason.nvim" },           -- manager for LSP and such
  { "williamboman/mason-lspconfig.nvim" }, -- manager for LSP and such

  -- === Git ===
  { 'tpope/vim-fugitive' },      -- :G
  { 'lewis6991/gitsigns.nvim' }, -- Enable git changes to be shown in sign column
  { 'ruifm/gitlinker.nvim' },

  -- === UI === --
  { 'hoob3rt/lualine.nvim' },
  { 'karb94/neoscroll.nvim' },                          -- smooth scroll
  { 'kyazdani42/nvim-tree.lua',           pin = true }, --File explorer
  { 'azabiong/vim-highlighter' },
  { 'echasnovski/mini.nvim' },
  { "andrewferrier/wrapping.nvim" },
  { "Mr-LLLLL/cool-chunk.nvim" },

  { 'goolord/alpha-nvim' },                  -- cool startup screen!
  { 'akinsho/toggleterm.nvim' },             -- toggle terminal per session
  { 'lukas-reineke/indent-blankline.nvim' }, -- draws small symbols for indentation
  { 'stevearc/dressing.nvim' },              -- improved vim.ui interfaces, like (select) and (input)
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  { 'mrjones2014/legendary.nvim' },
  { "asiryk/auto-hlsearch.nvim", tag = "1.1.0" },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,

  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons"
  --   }
  -- },

  {
    'letieu/harpoon-lualine',
    dependencies = { { 'ThePrimeagen/harpoon' } }
  },

  -- === Colorschemes === --
  { 'morhetz/gruvbox' },
  { 'savq/melange' },
  { 'EdenEast/nightfox.nvim' },
  { 'nyoom-engineering/oxocarbon.nvim' },
  { 'ribru17/bamboo.nvim' },
  { 'sainnhe/everforest' },
  { 'sainnhe/sonokai' },
  { "rebelot/kanagawa.nvim" },
  { "folke/tokyonight.nvim" },
  {
    'uloco/bluloco.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
  },
  { "samharju/synthweave.nvim" },

  -- === TMUX === --
  { 'christoomey/vim-tmux-navigator' }, -- Allows to <C-hjkl> to move to/from tmux panes
  { 'sjl/vitality.vim' },               -- Restore FocusGained, FocusLost
  { 'tpope/vim-obsession' },

  -- === LSP and completion ===
  { 'neovim/nvim-lspconfig' },
  -- completion core and completion sources
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  -- {
  --   'Zeioth/garbage-day.nvim',
  --   opts = {
  --     notifications = true,
  --     aggressive_mode = false,
  --     grace_period = 60 * 10,
  --     wakeup_delay = 0,
  --   }
  -- },

  -- === Treesitter ===
  { 'nvim-treesitter/nvim-treesitter',                       build = ':TSUpdate' },
  { 'nvim-treesitter/playground' },
  { 'hiphish/rainbow-delimiters.nvim' },

  -- === Telescope ===
  { 'nvim-telescope/telescope.nvim',                         branch = "0.1.x" },
  { 'nvim-telescope/telescope-fzf-native.nvim',              build = 'make' },
  { 'nvim-telescope/telescope-media-files.nvim' },

  -- === Language specific
  { 'hashivim/vim-terraform' }, -- just the highlighting
  { 'towolf/vim-helm' },        -- just the highlighting

  -- === Plugin \ Lua development ===
  { 'tjdevries/colorbuddy.nvim' },
  { dir = os.getenv("HOME") .. '/hobbies/plugins/showmethat' },
  { dir = os.getenv("HOME") .. '/hobbies/academy' },

  -- === neovim as PDE ===
  { "keaising/im-select.nvim", }, -- navigation in normal mode with Japanese
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>zip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
      },
    },
  },

  -- === Misc ===
  { 'fladson/vim-kitty' }, -- keyword highlighting of kitty.conf

  -- === Dependencies ===
  { 'tami5/sqlite.lua' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'nvim-lua/popup.nvim' },
  { 'nvim-lua/plenary.nvim' },
  { 'onsails/lspkind-nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
}

return pluginspec
