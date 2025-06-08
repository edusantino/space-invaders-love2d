local HudHealthComp = {}
HudHealthComp.__index = HudHealthComp

function HudHealthComp:new(x, y)
    local self = setmetatable({}, HudHealthComp)
    self.x = x
    self.y = y
    self.greenSize = 30
    self.redSize = 0
    self.h = 15
    self.healf = 100
    return self
end

-- HudHealthComp top-center
function HudHealthComp:draw()

    -- Outerlines
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

    -- Green bar
    love.graphics.rectangle("fill", self.x, self.y, self.greenSize - 1, self.h - 1)

    -- Red bar
    love.graphics.rectangle("fill", self.x + self.w + 1, self.y, self.redSize - 1, self.h - 1)
end

function HudHealthComp:update(health)
    if health <= 0 then
        -- animate fading
    else
        self.greenSize = (health / 100) * self.greenSize
        self.redSize = self.health - (health / 100) * self.greenSize
    end
end

return HudHealthComp