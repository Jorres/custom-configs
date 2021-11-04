local aerial = require('aerial')

-- local LspLocationList = function()
--     vim.lsp.diagnostic.set_loclist({open_loclist = false})
-- end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    aerial.on_attach(client)
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ae', '<cmd>AerialToggle!<CR>', {})
    -- Jump forwards/backwards with '[[' and ']]'
    vim.api.nvim_buf_set_keymap(0, 'n', '{', '<cmd>AerialPrevUp<CR>', {})
    vim.api.nvim_buf_set_keymap(0, 'n', '}', '<cmd>AerialNextUp<CR>', {})
    -- Jump up the tree with '{' or '}'
    vim.api.nvim_buf_set_keymap(0, 'n', '[[', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(0, 'n', ']]', '<cmd>AerialNext<CR>', {})


    local opts = { noremap=true, silent=true }

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', '<leader>dD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<leader>dd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>dj', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', "<leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap('n', '<leader>dr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    -- These ones covered by lspsaga:
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap('n', '<leader>da', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', '<leader>dn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- These ones I do not yet use in my workflow
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        signs = false,
        -- Enable virtual text only on Warning or above, override spacing to 2
        virtual_text = {
            spacing = 2,
            severity_limit = "Error",
        },
    }
)

require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
}

require'lspconfig'.cssls.setup{
  on_attach = on_attach,
}

require'lspconfig'.ccls.setup {
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


require'lspconfig'.zeta_note.setup{
  cmd = {'/home/jorres/.local/bin/zeta-note'},
  on_attach = on_attach,
  root_dir = require'lspconfig'.util.root_pattern(".git"),
  settings = {
      filetypes = { "md" }
  }
}

--[[ require'lspconfig'.yamlls.setup{
    on_attach = on_attach,
    settings = {
        yaml = {
            schemas = { kubernetes = "/*.yaml" },
        }
    }
} ]]

-- Looks like it does not support data definition model... sad
--[[ require'lspconfig'.sqlls.setup{
  on_attach = on_attach,
  cmd = {"sql-language-server", "up", "--method", "stdio"},
  settings = {
  }
} ]]

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = "/home/jorres/hobbies/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
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
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require'lspconfig'.terraformls.setup {}
