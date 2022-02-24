local ls = require"luasnip"
local types = require("luasnip.util.types")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt

ls.config.set_config {
    -- Jump in and out of snippet
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}

SETMAP("i", "<c-f>", "<Esc>:lua require('jorres.snippets').check_jump_forward()<CR>li", {silent = true})

SETMAP("i", "<c-b>", "<Esc>:lua require('jorres.snippets').check_jump_backward()<CR>li", {silent = true})

SETMAP("i", "<c-s>", "<Esc>:lua require('jorres.snippets').check_choice_node()<CR>li", {silent = true})

-- read help on luasnip-snippets

ls.snippets = {
    all = {

    },

    python = {
        s({trig="pmn"}, t({"def main():", "    pass", "", "if __name__  == '__main__':", "    main()"})),
        s({trig="pf"}, fmt("def {}({}):\n    pass", {i(1, "fname"), i(0, "")}))
    }
}

local M = {}

M.check_jump_forward = function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end

M.check_jump_backward = function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end

M.check_choice_node = function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end

return M
