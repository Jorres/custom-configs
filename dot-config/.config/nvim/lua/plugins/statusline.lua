require('lualine').setup {
  options = {
    icons_enabled = true,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {},
    globalstatus = true,
  },
  sections = {
    -- lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end }},
    lualine_a = { { 'mode', padding = 2 } },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { {
      'filename',
      path = 3,
      cond = function()
        return vim.bo.buftype ~= 'terminal'
      end,
    }, '%=', {
      "harpoon2",
      icon = '♥',
      separator = " ",
    } },
    lualine_x = { 'encoding' },
    lualine_y = { 'filetype', 'filesize', require("recorder").displaySlots, },
    lualine_z = {
      require("recorder").recordingStatus,
    }
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = { 'fugitive', 'quickfix', 'nvim-tree' }
}
