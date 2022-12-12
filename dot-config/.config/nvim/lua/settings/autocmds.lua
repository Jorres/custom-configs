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

local lifelog_group = vim.api.nvim_create_augroup("auto zen mode", {clear = true})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = { "I.md", "II.md", "III.md" },
  callback = function ()
    vim.schedule(function ()
      pcall(require("nvim-tree.view").close)
      vim.cmd [[ set filetype=telekasten ]]
    end)
  end,
  group = lifelog_group
})

-- local prettify_prettify = vim.api.nvim_create_augroup("auto Prettify md", {clear = true})
-- vim.api.nvim_create_autocmd({"BufWritePost"}, {
--   pattern = { "*.md" },
--   callback = function ()
--     vim.cmd [[ Prettier ]]
--   end,
--   group = prettify_group
-- })
