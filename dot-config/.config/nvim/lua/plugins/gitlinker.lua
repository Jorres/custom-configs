return {
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require "gitlinker".setup {
        opts = {
          remote = nil, -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = require "gitlinker.actions".copy_to_clipboard,
          -- print the url after performing the action
          print_url = true,
        },
        callbacks = {
          ["thinkpad-github"] = function(url_data)
            url_data.host = "github.com"
            return require "gitlinker.hosts".get_github_type_url(url_data)
          end,
          ["github.com"] = require "gitlinker.hosts".get_github_type_url,
          ["gitlab.com"] = require "gitlinker.hosts".get_gitlab_type_url,
          ["gitlab.nebius.dev"] = function(url_data)
            local lines = ""
            if url_data.lstart then
              lines = "#L" .. url_data.lstart
              if url_data.lend then
                lines = lines .. "-" .. url_data.lend
              end
            end

            local hack = "-/blob/main"

            if string.find(url_data.repo, "nebo") then
              hack = "-/blob/trunk"
            end

            local base = "https://gitlab.nebius.dev/" .. url_data.repo .. '/' .. hack .. '/'
            return base .. url_data.file .. lines
          end,
        },
        mappings = nil,
      }
    end
  }
}
