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
  -- "plugins.indent-blanks",
  "plugins.guess-indent",
  "plugins.hydra",
  "plugins.imageview",
  "plugins.dressing",
  "plugins.gitlinker",
  "plugins.legendary",
  "plugins.noice",
  "plugins.auto-hlsearch",
  "plugins.mini-indent",
  "plugins.mini-highlight",
  "plugins.mini-files",
  -- "plugins.wrapping",
  "plugins.flash",

  -- PDE
  "plugins.telekasten",
  "plugins.prettier",
  "plugins.ascii-drawing",

  --- MY OWN PLUGINS
  "showmethat"
})
