require("utils")

local Snake = R("snake.snake")
local window = R("snake.window")

-- initial state
local GameState = {
  food = {},
  velocity = 500, -- ms
  snake = Snake:new(),
  board = { "Hello World 🌎" }, -- TODO: generate empty board
}

GameState.update = function()
  GameState.snake:move()

  for index, value in ipairs(GameState.board) do
    GameState.board[index] = " " .. value
  end
end

GameState.view = function()
  -- update view
  window.write_lines(GameState.board)
end

local Game = {}

Game.start = function()
  GameState.init(Snake:new())
  window.open()

  local function loop()
    GameState.update()

    GameState.view()

    -- schedule next call
    vim.defer_fn(loop, GameState.velocity)
  end

  -- start loop
  vim.defer_fn(loop, 0)
end

Game.setup = function()
  -- commands
  vim.api.nvim_create_user_command("Snake", function()
    Game.start()
  end, { desc = "Start Snake game" })

  -- keymap
  local opts = {
    noremap = true,
    silent = true,
    buffer = window.buf,
  }

  for key in pairs(Snake.direction_map) do
    local move = function()
      GameState.snake:change_dir(key)
    end

    -- TODO: set keys inside window only
    vim.keymap.set({ "n" }, key, move, opts)
  end

  vim.keymap.set({ "n" }, "q", ":q<CR>", opts)
end

return Game
