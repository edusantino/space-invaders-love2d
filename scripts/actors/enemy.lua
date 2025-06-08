local Enemy = {}
Enemy.__index = Enemy

local idleImg = love.graphics.newImage("assets/idle/enemy.png")
local shootingImg = love.graphics.newImage("assets/anim/enemy_shooting.png") -- spritesheet

local PVector = require("scripts.extensions.pvector")
local Bullet = require("scripts.actors.bullet")

function Enemy:new(x, y)
    local instance = setmetatable({}, Enemy)
    instance.position = PVector:new(x or 0, y or 0)
    instance.velocity = PVector:new(60, 0) -- pixels per seconds
    instance.health = 100
    instance.state = "idle"
    instance.direction = 1
    instance.width = idleImg:getWidth()
    instance.height = idleImg:getHeight()

    -- Animação shooting
    instance.shootingFrames = {}
    local frameWidth, frameHeight = 32, 32
    for i = 0, (shootingImg:getWidth() / frameWidth) - 1 do
        table.insert(instance.shootingFrames, love.graphics.newQuad(i * frameWidth, 0, frameWidth, frameHeight, shootingImg:getDimensions()))
    end
    instance.currentFrame = 1
    instance.frameTimer = 0
    instance.frameDuration = 0.1 -- segundos por frame

    return instance
end

function Enemy:update(dt, screenWidth)
    -- Moving left to right
    if self.position.x + self.width >= (screenWidth or love.graphics.getWidth()) then
        self.direction = -1
    elseif self.position.x <= 0 then
        self.direction = 1
    end
    self.position.x = self.position.x + self.velocity.x * self.direction * dt

    -- Animate if shooting
    if self.state == "shooting" then
        self.frameTimer = self.frameTimer + dt
        if self.frameTimer >= self.frameDuration then
            self.frameTimer = self.frameTimer - self.frameDuration
            self.currentFrame = self.currentFrame % #self.shootingFrames + 1
        end
    end
end

function Enemy:draw()
    if self.state == "shooting" then
        love.graphics.draw(
            shootingImg,
            self.shootingFrames[self.currentFrame],
            self.position.x, self.position.y
        )
    else
        love.graphics.draw(idleImg, self.position.x, self.position.y)
    end
end

function Enemy:shoot(enemyBullets)
    table.insert(enemyBullets, Bullet:new(self.position.x + 13, self.position.y + self.height, {x = 0, y = 1}))
end

return Enemy