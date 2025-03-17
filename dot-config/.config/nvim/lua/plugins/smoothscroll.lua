local neoscroll = require'neoscroll'

neoscroll.setup({
  -- All these keys will be mapped to their corresponding default scrolling animation
  mappings = {},
  hide_cursor = true,           -- Hide cursor while scrolling
  stop_eof = true,              -- Stop at <EOF> when scrolling downwards
  use_local_scrolloff = false,  -- Use the local scope of scrolloff instead of the global scope
  respect_scrolloff = false,    -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true,  -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = "circular", -- Default easing function
  pre_hook = nil,               -- Function to run before the scrolling animation starts
  post_hook = nil,              -- Function to run after the scrolling animation ends
})

-- require('neoscroll.config').set_mappings({
--   -- The following looks very nice, but you actually don't want to wait three seconds
--   -- if you want to look at file's end
--   -- ['gg']    = {'scroll', {'-2*vim.api.nvim_buf_line_count(0)', 'true', '50'}},
--   -- ['G']     = {'scroll', {'2*vim.api.nvim_buf_line_count(0)', 'true', '50'}}
-- })

local keymap = {
  ["<C-Y>"] = function() neoscroll.scroll(-6, { move_cursor=false; duration = 60 }) end;
  ["<C-E>"] = function() neoscroll.scroll(6, { move_cursor=false; duration = 60 }) end;
}

local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end
