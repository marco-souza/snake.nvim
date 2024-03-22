local direction_map = {
  h = "left",
  l = "right",
  k = "up",
  j = "down",
}

local Snake = {
  position = { x = 0, y = 0 },
  queue = {},
  direction = "l", -- u d l r
  size = 3, -- snake size
}

function Snake:new()
  local instance = {}

  setmetatable(instance, self)
  self.__index = self

  return instance
end

function Snake:move()
  local pos = self.position

  if self.direction == "l" then
    pos.x = pos.x + 1
  elseif self.direction == "r" then
    pos.x = pos.x - 1
  end

  if self.direction == "u" then
    pos.y = pos.y + 1
  elseif self.direction == "d" then
    pos.y = pos.y - 1
  end

  table.insert(self.queue, 1, pos)

  if #self.queue > self.size then
    table.remove(self.queue, 1)
  end
end

function Snake:change_dir(dir)
  if direction_map[dir] == nil then
    print(dir .. " is a invalid direction")
    return
  end

  self.direction = dir
end

Snake.direction_map = direction_map

return Snake
