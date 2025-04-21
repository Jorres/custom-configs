return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup({
        ensure_installed = {
          "lua",
          "cpp",
          "go",
          "markdown",
          "javascript",
          "html",
          "css",
          "rust",
          "bash",
          "python",
          "proto",
        },
        sync_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
          disable = function(lang, buf)
            -- disable by language
            -- if lang == "markdown" then
            --   return true
            -- end
            local max_filesize = 100 * 1024
            local ok, stats    = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        incremental_selection = {
          enable = false,
        },
        indent = {
          enable = false,
        },
        textobjects = {
          enable = false
        },
        build = ":TSUpdate",
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
      })
    end
  },
  { 'hiphish/rainbow-delimiters.nvim' },
  -- { 'nvim-treesitter/playground' },
}
