local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--max-filesize=1M'
        },
        prompt_prefix = "  ",
        selection_caret = "   ",
        entry_prefix = "   ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
           horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
           },
           vertical = {
              mirror = false,
           },
           width = 0.90,
           height = 0.80,
           preview_cutoff = 1,
        },
        file_sorter =  require'telescope.sorters'.get_fzy_sorter,
        file_ignore_patterns = {"node_modules"},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        path_display = {"truncate"},
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        mappings = { 
            i = { 
                ["<C-x>"] = false, 
                ["<C-q>"] = actions.send_to_qflist 
            } 
        },

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
    extensions = { }
}

local M = {}

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "Dotfiles",
        cwd = "~/dotfiles/",
        hidden = true,
    })
end

M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "<c-d>", actions.git_delete_branch)
            return true
        end,
    })
end

return M
