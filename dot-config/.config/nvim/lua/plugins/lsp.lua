require("mason").setup()

local lua_library = vim.api.nvim_get_runtime_file("", true)
lua_library['/usr/share/nvim/runtime/lua'] = true
lua_library['/usr/share/nvim/runtime/lua/lsp'] = true
lua_library['/usr/share/awesome/lib'] = true

local servers = {
  gopls = {},
  yamlls = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.yaml",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      }
    },
  },
  sumneko_lua = {
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


local on_attach = function(_, bufnr)
  if vim.bo[bufnr].filetype == "helm" then
    vim.diagnostic.disable(bufnr)
  end
end

local enforce_installed = vim.tbl_keys(servers)

local additional_tools = {
  "bashls",
  "dockerls",
  "kotlin_language_server",
  "terraformls",
  "tsserver"
}

for _, tool in ipairs(additional_tools) do
  table.insert(enforce_installed, tool)
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
