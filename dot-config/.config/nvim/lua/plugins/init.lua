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
  "plugins.yank-ring",
  "plugins.autopairs",

  -- UI
  "plugins.telescope",
  "plugins.filetree",
  "plugins.alpha",
  "plugins.statusline",
  "plugins.smoothscroll",
  "plugins.cursor-landing",
  "plugins.toggleterm",
  "plugins.gitsigns",
  "plugins.harpoon",
  "plugins.indent-blanks",
  "plugins.guess-indent",
  "plugins.hydra",
  "plugins.numb",
  "plugins.diffview",
  "plugins.imageview",
  -- "plugins.mode-on-line",
  "plugins.dressing",
  "plugins.gitlinker",
  "plugins.focus",
  "plugins.legendary",
  "plugins.noice",
  "plugins.ufo",

  -- PDE
  "plugins.telekasten",
  "plugins.prettier",
  "plugins.ascii-drawing",

  --- MY OWN PLUGINS
  "showmethat"
})
