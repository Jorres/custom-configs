local options = {
  termguicolors = true,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.g.mapleader = ","
