local direction_map = {
  h = "l",
  l = "r",
  k = "u",
  j = "d",
}

local initial_position = { x = 1, y = 1 }

local Snake = {}

function Snake:new()
  local instance = {}

  setmetatable(instance, self)
  self.__index = self

  self.queue = { initial_position }
  self.movements_queue = {}
  self.direction = "r" -- u d l r
  self.size = 3 -- snake size

  for _ = 1, self.size do
    self:move()
  end

  return instance
end

function Snake:move()
  local pos = vim.tbl_deep_extend("force", {}, self.queue[1])
  self.direction = table.remove(self.movements_queue, 1) or self.direction

  if self.direction == "l" then
    pos.x = pos.x - 1
  elseif self.direction == "r" then
    pos.x = pos.x + 1
  end

  if self.direction == "u" then
    pos.y = pos.y - 1
  elseif self.direction == "d" then
    pos.y = pos.y + 1
  end

  table.insert(self.queue, 1, pos)

  if #self.queue > self.size then
    table.remove(self.queue, #self.queue)
  end
end

function Snake:change_dir(dir)
  if direction_map[dir] == nil then
    print(dir .. " is a invalid direction")
    return
  end

  local new_dir = direction_map[dir]

  local last_dir = self.movements_queue[#self.movements_queue] or self.direction

  if
    (new_dir == "l" and last_dir == "r")
    or (new_dir == "r" and last_dir == "l")
    or (new_dir == "u" and last_dir == "d")
    or (new_dir == "d" and last_dir == "u")
  then
    return
  end

  table.insert(self.movements_queue, new_dir)
end

function Snake:board_colision_check(height, width)
  for _, pos in ipairs(self.queue) do
    if pos.x <= 0 or pos.x > width then
      return true
    end

    if pos.y <= 0 or pos.y > height then
      return true
    end
  end

  return false
end

function Snake:snake_colision_check()
  local pos_map = {}

  for _, pos in ipairs(self.queue) do
    local map_key = pos.x .. "," .. pos.y

    if pos_map[map_key] then
      return true
    end

    pos_map[map_key] = true
  end

  return false
end

function Snake:grow(amount)
  self.size = self.size + (amount or 1)
end

function Snake:is_over_position(check_pos)
  for _, pos in ipairs(self.queue) do
    if pos.x == check_pos.x and pos.y == check_pos.y then
      return true
    end
  end

  return false
end

Snake.direction_map = direction_map

return Snake
