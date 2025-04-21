local M = {}

local state = {
  term = {
    buf = -1,
    win = -1,
    job_id = -1,
  }
}

M.toggle_terminal = function()
  if not vim.api.nvim_buf_is_valid(state.term.buf) then
    state.term.buf = vim.api.nvim_create_buf(false, true)
  end

  if not vim.api.nvim_win_is_valid(state.term.win) then
    vim.cmd("split")
    state.term.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(state.term.win, state.term.buf)

    if vim.bo[state.term.buf].buftype ~= "terminal" then
      vim.cmd.term()
    end

    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 25)
    vim.cmd('startinsert')
    state.term.job_id = vim.bo.channel
  else
    vim.api.nvim_win_hide(state.term.win)
  end
end

M.send_stuff = function()
  vim.fn.chansend(state.term.job_id, "ls -lah\r\n")
end

return M
