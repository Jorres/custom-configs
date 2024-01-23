local Color, colors, Group, groups, styles = require('colorbuddy').setup()

-- Use Color.new(<name>, <#rrggbb>) to create new colors
-- They can be accessed through colors.<name>

Color.new("myclr1", "#252525")
Color.new("myclr2", "#303030")
Color.new("myclr3", "#C6393D")
Color.new("myclr4", "#FFFFFF")
Color.new("myclr5", "#393DC6")
Color.new("myclr6", "#3DC639")
Color.new("myclr7", "#404040")
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


-- Telekasten links and tags
-- Color.new("telelink", "#689d6a")
-- Group.new("tkLink", colors.telelink, nil, styles.bold + styles.underline)
-- Group.new("tkBrackets", colors.gray, nil, nil)

-- Color.new("teletag", "#d3869B")
-- Group.new("tkTagSep", colors.gray, nil, nil)
-- Group.new("tkTag", colors.teletag, nil)

vim.cmd [[ highlight EndOfBuffer guifg=bg ]]
