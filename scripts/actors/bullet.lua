local Bullet = {}
Bullet.__index = Bullet

Anim = require("scripts.extensions.anim")
local anim = Anim:new()

function Bullet:new(x, y, direction)
    local self = setmetatable({}, Bullet)
    self.position = {x = x, y = y}
    self.direction = direction -- {x = 0, y = -1} up, {x = 0, y = 1} down
    self.width = 4
    self.height = 12
    
    -- animation timer
    self.elapsed = 0
    self.norm = 0
    self.duration = 0.5 -- in seconds

    -- animation distance
    self.from = {x = x, y = y}
    self.to = - 12  -- height
    self.is_offscreen = false
    return self
end

function Bullet:update(dt)
    if self.elapsed < self.duration then
       self.position.y = anim:lerp(self.from.y, self.to, anim:easeInQuad(self.norm))
       self.elapsed = self.elapsed + dt
       self.norm = self.elapsed / self.duration
    end
end

function Bullet:draw()
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.width, self.height)
end

function Bullet:isOffScreen(screenHeight)
    return self.position.y < 0 or self.position.y > screenHeight
end

return Bullet