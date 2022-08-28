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
  backupdir = vim.env.HOME ..  "/.local/share/nvim/backup",
  backup = true,
  swapfile = false,
  fileencoding = "utf-8",
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevelstart = 100,
  equalalways = false,
  lazyredraw = true,
  mouse = "a"
}


vim.cmd [[set fillchars+=vert:│]]
vim.cmd [[let g:HowMuch_no_mappings = 1]]

vim.opt.shortmess:append("c")

vim.notify = require("notify")

for key, value in pairs(options) do
  vim.opt[key] = value
end
