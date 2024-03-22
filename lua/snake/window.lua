local Window = {
  buf = vim.api.nvim_create_buf(false, true),
  win = nil,
}

Window.open = function(opts)
  if Window.win ~= nil then
    return
  end

  local defaults = {
    width = 80,
    height = 80,
    title = "Snake 🐍",
    style = "minimal",
    border = "rounded",
  }
  -- center
  defaults.relative = "win"
  defaults.row = vim.api.nvim_win_get_height(0) / 2 - defaults.height / 2
  defaults.col = vim.api.nvim_win_get_width(0) / 2 - defaults.width / 2

  opts = vim.tbl_deep_extend("force", defaults, opts or {})
  print(vim.inspect.inspect(Window))
  Window.win = vim.api.nvim_open_win(Window.buf, true, opts)

  -- setup window
  vim.wo.relativenumber = false
  vim.o.number = false
  vim.bo.buflisted = false
  vim.wo.foldcolumn = "0"
end

return Window
