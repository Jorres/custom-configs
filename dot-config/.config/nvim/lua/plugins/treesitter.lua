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
    "python",
    "vim",
  },
  sync_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = { "markdown", "help", "vimdoc" },
  },
  incremental_selection = {
    enable = true,
    disable = { "markdown", "help", "vimdoc" },
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
    disable = { "markdown", "help", "vimdoc" },
  },
  textobjects = {
    enable = false
  },
  playground = {
    enable = false,
    disable = { "markdown", "help", "vimdoc" },
    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
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
