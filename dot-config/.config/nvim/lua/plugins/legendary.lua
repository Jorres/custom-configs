local named_keymaps = {}

local default_opts = {
  noremap = true,
  silent = true
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
    local filetype = vim.bo.filetype
    if filetype == "Avante" or filetype == "AvanteInput" then
      vim.api.nvim_command(":AvanteToggle")
    else
      vim.api.nvim_command(":GpChatToggle")
      if chat.active then
        chat.active = false
        vim.api.nvim_command('stopinsert')
      else
        vim.api.nvim_command('startinsert')
        chat.active = true
      end
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

named_keymaps.file_sequence_toggle = {
  "<leader>ss",
  ":lua MiniFiles.open()<CR>",
  mode = { "n" },
  description = "Toggle file sequence",
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

named_keymaps.jump_forward_insert_mode = {
  "<C-s>",
  function()
    require("flash").jump({
      search = { forward = true, wrap = true, multi_window = false },
    })
  end,
  mode = { "i" },
  description = "Jump on the screen insert mode",
}

local unnamed_keymaps = {}
for _, v in pairs(named_keymaps) do
  table.insert(unnamed_keymaps, v)
end

local named_commands = {}

local unnamed_commands = {}
for _, v in pairs(named_commands) do
  table.insert(unnamed_commands, v)
end

require('legendary').setup({
  -- Initial keymaps to bind
  keymaps = unnamed_keymaps,
  -- Initial commands to bind
  commands = unnamed_commands,
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

-- I don't recall using those keymaps ever, they make the quickfix list slow
vim.keymap.del('n', '[d')
vim.keymap.del('n', ']d')
