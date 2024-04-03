local Window = {
  buf = vim.api.nvim_create_buf(false, true),
  win = nil,
}

Window.close = function()
  if Window.win == nil then
    return
  end

  vim.api.nvim_win_close(Window.win, true)
  Window.win = nil
end

Window.open = function(opts)
  if Window.win ~= nil then
    return
  end

  local defaults = {
    width = 80,
    height = 40,
    title = "Snake 🐍",
    style = "minimal",
    border = "rounded",
  }
  -- center
  defaults.relative = "win"
  defaults.row = 40
  defaults.col = 40

  opts = vim.tbl_deep_extend("force", defaults, opts or {})
  Window.win = vim.api.nvim_open_win(Window.buf, true, opts)

  -- setup window
  vim.wo.relativenumber = false
  vim.o.number = false
  vim.bo.buflisted = false
  vim.wo.foldcolumn = "0"
end

Window.write_lines = function(lines)
  vim.api.nvim_buf_set_lines(Window.buf, 0, 80, false, lines)
end

return Window
