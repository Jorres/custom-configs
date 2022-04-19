local lspconfig = require'lspconfig'

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- <leader>s for lSp! to have it on a different hand instead of ,l! Microing your ergonomics!
    local pref = "<leader>s"
    buf_set_keymap('n', pref .. 'd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', pref .. 'D', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', pref .. 'i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', pref .. 'r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    buf_set_keymap('n', pref .. 'f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', pref .. 'a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', pref .. 'n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    local diagnostic_pref = 'd'

    buf_set_keymap('n', diagnostic_pref .. 'k', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', diagnostic_pref .. 'j', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', diagnostic_pref .. 'l', '<cmd>Telescope diagnostics', opts)


    -- These ones I'd like to have:
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    --
    -- This is made redundant by lsp.buf.goto_next
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)


    -- These ones I do not yet use in my workflow
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
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


--[[ lspconfig.yamlls.setup{
    on_attach = on_attach,
    settings = {
        yaml = {
            schemas = { kubernetes = "/*.yaml" },
        }
    }
} ]]

local sumneko_root_path = "/home/jorres/Downloads/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.tsserver.setup{ on_attach = on_attach, }

lspconfig.cssls.setup{ on_attach = on_attach, }

lspconfig.ccls.setup {
  on_attach = on_attach,
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}


lspconfig.zeta_note.setup{
  cmd = {'/home/jorres/bin/zeta-note'},
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern(".git"),
  settings = {
      filetypes = { "md" }
  }
}

lspconfig.gopls.setup{
  on_attach = on_attach,
}

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
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
        globals = {'vim'},
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

lspconfig.pylsp.setup{ on_attach = on_attach }

lspconfig.rust_analyzer.setup{ on_attach = on_attach }

lspconfig.kotlin_language_server.setup{
    on_attach = on_attach,
    cmd = {
        "/home/jorres/bin/kotlin-language-server/server/build/install/server/bin/kotlin-language-server" 
    },
    filetypes = { "kotlin" },
    root_dir = lspconfig.util.root_pattern("settings.gradle.kts")
}
