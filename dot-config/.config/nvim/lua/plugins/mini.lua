return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.indentscope').setup({
        -- Draw options
        draw = {
          -- Delay (in ms) between event and start of drawing scope indicator
          delay = 60,
          -- Symbol priority. Increase to display on top of more symbols.
          priority = 3,

          animation = function(current_step, total_steps)
            return 8
          end,
        },
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Textobjects
          object_scope = '',
          object_scope_with_border = '',
          -- Motions (jump to respective border line; if not present - body line)
          goto_top = '',
          goto_bottom = '',
        },
        -- Options which control scope computation
        options = {
          -- Type of scope's border: which line(s) with smaller indent to
          -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
          border = 'top',
          -- Whether to use cursor column when computing reference indent.
          -- Useful to see incremental scopes with horizontal cursor movements.
          indent_at_cursor = true,
          -- Whether to first check input line to be a border of adjacent scope.
          -- Use it if you want to place cursor on function header to get scope of
          -- its body.
          try_as_border = true,
        },
        -- Which character to use for drawing scope indicator
        symbol = '╎',
      })

      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme       = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack        = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo        = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note        = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          small_fixme = { pattern = '%f[%w]()fixme()%f[%W]', group = 'MiniHipatternsFixme' },
          small_hack  = { pattern = '%f[%w]()hack()%f[%W]', group = 'MiniHipatternsHack' },
          small_todo  = { pattern = '%f[%w]()todo()%f[%W]', group = 'MiniHipatternsTodo' },
          small_note  = { pattern = '%f[%w]()note()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color   = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
}
