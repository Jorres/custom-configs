local true_zen = require "true-zen"

true_zen.setup {
  ui = {
    bottom = {
      laststatus = 0,
      ruler = false,
      showmode = false,
      showcmd = false,
      cmdheight = 1,
    },
    top = {
      showtabline = 0,
    },
    left = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
    },
  },
  modes = {
    ataraxis = {
      top_padding = 1,
      bottom_padding = 1,
      ideal_writing_area_width = { 90 },
      auto_padding = true,
      keep_default_fold_fillchars = true,
      custom_bg = { "none", "" },
      bg_configuration = true,
      quit = "untoggle",
      ignore_floating_windows = true,
      affected_higroups = {
        NonText = true,
        FoldColumn = true,
        ColorColumn = true,
        VertSplit = true,
        StatusLine = true,
        StatusLineNC = true,
        SignColumn = true,
      },
    },
    focus = {
      margin_of_error = 5,
      focus_method = "experimental"
    },
  },
  integrations = {
    tmux = false,
    gitsigns = true,
    lualine = true,
  },
  misc = {
    on_off_commands = false,
    ui_elements_commands = false,
    cursor_by_mode = false,
  }
}

true_zen.before_mode_ataraxis_on = function ()
  pcall(require"nvim-tree".toggle, false, true)
end

true_zen.after_mode_ataraxis_off = function ()
  pcall(require"nvim-tree".toggle, false, true)
end
