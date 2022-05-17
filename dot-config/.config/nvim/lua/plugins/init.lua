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

  -- UI
  "plugins.telescope",
  "plugins.filetree",
  "plugins.alpha",
  "plugins.statusline",
  "plugins.smoothscroll",
  "plugins.cursor-landing",
  "plugins.toggleterm",
  "plugins.which-key",
  "plugins.gitsigns",
  "plugins.carbon",
  "plugins.harpoon",
  "plugins.indent-blanks",
  "plugins.twilight",
})

-- Try this later
-- require("plugins.distant")

--- MY OWN PLUGINS ---

require("showmethat").setup({})
