require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c",
    "lua",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "json",
    "go",
    "html",
    "css",
    "rust",
    "bash", 
    "markdown",
    "cpp", 
    "dockerfile",
    "java",
    "kotlin",
    "latex",
    "python",
    "vim"
  },
  sync_install = true,
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
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
    disable = {},
    extended_mode = true,  -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 5000, -- Do not enable for files with more than n lines, int
  },
  playground = {
    enable = true,
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

