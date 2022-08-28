local lspconfig = require 'lspconfig'

local on_attach = function(client, bufnr)
  local opts = { 
    noremap = true, 
    silent = true, 
    buffer = bufnr 
  }
  local set = vim.keymap.set

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- <leader>s for lSp! to have it on a different hand instead of ,l! Microing your ergonomics!
  local pref = vim.g.mapleader .. "s"
  set('n', pref .. 'd', ':Telescope lsp_definitions<CR>', opts)
  set('n', pref .. 'i', ':Telescope lsp_implementations<CR>', opts)
  set('n', pref .. 'r', ':Telescope lsp_references<CR>', opts)

  set('n', pref .. 'f', vim.lsp.buf.formatting, opts)
  set('n', pref .. 'a', vim.lsp.buf.code_action, opts)
  set('n', pref .. 'n', vim.lsp.buf.rename, opts)
  set('n', 'K', vim.lsp.buf.hover, opts)

  local diagnostic_pref = 'd'

  set('n', diagnostic_pref .. 'k', vim.lsp.diagnostic.goto_prev, opts)
  set('n', diagnostic_pref .. 'j', vim.lsp.diagnostic.goto_next, opts)
  set('n', diagnostic_pref .. 'l', ':Telescope diagnostics<CR>', opts)


  -- These ones I'd like to have:
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --
  -- This is made redundant by lsp.buf.goto_next
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)


  -- These ones I do not yet use in my workflow
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua P(vim.lsp.buf.list_workspace_folders())<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Enable underline, use default values
  underline = true,
  signs = false,
  -- Enable virtual text only on Warning or above, override spacing to 2
  virtual_text = {
    spacing = 2,
    severity_limit = "Warning",
  },
}
)

local sumneko_root_path = vim.env.HOME .. "/bin/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.tsserver.setup { on_attach = on_attach, }

lspconfig.cssls.setup { on_attach = on_attach, }

lspconfig.ccls.setup {
  on_attach = on_attach,
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math" };
    };
  }
}

lspconfig.gopls.setup {
  on_attach = on_attach,
}

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
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

lspconfig.terraformls.setup { on_attach = on_attach }

lspconfig.pylsp.setup { on_attach = on_attach }

lspconfig.rust_analyzer.setup { on_attach = on_attach }

lspconfig.kotlin_language_server.setup {
  on_attach = on_attach,
  cmd = {
    "/home/jorres/bin/kotlin-language-server/server/build/install/server/bin/kotlin-language-server"
  },
  filetypes = { "kotlin" },
  root_dir = lspconfig.util.root_pattern("settings.gradle.kts")
}
