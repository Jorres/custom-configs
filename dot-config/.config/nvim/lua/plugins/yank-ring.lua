return {
  {
    "gbprod/yanky.nvim",
    opts = {
      ring = {
        history_length = 100,
        storage = "shada",
        sync_with_numbered_registers = true,
        cancel_event = "update",
      },
      picker = {
        select = {
          action = nil, -- nil to use default put action
        },
        telescope = {
          mappings = nil, -- nil to use default mappings
        },
      },
      system_clipboard = {
        sync_with_ring = false,
      },
      highlight = {
        on_put = true,
        on_yank = false,
        timer = 300,
      },
      preserve_cursor_position = {
        enabled = true,
      },
    }
  },
}
