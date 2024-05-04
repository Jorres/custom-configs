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
    lualine_c = { { 'filename', path = 3 }, '%=', {
      "harpoon2",
      icon = '♥',
      separator = " ",
    } },
    lualine_x = { 'encoding' },
    lualine_y = { 'filetype', 'filesize' },
    lualine_z = { { 'location', padding = 2 } }
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  -- tabline = {
  --   lualine_b = {'branch'},
  --   lualine_x = {},
  --   lualine_y = {},
  -- },
  extensions = { 'fugitive', 'quickfix', 'nvim-tree' }
}
