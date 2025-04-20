local named_keymaps = {}

local default_opts = {
  noremap = true,
  silent = true
}

local loud_opts = { silent = false }


-- DELETING

-- I don't recall using those keymaps ever, they make the quickfix list slow
vim.keymap.del('n', '[d')
vim.keymap.del('n', ']d')
-- this disable ftplugin for markdown mappings, they also mess with quickfix [ and ]
vim.g.no_markdown_maps = 1

-- legendary: ,l
-- telescope git commits: ,gc
--   [leader .. "j"] = function() require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") } end,
-- Fugitive
-- set({ "n" }, "<leader>gfh", ":0Gclog<CR>", default_opt)
-- set({ "n" }, "<leader>ge", ":Gedit<CR>", default_opt)
-- leader d, leader p: without spoiling primary register

-- Include relative jumps into jump stack for c-i\c-o
-- Figure out how to use vim.v.count with that
vim.cmd [[
  nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
  nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
]]

-- CREATING

named_keymaps.visual_leader_p = {
  "<leader>p",
  "\"_dP",
  mode = { "x" },
  opts = default_opts,
  description = "Paste over selection without yanking",
}

named_keymaps.gitlinker = {
  "<leader>gy",
  function()
    require"gitlinker".get_buf_range_url("n")
  end,
  mode = { "n" },
  opts = default_opts,
  description = "Create a link to line (normal mode)",
}

named_keymaps.gitlinker_visual_range = {
  "<leader>gy",
  function()
    require"gitlinker".get_buf_range_url("v")
  end,
  mode = { "v" },
  opts = default_opts,
  description = "Create a link to line (visual range)",
}

local last_diagnostic_id = 0

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(_)
    last_diagnostic_id = 0
  end,
})

