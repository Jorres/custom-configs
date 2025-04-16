local cinnamon = require "cinnamon"
cinnamon.setup {
  keymaps = {
    basic = false,
    extra = false,
  },
  options = {
    delay = 8,
  },
}

local keymap = {
  ["<C-Y>"] = function()
    cinnamon.scroll("5<C-Y>")
  end,
  ["<C-E>"] = function()
    cinnamon.scroll("5<C-E>")
  end,
}

local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end
