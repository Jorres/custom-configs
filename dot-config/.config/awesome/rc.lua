-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
local cairo = require("lgi").cairo
local delayed_call = require("gears.timer").delayed_call
local titlebar = require("actionless.titlebar")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local constants = require("constants")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")
beautiful.gap_single_client = true

-- This is used later as the default terminal and editor to run.
awful.util.shell = "zsh"

terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
  mymainmenu = freedesktop.menu.build({
    before = { menu_awesome },
    after = { menu_terminal }
  })
else
  mymainmenu = awful.menu({
    items = {
      menu_awesome,
      { "Debian", debian.menu.Debian_menu.Debian },
      menu_terminal,
    }
  })
end


mylauncher = awful.widget.launcher(
  {
    image = beautiful.awesome_icon,
    menu = mymainmenu
  }
)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher

-- Create a wibox for each screen and add it
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

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end))

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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
-- screen.padding = { top = 20, right = 20, bottom = 20, left = 20 }
--

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
  -- Create a taglist widget
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

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  s.mywibox = require("wibar").init_wibar(s)
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
  awful.button({}, 3, function() mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

beautiful.hotkeys_font = 'Sans 14'
beautiful.hotkeys_description_font = 'Sans 12'


local focus_or_else_spawn = function(client_class, client_command)
  for _, cur_client in pairs(client.get()) do
    if string.find(cur_client.class, client_class) then
      client.focus = cur_client
      cur_client:raise()
      return
    end
  end
  awful.util.spawn(client_command)
end

-- {{{ Key bindings
awful.keyboard.append_global_keybindings {
  -- awful.key({ modkey, }, "t", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end,
  --   { description = "show help", group = "awesome" }),
  awful.key({ modkey, }, "Left", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),
  awful.key({ modkey, }, "Right", awful.tag.viewnext,
    { description = "view next", group = "tag" }),
  awful.key({ modkey, }, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" }),

  awful.key({}, "XF86MonBrightnessDown", function()
    awful.util.spawn("xbacklight -dec 15")
  end, { description = "decrease brightness", group = "fn keys" }),
  awful.key({}, "XF86MonBrightnessUp", function()
    awful.util.spawn("xbacklight -inc 15")
  end, { description = "increase brightness", group = "fn keys" }),

  awful.key({ modkey }, "j", function() awful.client.focus.bydirection("down")
    if client.focus then client.focus:raise() end
  end, { description = "select window down", group = "navigation" }),
  awful.key({ modkey }, "k", function() awful.client.focus.bydirection("up")
    if client.focus then client.focus:raise() end
  end, { description = "select window up", group = "navigation" }),
  awful.key({ modkey }, "h", function() awful.client.focus.bydirection("left")
    if client.focus then client.focus:raise() end
  end, { description = "select window left", group = "navigation" }),
  awful.key({ modkey }, "l", function() awful.client.focus.bydirection("right")
    if client.focus then client.focus:raise() end
  end, { description = "select window right", group = "navigation" }),

  -- awful.key({ modkey, "Shift" }, "j", function() awful.client.relative_move(0, 20, 0, 0) end, { description = "move window down", group = "navigation" }),
  -- awful.key({ modkey, "Shift" }, "k", function() awful.client.relative_move(0, -20, 0, 0) end, { description = "move window up", group = "navigation" }),
  -- awful.key({ modkey, "Shift" }, "h", function() awful.client.relative_move(-20, 0, 0, 0) end, { description = "move window left", group = "navigation" }),
  -- awful.key({ modkey, "Shift" }, "l", function() awful.client.relative_move(20, 0, 0, 0) end, { description = "move window right", group = "navigation" }),

  awful.key({ modkey, }, "n",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),
  awful.key({ modkey, }, "p",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  ),
  -- awful.key({ modkey, }, "w", function() mymainmenu:show() end,
  --   { description = "show main menu", group = "awesome" }),

  -- Layout manipulation
  -- awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.(1) end,
  --   { description = "swap with next client by index", group = "client" }),
  -- awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
  --   { description = "swap with previous client by index", group = "client" }),
  --

  awful.key({ "Control", "Shift" }, "j", function()
    awful.client.focus.bydirection("down")
    if client.focus then
      client.focus:raise()
    end
    awful.client.swap.bydirection("up")
  end, {
    description = "swap with lower window",
    group = "navigation",
  }),
  awful.key({ "Control", "Shift" }, "k", function()
    awful.client.focus.bydirection("up")
    if client.focus then
      client.focus:raise()
    end
    awful.client.swap.bydirection("down")
  end, {
    description = "swap with upper window",
    group = "navigation",
  }),
  awful.key({ "Control", "Shift" }, "h", function()
    awful.client.focus.bydirection("left")
    if client.focus then
      client.focus:raise()
    end
    awful.client.swap.bydirection("right")
  end, {
    description = "swap with left window",
    group = "navigation",
  }),
  awful.key({ "Control", "Shift" }, "l", function()
    awful.client.focus.bydirection("right")
    if client.focus then
      client.focus:raise()
    end
    awful.client.swap.bydirection("left")
  end, {
    description = "swap with right window",
    group = "navigation",
  }),

  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),

  -- awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
  --   { description = "jump to urgent client", group = "client" }),
  -- awful.key({ modkey, }, "Tab",
  --   function()
  --     awful.client.focus.history.previous()
  --     if client.focus then
  --       client.focus:raise()
  --     end
  --   end,
  --   { description = "go back", group = "client" }),

  awful.key({ modkey, "Control" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),

  awful.key({ modkey, "Shift", }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "Move width separator right", group = "resizing" }),
  awful.key({ modkey, "Shift", }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "Move width separator left", group = "resizing" }),

  awful.key({ modkey, "Shift", }, "j", function() awful.client.incwfact(0.05) end,
    { description = "Increase window height", group = "resizing" }),
  awful.key({ modkey, "Shift", }, "k", function() awful.client.incwfact(-0.05) end,
    { description = "Decrease window hight", group = "resizing" }),

  -- awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
  --   { description = "increase the number of master clients", group = "layout" }),
  -- awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
  --   { description = "decrease the number of master clients", group = "layout" }),
  -- awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
  --   { description = "increase the number of columns", group = "layout" }),
  -- awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
  --   { description = "decrease the number of columns", group = "layout" }),
  -- awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
  --   { description = "select next", group = "layout" }),
  -- awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
  --   { description = "select previous", group = "layout" }),

  -- awful.key({ modkey, "Control" }, "n",
  --   function()
  --     local c = awful.client.restore()
  --     -- Focus restored client
  --     if c then
  --       c:emit_signal(
  --         "request::activate", "key.unminimize", { raise = true }
  --       )
  --     end
  --   end,
  --   { description = "restore minimized", group = "client" }),

  -- Prompt
  -- awful.key({ modkey }, "r", function()
  --   awful.screen.focused().mypromptbox:run() end,
  --   { description = "run prompt", group = "launcher" }),
  --
  -- awful.key({ modkey }, "r", function()
  --   awful.util.spawn("rofi -modi drun -show drun -show-icons -width 22 -no-click-to-exit", false)
  --   os.execute("sleep 4 && kill -9 $(ps aux | rg rofi | awk '{print $2} ' | head -n 1)")
  -- end, { description = "Runs rofi", group = "apps" }),

  awful.key({ modkey }, "r", function()
    awful.util.spawn("dmenu_run")
  end, { description = "Runs dmenu", group = "apps" }),

  awful.key({ modkey }, "1",
    function()
      focus_or_else_spawn("kitty", terminal)
    end,
    { description = "Run " .. terminal, group = "apps" }),


  awful.key({ modkey }, "2", function()
    focus_or_else_spawn("firefox", "firefox")
  end,
    { description = "Run Firefox", group = "apps" }),

  awful.key({ modkey }, "3", function()
    focus_or_else_spawn("TelegramDesktop", "telegram-desktop")
  end,
    { description = "Run Telegram", group = "apps" }),

  awful.key({ "Ctrl", "Shift" }, "\\", function()
    awful.spawn("flameshot gui")
  end, { description = "Spawn Flameshot", group = "apps" }),

  awful.key({ modkey, "Shift" }, "Down", function(c) c:relative_move(0, 20, 0, 0) end),
  awful.key({ modkey, "Shift" }, "Up", function(c) c:relative_move(0, -20, 0, 0) end),
  awful.key({ modkey, "Shift" }, "Left", function(c) c:relative_move(-20, 0, 0, 0) end),
  awful.key({ modkey, "Shift" }, "Right", function(c) c:relative_move(20, 0, 0, 0) end),

  awful.key({ modkey }, "x",
    function()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    { description = "lua execute prompt", group = "awesome" })
}

