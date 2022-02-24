local config = require("nvim-peekup.config")

-- for some reason the default is 700ms. Weird!
config.on_keystroke["delay"] = ""
config.geometry["wrap"] = false

-- Think of ways to recolor the window?)
-- Make a PR to allow window options customization
-- Make a PR to allow recoloring) 
-- Good way to accumulate knowledge for your plugins

SETMAP("n", "<leader>r", ":lua require('nvim-peekup').peekup_open()<CR>", {silent = true})
