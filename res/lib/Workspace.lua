local Workspace = {}

function Workspace:new(pos, size)
    local newWorkspace = {}
    pos = pos or Vector2:new()
    size = size or Vector2:new(love.graphics.getWidth(), love.graphics.getHeight())
    newWorkspace.pos = pos
    newWorkspace.size = size
    newWorkspace.canvas = love.graphics.newCanvas(size.x, size.y)
    newWorkspace.cameraZoom = 1
    newWorkspace.cameraOffset = Vector2:new()
    newWorkspace.gridZoom = 1
    setmetatable(newWorkspace, self)
    self.__index = self
    return newWorkspace
end

function Workspace:setPosition(pos)
    self.pos = pos
    return self
end
function Workspace:setSize(size)
    self.canvas:release()
    self.size = size
    self.canvas = love.graphics.newCanvas(size.x, size.y)
    return self
end
function Workspace:zoomIncrease()
    self.cameraZoom = self.cameraZoom * 1.1
    self.gridZoom = self.gridZoom * 1.1
    if self.gridZoom > 2 then
        self.gridZoom = 1
    end
    return self
end
function Workspace:zoomDecrease()
    self.cameraZoom = self.cameraZoom / 1.1
    self.gridZoom = self.gridZoom / 1.1
    if self.gridZoom < 0.5 then
        self.gridZoom = 1
    end
    return self
end
function Workspace:moveOffset(dx, dy)
    self.cameraOffset.x = self.cameraOffset.x + dx
    self.cameraOffset.y = self.cameraOffset.y + dy
    return self
end

function Workspace:draw()
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear(1, 1, 1, 1)
        love.graphics.setBlendMode("alpha")
        --Draw subgrid
        love.graphics.setColor(0,0,0,0.1)
        local gridSize = 100*(self.gridZoom)
        local ox, oy = (self.cameraOffset.x % gridSize) + gridSize/2, (self.cameraOffset.y % gridSize) + gridSize/2
        for x=-gridSize, self.canvas:getWidth(), gridSize do
            love.graphics.line(x + ox, -gridSize*2 + oy, x + ox, self.canvas:getHeight() + oy)
        end
        for y=-gridSize, self.canvas:getHeight(), gridSize do
            love.graphics.line(-gridSize*2 + ox, y + oy, self.canvas:getWidth() + ox, y + oy)
        end
        --Draw maingrid
        love.graphics.setColor(0,0,0,0.25)
        local gridSize = 100*(self.gridZoom)
        local ox, oy = self.cameraOffset.x % gridSize, self.cameraOffset.y % gridSize 
        for x=-gridSize, self.canvas:getWidth(), gridSize do
            love.graphics.line(x + ox, -gridSize + oy, x + ox, self.canvas:getHeight() + oy)
        end
        for y=-gridSize, self.canvas:getHeight(), gridSize do
            love.graphics.line(-gridSize + ox, y + oy, self.canvas:getWidth() + ox, y + oy)
        end
    love.graphics.setCanvas()
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.canvas, self.pos.x, self.pos.y)
    love.graphics.setBlendMode("alpha")
end

return Workspace