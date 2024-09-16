-- ATTACH DEBUGGER --
if arg[2] == "debug" then
    require("lldebugger").start();
    DefaultErrorHandler = love.errorhandler;
end

-- REQUIRE MODULES --
Vector2 = require "res.lib.Vector2"
Workspace = require "res.lib.Workspace"

-- LOVE 2D CALLBACKS --
function love.load()
    MainWorkspace = Workspace:new()
end

function love.update(dt)
end

function love.draw()
    MainWorkspace:draw()
end

function love.wheelmoved(x, y)
    if y > 0 then
        MainWorkspace:zoomIncrease()
    elseif y < 0 then
        MainWorkspace:zoomDecrease()
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    if (not istouch) and love.mouse.isDown(3) then
        MainWorkspace:moveOffset(dx, dy)
    end
end

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2);
    else
        return DefaultErrorHandler(msg);
    end
end