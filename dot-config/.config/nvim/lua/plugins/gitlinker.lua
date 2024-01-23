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
    ["codeberg.org"] = require "gitlinker.hosts".get_gitea_type_url,
    ["bitbucket.org"] = require "gitlinker.hosts".get_bitbucket_type_url,
    ["arc-git.nebius.dev"] = function(url_data)
      local lines = ""
      if url_data.lstart then
        lines = "#L" .. url_data.lstart
        if url_data.lend then
          lines = lines .. "-" .. url_data.lend
        end
      end

      local base = "https://arcanum.nebius.dev/nebo/bb/cloud/bootstrap-templates/"
      return base .. url_data.file .. lines
    end,
    ["try.gogs.io"] = require "gitlinker.hosts".get_gogs_type_url,
    ["git.sr.ht"] = require "gitlinker.hosts".get_srht_type_url,
    ["git.launchpad.net"] = require "gitlinker.hosts".get_launchpad_type_url,
    ["repo.or.cz"] = require "gitlinker.hosts".get_repoorcz_type_url,
    ["git.kernel.org"] = require "gitlinker.hosts".get_cgit_type_url,
    ["git.savannah.gnu.org"] = require "gitlinker.hosts".get_cgit_type_url
  },
  -- default mapping to call url generation with action_callback
  mappings = vim.g.mapleader .. "gy"
})
