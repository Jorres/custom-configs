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
  { 'MunifTanjim/prettier.nvim' }, -- :Prettier
  { 'folke/flash.nvim' },          -- Ultimate screen-jumping plugin
  { 'tpope/vim-repeat' },          -- zero-config, allows to repeat complex commands
  { 'AndrewRadev/splitjoin.vim' }, -- gJ and gS to split\join statements in multiple languages
  { 'sk1418/HowMuch' },            -- https://github.com/sk1418/HowMuch
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
  }, -- Keep track of latest files you work with
  {
    "heilgar/bookmarks.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  }, -- like marks but simpler, thinking about letters really sucks
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

  { "ThePrimeagen/refactoring.nvim" },
  { "meznaric/key-analyzer.nvim",   opts = {} }, -- draw a chart with unoccupied keybindingds

  { import = 'plugins.chatgpt', },

  -- === Vim utilities ===
  { 'lambdalisue/suda.vim' }, -- reenter sudo editing with :Suda
  { 'nanotee/luv-vimdocs' },  -- docs for libuv
  { 'milisims/nvim-luaref' }, -- docs for lua

  -- === Git ===
  { 'tpope/vim-fugitive' },      -- :G
  { 'lewis6991/gitsigns.nvim' }, -- Enable git changes to be shown in sign column
  { 'ruifm/gitlinker.nvim' },    -- produce browser links pointing at source

  -- === UI === --
  { 'hoob3rt/lualine.nvim' },
  { 'declancm/cinnamon.nvim' },                   -- smooth scroll
  { 'kyazdani42/nvim-tree.lua',     pin = true }, --File explorer
  {
    "azabiong/vim-highlighter",
    init = function()
      vim.cmd([[
         let HiSet   = '<leader>hl'
         let HiErase = '<leader>he'
         let HiClear = '<leader>hc'
         let HiFind  = '<leader>h<Tab>'
         let HiSetSL = '<leader>h<CR>'
       ]])
    end,
  },
  { 'echasnovski/mini.nvim' },

  { import = 'plugins.alpha' },              -- cool startup screen!
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

  {
    'letieu/harpoon-lualine',
    dependencies = { { 'ThePrimeagen/harpoon' } }
  },

  -- === Colorschemes === --
  { import = 'plugins.colorscheme' },

  -- === TMUX === --
  { 'christoomey/vim-tmux-navigator' }, -- Allows to <C-hjkl> to move to/from tmux panes
  { 'sjl/vitality.vim' },               -- Restore FocusGained, FocusLost

  -- === LSP and completion ===
  { import = "plugins.lsp" },
  -- completion core and completion sources
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    -- dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
  },

  -- === Treesitter ===
  { 'nvim-treesitter/nvim-treesitter',                       build = ':TSUpdate' },
  -- { 'nvim-treesitter/playground' },
  { 'hiphish/rainbow-delimiters.nvim' },

  -- === Telescope ===
  { import = "plugins.telescope" },

  -- === Language specific
  { 'hashivim/vim-terraform' }, -- just the highlighting
  { 'towolf/vim-helm' },        -- just the highlighting

  -- === Plugin \ Lua development ===
  -- { 'tjdevries/colorbuddy.nvim' },
  { dir = os.getenv("HOME") .. '/hobbies/plugins/showmethat' },
  -- { dir = os.getenv("HOME") .. '/hobbies/academy' }, -- not yet(

  -- === neovim as PDE ===
  { "keaising/im-select.nvim", }, -- navigation in normal mode with Japanese
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>zip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
    opts = {
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
}

return pluginspec
