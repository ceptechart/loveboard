local CanvasElement = {}

function CanvasElement:new(pos, size)
    local newElement = {}
    pos = pos or Vector2:new()
    size = size or Vector2:new(250, 250)
    newElement.pos = pos
    newElement.size = size
    setmetatable(newElement, self)
    self.__index = self
    return newElement
end

function CanvasElement:draw(scale, offset)
    love.graphics.setColor(1,0.75,0.25,1)
    love.graphics.rectangle("fill", (self.pos.x*scale)+offset.x, (self.pos.y*scale)+offset.y, self.size.x*scale, self.size.y*scale)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print("Canvas element at X: "..self.pos.x.." Y: "..self.pos.y, self.pos.x+offset.x, self.pos.y+offset.y, 0, scale, scale)
end

return CanvasElement