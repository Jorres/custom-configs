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
  laststatus = 3,
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
  max_width = 70,
  max_height = 10,
  timeout = 2000
})

-- vim.notify = notify

for key, value in pairs(options) do
  vim.opt[key] = value
end
