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
  "plugins.comment",
  "plugins.yank-ring",
  "plugins.autopairs",
  "plugins.chatgpt",
  "plugins.refactoring",

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
  "plugins.colorscheme",
  "plugins.guess-indent",
  "plugins.hydra",
  "plugins.dressing",
  "plugins.gitlinker",
  "plugins.legendary",
  "plugins.noice",
  "plugins.auto-hlsearch",
  "plugins.mini-indent",
  "plugins.mini-highlight",
  "plugins.flash",
  "plugins.headlines",
  "plugins.japanese",

  -- PDE
  "plugins.telekasten",
  "plugins.prettier",

  --- MY OWN PLUGINS
  "showmethat"
})
