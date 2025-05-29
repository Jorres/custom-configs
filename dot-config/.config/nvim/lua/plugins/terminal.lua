local M = {}

local state = {
  buf = -1,
  win = -1,
  job_id = -1,
  resizing_active = false,
}

function M.toggle_terminal()
  if not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
  end

  if vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = -1
    return
  end

  local width  = math.ceil(vim.o.columns * 0.8)
  local height = math.ceil(vim.o.lines * 0.8)
  local row    = math.ceil((vim.o.lines - height) / 2 - 1)
  local col    = math.ceil((vim.o.columns - width) / 2)

  state.win    = vim.api.nvim_open_win(state.buf, true, {
    relative = "editor",
    width    = width,
    height   = height,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = "rounded",
  })

  if vim.bo[state.buf].buftype ~= "terminal" then
    vim.cmd("terminal")
  end

  vim.cmd("startinsert")

  state.job_id = vim.bo[state.buf].channel
end

M.send_stuff = function()
  vim.fn.chansend(state.job_id, "ls -lah\r\n")
end

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    if vim.api.nvim_win_is_valid(state.win) then
      vim.api.nvim_win_close(state.win, false)
    end
  end
})

return M
