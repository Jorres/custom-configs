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

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = args.buf, id = client.id
                })
              end
            })
          end
        end
      })

      vim.lsp.config("*", {
        on_attach = on_attach,
      })

      vim.lsp.config("golangci_lint_ls", {
        settings = {
          cmd = { "golangci-lint", "run", "--fast", "--out-format", "json", "-j", "2" }
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
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
