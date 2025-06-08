PVector = {}
PVector.__index = PVector

function PVector:new(x, y)
    local instance = setmetatable({}, PVector)
    instance.x = x or 0
    instance.y = y or 0
    return instance
end

function PVector:__tostring()
    return "Vector(" .. self.x .. ", " .. self.y .. ")"
end

function PVector:__add(other)
    return PVector:new(self.x + other.x, self.y + other.y)
end

function PVector:__sub(other)
    return PVector:new(self.x - other.x, self.y - other.y)  -- Corrigido (estava self.x - other.y)
end

function PVector:__mul(value)
    return PVector:new(self.x * value, self.y * value)
end

function PVector:__eq(other)
    if self.x == other.x and self.y == other.y then
        return true
    else
        return false
    end
end

function PVector:normalize()
    local mag = self:magnitude()
    if mag > 0 then
        return PVector:new(self.x/mag, self.y/mag)
    end
    return PVector:new(0, 0)
end

function PVector:magnitude()
    return math.sqrt(self.x^2 + self.y^2)
end

return PVector