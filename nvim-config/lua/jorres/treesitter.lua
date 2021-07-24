require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { },  -- list of language that will be disabled
    },
    indent = {
        enable = true,
    },
    incremental_selection = { 
        enable = true,
        keymaps = {
            init_selection = "znn",
            node_incremental = "zrn",
            scope_incremental = "zrc",
            node_decremental = "zrm",
        },
    },
    textobjects = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 2000, -- Do not enable for files with more than 1000 lines, int
    },
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr   = "nvim_treesitter#foldexpr()
