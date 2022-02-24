local opts = {silent = true}

SETMAP("n", "<leader>hm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
SETMAP("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", opts)
SETMAP("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
SETMAP("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
SETMAP("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
SETMAP("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)
SETMAP("n", "<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>", opts)
SETMAP("n", "<leader>6", ":lua require('harpoon.ui').nav_file(6)<CR>", opts)
SETMAP("n", "<leader>7", ":lua require('harpoon.ui').nav_file(7)<CR>", opts)
SETMAP("n", "<leader>8", ":lua require('harpoon.ui').nav_file(8)<CR>", opts)

require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    },
})