clientkeys = gears.table.join(
-- awful.key({ modkey, }, "f",
--   function(c)
--     c.fullscreen = not c.fullscreen
--     c:raise()
--   end,
--   { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, }, "q", function(c) c:kill() end,
    { description = "close", group = "client" }),
  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }),
  awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),
  awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
    { description = "move to next screen", group = "client" }),

  -- awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
  --   { description = "toggle keep on top", group = "client" }),
  -- awful.key({ modkey, }, "n",
  --   function(c)
  --     -- The client currently has the input focus, so it cannot be
  --     -- minimized, since minimized clients can't have the focus.
  --     c.minimized = true
  --   end,
  --   { description = "minimize", group = "client" }),
  awful.key({ modkey, }, "m",
    function(c)
      c.fullscreen = not c.fullscreen
      if c.fullscreen then

      else

      end
      c:raise()
    end,
    { description = "(un)maximize", group = "client" }),
  awful.key({ modkey, "Control" }, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(un)maximize vertically", group = "client" }),
  awful.key({ modkey, "Shift" }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 3 do
  awful.keyboard.append_global_keybindings {
    -- View tag only.
    -- awful.key({ modkey }, "#" .. i + 9,
    --   function()
    --     local screen = awful.screen.focused()
    --     local tag = screen.tags[i]
    --     if tag then
    --       tag:view_only()
    --     end
    --   end,
    --   { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  }
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = {},
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  -- The pesky zoom window that asks you for stuff
  {
    rule = {
      class = "zoom",
      name = "Choose ONE of the audio conference options",
    },
    properties = {
      floating = true,
      placement = awful.placement.centered
    }
  },

  -- Zoom chat window, also floating
  {
    rule = {
      class = "zoom",
      name = "Chat",
    },
    properties = {
      floating = true,
      placement = awful.placement.centered
    }
  },

  -- The small window that appears as a notification
  -- which source you use
  {
    rule = {
      class = "zoom",
      name = "zoom",
    },
    properties = {
      floating = true,
      ontop = true,
      placement = awful.placement.centered
    }
  },


  -- Bluetooth window
  {
    rule = {
      name = "Bluetooth Devices",
    },
    properties = {
      floating = true,
      ontop = true,
      placement = awful.placement.centered
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA", -- Firefox addon DownThemAll.
      "copyq", -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin", -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer"
    },

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester", -- xev.
    },
    role = {
      "AlarmWindow", -- Thunderbird's calendar.
      "ConfigManager", -- Thunderbird's about:config.
      "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true } },

  -- Add titlebars to normal clients and dialogs
  { rule_any = {
  }, properties = { titlebars_enabled = false }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}

client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}

screen.connect_signal("arrange", function(s)
  local clients = client.get()
  for _, c in ipairs(clients) do
    if #clients == 1 or c.maximized then
      c.border_width = 0
    else
      c.border_width = beautiful.border_width -- your border width
    end
  end
end)

local process_corners = function(c)
  if c.fullscreen then
    c.shape = function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, 0)
    end
  else
    c.shape = function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, 30)
    end
  end
end

local function choose_tag(c)
  if c.screen and c.screen.selected_tags then
    for _, sel_tag in ipairs(c.screen.selected_tags) do
      for _, cli_tag in ipairs(c:tags()) do
        if sel_tag.index == cli_tag.index then
          return cli_tag
        end
      end
    end
  end
  return c.first_tag
end

local function get_num_tiled(t)
  local s = t.screen
  if s.selected_tags and #s.selected_tags > 1 then
    return #s.tiled_clients
  end
  return 1 / 0 -- #tag_helpers.get_tiled(t)
end

local function _on_client_unfocus(c)
  if c.minimized then return end
  c.border_color = beautiful.border_normal
  local t = choose_tag(c)
  local layout = t.layout
  local num_tiled = get_num_tiled(t)
  if c.floating then
    -- clog("U: floating client", c)
    titlebar.make_titlebar(c, beautiful.actionless_titlebar_bg_normal, beautiful.titlebar_shadow_normal)
  elseif layout == awful.layout.suit.floating then
    -- clog(c, "U: floating layout", c)
    titlebar.make_titlebar(c, beautiful.actionless_titlebar_bg_normal, beautiful.titlebar_shadow_normal)
  elseif num_tiled > 1 then
    -- clog("U: multiple tiling clients", c)
    titlebar.make_border(c, beautiful.actionless_titlebar_bg_normal, beautiful.titlebar_shadow_normal)
  elseif num_tiled == 1 then
    if t.master_fill_policy == 'expand' and screen.count() == 1 then
      -- clog("U: one tiling client: expand", c)
      titlebar.remove_border(c)
    else
      -- clog("U: one tiling client", c)
      titlebar.make_border(c, beautiful.actionless_titlebar_bg_normal, beautiful.titlebar_shadow_normal)
    end
  else
    -- nlog('Signals: U: How did that happened?')
    -- nlog(num_tiled)
  end
end

local function on_client_unfocus(c, force, callback)
  local function unfocus_sequence()
    _on_client_unfocus(c)
    if callback then
      callback(c)
    end
  end

  if force then
    unfocus_sequence()
    return
  end
  delayed_call(function()
    if not c.valid or c == client.focus then
      return
    end
    -- Actually draw changes only if client is visible:
    if c.sticky then
      unfocus_sequence()
      return
    end
    for _, sel_tag in ipairs(c.screen.selected_tags) do
      for _, cli_tag in ipairs(c:tags()) do
        if sel_tag.index == cli_tag.index then
          unfocus_sequence()
        end
      end
    end
  end)
end

--=============================================================================
-- Focused (active, selected) window logic

local function on_client_focus(c)
  local t = choose_tag(c)
  local layout = t.layout
  local num_tiled = get_num_tiled(t)

  c.border_color = beautiful.border_focus
  --

  if c.maximized or c.fullscreen then
    clog("F: maximized")
    --set_default_screen_padding(s)
    titlebar.remove_border(c)
  elseif c.floating then
    -- clog("F: floating client")
    --choose_screen_padding(s, t, num_tiled)
    titlebar.make_titlebar(c, beautiful.actionless_titlebar_bg_focus, beautiful.titlebar_shadow_focus)
  elseif layout == awful.layout.suit.floating then
    -- clog("F: floating layout")
    --choose_screen_padding(s, t, num_tiled)
    titlebar.make_titlebar(c, beautiful.actionless_titlebar_bg_focus, beautiful.titlebar_shadow_focus)
  elseif num_tiled > 1 then
    -- clog("F: multiple tiling clients")
    --set_default_screen_padding(s)
    c.border_width = beautiful.border_width
    titlebar.make_border(c, beautiful.actionless_titlebar_bg_focus, beautiful.titlebar_shadow_focus)
  elseif num_tiled == 1 then
    if t.master_fill_policy == 'expand' and screen.count() == 1 then
      -- clog("F: one tiling client: expand")
      --set_default_screen_padding(s)
      titlebar.remove_border(c)
    else
      -- clog("F: one tiling client")
      --set_mwfact_screen_padding(t)
      c.border_width = beautiful.border_width
      titlebar.make_border(c, beautiful.actionless_titlebar_bg_focus, beautiful.titlebar_shadow_focus)
    end
  else
    -- clog("F: zero tiling clients -- other tag?")
    return on_client_unfocus(c)
  end

  --c.border_color = beautiful.border_focus
end

local function apply_shape(draw, shape, outer_shape_args, inner_shape_args)

  local geo = draw:geometry()

  local border = beautiful.base_border_width
  local titlebar_height = border
  --local titlebar_height = titlebar.is_enabled(draw) and beautiful.titlebar_height or border

  local img = cairo.ImageSurface(cairo.Format.A1, geo.width, geo.height)
  local cr = cairo.Context(img)

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0, 0, 0, 1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1, 1, 1, 1)

  shape(cr, geo.width, geo.height, outer_shape_args)
  cr:fill()
  draw.shape_bounding = img._native

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0, 0, 0, 1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1, 1, 1, 1)

  gears.shape.transform(shape):translate(
    border, titlebar_height
  )(
    cr,
    geo.width - border * 2,
    geo.height - titlebar_height - border,
    inner_shape_args
  )
  cr:fill()
  draw.shape_clip = img._native

  img:finish()
