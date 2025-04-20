local colorbuddy = require('colorbuddy')

colorbuddy.setup()

local Color = colorbuddy.Color
local colors = colorbuddy.colors
local Group = colorbuddy.Group

-- Use Color.new(<name>, <#rrggbb>) to create new colors
-- They can be accessed through colors.<name>

Color.new("myclr1", "#252525")
Color.new("myclr2", "#303030")
Color.new("myclr3", "#C6393D")
Color.new("myclr4", "#FFFFFF")
Color.new("myclr5", "#393DC6")
Color.new("myclr6", "#3DC639")
Color.new("myclr7", "#404040")
Color.new("completion", "#1e1c2a")
Color.new("completion_selection", "#2f2b43")

Color.new("icon1", "#393dc6")
Color.new("icon2", "#c63983")
Color.new("icon3", "#c6c239")
Color.new("icon4", "#39c67c")

Color.new("pinkBorder", "#E56399")

Group.new("TelescopeBorder", colors.myclr1, colors.myclr1, nil)
Group.new("TelescopeNormal", nil, colors.myclr1, nil)
Group.new("TelescopePromptTitle", colors.myclr1, colors.myclr3, nil)
Group.new("TelescopePromptBorder", colors.myclr2, colors.myclr2, nil)
Group.new("TelescopePromptNormal", colors.myclr4, colors.myclr2, nil)
Group.new("TelescopePromptPrefix", colors.myclr3, colors.myclr2, nil)
Group.new("TelescopePreviewTitle", colors.myclr1, colors.myclr5, nil)
Group.new("TelescopeResultsTitle", colors.myclr1, colors.myclr6, nil)
Group.new("TelescopeSelection", nil, colors.myclr7, nil)

Group.new("VibrantFloatBorder", colors.pinkBorder, nil, nil)
Group.new("Directory", colors.pinkBorder, nil, nil)
Group.new("NvimTreeFolderName", colors.pinkBorder, nil, nil)

Group.new("Pmenu", nil, colors.completion, nil)
Group.new("PmenuSel", nil, colors.completion_selection, nil)

Group.new("BlinkCmpKindFunction", colors.icon1, nil, nil)
Group.new("BlinkCmpKindText", colors.icon2, nil, nil)
Group.new("BlinkCmpKindModule", colors.icon3, nil, nil)
Group.new("BlinkCmpKindConstant", colors.icon4, nil, nil)
Group.new("BlinkCmpKindVariable", colors.icon1, nil, nil)
Group.new("BlinkCmpKindInterface", colors.icon2, nil, nil)
Group.new("BlinkCmpKindMethod", colors.icon3, nil, nil)
Group.new("BlinkCmpKindKeyword", colors.icon4, nil, nil)
Group.new("BlinkCmpKindClass", colors.icon1, nil, nil)

Group.new("NormalFloat", nil, colors.completion, nil)
Group.new("NormalFloat", nil, colors.completion, nil)
Group.new("FloatBorder", nil, colors.completion, nil)


vim.cmd [[ highlight EndOfBuffer guifg=bg ]]
