local loudOpts = {silent = false}
local harpoon_pref = "<leader>h"

vim.keymap.set("n", harpoon_pref .. "m", require"harpoon.ui".toggle_quick_menu, loudOpts)
vim.keymap.set("n", harpoon_pref .. "a", require"harpoon.mark".add_file, loudOpts)

local silentOpts = {silent = true}
for i = 1, 8, 1 do
  vim.keymap.set("n", "<leader>" .. i, function ()
    require"harpoon.ui".nav_file(i)
  end, silentOpts)
end

require"harpoon".setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    },
})
