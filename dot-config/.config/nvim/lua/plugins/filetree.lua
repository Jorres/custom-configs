local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<C-d>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-u>', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'U', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))

end

require 'nvim-tree'.setup {
  on_attach = on_attach,
  reload_on_bufenter = true,
  renderer             = {
    add_trailing = false,
    group_empty = true,
    highlight_git = false,
    highlight_opened_files = "none",
    root_folder_label = false,
    indent_markers = {
      enable = true,
    },
    special_files = { 'init.lua', 'packer.lua', 'entrypoint.md' }
  },
  -- disables netrw completely
  disable_netrw        = true,
  -- hijack netrw window on startup
  hijack_netrw         = true,
  auto_reload_on_write = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab          = true,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor        = true,
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
    update_root  = false,
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
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    preserve_window_proportions = true,

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
