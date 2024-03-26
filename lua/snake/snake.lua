local direction_map = {
  h = "l",
  l = "r",
  k = "u",
  j = "d",
}

local initial_position = { x = 0, y = 0 }
local Snake = {
  queue = { initial_position },
  direction = "r", -- u d l r
  size = 3, -- snake size
}

function Snake:new()
  local instance = {}

  setmetatable(instance, self)
  self.__index = self

  self:init()

  return instance
end

function Snake:move()
  local pos = vim.tbl_deep_extend("force", {}, self.queue[1])

  if self.direction == "l" then
    pos.x = pos.x - 1
  elseif self.direction == "r" then
    pos.x = pos.x + 1
  end

  if self.direction == "u" then
    pos.y = pos.y + 1
  elseif self.direction == "d" then
    pos.y = pos.y - 1
  end

  table.insert(self.queue, 1, pos)

  if #self.queue > self.size then
    table.remove(self.queue, #self.queue)
  end
end

function Snake:init()
  ---@diagnostic disable-next-line: unused-local
  for i = 1, self.size do
    self:move()
  end
end

function Snake:print()
  local res = ""
  for index, value in ipairs(self.queue) do
    res = res .. "(" .. value.x .. ", " .. value.y .. "), "
  end
  print(res)
end

function Snake:change_dir(dir)
  if direction_map[dir] == nil then
    print(dir .. " is a invalid direction")
    return
  end

  self.direction = direction_map[dir]
end

Snake.direction_map = direction_map

return Snake
