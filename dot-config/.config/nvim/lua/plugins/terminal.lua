local M = {}

local state = {
  buf = -1,
  win = -1,
  job_id = -1,
  resizing_active = false,
}

M.toggle_terminal = function()
  if not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
  end

  if not vim.api.nvim_win_is_valid(state.win) then
    vim.cmd("split")
    state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(state.win, state.buf)

    if vim.bo[state.buf].buftype ~= "terminal" then
      vim.cmd.term()
    end

    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 25)
    vim.cmd('startinsert')
    state.job_id = vim.bo.channel
  else
    vim.api.nvim_win_hide(state.win)
  end
end

M.send_stuff = function()
  vim.fn.chansend(state.job_id, "ls -lah\r\n")
end

vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    if state.resizing_active then
      return
    end

    state.resizing_active = true

    local old_win = vim.api.nvim_get_current_win()

    if not vim.api.nvim_win_is_valid(state.win) then
      return
    end
    vim.api.nvim_set_current_win(state.win)
    vim.cmd("wincmd J")
    if vim.api.nvim_win_is_valid(old_win) then
      vim.api.nvim_set_current_win(old_win)
    end

    if old_win == state.win then
      vim.cmd("startinsert")
    end

    state.resizing_active = false
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    if vim.api.nvim_win_is_valid(state.win) then
      vim.api.nvim_win_close(state.win, false)
    end
  end
})

return M
