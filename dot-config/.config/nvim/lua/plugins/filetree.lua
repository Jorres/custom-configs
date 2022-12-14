require "nnn".setup {
  explorer = {
    cmd = "nnn", -- command overrride (-F1 flag is implied, -a flag is invalid!)
    width = 24, -- width of the vertical split
    side = "topleft", -- or "botright", location of the explorer window
    session = "", -- or "global" / "local" / "shared"
    tabs = true, -- seperate nnn instance per tab
    fullscreen = true, -- whether to fullscreen explorer window when current tab is empty
  },
  picker = {
    cmd = "nnn", -- command override (-p flag is implied)
    style = {
      width = 0.9, -- percentage relative to terminal size when < 1, absolute otherwise
      height = 0.8, -- ^
      xoffset = 0.5, -- ^
      yoffset = 0.5, -- ^
      border = "single" -- border decoration for example "rounded"(:h nvim_open_win)
    },
    session = "", -- or "global" / "local" / "shared"
    fullscreen = true, -- whether to fullscreen picker window when current tab is empty
  },
  auto_open = {
    setup = false, -- or "explorer" / "picker", auto open on setup function
    tabpage = false, -- or "explorer" / "picker", auto open when opening new tabpage
    empty = false, -- only auto open on empty buffer
    ft_ignore = { -- dont auto open for these filetypes
      "gitcommit",
    }
  },
  auto_close = false, -- close tabpage/nvim when nnn is last window
  replace_netrw = nil, -- or "explorer" / "picker"
  mappings = {
  },
  windownav = { -- window movement mappings to navigate out of nnn
    left = "<C-h>",
    right = "<C-l>",
    -- next = "<C-w>w",
    -- prev = "<C-w>W",
  },
  buflisted = false, -- whether or not nnn buffers show up in the bufferlist
  quitcd = nil, -- or "cd" / tcd" / "lcd", command to run on quitcd file if found
  offset = false, -- whether or not to write position offset to tmpfile(for use in preview-tui)
}

-- Brought from readme to switch off some nasty mappings that conflict with my own

local mappings = {
  { key = { "<CR>" }, action = "edit" },
  { key = { "<C-d>" }, action = "cd" },
  { key = { "<C-u>" }, action = "dir_up" },
  { key = { "O" }, action = "edit_no_picker" },
  { key = "<C-v>", action = "vsplit" },
  { key = "<C-x>", action = "split" },
  -- { key = "<", action = "prev_sibling" },
  -- { key = ">", action = "next_sibling" },
  { key = "U", action = "parent_node" },
  { key = "<BS>", action = "close_node" },
  { key = "K", action = "first_sibling" },
  { key = "J", action = "last_sibling" },
  { key = "I", action = "toggle_ignored" },
  { key = "H", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "D", action = "trash" },
  { key = "r", action = "rename" },
  { key = "<C-r>", action = "full_rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "y", action = "copy_name" },
  { key = "Y", action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  -- { key = "[c", action = "prev_git_item" },
  -- { key = "]c", action = "next_git_item" },
  { key = "s", action = "system_open" },
  { key = "q", action = "close" },
  { key = "g?", action = "toggle_help" },
  { key = "W", action = "collapse_all" },
}

require 'nvim-tree'.setup {
  reload_on_bufenter = true,
  renderer             = {
    add_trailing = false,
    group_empty = true,
    highlight_git = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = true,
    },
    special_files = { 'init.lua', 'packer.lua', 'entrypoint.md' }
  },
  -- disables netrw completely
  disable_netrw        = true,
  -- hijack netrw window on startup
  hijack_netrw         = true,
  -- open the tree when running this setup function
  open_on_setup        = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup   = {},
  auto_reload_on_write = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab          = true,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor        = true,
  -- updates the root directory of the tree on `DirChanged` (when you run `:cd` usually)
  update_cwd           = true,
  -- show lsp diagnostics in the signcolumn
  diagnostics          = {
    enable = false,
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file  = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = true,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open          = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    -- Hide the root path of the current folder on top of the tree
    hide_root_folder = true,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    preserve_window_proportions = true,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = true,
      -- list of mappings to set on the tree manually
      list = mappings
    },

    number = true,
    relativenumber = true,
    signcolumn = "no",
  },

  filters = {
    dotfiles = false,
    custom = { },
  },

  git = {
    enable = false,
  },

  actions = {
    open_file = {
      resize_window = true
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
}
