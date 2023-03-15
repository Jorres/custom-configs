local delayed_call = require("gears.timer").delayed_call
local awful = require("awful")
local debug = require("jorres.debug")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local display = {}

display.init_monitor_set = function()
  os.execute([[
# that means WHEN NOT CONNECTED, sorry for bad code
if [ -z `xrandr --query | grep "HDMI1 connected"` ]
then
  xrandr --output eDP1 --mode 1920x1080 --pos 0x0 --rotate normal \
         --output HDMI1 --off \ 
         --output DP1 --off \
         --output DP2 --off \
         --output HDMI2 --off \
         --output VIRTUAL1 --off
else
  xrandr --output eDP1 --mode 1920x1080 --pos 2560x360 --rotate normal \
         --output HDMI1 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
         --output DP1 --off \
         --output DP2 --off \
         --output HDMI2 --off \
         --output VIRTUAL1 --off
fi
]] )

-- xrandr --output eDP1 --mode 1920x1080 --pos 2560x360 --rotate normal \
--        --output HDMI1 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
--        --output DP1 --off \
--        --output DP2 --off \
--        --output HDMI2 --off \
--        --output VIRTUAL1 --off

  local main_screen = awful.screen.getbycoord(20, 20)
  delayed_call(function()
    for _, c in pairs(client.get()) do
      if c.name ~= "Awesome drawin" then
        c:move_to_screen(screen[main_screen])
        c.hidden = false
        c.minimized = false
        c.fullscreen = false
        awful.placement.no_offscreen(c)
        c:raise()
      end
    end
  end)
end

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

display.init_display_handlers = function(keyboard_widget)
  screen.connect_signal("property::geometry", set_wallpaper)

  awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])

    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
      awful.button({}, 1, function() awful.layout.inc(1) end),
      awful.button({}, 3, function() awful.layout.inc(-1) end),
      awful.button({}, 4, function() awful.layout.inc(1) end),
      awful.button({}, 5, function() awful.layout.inc(-1) end)))

    s.mytaglist = awful.widget.taglist {
      screen          = s,
      filter          = awful.widget.taglist.filter.all,
      buttons         = taglist_buttons,
      layout          = {
        layout = wibox.layout.fixed.vertical
      },
      widget_template = {
        {
          {
            {
              widget = wibox.widget.imagebox,
            },
            bg            = '#cccccc',
            shape         = gears.shape.circle,
            forced_height = 60,
            widget        = wibox.container.background,
          },
          left   = 14,
          right  = 14,
          widget = wibox.container.margin,
        },
        id     = 'background_role',
        widget = wibox.container.background,
      }
    }

    s.mywibox = require("wibar").init_wibar(s, keyboard_widget)
  end)
end

return display
