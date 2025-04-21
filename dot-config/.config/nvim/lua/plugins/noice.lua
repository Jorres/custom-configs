require("noice").setup({
  views = {
    confirm = {
      backend = "popup",
      relative = "editor",
      focusable = false,
      align = "center",
      enter = false,
      zindex = 210,
      format = { "{confirm}" },
      position = {
        row = "20%",
        col = "80%",
      },
      size = "auto",
      border = {
        style = "none",
        padding = { 1, 1 },
      },
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
  },
  cmdline = {
    enabled = true,   -- enables the Noice cmdline UI
    view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    opts = {},        -- global options for the cmdline. See section on views
    ---@type table<string, CmdlineFormat>
    format = {
      -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
      -- view: (default is cmdline view)
      -- opts: any options passed to the view
      -- icon_hl_group: optional hl_group for the icon
      -- title: set to anything or empty string to hide
      cmdline = { pattern = "^:", icon = " ", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = " $", lang = "bash" },
      lua = { pattern = "^:%s*lua%s+", icon = " ", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = " " },
      input = { view = "cmdline" }, -- Used by input()
      -- lua = false, -- to disable a format, set to `false`
    },
  },
  messages = {
    -- NOTE: If you enable messages, then the cmdline is enabled automatically.
    -- This is a current Neovim limitation.
    enabled = true,            -- enables the Noice messages UI
    view = "mini",             -- default view for messages
    view_error = "notify",     -- view for errors
    view_warn = "mini",        -- view for warnings
    view_history = "messages", -- view for :messages
    view_search = false,
    -- view_search = "virtualtext",
  },
  popupmenu = {
    enabled = true,  -- enables the Noice popupmenu UI
    ---@type 'nui'|'cmp'
    backend = "nui", -- backend to use to show regular cmdline completions
    ---@type NoicePopupmenuItemKind|false
    -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
    kind_icons = {}, -- set to `false` to disable icons
  },
  routes = {
    { -- To reduce noise from writing to a file
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
    { -- This is for vim-highlighter when going to a new file
      filter = {
        find = "Not found: /home.*",
      },
      opts = { skip = true },
    },
    { -- To reduce noise from my vim-highlighter automation
      filter = {
        find = ".*Hi:save.*",
      },
      opts = { skip = true },
    },
    { -- To reduce noise from my vim-highlighter automation
      filter = {
        find = ".*Hi:load.*",
      },
      opts = { skip = true },
    },
  },
  ---@type table<string, NoiceCommand>
  commands = {},
  notify = {
    -- Noice can be used as `vim.notify` so you can route any notification like other messages
    -- Notification messages have their level and other properties set.
    -- event is always "notify" and kind can be any log level as a string
    -- The default routes will forward notifications to nvim-notify
    -- Benefit of using Noice for this is the routing and consistent history view
    enabled = true,
    view = "mini",
  },
  lsp = {
    progress = {
      enabled = true,
      -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
      -- See the section on formatting for more details on how to customize.
      --- @type NoiceFormat|string
      format = "lsp_progress",
      --- @type NoiceFormat|string
      format_done = "lsp_progress_done",
      throttle = 1000 / 30, -- frequency to update lsp progress message
      view = "mini",
    },
    override = {
      -- override the default lsp markdown formatter with Noice
      ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
      -- override the lsp markdown formatter with Noice
      ["vim.lsp.util.stylize_markdown"] = false,
      -- override cmp documentation with Noice (needs the other options to work)
      ["cmp.entry.get_documentation"] = false,
    },
    hover = {
      border = "solid",
      enabled = false,
      view = nil, -- when nil, use defaults from documentation
      ---@type NoiceViewOptions
      opts = {},  -- merged with defaults from documentation
    },
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
        trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
        throttle = 50,  -- Debounce lsp signature help request by 50ms
      },
      view = nil,       -- when nil, use defaults from documentation
      ---@type NoiceViewOptions
      opts = {},        -- merged with defaults from documentation
    },
    message = {
      -- Messages shown by lsp servers
      enabled = true,
      view = "notify",
      opts = {},
    },
    -- defaults for hover and signature help
    documentation = {
      view = "hover",
      ---@type NoiceViewOptions
      opts = {
        lang = "markdown",
        replace = true,
        render = "plain",
        format = { "{message}" },
        win_options = { concealcursor = "n", conceallevel = 3 },
      },
    },
  },
  markdown = {
    hover = {
      ["|(%S-)|"] = vim.cmd.help,                       -- vim help links
      ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
    },
    highlights = {
      ["|%S-|"] = "@text.reference",
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
    },
  },
  health = {
    checker = true, -- Disable if you don't want health checks to run
  },
  smart_move = {
    enabled = false, -- you can disable this behaviour here
  },
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
  throttle = 1000 / 10,           -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
})

require "noice.config.format".builtin.lsp_progress = {
  {
    "{progress} ",
    key = "progress.percentage",
    contents = {
      { "{data.progress.message} " },
    },
  },
  -- "({data.progress.percentage}%) ",
  { "{spinner} ",              hl_group = "NoiceLspProgressSpinner" },
  -- { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
  { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
}
require "noice.config.format".builtin.lsp_progress_done = {
  { "✔ ", hl_group = "NoiceLspProgressSpinner" },
  { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
  { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
}
