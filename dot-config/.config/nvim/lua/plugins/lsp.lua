local lspconfig = require 'lspconfig'

require("mason").setup()
require("mason-lspconfig").setup()

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--   -- Enable underline, use default values
--   underline = true,
--   signs = false,
--   -- Enable virtual text only on Warning or above, override spacing to 2
--   virtual_text = {
--     spacing = 2,
--     severity_limit = "Warning",
--   },
-- }
-- )

require("mason-lspconfig").setup_handlers {

  function(server_name)
    require("lspconfig")[server_name].setup {
    }
  end,

  ["gopls"] = function()
    lspconfig.gopls.setup {
      cmd = { "gopls", "serve" },
      filetypes = { "go", "gomod" },
      root_dir = require "lspconfig/util".root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }
  end,

  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim', 'text', 'for_node', 'indent', 'newline', 'list', 'random_words', 'awesome' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = true,
          },
        },
      },
    }
  end
}

local null_ls = require "null-ls"

null_ls.setup()
