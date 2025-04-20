require("bookmarks").setup({
  -- Storage configuration
  db_path = vim.fn.stdpath('data') .. '/bookmarks.db',   -- Path to SQLite database

  -- Keymaps configuration
  default_mappings = false,   -- Set to false to disable default keymaps

  -- Custom mappings example (if default_mappings = false):
  mappings = {
    add = "ma",        -- Add bookmark at current line
    delete = "md",     -- Delete bookmark at current line
    list = "ml",       -- List all bookmarks
  }
})
