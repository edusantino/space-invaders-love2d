-- Input: from=1 to=2, 5
-- Output: [1, 1.25, 1.50, 1.75, 2.0] 

local buffer = {}

local function clerp(from, to, intervals)
    local values = {}
    local step = (to - from) / intervals

    for i=from, to, step do
        print(i)
        table.insert(values, i)
    end
    return values
end

local nums = clerp(1, 2, 20)

print(buffer)