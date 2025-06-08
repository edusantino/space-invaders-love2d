local Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, direction)
    local instance = setmetatable({}, Bullet)
    instance.position = {x = x, y = y}
    instance.speed = 300
    instance.direction = direction -- {x = 0, y = -1} para cima, {x = 0, y = 1} para baixo
    instance.width = 4
    instance.height = 12
    return instance
end

function Bullet:update(dt)
    self.position.x = self.position.x + self.direction.x * self.speed * dt
    self.position.y = self.position.y + self.direction.y * self.speed * dt
end

function Bullet:draw()
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.width, self.height)
end

function Bullet:isOffScreen(screenHeight)
    return self.position.y < 0 or self.position.y > screenHeight
end

return Bullet