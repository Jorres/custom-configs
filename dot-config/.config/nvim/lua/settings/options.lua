local options = {
  splitbelow = true,
  splitright = true,
  virtualedit = "all",
  langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz",
  signcolumn = "yes",
  showcmd = false,
  clipboard = "unnamedplus",
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  wrap = false,
  updatetime = 500,
  ignorecase = true,
  smartcase = true,
  autoread = true,
  autowriteall = true,
  number = true,
  relativenumber = true,
  undofile = true,
  undolevels = 3000,
  undoreload = 10000,
  backupdir = vim.env.HOME .. "/.local/share/nvim/backup",
  backup = true,
  swapfile = false,
  fileencoding = "utf-8",
  equalalways = false,
  lazyredraw = true,
  laststatus = 3,

  mouse = "a",
  ch = 0,
}

vim.cmd [[set fillchars+=vert:│]]
vim.cmd [[let g:HowMuch_no_mappings = 1]]

vim.opt.shortmess:append("c")

local notify = require("notify")

notify.setup({
  background_colour = "Normal",
  fps = 120,
  max_width = 90,
  max_height = 50,
  timeout = 10000,
  render = "wrapped-compact",
})

-- vim.notify = notify

for key, value in pairs(options) do
  vim.opt[key] = value
end
