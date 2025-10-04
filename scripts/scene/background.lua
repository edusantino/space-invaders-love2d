Background = {}
Background.__index = Background

function Background:new()
    local self = setmetatable({}, Background)
    local particles = {}
    for i=1, 50 do
        table.insert(particles, {
            x = math.random(10, 800),
            y = math.random(10, 600),
            size = math.random(2, 5)
        }
    )
    end
    self.particles = particles
    return self
end

function Background:update(dt)
    for _, i in ipairs(self.particles) do
        love.graphics.line(i.x, i.y, i.x, i.y + i.size)
        i.y = i.y + 10 * dt * 2
    end
end

function Background:draw()
    for i = #self.particles, 1, -1 do
        if table[i].x > 600 then
            table.remove(self.particles, i)
            table.insert(self.particles, {
            x = math.random(10, 800),
            y = math.random(10, 600),
            size = math.random(2, 5)
        })
        end
    end
end

return Background