vim.opt.completeopt = { "menu", "menuone", "noselect" }

local lspkind = require"lspkind"
lspkind.init()

local cmp = require"cmp"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

cmp.setup {
  mapping = {
    -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-e>"] = cmp.mapping.close(),

    --[[ ["<c-q>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<c-q>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    ["<c-space>"] = cmp.mapping.complete(), ]]

    -- If you want tab completion :'(
    --  First you have to just promise to read `:help ins-completion`.
    ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif cmp.visible() then
            cmp.select_next_item()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end, { "i", "s" }),
},

  sources = {
    { name = "luasnip", max_item_count = 2 },
    { name = "nvim_lua", max_item_count = 5 },
    { name = "nvim_lsp" },
    { name = "path", max_item_count = 3 },
    { name = "buffer", max_item_count = 2, keyword_length = 5 },
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
