local Hud = {}
Hud.__index = Hud

function Hud:new(screenWidth, screenHeight)
    local self = setmetatable({}, Hud)
    self.width = screenWidth
    self.height = screenHeight
    self.score = 0
    return self
end

-- hud score top-left
function Hud:showScore()
    love.graphics.printf(self.score, 10, 10, 200, "left")
end

function Hud:showLives()
    love.graphics.printf(tostring(3), self.width /2, 10, 200, "left")
end

function Hud:updateScore(score)
    self.score = score
end

function Hud:draw()
    self:showLives()
    self:showScore()
end

return Hud