named_keymaps.jump_next_diagnostic = {
  "<leader>dj",
  function()
    local diagnostics = vim.diagnostic.get(nil)
    if #diagnostics == 0 then
      require"notify"("No diagnostics found :)")
      return
    end

    last_diagnostic_id = last_diagnostic_id % (#diagnostics)
    last_diagnostic_id = last_diagnostic_id + 1
    local last_diagnostic = diagnostics[last_diagnostic_id]

    vim.api.nvim_set_current_buf(last_diagnostic.bufnr)
    vim.diagnostic.jump({diagnostic = last_diagnostic, float = true})
  end,
  mode = { "n" },
  opts = default_opts,
  description = "Jump to next diagnostic",
}

named_keymaps.normal_leader_d = {
  "<leader>d",
  "\"_d",
  mode = { "n" },
  opts = default_opts,
  description = "Delete to blackhole register",
}

named_keymaps.visual_leader_d = {
  "<leader>d",
  "\"_d",
  mode = { "v" },
  opts = default_opts,
  description = "Delete to blackhole register (visual)",
}

named_keymaps.line_join_keep_pos = {
  "J",
  "mzJ`z",
  mode = { "n" },
  opts = default_opts,
  description = "Join line but keep cursor position",
}

named_keymaps.undo_break_exclaim = {
  "!",
  "!<c-g>u",
  mode = { "n" },
  opts = default_opts,
  description = "Undo break after !",
}

named_keymaps.undo_break_question = {
  "?",
  "?<c-g>u",
  mode = { "n" },
  opts = default_opts,
  description = "Undo break after ?",
}

named_keymaps.quickfix_next = {
  "]",
  function()
    vim.cmd("cnext")
  end,
  mode = { "n" },
  opts = default_opts,
  description = "Quickfix next",
}

named_keymaps.quickfix_prev = {
  "[",
  function()
    vim.cmd("cprev")
  end,
  mode = { "n" },
  opts = default_opts,
  description = "Quickfix prev",
}

named_keymaps.quickfix_close = {
  "<leader>q",
  ":cclose<CR>",
  mode = { "n" },
  opts = default_opts,
  description = "Close quickfix",
}

named_keymaps.quickfix_open5 = {
  "<leader>o",
  ":copen 5<CR>",
  mode = { "n" },
  opts = default_opts,
  description = "Open quickfix with height 5",
}

named_keymaps.vertical_resize_plus5 = {
  "U",
  ":vertical resize +5<CR>",
  mode = { "n" },
  opts = default_opts,
  description = "Increase window width by 5",
}

named_keymaps.resize_plus5 = {
  "<leader>u",
  ":resize +5<CR>",
  mode = { "n" },
  opts = default_opts,
  description = "Increase window height by 5",
}

named_keymaps.source_current_file = {
  "<leader><leader>x",
  ":source %<CR>",
  mode = { "n" },
  opts = default_opts,
  description = "Source current file",
}

named_keymaps.toggle_fold = {
  ";",
  "za",
  mode = { "n" },
  opts = default_opts,
  description = "Toggle fold",
}

named_keymaps.print_var = {
  "<leader>rv",
  function() require('refactoring').debug.print_var() end,
  mode = { "n" },
  description = "Debug a variable",
  opts = default_opts
}

named_keymaps.debug_cleanup = {
  "<leader>rc",
  function() require('refactoring').debug.cleanup({}) end,
  mode = { "n" },
  description = "Cleanup debug statements",
  opts = default_opts
}

named_keymaps.telescope_lsp_definitions = {
  "<leader>sd",
  ":Telescope lsp_definitions<CR>",
  mode = { "n" },
  description = "Jump to definition with telescope",
  opts = default_opts
}

named_keymaps.telescope_lsp_implementations = {
  "<leader>si",
  ":Telescope lsp_implementations<CR>",
  mode = { "n" },
  description = "Jump to implementations with telescope",
  opts = default_opts
}

named_keymaps.telescope_lsp_references = {
  "<leader>sr",
  ":Telescope lsp_references<CR>",
  mode = { "n" },
  description = "Jump to references with telescope",
  opts = default_opts
}

named_keymaps.lsp_format = {
  "<leader>sf",
  function() vim.lsp.buf.format({ async = true }) end,
  mode = { "n" },
  description = "Format file using LSP formatting",
  opts = default_opts
}

named_keymaps.fixjson = {
  "<leader>sj",
  ":'<,'>!fixjson<CR>",
  mode = { "v" },
  description = "Format json",
  opts = default_opts
}

named_keymaps.lsp_code_action = {
  "<leader>sa",
  vim.lsp.buf.code_action,
  mode = { "n" },
  description = "Perform LSP code action",
  opts = default_opts
}

named_keymaps.lsp_rename = {
  "<leader>sn",
  vim.lsp.buf.rename,
  mode = { "n" },
  description = "Perform LSP rename",
  opts = default_opts
}

named_keymaps.lsp_hover = {
  "K",
  vim.lsp.buf.hover,
  mode = { "n" },
  description = "Do hover action over element, get documentation",
  opts = default_opts
}

named_keymaps.lsp_view_all_diagnostics = {
  "<leader>ds",
  vim.diagnostic.setqflist,
  mode = { "n" },
  description = "Show all diagnostics",
  opts = default_opts
}

named_keymaps.show_legendary = {
  "<leader>l",
  ":Legendary<CR>",
  mode = { "n" },
  description = "Show legendary",
  opts = default_opts
}

local tmux_moves = {
  -- this one is a hack. I use QMK to override ctrl+h to send a backspace.
  -- but I use tmux to send C-h to vim anyway when tmux detects backspace.
  -- that's why it works here without a custom reaction to backspace, vim never
  -- sees backspace in the first place
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

-- Have to explicitly disable standard mappings of this plugin:
vim.api.nvim_command("let g:tmux_navigator_no_mappings = 1")

for direction_vim, direction_word in pairs(tmux_moves) do
  named_keymaps["jump_window_" .. direction_word] = {
    "<C-" .. direction_vim .. ">",
    function()
      vim.api.nvim_command("TmuxNavigate" .. direction_word)
    end,
    mode = { "n", "v" },
    description = "Easier switching between windows",
    opts = default_opts
  }
end

for direction_vim, direction_word in pairs(tmux_moves) do
  named_keymaps["jump_window_insert_" .. direction_word] = {
    "<C-" .. direction_vim .. ">",
    function()
      local s = vim.api.nvim_replace_termcodes('<C-h>', true, true, true)
      vim.api.nvim_feedkeys(s, 'n', false)
    end,
    mode = { "i" },
    description = "Easier switching between windows",
    opts = default_opts
  }
end

local chat = {
  active = false,
}

named_keymaps.run_chat_gpt = {
  "<C-c>",
  function()
    vim.api.nvim_command(":GpChatToggle")
    if chat.active then
      chat.active = false
      vim.api.nvim_command('stopinsert')
    else
      vim.api.nvim_command('startinsert')
      chat.active = true
    end
  end,
  mode = { "n", "i" },
  description = "Open/close ChatGPT window",
  opts = default_opts
}

named_keymaps.change_chat_gpt_agent = {
  "<leader>a",
  function()
    vim.api.nvim_command(":GpNextAgent")
  end,
  mode = { "n" },
  description = "Change AI agent",
  opts = default_opts
}

named_keymaps.exit_terminal_1 = {
  "<c-[>",
  "<c-\\><c-n>",
  mode = { "t" },
  description = "Exit terminal easier 1",
  opts = default_opts
}

named_keymaps.exit_terminal_2 = {
  "<Esc>",
  "<c-\\><c-n>",
  mode = { "t" },
  description = "Exit terminal easier 2",
  opts = default_opts
}

named_keymaps.file_tree_toggle = {
  "<leader>n",
  ":NvimTreeFindFileToggle<CR>",
  mode = { "n" },
  description = "Toggle file tree",
  opts = default_opts
}

named_keymaps.increment = {
  "<c-f>",
  "<c-a>",
  mode = { "n" },
  description = "Increment next number",
  opts = default_opts
}

named_keymaps.jump_forward = {
  "s",
  function()
    require("flash").jump({
      search = { forward = true, wrap = true, multi_window = false },
    })
  end,
  mode = { "n", "v" },
  description = "Jump on the screen",
}

named_keymaps.dismiss_notify = {
  "<C-d>",
  function()
    require("notify").dismiss()
  end,
  mode = { "n" },
  description = "Dismiss all notifications",
}

local ok_showmethat, _ = pcall(require, "showmethat")
if not ok_showmethat then
  print('local showmethat not installed ;(')
else
  named_keymaps.showmethat = {
    "<leader>sh",
    function()
      require('showmethat').show()
    end,
    mode = { "n" },
    description = "Show artifact under cursor",
  }
end

named_keymaps.yanky_put_after = {
  "p",
  "<Plug>(YankyPutAfter)",
  mode = { "n", "x" },
  description = "Override regular put with yanky put",
}

named_keymaps.yanky_put_before = {
  "P",
  "<Plug>(YankyPutBefore)",
  mode = { "n", "x" },
  description = "Override regular put before with yanky put",
}

named_keymaps.yanky_gput_after = {
  "gp",
  "<Plug>(YankyGPutAfter)",
  mode = { "n", "x" },
  description = "Yanky g-put after",
}

named_keymaps.yanky_gput_before = {
  "gP",
  "<Plug>(YankyGPutBefore)",
  mode = { "n", "x" },
  description = "Yanky g-put before",
}

named_keymaps.yanky_cycle_forward = {
  "<c-n>",
  "<Plug>(YankyCycleForward)",
  mode = "n",
  description = "Yanky cycle forward",
}

named_keymaps.yanky_cycle_backward = {
  "<c-p>",
  "<Plug>(YankyCycleBackward)",
  mode = "n",
  description = "Yanky cycle backward",
}

named_keymaps.telescope_yank_history = {
  "<leader>y",
  ":Telescope yank_history<CR>",
  mode = "n",
  description = "Telescope yank history",
}

named_keymaps.yanky_yank = {
  "y",
  "<Plug>(YankyYank)",
  mode = { "n", "x" },
  description = "Yanky yank",
}

local harpoon_pref = "<leader>h"
local harpoon = require"harpoon"

named_keymaps.harpoon_toggle_quick_menu = {
  harpoon_pref .. "m",
  function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  mode = "n",
  opts = loud_opts,
  description = "Toggle Harpoon quick menu",
}

named_keymaps.harpoon_add = {
  harpoon_pref .. "a",
  function() harpoon:list():add() end,
  mode = "n",
  opts = loud_opts,
  description = "Add file to Harpoon",
}

for i = 1, 4 do
  named_keymaps["harpoon_select_" .. i] = {
    "<leader>" .. i,
    function() harpoon:list():select(i) end,
    mode = "n",
    opts = default_opts,
    description = "Harpoon select " .. i,
  }
end

-- Telescope
named_keymaps.telescope_live_grep_with_optional_filter = {
  "<leader>gs",
  require('plugins.telescope').live_grep_with_optional_filter,
  mode = { "n" },
  opts = default_opts,
  description = "Telescope live grep with optional filter",
}

named_keymaps.telescope_git_commits = {
  "<leader>gc",
  require('telescope.builtin').git_commits,
  mode = { "n" },
  opts = default_opts,
  description = "Telescope git commits",
}

named_keymaps.telescope_find_files_hidden = {
  "<leader>f",
  function() require('telescope.builtin').find_files({ hidden = true }) end,
  mode = { "n" },
  opts = default_opts,
  description = "Telescope find files (hidden)",
}

named_keymaps.telescope_grep_cword = {
  "<leader>j",
  function() require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") } end,
  mode = { "n" },
  opts = default_opts,
  description = "Telescope grep <cword>",
}

named_keymaps.telescope_help_tags = {
  "<leader>vh",
  require('telescope.builtin').help_tags,
  mode = { "n" },
  opts = default_opts,
  description = "Telescope help tags",
}

-- Gitsigns
named_keymaps.gitsigns_stage_hunk = {
  "<leader>hs",
  require('gitsigns').stage_hunk,
  mode = { "n" },
  opts = default_opts,
  description = "Gitsigns stage hunk",
}

named_keymaps.gitsigns_reset_hunk = {
  "<leader>hr",
  require('gitsigns').reset_hunk,
  mode = { "n" },
  opts = default_opts,
  description = "Gitsigns reset hunk",
}

named_keymaps.gitsigns_undo_stage_hunk = {
  "<leader>hu",
  require('gitsigns').undo_stage_hunk,
  mode = { "n" },
  opts = default_opts,
  description = "Gitsigns undo stage hunk",
}

named_keymaps.gitsigns_preview_hunk = {
  "<leader>hp",
  require('gitsigns').preview_hunk,
  mode = { "n" },
  opts = default_opts,
  description = "Gitsigns preview hunk",
}

named_keymaps.gitsigns_next_hunk = {
  "<leader>hn",
  require('gitsigns').next_hunk,
  mode = { "n" },
  opts = default_opts,
  description = "Gitsigns next hunk",
}

local unnamed_keymaps = {}
for _, v in pairs(named_keymaps) do
  table.insert(unnamed_keymaps, v)
end

require('legendary').setup({
  -- Initial keymaps to bind
  keymaps = unnamed_keymaps,
  -- Initial commands to bind
  commands = {},
  -- Initial augroups/autocmds to bind
  autocmds = {},
  -- Initial functions to bidn
  funcs = {},
  -- default opts to merge with the `opts` table
  -- of each individual item
  default_opts = {
    keymaps = {},
    commands = {},
    autocmds = {},
  },
  sort = {
    -- sort most recently used item to the top
    most_recent_first = true,
    -- sort user-defined items before built-in items
    user_items_first = true,
    -- sort the specified item type before other item types,
    -- value must be one of: 'keymap', 'command', 'autocmd', 'group', nil
    item_type_bias = nil,
    -- settings for frecency sorting.
    -- https://en.wikipedia.org/wiki/Frecency
    -- Set `frecency = false` to disable.
    -- this feature requires sqlite.lua (https://github.com/tami5/sqlite.lua)
    -- and will be automatically disabled if sqlite is not available.
    -- NOTE: THIS TAKES PRECEDENCE OVER OTHER SORT OPTIONS!
    frecency = false,
  },
  -- Customize the prompt that appears on your vim.ui.select() handler
  -- Can be a string or a function that returns a string.
  select_prompt = 'legendary.nvim',
  -- Character to use to separate columns in the UI
  col_separator_char = '│',
  -- Optionally pass a custom formatter function. This function
  -- receives the item as a parameter and the mode that legendary
  -- was triggered from (e.g. `function(item, mode): string[]`)
  -- and must return a table of non-nil string values for display.
  -- It must return the same number of values for each item to work correctly.
  -- The values will be used as column values when formatted.
  -- See function `default_format(item)` in
  -- `lua/legendary/ui/format.lua` to see default implementation.
  default_item_formatter = nil,
  -- Include builtins by default, set to false to disable
  include_builtin = true,
  -- Include the commands that legendary.nvim creates itself
  -- in the legend by default, set to false to disable
  include_legendary_cmds = true,
  -- Sort most recently used items to the top of the list
  -- so they can be quickly re-triggered when opening legendary again
  scratchpad = {
    -- How to open the scratchpad buffer,
    -- 'current' for current window, 'float'
    -- for floating window
    view = 'float',
    -- How to show the results of evaluated Lua code.
    -- 'print' for `print(result)`, 'float' for a floating window.
    results_view = 'float',
    -- Border style for floating windows related to the scratchpad
    float_border = 'rounded',
    -- Whether to restore scratchpad contents from a cache file
    keep_contents = true,
  },
  -- Directory used for caches
  cache_path = string.format('%s/legendary/', vim.fn.stdpath('cache')),
})
