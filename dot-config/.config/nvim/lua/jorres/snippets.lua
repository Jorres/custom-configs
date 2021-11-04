local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local events = require("luasnip.util.events")

-- read help on luasnip-snippets

local tmp = s({trig="trigger"}, t("Wow! Text!"))

ls.snippets.all = { tmp }