end

beautiful.client_border_radius = 30

local pending_shapes = {}
local function round_up_client_corners(c, force, reference)
  -- if not force and ((
  --     -- @TODO: figure it out and uncomment
  --     not beautiful.client_border_radius or beautiful.client_border_radius == 0
  --     ) or (
  --     not c.valid
  --     ) or (
  --     c.fullscreen
  --     ) or (
  --     pending_shapes[c]
  --     ) or (
  --     #c:tags() < 1
  --     )) or beautiful.skip_rounding_for_crazy_borders then
  --   --clog('R1 F='..(force or 'nil').. ', R='..(reference or '')..', C='.. (c and c.name or '<no name>'), c)
  --   return
  -- end
  --clog({"Geometry", c:tags()}, c)
  pending_shapes[c] = true
  delayed_call(function()
    local client_tag = choose_tag(c)
    if not client_tag then
      -- nlog('no client tag')
      return
    end
    local num_tiled = get_num_tiled(client_tag)
    --clog({"Shape", num_tiled, client_tag.master_fill_policy, c.name}, c)
    --if not force and (c.maximized or (
    if (
        c.maximized or c.fullscreen
            or (
            (num_tiled <= 1 and client_tag.master_fill_policy == 'expand')
                and not c.floating
                and client_tag.layout.name ~= "floating"
            )) then
      pending_shapes[c] = nil
      --nlog('R2 F='..(force and force or 'nil').. ', R='..reference..', C='.. c.name)
      return
    end
    -- Draw outer shape only if floating layout or useless gaps
    local outer_shape_args = 0
    if client_tag.layout.name == "floating" or client_tag:get_gap() ~= 0 then
      outer_shape_args = beautiful.client_border_radius
    end
    local inner_shape_args = beautiful.client_border_radius * 0.75
    --local inner_shape_args = beautiful.client_border_radius - beautiful.base_border_width
    --if inner_shape_args < 0 then inner_shape_args = 0 end
    apply_shape(c, gears.shape.rounded_rect, outer_shape_args, inner_shape_args)
    --clog("apply_shape "..(reference or 'no_ref'), c)
    pending_shapes[c] = nil
    --nlog('OK F='..(force and "true" or 'nil').. ', R='..reference..', C='.. c.name)
  end)
end

-- client.connect_signal("manage", function(c)
--   process_corners(c)
-- end)

client.connect_signal("manage", function(c)
  local awesome_startup = awesome.startup
  c.minimized = false
  delayed_call(function()
    if c == client.focus then
      on_client_focus(c)
      if awesome_startup then
        round_up_client_corners(c, false, "MF")
      end
    else
      on_client_unfocus(c, true, function(_c)
        if awesome_startup then
          round_up_client_corners(_c, false, "MU")
        end
      end)
    end
  end)
end)

client.connect_signal("property::size", function(c)
  if not awesome.startup then
    round_up_client_corners(c, false, "S")
  end
end)

-- client.connect_signal("property::size", function(c)
--   process_corners(c)
-- end)

-- Auto start applications
awful.spawn('picom -b --transparent-clipping')
-- Enable russian + english layout and specify what shortcut will swap them
os.execute("setxkbmap -layout us,ru -option 'grp:win_space_toggle'")
-- Set keyboard key repeat delay (ms) and repeat rate
os.execute("xset r rate 150 30")

-- This sets primary monitor, resolution... basically everything that Gnome Displays did
os.execute("xrandr --output eDP1 --mode 1920x1080 --pos 2560x360 --rotate normal --output DP1 --off --output DP2 --off --output HDMI1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI2 --off --output VIRTUAL1 --off")

awful.spawn.with_shell('nm-applet')
awful.spawn('copyq')
awful.spawn('blueman-applet')

-- toggle fullscreen (super + f)
-- move\resize windows with mouse (super + left|right hold + drag, for moving|resizing)
-- super + j\k move through all the windows
-- windows can be present at many tags at once! this is fun
-- you can open separate tags on each display, 9*9 combinations
