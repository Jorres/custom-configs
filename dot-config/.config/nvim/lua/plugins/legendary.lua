local named_keymaps = {}

local default_opts = {
  noremap = true,
  silent = true
}

named_keymaps.highlight = {
  "<leader>hl",
  ":<c-u>HSHighlight 1<CR>",
  mode = { "v" },
  description = "Do visual highlight",
  opts = default_opts
}

named_keymaps.remove_highlight = {
  "<leader>hr",
  ":<c-u>HSRmHighlight<CR>",
  mode = { "v" },
  description = "Remove visual highlight",
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

-- named_keymaps.lsp_prev_diagnostic = {
--   "dk",
--   vim.lsp.diagnostic.goto_prev,
--   mode = { "n" },
--   description = "Go to previous diagnostic",
--   opts = default_opts
-- }

-- named_keymaps.lsp_next_diagnostic = {
--   "dj",
--   vim.lsp.diagnostic.goto_next,
--   mode = { "n" },
--   description = "Go to next diagnostic",
--   opts = default_opts
-- }

named_keymaps.lsp_view_all_diagnostics = {
  "dl",
  ":Telescope diagnostics<CR>",
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

named_keymaps.packer_sync = {
  "<leader>Ps",
  ":PackerSync<CR>",
  mode = { "n" },
  description = "PackerSync, but shorter",
  opts = default_opts
}

named_keymaps.test_file = {
  "<leader><leader>t",
  ":TestFile<CR>",
  mode = { "n" },
  description = "Run language agnostic tests",
  opts = default_opts
}

named_keymaps.lua_test_file = {
  "<leader><leader>lt",
  function()
    require('plenary.test_harness').test_directory(vim.fn.expand("%:p"))
  end,
  mode = { "n" },
  description = "Run current lua file tests",
  opts = default_opts
}

named_keymaps.toggleterm_send_visual_selection = {
  "<leader>t",
  ":ToggleTermSendVisualSelection<CR>:ToggleTerm<CR>",
  mode = { "v" },
  description = "Send visual selection to terminal",
  opts = default_opts
}

local tmux_moves = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

-- vim.opt["tmux_navigator_no_mappings"] = 1
for direction_vim, direction_word in pairs(tmux_moves) do
  named_keymaps["tmux_move_" .. direction_vim] = {
    "<C-" .. direction_vim .. ">",
    ":TmuxNavigate" .. direction_word .. "<CR>",
    mode = { "n", "v" },
    description = "Tmux navigate " .. direction_word,
    opts = default_opts
  }
end

named_keymaps.toggleterm_send_line = {
  "<leader>t",
  ":ToggleTermSendCurrentLine<CR>:ToggleTerm<CR>",
  mode = { "n" },
  description = "Send current line to terminal",
  opts = default_opts
}

named_keymaps.increment = {
  "<c-f>",
  "<c-a>",
  mode = { "n" },
  description = "Increment next number",
  opts = default_opts
}

local unnamed_keymaps = {}
for _, v in pairs(named_keymaps) do
  table.insert(unnamed_keymaps, v)
end

local named_commands = {}

-- named_commands.packer_sync_shorter = {
--   ':PS',
--   function() vim.api.nvim_command(':PackerSync<CR>') end,
--   description = 'PackerSync, but shorter'
-- }

local unnamed_commands = {}
for _, v in pairs(named_commands) do
  table.insert(unnamed_commands, v)
end

-- require('legendary').setup({
--   autocmds = {
--     -- Create autocmds and augroups
--     { 'BufWritePre', vim.lsp.buf.format, description = 'Format on save' },
--     {
--       name = 'MyAugroup',
--       clear = true,
--       -- autocmds here
--     },
--   },
--   functions = {
--     -- Make arbitrary Lua functions that can be executed via the item finder
--     { function() doSomeStuff() end, description = 'Do some stuff with a Lua function!' },
--   },
-- })

require('legendary').setup({
  -- Initial keymaps to bind
  keymaps = unnamed_keymaps,
  -- Initial commands to bind
  commands = unnamed_commands,
  -- Initial augroups/autocmds to bind
  autocmds = {},
  -- Initial functions to bidn
  functions = {},
  -- default opts to merge with the `opts` table
  -- of each individual item
  default_opts = {
    keymaps = {},
    commands = {},
    autocmds = {},
  },

  sort = {
    most_recent_first = true,
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
  which_key = {
    -- Automatically add which-key tables to legendary
    -- see ./doc/WHICH_KEY.md for more details
    auto_register = false,
    -- you can put which-key.nvim tables here,
    -- or alternatively have them auto-register,
    -- see ./doc/WHICH_KEY.md
    mappings = {},
    opts = {},
    -- controls whether legendary.nvim actually binds they keymaps,
    -- or if you want to let which-key.nvim handle the bindings.
    -- if not passed, true by default
    do_binding = true,
  },
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
