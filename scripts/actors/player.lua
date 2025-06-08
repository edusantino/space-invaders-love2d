Player = {}
Player.__index = Player

local PVector = require("scripts.extensions.pvector")
local Bullet = require("scripts.actors.bullet")

function Player:new(x, y)
    local instance = setmetatable({}, Player)
    instance.position = PVector:new(x or 0, y or 0)
    instance.speed = PVector:new(10, 0)
    instance.velocity = PVector:new(0, 0)
    return instance
end

function Player:update(dt)
    if love.keyboard.isDown("d") then self:moveLeft() end
    if love.keyboard.isDown("a") then self:moveRight() end
end

function Player:moveLeft()
    self.position = self.position + self.speed
end

function Player:moveRight()
    self.position = self.position - self.speed
end

function Player:shoot(bullets)
    table.insert(bullets, Bullet:new(self.position.x + 13, self.position.y, {x = 0, y = -1}))
end

function Player:draw()
    love.graphics.rectangle("line", self.position.x, self.position.y, 30, 30)
end

return Player