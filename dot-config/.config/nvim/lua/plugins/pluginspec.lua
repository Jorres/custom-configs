local pluginspec = {
  -- Not using:
  { 'tpope/vim-abolish' }, -- :Subvert, coerce to various cases

  -- === Language agnostic editing plugins ===
  { 'windwp/nvim-autopairs',    opts = {} }, -- auto-close brackets plugin
  { 'tpope/vim-surround' },                  -- cs<surrounding1><surrounding2> ds<surrounding1>
  { import = 'plugins.comment' },            -- visual select + gc
  { 'wellle/targets.vim' },                  -- Additional text objects: e.g. inside *, inside comma-separated list etc.
  { 'folke/flash.nvim' },                    -- Ultimate screen-jumping plugin
  { 'tpope/vim-repeat' },                    -- zero-config, allows to repeat complex commands
  { 'AndrewRadev/splitjoin.vim' },           -- gJ and gS to split\join statements in multiple languages
  { 'sk1418/HowMuch' },                      -- https://github.com/sk1418/HowMuch

  {
    import = 'plugins.harpoon',
  },
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
  { import = 'plugins.yank-ring' },

  { import = 'plugins.macro-recorder' },

  { import = "plugins.refactoring" },
  { "meznaric/key-analyzer.nvim",     opts = {} }, -- draw a chart with unoccupied keybindingds

  { import = 'plugins.chatgpt', },
  { import = 'plugins.filetree' },

  -- === Vim utilities ===
  { 'lambdalisue/suda.vim' }, -- reenter sudo editing with :Suda
  { 'nanotee/luv-vimdocs' },  -- docs for libuv
  { 'milisims/nvim-luaref' }, -- docs for lua

  -- === Git ===
  { 'tpope/vim-fugitive' },         -- :G
  { import = "plugins.gitsigns" },  -- Enable git changes to be shown in sign column
  { import = "plugins.gitlinker" }, -- create browser links from current line

  -- === UI === --
  { 'hoob3rt/lualine.nvim' },
  { import = "plugins.smoothscroll" },
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
  { import = "plugins.mini" },

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

  -- === TMUX === --
  { 'christoomey/vim-tmux-navigator' }, -- Allows to <C-hjkl> to move to/from tmux panes
  { 'sjl/vitality.vim' },               -- Restore FocusGained, FocusLost

  -- === LSP and completion ===
  { import = "plugins.lsp" },
  -- completion core and completion sources
  { import = "plugins.autoc8n" },

  -- === Treesitter ===
  { import = 'plugins.treesitter' },

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

  { import = "plugins.prettier" },

  { import = "plugins.folding" },

  -- === Colorschemes === --
  { import = 'plugins.colorscheme' },

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
