return {
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    config = function()
      require("harpoon").setup({})

      local harpoon = require("harpoon")

      -- quirky but REQUIRED
      harpoon:setup()
    end
  }
}
