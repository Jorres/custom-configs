local opts = {noremap = true, silent = true}

SETMAP("n", "<leader>bl", ":Gitsigns toggle_current_line_blame<CR>", opts)
SETMAP("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
SETMAP("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
SETMAP("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", opts)
SETMAP("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", opts)
SETMAP("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
SETMAP("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
SETMAP("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", opts)
SETMAP("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", opts)

require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`

    numhl      = false,  -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
}
