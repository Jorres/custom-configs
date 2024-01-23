local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
dashboard.section.header.val = {
  -- [[                                             ]],
  -- [[  ____    ____    ____  ___  __|__|  _____   ]],
  -- [[ /    \ _/ __ \  /  _ \ \  \/ /|  | /     \  ]],
  -- [[|   |  \\  ___/ (  <_> ) \   / |  ||  Y Y  \ ]],
  -- [[|___|  / \___  > \____/   \_/  |__||__|_|  / ]],
  -- [[     \/      \/                          \/  ]],
  --
  [[  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
  [[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
  [[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
  [[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ]],
  [[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ]],
  [[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
  [[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ]],
  [[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ]],
  [[          ░    ░  ░    ░ ░        ░   ░         ░    ]],
  [[                                 ░                   ]]
  -- [[      ___  __              ]],
  -- [[|\ | |__  /  \ \  / |  |\/|]],
  -- [[| \| |___ \__/  \/  |  |  |]],

}
dashboard.section.buttons.val = {
  dashboard.button("1", "  new file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("2", "  quit NVIM", ":qa<CR>"),
  dashboard.button("3", "  search helptags", ":Telescope help_tags<CR>"),
}

dashboard.config.opts.noautocmd = true

alpha.setup(dashboard.config)
