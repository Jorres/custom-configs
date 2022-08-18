local load_list_safely = function(plugins)
  for _, plugin in ipairs(plugins) do
    local ok, msg = pcall(require, plugin)
    if not ok then
      print("Failed to load plugin: " .. plugin .. " : " .. msg)
    end
  end
end

require("plugins.packer")

load_list_safely({
  -- Core
  "plugins.colorbuddy",
  "plugins.lsp",
  "plugins.autoc8n",
  "plugins.treesitter",
  "plugins.snippets",
  "plugins.comment",
  "plugins.notify",

  -- UI
  "plugins.telescope",
  "plugins.filetree",
  "plugins.alpha",
  "plugins.statusline",
  "plugins.smoothscroll",
  "plugins.cursor-landing",
  "plugins.toggleterm",
  "plugins.gitsigns",
  "plugins.carbon",
  "plugins.harpoon",
  "plugins.indent-blanks",
  "plugins.zen-mode",
  "plugins.lsp-fidget",
  "plugins.guess-indent",
  "plugins.hydra",
  "plugins.numb",

  -- PDE
  "plugins.telekasten",
  "plugins.prettier",
  "plugins.ascii-drawing"
})

-- Try this later
-- require("plugins.distant")

--- MY OWN PLUGINS ---
-- require("academy.prototyping").setup()
