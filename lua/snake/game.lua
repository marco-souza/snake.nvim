require("utils")

local M = {}

M.start = function()
  local Snake = R("snake.snake")
  local window = R("snake.window")
  local snake = Snake:new()
  local velocity = 500

  -- commands
  local open_game = function()
    window.open()

    local line = "Hello World 🌎"
    local lines = { line }

    local function update()
      -- update state
      line = " " .. line
      -- table.insert(lines, line)
      lines = { line }
    end

    local function view()
      -- update view
      window.write_lines(lines)
    end

    local function loop()
      update()

      view()

      -- schedule next call
      vim.defer_fn(loop, velocity)
    end

    -- start loop
    vim.defer_fn(loop, 0)
  end

  vim.api.nvim_create_user_command(
    "Snake",
    open_game,
    { desc = "Start Snake game" }
  )

  -- keymap
  for key in pairs(Snake.direction_map) do
    local move = function()
      snake.change_dir(key)
    end

    -- TODO: set keys inside window only
    -- vim.keymap.set({ "n" }, key, move, { noremap = true, silent = true })
  end
end

return M
