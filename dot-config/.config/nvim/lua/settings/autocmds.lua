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


local terraform_group = vim.api.nvim_create_augroup("autoformat terraform", {clear = true})
vim.api.nvim_create_autocmd({"BufReadPost", "FileReadPost", "BufWritePost", "FileWritePost"}, {
  pattern = { "*.tf", "*.tfvars" },
  callback = vim.lsp.buf.formatting,
  group = terraform_group
})

local lifelog_group = vim.api.nvim_create_augroup("auto zen mode", {clear = true})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = { "I.md", "II.md", "III.md" },
  callback = function ()
    vim.schedule(function ()
      require("nvim-tree.view").close()
      vim.cmd [[ ZenMode ]]
    end)
  end,
  group = lifelog_group
})
