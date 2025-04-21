local load_list_safely = function(plugins)
  for _, plugin in ipairs(plugins) do
    local ok, msg = pcall(require, plugin)
    if not ok then
      print("Failed to load plugin: " .. plugin .. " : " .. msg)
    end
  end
end

require("plugins.lazy")

load_list_safely({
  -- Core
  "plugins.colorbuddy",
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
  "plugins.toggleterm",
  "plugins.gitsigns",
  "plugins.harpoon",

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

  "plugins.japanese",
  "plugins.macro-recorder",
  "plugins.img-clip",
  "plugins.marks",

  -- PDE
  "plugins.prettier",

  --- MY OWN PLUGINS
  "showmethat",
  -- "academy",
})
