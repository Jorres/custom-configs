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

local folding_group = vim.api.nvim_create_augroup("managing folds", {clear = true})
vim.api.nvim_create_autocmd({"BufReadPost", "FileReadPost", "BufEnter"}, {
  pattern = { "*" },
  command = "normal zR",
  group = folding_group
})


local terraform_group = vim.api.nvim_create_augroup("autoformat terraform", {clear = true})
vim.api.nvim_create_autocmd({"BufReadPost", "FileReadPost", "BufWritePost", "FileWritePost"}, {
  pattern = { "*.tf", "*.tfvars" },
  callback = vim.lsp.buf.formatting,
  group = terraform_group
})
