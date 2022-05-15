require('lualine').setup {
  options = {
    icons_enabled = true,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {}
  },
  sections = {
    -- lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end }},
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding' },
    lualine_y = { 'filetype', 'filesize' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  --[[ tabline = {
        lualine_a = {'tabs'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }, ]]
  extensions = { 'fugitive', 'quickfix', 'nvim-tree', 'aerial' }
}


--[[ local colors = require("colorbuddy").setup()

require('galaxyline').section.left[1]= {
  FileSize = {
    provider = 'FileSize',
    condition = function()
      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
      end
      return false
      end,
    icon = '   ',
    highlight = {colors.green,colors.purple},
    separator = '',
    separator_highlight = {colors.purple,colors.darkblue},
  }
}

require('galaxyline').section.left[2]= {
  FileSize = {
    provider = 'FileSize',
    condition = function()
      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
      end
      return false
      end,
    icon = ' size  ',
    highlight = {colors.green,colors.purple},
    separator = '|',
    separator_highlight = {colors.purple,colors.darkblue},
  }
}
require('galaxyline').section.left[3]= {
  FileSize = {
    provider = 'FileSize',
    condition = function()
      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
      end
      return false
      end,
    icon = '   ',
    highlight = {colors.green,colors.purple},
    separator = '',
    separator_highlight = {colors.purple,colors.darkblue},
  }
} ]]
