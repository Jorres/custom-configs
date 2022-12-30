local bling = require("bling")
local awful = require("awful")

local rubato = require("rubato")

local anim_y = rubato.timed {
  pos = awful.screen.focused().geometry.height + 100,
  rate = 120,
  easing = rubato.quadratic,
  intro = 0.1,
  duration = 0.27,
  awestore_compat = true
}

local anim_x = rubato.timed {
  pos = (awful.screen.focused().geometry.width / 2) - 350,
  rate = 120,
  easing = rubato.quadratic,
  intro = 0.1,
  duration = 0.27,
  awestore_compat = true
}

local args = {
  terminal = "kitty",
  favorites = {
    "firefox", "kitty"
  },
  hide_on_left_clicked_outside = true,
  hide_on_right_clicked_outside = true,
  hide_on_launch = true,
  rubato = { x = anim_x, y = anim_y },
  background = "#222222",

  prompt_color = "#BBBBBB",
  prompt_show_icon = false,
  prompt_font = "Play 14",

  app_normal_color = "#333333",
  app_normal_hover_color = "#555555",

  app_width = 200,
}

local app_launcher = bling.widget.app_launcher(args)

local M = {}

M.toggle = function()
  app_launcher:toggle()
end

return M
