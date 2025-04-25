vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  command = "FormatWrite",
})

return {
  {
    'mhartington/formatter.nvim',
    config = function()
      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require("formatter").setup {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          markdown = {
            -- You can also define your own configuration
            function()
              -- Supports conditional formatting
              -- if require "formatter.util".get_current_buffer_file_name() == "special.lua" then
              --   return nil
              -- end

              -- Full specification of configurations is down below and in Vim help
              -- files
              return {
                exe = "prettier",
                args = {
                  -- "--search-parent-directories",
                  -- "--stdin-filepath",
                  require "formatter.util".escape_path(require "formatter.util".get_current_buffer_file_path()),
                  -- "--",
                  -- "-",
                },
                stdin = true,
              }
            end
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          -- ["*"] = {
          --   -- "formatter.filetypes.any" defines default configurations for any
          --   -- filetype
          --   require("formatter.filetypes.any").remove_trailing_whitespace,
          --   -- Remove trailing whitespace without 'sed'
          --   -- require("formatter.filetypes.any").substitute_trailing_whitespace,
          -- }
        }
      }
    end
  },
}
