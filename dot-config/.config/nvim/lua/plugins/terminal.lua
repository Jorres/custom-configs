local M = {}

local state = {
  buf = -1,
  win = -1,
  job_id = -1,
  resizing_active = false,
}

-- M.toggle_terminal = function()
--   if not vim.api.nvim_buf_is_valid(state.buf) then
--     state.buf = vim.api.nvim_create_buf(false, true)
--   end

--   if not vim.api.nvim_win_is_valid(state.win) then
--     vim.cmd("split")
--     state.win = vim.api.nvim_get_current_win()
--     vim.api.nvim_win_set_buf(state.win, state.buf)

--     if vim.bo[state.buf].buftype ~= "terminal" then
--       vim.cmd.term()
--     end

--     vim.cmd.wincmd("J")
--     vim.api.nvim_win_set_height(0, 25)
--     vim.cmd('startinsert')
--     state.job_id = vim.bo.channel
--   else
--     vim.api.nvim_win_hide(state.win)
--   end
-- end

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
