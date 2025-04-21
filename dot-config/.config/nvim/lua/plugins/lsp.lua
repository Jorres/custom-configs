return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- vim.cmd [[
      --   autocmd CursorHold * lua vim.diagnostic.open_float({ border = "solid" })
      -- ]]

      local on_attach = function(_, bufnr)
        if vim.bo[bufnr].filetype == "helm" then
          vim.diagnostic.enable(false, bufnr)
        end
      end

      vim.lsp.config("*", {
        on_attach = on_attach,
      })

      vim.lsp.config("golangci_lint_ls", {
        settings = {
          cmd = { "golangci-lint", "run", "--fast", "--out-format", "json", "-j", "2" }
        }
      })

      vim.lsp.config("lua_ls", {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {
                'vim', 'text', 'for_node', 'indent', 'newline',
                'list', 'random_words', 'awesome', 'terminal',
                'editor', 'editor_cmd', 'modkey', 'mymainmenu',
                'client', 'screen', 'root', 'require', 'print',
              },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })
    end
  },
  {
    'williamboman/mason.nvim',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      -- Here is the mapping between mason names and lspconfig names:
      -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
      -- In this table, you can only specify SERVERS, not general tools :(
      -- For stuff like `prettify`, you still have to do it manually
      local ensure_installed = {
        "gopls",
        "terraformls",
        "pyright",
        "lua_ls",
        "golangci_lint_ls",
      }

      local handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end
      }

      require("mason-lspconfig").setup {
        ensure_installed = ensure_installed,
        handlers = handlers,
      }
    end
  }
}
