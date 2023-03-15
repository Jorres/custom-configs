local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local C = require("constants")
local rubato = require("rubato")
local debug = require("jorres.debug")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local M = {}

local wibar_is_resizing = false

M.init_wibar = function(s, keyboard_widget)
  local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
  local volume_widget     = require('awesome-wm-widgets.volume-widget.volume')

  -- Had to separate into different widgets to have separate alignment
  --                                     xxx
  -- (month takes 3 chars where hour 2): xx
  local text_clock_widget  = wibox.widget.textclock()
  text_clock_widget.format = "%H\n%M"
  local month_widget       = wibox.widget.textclock()
  month_widget.format      = "%b"
  local day_widget         = wibox.widget.textclock()
  day_widget.format        = "%d"

  local wibar_subwin = awful.popup {
    ontop          = true,
    placement      = C.wibar_subwin_placement,
    minimum_width  = C.wibar_subwin_width,
    minimum_height = C.wibar_subwin_height + 200,
    opacity        = 0.01,
    screen         = s,
    widget         = {},
    shape          = C.wibar_subwin_shape,
    visible        = true,
  }

  local wibar = awful.wibar({
    ontop = true,
    screen = s,
    fg = beautiful.fg_normal,
    height = C.wibar_height + 200,
    width = C.wibar_width,
    bg = beautiful.bg_normal,
    position = C.wibar_position,
    border_color = "#00000000",
    border_width = C.wibar_border_width,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 40)
    end,
  })


  local systray = wibox.widget.systray()
  systray:set_horizontal(false)
  s.systray = systray
  systray.visible = true

  wibar_subwin.x = C.wibar_subwin_x(s, wibar)
  wibar_subwin.y = C.wibar_subwin_y(s, wibar)

  local my_volume_widget = volume_widget {
    size = 40,
    arc_thickness = 3,
    widget_type = "arc",
  }

  wibar:setup {
    layout = wibox.layout.flex.vertical,
    {
      {
        {
          layout = wibox.layout.fixed.vertical,
          spacing = 45,
          s.mytaglist,
          {
            {
              month_widget,
              widget = wibox.container.place,
              haligh = "center",
              valign = "center",
            },
            {
              day_widget,
              widget = wibox.container.place,
              haligh = "center",
              valign = "center",
            },
            {
              wibox.widget {
                markup = '--',
                widget = wibox.widget.textbox
              },
              widget = wibox.container.place,
              haligh = "center",
              valign = "center",
            },
            {
              text_clock_widget,
              widget = wibox.container.place,
              haligh = "center",
              valign = "center",
            },
            widget = wibox.container.place,
            layout = wibox.layout.fixed.vertical,
            haligh = "center",
            valign = "center",
          },
          {
            keyboard_widget,
            widget = wibox.container.place,
            haligh = "center",
            valign = "center",
          },
          systray,
          {
            {
              s.mylayoutbox,
              widget = wibox.container.background,
              forced_height = 40,
            },
            widget = wibox.container.place,
            haligh = "center",
            valign = "center",
          },
          my_volume_widget,
          batteryarc_widget({
            size = 40,
            font = "Play 10",
            show_current_level = true,
            arc_thickness = 3,
          }),
        },
        widget = wibox.container.margin,
        margins = dpi(10),
      },
      widget = wibox.container.place,
      valign = "center",
    },
  }

  local systray_visible_hack = true

  awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "t", function()
      if wibar_is_resizing then
        return
      end
      wibar_is_resizing = true
      -- TODO: this is a hack, find a better way, the line below just does not work
      -- systray.visible = not systray.visible
      local intro = 0.15
      local duration = 0.3
      local timed
      if systray_visible_hack == true then
        timed = rubato.timed {
          intro = intro,
          rate = 60,
          duration = duration,
          subscribed = function(pos)
            wibar.height = C.wibar_height + math.floor(200 * (1 - pos))
          end
        }
        systray.visible = false
        gears.timer {
          timeout = duration, autostart = true, single_shot = true,
          callback = function()
            wibar_is_resizing = false
          end
        }
      else
        timed = rubato.timed {
          intro = intro,
          rate = 60,
          duration = duration,
          subscribed = function(pos)
            wibar.height = C.wibar_height + math.floor(200 * pos)
          end
        }
        gears.timer {
          timeout = duration, autostart = true, single_shot = true,
          callback = function()
            systray.visible = true
            wibar_is_resizing = false
          end
        }
      end
      systray_visible_hack = not systray_visible_hack
      timed.target = 1
    end, { description = "Toggle systray visibility", group = "custom" }),
    awful.key({}, "XF86AudioRaiseVolume",
      function()
        volume_widget:inc(5)
      end, { description = "volume up", group = "fn keys" }),
    awful.key({}, "XF86AudioLowerVolume",
      function()
        volume_widget:dec(5)
      end, { description = "volume down", group = "fn keys" }),
    awful.key({}, "XF86AudioMute",
      function()
        volume_widget:toggle()
      end, { description = "toggle mute", group = "fn keys" })
  })

  return wibar
end

return M
