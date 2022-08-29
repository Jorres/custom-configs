local lspkind = require "lspkind"
lspkind.init()

local cmp = require "cmp"

local luasnip = require("luasnip")

cmp.setup {
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = {
    ["<c-y>"] = cmp.mapping.confirm {
      select = true,
    },
    -- I use moonlander keyboard, okay? I have my arrow keys where I want them
    -- and they are super easy to reach. Regular keyboards users will
    -- suffer. But <C-n> and <C-p> are also defined
    -- for selecting options of the completion menu. Use them as well!
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),

    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
  },

  sources = {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua", max_item_count = 5, filetype = "lua" },
    { name = "luasnip", max_item_count = 2 },
    { name = "nvim_lsp", max_item_count = 5 },
    {
      name = 'tmux',
      option = {
        all_panes = true,
        label = '[tmux]',
        trigger_characters = { '.' },
        trigger_characters_ft = {} -- { filetype = { '.' } }
      },
      max_item_count = 3,
      keyword_length = 3,
    },
    { name = "path", max_item_count = 3 },
    { name = "buffer", max_item_count = 2, keyword_length = 4 },
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        tmux = "[tmux]",
        nvim_lsp_signature_help = "[sign]",
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      },
    },
  },

  experimental = {
    native_menu = false,
    -- I've found it to be too annoying
    ghost_text = false,
  },
}

cmp.setup.filetype({ 'markdown', 'telekasten' }, {
  enabled = false,
  mapping = {
    ["<c-y>"] = cmp.mapping.confirm {
      select = true,
    },
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
  },
  sources = {
    { name = "path", max_item_count = 3 },
    { name = "buffer", max_item_count = 2, keyword_length = 4 },
  },
  experimental = {
    native_menu = false,
    ghost_text = false,
  },
})
