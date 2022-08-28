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


setter({
  -- Execute tests agnostic from language
  ["<leader><leader>t"] = ":TestFile<CR>",
  -- Execute lua test
  ["<leader><leader>lt"] = function()
    require('plenary.test_harness').test_directory(vim.fn.expand("%:p"))
  end,
}, { "n" })

-- Exit from terminal mode comfortably
setter({
  ["<c-[>"] = "<c-\\><c-n>",
  ["<Esc>"] = "<c-\\><c-n>"
}, { "t" })

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
  ["["] = function()
    pcall(del, { "n", "i", "v" }, "[%")
    vim.cmd("cnext")
  end,
  ["]"] = function()
    pcall(del, { "n", "i", "v" }, "]%")
    vim.cmd("cprev")
  end,
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

-- NvimTree
set({ "n" }, "<leader>n", ":NvimTreeFindFileToggle<CR>", default_opt)

-- ZenMode
set({ "n" }, "<leader>a", ":TZAtaraxis<CR>", default_opt)
set({ "v" }, "<leader>a", ":'<,'>TZNarrow<CR>", default_opt)

-- Integrating with tmux
-- vim.opt["tmux_navigator_no_mappings"] = 1
setter({
  ["<C-h>"] = ":TmuxNavigateLeft<cr>",
  ["<C-j>"] = ":TmuxNavigateDown<cr>",
  ["<C-k>"] = ":TmuxNavigateUp<cr>",
  ["<C-l>"] = ":TmuxNavigateRight<cr>",
}, { "n", "i", "v" })

-- Packer
set({ "n" }, "<leader>Ps", ":PackerSync<CR>", default_opt)

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
  [leader .. "Pi"] = require("carbon-now").create_snippet
}, { "v" })

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

-- Telekasten

local kasten_prefix = leader .. "z"
local telekasten = require 'telekasten'

setter({
  -- [kasten_prefix .. "d"] = telekasten.goto_today,
  -- [kasten_prefix .. "w"] = telekasten.goto_thisweek,
  [kasten_prefix .. "f"] = telekasten.follow_link,
  [kasten_prefix .. "n"] = telekasten.new_note,
  [kasten_prefix .. "b"] = telekasten.show_backlinks,
  [kasten_prefix .. "s"] = telekasten.find_notes, -- think 'search'
  [kasten_prefix .. "#"] = telekasten.show_tags,
  [kasten_prefix .. "l"] = telekasten.insert_link, -- {i = true}
  [kasten_prefix .. "im"] = telekasten.insert_img_link, -- {i = true}
  [kasten_prefix .. "ip"] = telekasten.paste_img_and_link,
  [kasten_prefix .. "iv"] = telekasten.preview_img,
  [kasten_prefix .. "c"] = telekasten.show_calendar,
  [kasten_prefix .. "r"] = telekasten.rename_note,
}, { "n" })

-- zd find_daily_notes
-- zg search_notes
-- zw find_weekly_notes
-- zN new_templated_note
-- zy yank_notelink
-- zc show_calendar
-- zt toggle_todo
-- zb show_backlinks
-- zF find_friends
-- zp preview_img
-- zm browse_media
-- zC :CalendarT
-- #  show_tags

-- Custom plugins

local ok_showmethat, msg = pcall(require, "showmethat")
if not ok_showmethat then
  -- It would be perfect to log this without explicitly print()'ing 
  -- this to interrupt user flow
else
  local showmethat = require("showmethat")
  set("n", leader .. "sh", showmethat.show)
  set("n", leader .. "sk", showmethat.kill_all)
end


-- Try to make link opening work
-- TODO for some mysterious reason, works on Matebook but not on Thinkpad
set("n", 'gx', [[:execute '!xdg-open ' . shellescape(expand('<cfile>'), 1)<CR>]])
