local actions = require('distant.nav.actions')

local inner_mdinc_gitlab_ip = "10.2.0.30"
local mdinc_vpn_car = "178.154.202.6"
local mdinc_default_user = "mdinc-dev"

require('distant').setup {
    -- Apply these settings to the specific host
    [inner_mdinc_gitlab_ip] = {
        max_timeout = 100000,
        launch = {
            -- Specify a specific location for the distant binary on the remote machine
            distant = '/home/'..mdinc_default_user..'/distant',
            identity_file = '/home/jorres/.ssh/gitlab-hoster',
            username = mdinc_default_user,
        },

        lsp = {
            -- Specify an LSP to run for a specific project
            ['My Project'] = {
                cmd = '/path/to/rust-analyzer',
                root_dir = '/path/to/project/root',

                -- Do your on_attach with keybindings like you would with
                -- nvim-lspconfig
                on_attach = function() 
                    -- Apply some general bindings for every buffer supporting lsp
                end,
            },
        },
    },
    [mdinc_vpn_car] = {
        max_timeout = 100000,
        launch = {
            -- Specify a specific location for the distant binary on the remote machine
            distant = '/home/'..mdinc_default_user..'/distant',
            identity_file = '/home/jorres/.ssh/vpn-gateway',
            username = mdinc_default_user,
        },
    },

    -- Apply these settings to any remote host
    ['*'] = {
        -- Apply these launch settings to all hosts
        launch = {
            -- Apply additional CLI options to the listening server, such as
            -- shutting down when there is no connection to it after 30 seconds
            extra_server_args = '"--shutdown-after 30"',
        },

        -- Specify mappings to apply on remote file buffers
        -- Presently, the only one you would want is some way to trigger
        -- file navigation
        file = {
            mappings = {
                ['-']         = actions.up,
            },
        },

        -- Specify mappings to apply on remote directory buffers
        dir = {
            mappings = {
                ['<Return>']  = actions.edit,
                ['-']         = actions.up,
                ['K']         = actions.mkdir,
                ['N']         = actions.newfile,
                ['R']         = actions.rename,
                ['D']         = actions.remove,
            }
        },
    }
}
