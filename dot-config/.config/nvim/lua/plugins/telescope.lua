return {
  {
    'nvim-telescope/telescope.nvim',
    tag = "0.1.8",
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    config = function()
      local actions = require('telescope.actions')
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

      require "telescope".setup {
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
              preview_width = 0.45,
            },
            vertical = {
              mirror = false,
            },
            width = 0.95,
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
          set_env = { ['COLORTERM'] = 'truecolor' },
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
          },
        },
        extensions = {
          fzf = {},
        }
      }

      telescope.load_extension('harpoon')
      telescope.load_extension("yank_history")
      telescope.load_extension("fzf")
    end
  },
}
