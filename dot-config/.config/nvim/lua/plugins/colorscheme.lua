return {
  {
    'tjdevries/colorbuddy.nvim',
    dependencies = {
      {
        "samharju/synthweave.nvim",
        config = function()
          vim.cmd.colorscheme "synthweave"
        end
      },
      -- { 'morhetz/gruvbox' },
      -- { 'savq/melange' },
      -- { 'EdenEast/nightfox.nvim' },
      -- { 'nyoom-engineering/oxocarbon.nvim' },
      -- {
      --   'ribru17/bamboo.nvim',
      --   opts = {
      --     -- Main options --
      --     -- NOTE: to use the light theme, set `vim.o.background = 'light'`
      --     style = 'vulgaris',                                         -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
      --     toggle_style_key = nil,                                     -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
      --     toggle_style_list = { 'vulgaris', 'multiplex', 'light' },   -- List of styles to toggle between
      --     transparent = false,                                        -- Show/hide background
      --     dim_inactive = false,                                       -- Dim inactive windows/buffers
      --     term_colors = true,                                         -- Change terminal color as per the selected theme style
      --     ending_tildes = false,                                      -- Show the end-of-buffer tildes. By default they are hidden
      --     cmp_itemkind_reverse = false,                               -- reverse item kind highlights in cmp menu

      --     -- Change code style ---
      --     -- Options are italic, bold, underline, none
      --     -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      --     code_style = {
      --       comments = 'italic',
      --       conditionals = 'italic',
      --       keywords = 'none',
      --       functions = 'none',
      --       namespaces = 'italic',
      --       parameters = 'italic',
      --       strings = 'none',
      --       variables = 'none',
      --     },

      --     -- Lualine options --
      --     lualine = {
      --       transparent = false,   -- lualine center bar transparency
      --     },

      --     -- Custom Highlights --
      --     colors = {},       -- Override default colors
      --     highlights = {},   -- Override highlight groups

      --     -- Plugins Config --
      --     diagnostics = {
      --       darker = false,      -- darker colors for diagnostic
      --       undercurl = true,    -- use undercurl instead of underline for diagnostics
      --       background = true,   -- use background color for virtual text
      --     },

      --   }
      -- },
      -- { 'sainnhe/everforest' },
      -- { 'sainnhe/sonokai' },
      -- { "rebelot/kanagawa.nvim" },
      -- { "folke/tokyonight.nvim" },
      -- {
      --   'uloco/bluloco.nvim',
      --   dependencies = { 'rktjmp/lush.nvim' },
      --   opts = {
      --     style       = "dark",
      --     transparent = false,
      --     italics     = false,
      --     terminal    = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
      --     guicursor   = true,
      --   },
      -- },
    },
    config = function()
      local colorbuddy = require('colorbuddy')

      colorbuddy.setup()

      local Color = colorbuddy.Color
      local colors = colorbuddy.colors
      local Group = colorbuddy.Group

      -- Use Color.new(<name>, <#rrggbb>) to create new colors
      -- They can be accessed through colors.<name>

      Color.new("myclr1", "#252525")
      Color.new("myclr2", "#303030")
      Color.new("myclr3", "#C6393D")
      Color.new("myclr4", "#FFFFFF")
      Color.new("myclr5", "#393DC6")
      Color.new("myclr6", "#3DC639")
      Color.new("myclr7", "#404040")
      Color.new("completion", "#1e1c2a")
      Color.new("completion_selection", "#2f2b43")

      Color.new("icon1", "#393dc6")
      Color.new("icon2", "#c63983")
      Color.new("icon3", "#c6c239")
      Color.new("icon4", "#39c67c")

      Color.new("pinkBorder", "#E56399")

      Group.new("TelescopeBorder", colors.myclr1, colors.myclr1, nil)
      Group.new("TelescopeNormal", nil, colors.myclr1, nil)
      Group.new("TelescopePromptTitle", colors.myclr1, colors.myclr3, nil)
      Group.new("TelescopePromptBorder", colors.myclr2, colors.myclr2, nil)
      Group.new("TelescopePromptNormal", colors.myclr4, colors.myclr2, nil)
      Group.new("TelescopePromptPrefix", colors.myclr3, colors.myclr2, nil)
      Group.new("TelescopePreviewTitle", colors.myclr1, colors.myclr5, nil)
      Group.new("TelescopeResultsTitle", colors.myclr1, colors.myclr6, nil)
      Group.new("TelescopeSelection", nil, colors.myclr7, nil)

      Group.new("VibrantFloatBorder", colors.pinkBorder, nil, nil)
      Group.new("Directory", colors.pinkBorder, nil, nil)
      Group.new("NvimTreeFolderName", colors.pinkBorder, nil, nil)

      Group.new("Pmenu", nil, colors.completion, nil)
      Group.new("PmenuSel", nil, colors.completion_selection, nil)

      Group.new("BlinkCmpKindFunction", colors.icon1, nil, nil)
      Group.new("BlinkCmpKindText", colors.icon2, nil, nil)
      Group.new("BlinkCmpKindModule", colors.icon3, nil, nil)
      Group.new("BlinkCmpKindConstant", colors.icon4, nil, nil)
      Group.new("BlinkCmpKindVariable", colors.icon1, nil, nil)
      Group.new("BlinkCmpKindInterface", colors.icon2, nil, nil)
      Group.new("BlinkCmpKindMethod", colors.icon3, nil, nil)
      Group.new("BlinkCmpKindKeyword", colors.icon4, nil, nil)
      Group.new("BlinkCmpKindClass", colors.icon1, nil, nil)

      Group.new("NormalFloat", nil, colors.completion, nil)
      Group.new("NormalFloat", nil, colors.completion, nil)
      Group.new("FloatBorder", nil, colors.completion, nil)


      vim.cmd [[ highlight EndOfBuffer guifg=bg ]]
    end
  },
}
