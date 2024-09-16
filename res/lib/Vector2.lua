local Vector2 = {}

function Vector2:new(x, y)
    x = x or 0
    y = y or 0
    local newVector = {}
    newVector.x = x
    newVector.y = y
    setmetatable(newVector, self)
    self.__index = self
    return newVector
end

return Vector2