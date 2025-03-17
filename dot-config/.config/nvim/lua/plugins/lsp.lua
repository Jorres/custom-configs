require("mason").setup()

local lspconfig = require "lspconfig"

-- Here is the mapping between mason names and lspconfig names:
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
-- In this table, you can only specify SERVERS, not general tools :(
-- For stuff like `prettify`, you still have to do it manually
local servers = {
  gopls = {},
  bashls = {},
  dockerls = {},
  terraformls = {},
  pyright = {},
  lua_ls = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'text',
          'for_node',
          'indent',
          'newline',
          'list',
          'random_words',
          'awesome',
          'terminal',
          'editor',
          'editor_cmd',
          'modkey',
          'mymainmenu',
          'client',
          'screen',
          'root',
          'require',
          'print',
        },
      },
      workspace = {
        library = {
          '/usr/share/nvim/runtime/lua',
          '/usr/share/nvim/runtime/lua/lsp',
          '/usr/share/awesome/lib',
        },
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
  }
)

local on_attach = function(client, bufnr)
  if vim.bo[bufnr].filetype == "helm" then
    vim.diagnostic.disable(bufnr)
  end
end

vim.cmd [[
  autocmd CursorHold * lua vim.diagnostic.open_float()
]]

local handlers = {
  function(server_name)
    require('lspconfig')[server_name].setup {
      settings = servers[server_name],
      on_attach = on_attach,
    }
  end,
  ["golangci_lint_ls"] = function()
    lspconfig.golangci_lint_ls.setup {
      init_options = {
        command = { "golangci-lint", "run", "--fast", "--out-format", "json", "-j", "2" },
      },
      on_attach = on_attach,
    }
  end
}

require("mason-lspconfig").setup {
  ensure_installed = vim.tbl_keys(servers),
  handlers = handlers
}

local null_ls = require "null-ls"
null_ls.setup()
