require("utils")

local Snake = R("snake.snake")
local window = R("snake.window")

local empty_block = " "
local snake_block = "#"
local board_width = 80
local board_height = 40

local function make_empty_board(height, width)
  local board = {}

  for i = 1, height do
    local line = {}
    for j = 1, width do
      table.insert(line, empty_block)
    end
    table.insert(board, line)
  end

  return board
end

-- initial state
local GameState = {
  velocity = 500, -- ms
  snake = Snake:new(),
  board = make_empty_board(board_height, board_width),
}

GameState.update = function()
  -- update
  GameState.snake:move()

  -- TODO: check board collision
  -- TODO: check snake collision

  -- TODO: generate food
  -- TODO: check food collision

  -- TODO: scoreboard
  -- TODO: restart game
end

GameState.view = function()
  local board = make_empty_board(board_height, board_width)

  -- print snake
  for _, pos in ipairs(GameState.snake.queue) do
    board[pos.y][pos.x] = snake_block
  end

  -- make view
  local view = {}
  for _, line in ipairs(board) do
    table.insert(view, table.concat(line, ""))
  end

  window.write_lines(view)
end

local Game = {}

Game.start = function()
  window.open()

  local function loop()
    GameState.update()

    GameState.view()

    -- schedule next call
    if GameState.velocity ~= 0 then
      vim.defer_fn(loop, GameState.velocity)
    end
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

    vim.keymap.set({ "n" }, key, move, opts)
  end

  local function quit()
    if GameState.velocity == 0 then
      GameState.velocity = 500
      Game.start()
    else
      GameState.velocity = 0
    end
  end
  vim.keymap.set({ "n" }, "q", quit, opts)
end

return Game
