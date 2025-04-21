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
  -- UI
  "plugins.statusline",
  "plugins.harpoon",

  "plugins.guess-indent",
  "plugins.dressing",
  "plugins.gitlinker",
  "plugins.legendary",
  "plugins.noice",

  "plugins.auto-hlsearch",
  "plugins.flash",

  "plugins.japanese",
  "plugins.img-clip",
  "plugins.marks",

  -- PDE
  "plugins.prettier",

  --- MY OWN PLUGINS
  "showmethat",
  -- "academy",
})
