local HudHealthComp = {}
HudHealthComp.__index = HudHealthComp

function HudHealthComp:new(position)
    local self = setmetatable({}, HudHealthComp)
    self.position = position
    self.greenSize = 30
    self.redSize = 1
    self.h = 5
    self.w = 30
    self.topMargin = 5
    self.health = 100
    return self
end

-- HudHealthComp top-center
function HudHealthComp:draw()
    -- Outerlines (white)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.position.x, self.position.y - self.h - self.topMargin, self.w, self.h)

    -- Green bar (life)
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", self.position.x, self.position.y - self.h - self.topMargin, self.greenSize, self.h)

    -- Red bar (damage)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "fill",
        self.position.x + self.greenSize,
        self.position.y - self.h - self.topMargin,
        self.w - self.greenSize,
        self.h
    )

    love.graphics.setColor(1, 1, 1)
end

function HudHealthComp:update(position)
    if self.health <= 0 then
        -- animate fading
    else
        self.greenSize = (self.health / 100) * self.greenSize
        self.redSize = self.health - (self.health / 100) * self.greenSize
    end
    self.position = position
end

return HudHealthComp