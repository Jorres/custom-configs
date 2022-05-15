local ls = require "luasnip"
local types = require("luasnip.util.types")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local rep = require "luasnip.extras".rep

local fmt = require("luasnip.extras.fmt").fmt

ls.config.set_config {
  -- Jump in and out of snippet
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

-- read help on luasnip-snippets

ls.add_snippets(nil, {
  all = {

  },

  python = {
    s({ trig = "pmn" }, t({ "def main():", "    pass", "", "if __name__  == '__main__':", "    main()" })),
    s({ trig = "pf" }, fmt("def {}({}):\n    pass", { i(1, "fname"), i(0, "") }))
  },

  typescript = {
    s({ trig = "ecl" }, {
      t("export class "), i(1, "className"), t({ " {", "" }),
      t("    "), i(2),
      t({ "", "}" }), i(0)
    }),
    s({ trig = "tf" }, {
      t("const "), i(1, "functionName"), t(" = ("), i(2), t(") => {"),
      t("    "), i(3),
      t({ "", "}" }), i(0)
    })
  },

  dockerfile = {
    -- s({trig="dockerfile"}, {
    --     t({"FROM "}), i(1, "IMAGE_NAME"), t(":"), i(2, "TAG"),
    --     t({"", "WORKDIR "}), i(4, "/usr/app"),
    --     t({"", "COPY . ."}),
    --     t({"", "RUN echo 'just some shell command'"}),
    --     t({"", "CMD, ['command', 'arg1', 'arg2']"}),
    --     t({"", "EXPOSE "}), i(5, "8000"),
    --     i(0)
    -- }),

    s({ trig = "dockerfile-multistage" }, {
      t({ "FROM " }), i(1, "IMAGE_NAME"), t(":"), i(2, "TAG"), t(" as "), i(3, "PHASE_NAME"),
      t({ "", "WORKDIR " }), i(4, "/usr/app"),
      t({ "", "COPY . ." }),
      t({ "", "FROM " }), i(5, "IMAGE_NAME"), t(":"), i(6, "TAG"), t(" as "), i(7, "PHASE_NAME_2"),
      t({ "", "WORKDIR " }), rep(4),
      t({ "", "COPY --from=" }), rep(3), t({ " " }), rep(4), t({ " " }), i(8, { "/usr/app" }),
      t({ "", "RUN echo 'just some shell command'" }),
      t({ "", "CMD command arg1 arg2" }),
      t({ "", "EXPOSE " }), i(9, "8000"),
      i(0)
    })
  }
})

local check_jump_forward = function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end

local check_jump_backward = function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end

local check_choice_node = function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end

vim.keymap.set({ "i", "s" }, "<c-f>", check_jump_forward, { silent = true })
vim.keymap.set({ "i", "s" }, "<c-b>", check_jump_backward, { silent = true })
vim.keymap.set({ "i", "s" }, "<c-s>", check_choice_node, { silent = true })
