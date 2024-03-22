require("utils")

local M = {}

M.start = function()
  local Snake = R("snake.snake")
  local window = R("snake.window")
  local snake = Snake:new()

  -- commands
  local open_game = function()
    window.open()
  end
  vim.api.nvim_create_user_command(
    "Snake",
    open_game,
    { desc = "Start Snake game" }
  )

  -- keymap
  for key in pairs(Snake.direction_map) do
    print("registering key " .. key)

    local move = function()
      snake.change_dir(key)
    end

    -- TODO: set keys inside window only
    -- vim.keymap.set({ "n" }, key, move, { noremap = true, silent = true })
  end
end

return M
