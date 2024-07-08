require("settings.autocmds")

require("settings.mappings")

require("settings.options")

require("settings.reload")

-- safe to place last
require("settings.theme")

vim.api.nvim_command [[
if has('nvim')
  let $ARC_EDITOR = 'nvr -cc split --remote-wait'
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
]]

vim.api.nvim_command [[
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
]]

local home_dir = vim.fn.expand("~/")
local dir_path = home_dir .. ".vim/after/vim-highlighter"
vim.fn.mkdir(dir_path, "p")
