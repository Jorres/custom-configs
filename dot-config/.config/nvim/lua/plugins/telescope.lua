local actions = require('telescope.actions')
local action_state = require 'telescope.actions.state'
local transform_mod = require('telescope.actions.mt').transform_mod
local putils = require "telescope.previewers.utils"
local telescope = require('telescope')

local previewers = require('telescope.previewers')

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end

    if stat.size > 500000 then
      vim.schedule(function()
        putils.set_preview_message(
          bufnr,
          opts.winid,
          "File too large",
          opts.preview.msg_bg_fillchar
        )
      end)
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

local live_grep_filters = {
  extension = nil
}

local function run_live_grep(current_input)
  require('telescope.builtin').live_grep {
    additional_args = live_grep_filters.extension and function()
      return { '--glob', live_grep_filters.extension }
    end,
    default_text = current_input,
  }
end

local custom_actions = transform_mod {
  set_extension = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local current_input = action_state.get_current_line()

    vim.ui.input({ prompt = 'Glob (not fuzzy! use *)' }, function(input)
      if input == nil then
        return
      end

      live_grep_filters.extension = input

      actions._close(prompt_bufnr, current_picker.initial_mode == 'insert')
      run_live_grep(current_input)
    end)
  end,
}


telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--max-filesize=100K',
      '--hidden'
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
    file_sorter = require 'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = { "%.node_modules/", "%.ccls-cache/", "%.package-lock.json", "%.git/objects/", "%.git/refs/" },
    generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    path_display = { "truncate" },
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist
      }
    },
    buffer_previewer_maker = new_maker
  },
  pickers = {
    live_grep = {
      path_display = { 'shorten' },
      mappings = {
        i = {
          ['<c-f>'] = custom_actions.set_extension,
        },
      },
    },
  },
  extensions = {
  }
}

telescope.load_extension('harpoon')
telescope.load_extension('fzf')
telescope.load_extension("yank_history")

local M = {}

M.git_branches = function()
  require("telescope.builtin").git_branches({
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.git_delete_branch)
      map("n", "<c-d>", actions.git_delete_branch)
      return true
    end,
  })
end

M.live_grep_with_optional_filter = function()
  live_grep_filters.extension = nil

  require('telescope.builtin').live_grep()
end


return M
