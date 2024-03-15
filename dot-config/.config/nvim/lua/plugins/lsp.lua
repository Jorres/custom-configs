require("mason").setup()

local lua_library = vim.api.nvim_get_runtime_file("", true)
lua_library['/usr/share/nvim/runtime/lua'] = true
lua_library['/usr/share/nvim/runtime/lua/lsp'] = true
lua_library['/usr/share/awesome/lib'] = true

local servers = {
  clangd = {},
  gopls = {},
  yamlls = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.yaml",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      }
    },
  },
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
        library = lua_library,
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

local on_attach = function(_, bufnr)
  if vim.bo[bufnr].filetype == "helm" then
    vim.diagnostic.disable(bufnr)
  end
  client.server_capabilities.semanticTokensProvider = nil
end

vim.cmd [[
  autocmd CursorHold * lua vim.diagnostic.open_float()
]]


local enforce_installed = vim.tbl_keys(servers)

-- Here is the mapping between mason names and lspconfig names:
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
-- In this table, you can only specify SERVERS, not general tools :( 
-- For stuff like `prettify`, you still have to do it manually
local zero_setup_servers = {
  "bashls",
  "dockerls",
  "kotlin_language_server",
  "terraformls",
  "tsserver",
  "golangci_lint_ls",
  "pyright",
}

for _, server in ipairs(zero_setup_servers) do
  table.insert(enforce_installed, server)
end

require("mason-lspconfig").setup {
  ensure_installed = enforce_installed,
}

require("mason-lspconfig").setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      settings = servers[server_name],
      on_attach = on_attach,
    }
  end,
}

local null_ls = require "null-ls"

null_ls.setup()
