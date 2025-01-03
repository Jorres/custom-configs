local lspkind = require "lspkind"
lspkind.init()

local cmp = require "cmp"

cmp.setup {
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = {
    ["<c-y>"] = function(fallback)
      if cmp.visible() then
        cmp.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior
        })
      else
        fallback()
      end
    end,

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
    --     nvim_lsp = "[LSP]",
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua",               max_item_count = 5, filetype = "lua" },
    { name = "nvim_lsp",               keyword_length = 2, },
    -- {
    --   name = 'tmux',
    --   option = {
    --     all_panes = true,
    --     label = '[tmux]',
    --     trigger_characters = { '.' },
    --     trigger_characters_ft = {} -- { filetype = { '.' } }
    --   },
    --   max_item_count = 3,
    --   keyword_length = 3,
    -- },
    { name = "path",                   max_item_count = 3 },
    { name = "buffer",                 max_item_count = 2, keyword_length = 4 },
  },

  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol',
      maxwidth = 50,
      symbol_map = {
      },
      --   menu = {
      --     -- tmux = "[tmux]",
      --     nvim_lsp_signature_help = "[sign]",
      --     buffer = "[buf]",
      --     nvim_lua = "[api]",
      --     path = "[path]",
      --   },
    },
  },

  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  experimental = {
    native_menu = false,
    ghost_text = false,
  },
}

cmp.setup.filetype({ 'markdown' }, {
  enabled = false,
  mapping = {
    ["<c-y>"] = cmp.mapping.confirm {
      select = true,
    },
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
  },
  sources = {
    { name = "path",   max_item_count = 3 },
    { name = "buffer", max_item_count = 2, keyword_length = 4 },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})
