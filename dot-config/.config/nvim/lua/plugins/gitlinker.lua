require "gitlinker".setup({
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
    ["try.gitea.io"] = require "gitlinker.hosts".get_gitea_type_url,
    ["bitbucket.org"] = require "gitlinker.hosts".get_bitbucket_type_url,
    ["arc-git.nebius.dev"] = function(url_data)
      local lines = ""
      if url_data.lstart then
        lines = "#L" .. url_data.lstart
        if url_data.lend then
          lines = lines .. "-" .. url_data.lend
        end
      end

      -- url_data.repo looks like 'bb-cloud-<repo-name>'
      -- so I have to strip the first 9 characters 'bb-cloud-'
      local base = "https://arcanum.nebius.dev/nebo/bb/cloud/" .. string.sub(url_data.repo, 10) .. "/"

      return base .. url_data.file .. lines
    end,
  },
  -- default mapping to call url generation with action_callback
  mappings = vim.g.mapleader .. "gy"
})
