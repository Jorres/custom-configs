local set = vim.keymap.set
local del = vim.keymap.del
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

-- This allows to paste and delete without spoiling
-- what is in my primary register.
setter({ ["<leader>p"] = "\"_dP" }, { "x" })
setter({ ["<leader>d"] = "\"_d" }, { "n" })
setter({ ["<leader>d"] = "\"_d" }, { "v" })

setter({
  -- make Y behave and yank till the end
  ["Y"] = "yg",
  -- make J behave and stay on the line
  ["J"] = "mzJ`z",
  -- undo break points
  ["!"] = "!<c-g>u",
  ["?"] = "?<c-g>u",
  -- quickfixlist remaps
  ["]"] = function()
    pcall(del, { "n", "i", "v" }, "[%")
    vim.cmd("cnext")
  end,
  ["["] = function()
    pcall(del, { "n", "i", "v" }, "]%")
    vim.cmd("cprev")
  end,
  ["<leader>q"] = ":cclose<CR>",
  -- open quickfixlist with height 5
  ["<leader>o"] = ":copen 5<CR>",
  -- Resize
  ["U"] = ":vertical resize +5<CR>",
  ["<leader>u"] = ":resize +5<CR>",
  -- Source current file
  ["<leader><leader>x"] = ":source %<CR>",
  -- use one button for folding
  [";"] = "za",
}, { "n" })

-- Include relative jumps into jump stack for c-i\c-o
-- Figure out how to use vim.v.count with that
vim.cmd [[nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k']]
vim.cmd [[nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j']]

-- Fugitive
set({ "n" }, "<leader>gfh", ":0Gclog<CR>", default_opt)
set({ "n" }, "<leader>ge", ":Gedit<CR>", default_opt)

-- Telescope
setter({
  [leader .. "gs"] = require('plugins.telescope').live_grep_with_optional_filter,
  [leader .. "gc"] = require('telescope.builtin').git_commits,
  [leader .. "f"] = function() require('telescope.builtin').find_files({ hidden = true }) end,
  [leader .. "j"] = function() require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") } end,
  [leader .. "vh"] = require('telescope.builtin').help_tags,
  [leader .. "br"] = require('plugins.telescope').git_branches,
}, { "n" })


-- Gitsigns
local gitsigns = require 'gitsigns'

local hunk_prefix = leader .. "h"
setter({
  [hunk_prefix .. "s"] = gitsigns.stage_hunk,
  [hunk_prefix .. "r"] = gitsigns.reset_hunk,
  [hunk_prefix .. "u"] = gitsigns.undo_stage_hunk,
  [hunk_prefix .. "p"] = gitsigns.preview_hunk,
  [hunk_prefix .. "n"] = gitsigns.next_hunk,
  [leader .. "bl"] = gitsigns.toggle_current_line_blame,
  -- [leader .. "d"] =  gitsigns.toggle_deleted,
}, { "n" })

-- for some reason, remapping this does not work, so here it is for reference only:
vim.cmd([[
   let HiSet   = 'f<CR>'
   let HiErase = 'f<BS>'
   let HiClear = 'f<C-L>'
   let HiFind  = 'f<Tab>'
   let HiSetSL = 't<CR>'
 ]])
