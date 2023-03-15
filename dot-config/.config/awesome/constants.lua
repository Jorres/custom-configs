local awful = require("awful")
local gears = require("gears")


local M = {}

M.wibar_position = "right" -- "bottom"
-- BOTTOM IS UNTESTED. MIGHT HAVE SOME VISUAL BUGS

M.wibar_border_width = 15
M.wibar_additional_subwin_padding = 0

if M.wibar_position == "right" then
  M.wibar_width = 70
  M.wibar_height = 900

  M.wibar_subwin_width  = M.wibar_width + 2 * M.wibar_border_width
  M.wibar_subwin_height = M.wibar_height + 2 * M.wibar_border_width + M.wibar_additional_subwin_padding * 2

  M.wibar_subwin_placement = awful.placement.right

  M.wibar_subwin_x = function(s, wibar)
    return wibar.x
    -- local wibar_width = M.wibar_width
    -- if wibar ~= nil then
    --   wibar_width = wibar.width
    -- end
    -- return s.geometry.width - wibar_width - 2 * M.wibar_border_width
  end
  M.wibar_subwin_y = function(s, wibar)
    return wibar.y
    -- local wibar_height = M.wibar_height
    -- if wibar ~= nil then
    --   wibar_height = wibar.height
    -- end
    -- return s.geometry.height - wibar_height - ((s.geometry.height - wibar_height) / 2) - M.wibar_additional_subwin_padding
  end
  M.wibar_subwin_shape = function(cr, w, h)
    gears.shape.partially_rounded_rect(cr, w, h, true, false, false, true, 30)
  end
else
  M.wibar_width = 1100
  M.wibar_height = 60

  M.wibar_subwin_width  = M.wibar_width + 2 * M.wibar_border_width + M.wibar_additional_subwin_padding * 2
  M.wibar_subwin_height = M.wibar_height + 2 * M.wibar_border_width

  M.wibar_subwin_placement = awful.placement.bottom

  M.wibar_subwin_x = function(s)
    return s.geometry.width - M.wibar_width - ((s.geometry.width - M.wibar_width) / 2) - M.wibar_additional_subwin_padding
  end
  M.wibar_subwin_y = function(s)
    return s.geometry.height - (M.wibar_height + M.wibar_border_width * 2)
  end
  M.wibar_subwin_shape = function(cr, w, h)
    gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 50)
  end
end

return M
