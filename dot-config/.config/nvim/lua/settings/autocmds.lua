local packer_group = vim.api.nvim_create_augroup("observe packer changes", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "packer.lua" },
  command = "luafile %",
  group = packer_group
})

local colorscheme_group = vim.api.nvim_create_augroup("colorscheme changes", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = { "*" },
  callback = function()
    R("plugins.colorbuddy")
  end,
  group = colorscheme_group
})
