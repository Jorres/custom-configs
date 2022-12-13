require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c",
    "lua",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "go",
    "html",
    "css",
    "rust",
    "bash",
    "markdown",
    "cpp",
    "java",
    "kotlin",
    "latex",
    "python",
    "vim",
    "svelte",
    "help",
  },
  sync_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = { "markdown" },
  },
  incremental_selection = {
    enable = true,
    disable = {},
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
    disable = {}
  },
  textobjects = {
    enable = false
  },
  rainbow = {
    enable = true,
    disable = { "markdown" },
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 5000, -- Do not enable for files with more than n lines, int
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

-- TODO does not work for some reason :( unable to do folds
local ft_to_parser = require "nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.telekasten = "markdown"
