vim.g.mapleader = ","

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
  number = true,
  relativenumber = true,
  undofile = true,
  undolevels = 3000,
  undoreload = 10000,
  backupdir = "/home/jorres/.local/share/nvim/backup",
  backup = true,
  swapfile = false,
  termguicolors = true,
  fileencoding = "utf-8",
}

vim.cmd [[set fillchars+=vert:│]]

vim.opt.shortmess:append("c")

vim.notify = require("notify")

for key, value in pairs(options) do
  vim.opt[key] = value
end