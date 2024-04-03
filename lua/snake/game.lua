require("utils")

local Snake = R("snake.snake")
local window = R("snake.window")

local empty_block = " "
local snake_block = "#"

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
local GameState = {}

function GameState:new(width, height)
  local instance = {}
  setmetatable(instance, self)
  self.__index = self

  self:init(width, height)

  return instance
end

function GameState:init(width, hight)
  self.velocity = 500 -- ms
  self.status = "running" -- 'idle' | 'running' | 'game-over'
  self.snake = Snake:new()
  self.board_width = width
  self.board_height = hight
end

function GameState:update()
  self.snake:move()

  if
    self.snake:board_colision_check(self.board_height, self.board_width)
    or self.snake:snake_colision_check()
  then
    self.status = "game-over"
  end

  -- TODO: generate food
  -- TODO: check food collision

  -- TODO: scoreboard
  -- TODO: restart game
end

function GameState:view()
  local board = make_empty_board(self.board_height, self.board_width)

  if self.status == "game-over" then
    -- print game over screen
    local view = {
      "",
      "Game Over 🐍❌",
      "",
      "Hit <C-r>  to restart",
      "",
    }
    window.write_lines(view)
    return
  end

  -- print snake
  for _, pos in ipairs(self.snake.queue) do
    board[pos.y][pos.x] = snake_block
  end

  -- make view
  local view = {}
  for _, line in ipairs(board) do
    table.insert(view, table.concat(line, ""))
  end

  window.write_lines(view)
end

local Game = {
  state = GameState:new(),
}

function Game:new()
  local instance = {}
  setmetatable(instance, self)
  self.__index = self

  self.width = 80
  self.height = 40

  self.state = GameState:new(self.width, self.height)

  return instance
end

function Game:start()
  -- make this window open again
  window.open()

  self.state:init(self.width, self.height)

  local function should_schedule()
    return not (
      self.state.status ~= "running" -- not if game over
      or self.state.velocity == 0 -- not if no velocity
    )
  end

  local function loop()
    self.state:update()

    self.state:view()

    -- return if game over
    if self.state.status == "game-over" then
      return
    end

    -- return if no velocity
    if self.state.velocity == 0 then
      return
    end

    -- schedule next call
    if should_schedule() then
      vim.defer_fn(loop, self.state.velocity)
    end
  end

  -- start loop
  vim.defer_fn(loop, 0)
end

function Game:setup()
  -- commands
  local function start()
    self:start()
  end

  local function quit()
    self.state.status = "idle"
    window.close()
  end

  vim.api.nvim_create_user_command(
    "Snake",
    start,
    { desc = "Start Snake game" }
  )

  -- keymap
  local opts = {
    noremap = true,
    silent = true,
    buffer = window.buf,
  }

  for key in pairs(Snake.direction_map) do
    local move = function()
      self.state.snake:change_dir(key)
    end

    vim.keymap.set({ "n" }, key, move, opts)
  end

  vim.keymap.set({ "n" }, "q", quit, opts)
  vim.keymap.set({ "n" }, "r", start, opts)
end

return {
  setup = function()
    local game = Game:new()
    game:setup()
  end,
}
