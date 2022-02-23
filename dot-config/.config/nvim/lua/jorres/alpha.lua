
local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'
dashboard.section.header.val = {
    -- [[                                             ]],
    -- [[  ____    ____    ____  ___  __|__|  _____   ]],
    -- [[ /    \ _/ __ \  /  _ \ \  \/ /|  | /     \  ]],
    -- [[|   |  \\  ___/ (  <_> ) \   / |  ||  Y Y  \ ]],
    -- [[|___|  / \___  > \____/   \_/  |__||__|_|  / ]],
    -- [[     \/      \/                          \/  ]],
    --
    -- [[  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
    -- [[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
    -- [[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
    -- [[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ]],
    -- [[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ]],
    -- [[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
    -- [[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ]],
    -- [[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ]],
    -- [[          ░    ░  ░    ░ ░        ░   ░         ░    ]],
    -- [[                                 ░                   ]]
    [[      ___  __              ]],
    [[|\ | |__  /  \ \  / |  |\/|]],
    [[| \| |___ \__/  \/  |  |  |]],

}
dashboard.section.buttons.val = {
    dashboard.button( "en", "  new file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "q", "  quit NVIM" , ":qa<CR>"),
    dashboard.button( "ec", "  search configs", ":lua require('jorres.telescope').search_dotfiles()<CR>"),
    dashboard.button( "eh", "  search helptags", ":Telescope help_tags<CR>"),
    dashboard.button( "m", "  launch Magma", ":ene <BAR>:MagmaInit python3<CR>"),
}
local handle = io.popen('fortune')
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune

dashboard.config.opts.noautocmd = true

vim.cmd[[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)
