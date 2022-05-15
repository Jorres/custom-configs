require("settings.autocmds")

require("settings.options")

-- `mappings` should be after `options`, depends on <leader>
require("settings.mappings")

require("settings.reload")

-- safe to place last
require("settings.theme")
