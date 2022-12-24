local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

M.init_wibar = function(s)
  local batteryarc_widget      = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
  local volume_widget          = require('awesome-wm-widgets.volume-widget.volume')
  local keyboard_layout_widget = awful.widget.keyboardlayout()
  local text_clock_widget      = wibox.widget.textclock()

  local wibar = awful.wibar({
    screen = s,
    fg = beautiful.fg_normal,
    height = 60,
    width = 1100,
    bg = beautiful.bg_normal,
    -- stretch = false,
    position = "bottom",
    border_color = "#00000000",
    border_width = dpi(15),
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 40)
    end,
  })

  wibar:setup {
    layout = wibox.layout.flex.horizontal,
    {
      {
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = 20,
          s.mytaglist,
          keyboard_layout_widget,
          wibox.widget.systray(),
          text_clock_widget,
          s.mylayoutbox,
          volume_widget {
            size = 30,
            arc_thickness = 2,
            widget_type = "arc",
          },
          batteryarc_widget({
            size = 30,
            font = "Play 10",
            show_current_level = true,
            arc_thickness = 2,
          }),
        },
        widget = wibox.container.margin,
        margins = dpi(10),
      },
      widget = wibox.container.place,
      haligh = "center",
      valign = "center",
    },
  }

  return wibar
end

return M
