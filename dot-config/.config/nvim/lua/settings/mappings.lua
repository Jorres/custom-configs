local set = vim.keymap.set
local leader = vim.g.mapleader

local default_opt = {
  silent = true,
  remap = false
}

local setter = function(mappings, modes)
  for mapping, action in pairs(mappings) do
    set(modes, mapping, action, default_opt)
  end
end


setter({
  -- Execute tests agnostic from language
  ["<leader><leader>t"] = ":TestFile<CR>",
  -- Execute lua test
  ["<leader><leader>lt"] = function()
    require('plenary.test_harness').test_directory(vim.fn.expand("%:p"))
  end,
}, {"n"})


-- Exit from terminal mode comfortably
setter({
  ["<c-[>"] = "<c-\\><c-n>",
  ["<Esc>"] = "<c-\\><c-n>"
}, { "t" })

setter({
  -- make Y behave and yank till the end
  ["Y"] = "yg",
  -- make J behave and stay on the line
  ["J"] = "mzJ`z",
  -- undo break points
  [","] = ",<c-g>u",
  ["!"] = "!<c-g>u",
  ["."] = ".<c-g>u",
  ["?"] = "?<c-g>u",
  -- quickfixlist remaps
  ["["] = ":cnext<CR>",
  ["]"] = ":cprev<CR>",
  ["<leader>q"] = ":cclose<CR>",
  -- open quickfixlist with height 5
  ["<leader>o"] = ":copen 5<CR>",
  -- Persistent highlight from hlsearch distracts.
  ["<CR>"] = ":noh<CR><CR>",
  -- Comfortable switching between windows
  ["<C-h>"] = "<C-w>h",
  ["<C-j>"] = "<C-w>j",
  ["<C-k>"] = "<C-w>k",
  ["<C-l>"] = "<C-w>l",
  -- Resize
  ["U"] = ":vertical resize +5<CR>",
  ["<leader>u"] = ":resize +5<CR>",
  -- Source current file
  ["<leader><leader>x"] = ":source %<CR>",
}, {"n"})

-- Include relative jumps into jump stack for c-i\c-o
-- Figure out how to use vim.v.count with that
vim.cmd [[nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k']]
vim.cmd [[nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j']]


-- Fugitive
set({ "n" }, "<leader>gfh", ":0Gclog<CR>", default_opt)
set({ "n" }, "<leader>ge", ":Gedit<CR>", default_opt)
-- NvimTree
set({ "n" }, "<leader>n", ":NvimTreeFindFileToggle<CR>", default_opt)

-- Integrating with tmux
-- vim.opt["tmux_navigator_no_mappings"] = 1
setter({
  ["<C-h>"] = ":TmuxNavigateLeft<cr>",
  ["<C-j>"] = ":TmuxNavigateDown<cr>",
  ["<C-k>"] = ":TmuxNavigateUp<cr>",
  ["<C-l>"] = ":TmuxNavigateRight<cr>",
}, {"n", "i", "v"})

-- Packer
set({ "n" }, "<leader>ps", ":PackerSync<CR>", default_opt)

-- Telescope
setter({
  [leader .. "gs"] = function() require('telescope.builtin').live_grep({ hidden = true }) end,
  [leader .. "gc"] = require('telescope.builtin').git_commits,
  [leader .. "t"] = function() require('telescope.builtin').git_files({ hidden = true }) end,
  [leader .. "j"] = function() require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") } end,
  [leader .. "vh"] = require('telescope.builtin').help_tags,
  [leader .. "br"] = require('plugins.telescope').git_branches,
  [leader .. "vrc"] = require('plugins.telescope').search_dotfiles
}, { "n" })

-- Carbon
setter({
  [leader .. "pic"] = require("carbon-now").create_snippet
}, {"v"})

-- Harpoon
local harpoon_pref = leader .. "h"

local loud_opts = { silent = false }

set("n", harpoon_pref .. "m", require "harpoon.ui".toggle_quick_menu, loud_opts)
set("n", harpoon_pref .. "a", require "harpoon.mark".add_file, loud_opts)

for i = 1, 8, 1 do
  set("n", leader .. i, function()
    require "harpoon.ui".nav_file(i)
  end, default_opt)
end
