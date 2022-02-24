local config = require("nvim-peekup.config")

-- for some reason the default is 700ms. Weird!
config.on_keystroke["delay"] = "0ms"
config.geometry["wrap"] = false

-- Think of ways to recolor the window?)

SETMAP("n", "<leader>r", ":lua require('nvim-peekup').peekup_open()<CR>", {silent = true})
