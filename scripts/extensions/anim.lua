-- Animensions for Animations

Anim = {}
Anim.__index = Anim

function Anim:new()
    return setmetatable({}, Anim) end

function Anim:lerp(a, b, t) return a + (b - a) * t end

function Anim:easeInQuad(t) return t * t end

function Anim:easeOutQuad(t) return 1 - (1 - t) * (1 - t) end

function Anim:easeInOutQuad(t)
    return t < 0.5 and 2 * t * t or 1 - math.pow(-2 * t + 2, 2) / 2
end

function Anim:easeOutCubic(t) return 1 - math.pow(1 - t, 3) end

function Anim:easeInCubic(t) return t * t * t end

return Anim