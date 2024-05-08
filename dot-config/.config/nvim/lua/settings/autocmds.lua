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

local function make_hl_file_path()
  local home_dir = os.getenv("HOME")
  local filepath = vim.fn.expand("%:p")
  local safe_path = string.gsub(filepath, "/", "_")
  return string.format("%s/.vim/after/vim-highlighter/%s", home_dir, safe_path)
end

local api = require("nvim-tree.api")
local Event = api.events.Event
api.events.subscribe(Event.TreeOpen, function()
  local hl_path = make_hl_file_path()
  vim.cmd(string.format("Hi load %s", hl_path))
end)

vim.api.nvim_create_autocmd({ "WinLeave", "VimLeave" }, {
  pattern = "*",
  callback = function()
    if vim.api.nvim_buf_get_option(0, 'filetype') == "NvimTree" then
      local hl_path = make_hl_file_path()
      vim.cmd(string.format("Hi save %s", hl_path))
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local hl_path = make_hl_file_path()
    vim.cmd(string.format("Hi load %s", hl_path))
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local hl_path = make_hl_file_path()
    vim.cmd(string.format("Hi save %s", hl_path))
  end,
})

-- Make some built-in vim highlighting activate for salt files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.sls",
  callback = function()
    vim.cmd("set filetype=jinja")
  end,
})

local Path = require('plenary.path')
local Scan = require('plenary.scandir')

local function delete_files_of_size(directory, size)
  local files = Scan.scan_dir(directory, {
    hidden = false,
    depth = 2,
  })

  for _, file in ipairs(files) do
    local p = Path:new(file)
    if p:is_file() then
      local file_size = p:_stat().size
      if file_size == size then
        p:rm()
      end
    end
  end
end

vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    -- if it stops working, just do a :Hi save ./abc.txt on an empty file and
    local empty_vim_highlighter_header_length = 26
    delete_files_of_size(string.format("%s/.vim/after/vim-highlighter", os.getenv("HOME")),
      empty_vim_highlighter_header_length)
  end,
})

-- local prettify_prettify = vim.api.nvim_create_augroup("auto Prettify md", {clear = true})
-- vim.api.nvim_create_autocmd({"BufWritePost"}, {
--   pattern = { "*.md" },
--   callback = function ()
--     vim.cmd [[ Prettier ]]
--   end,
--   group = prettify_group
-- })
