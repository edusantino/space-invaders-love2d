local w, h = 800, 600

local font

local GameManager = require("scripts.gamemanager")
local game = {}

function love.load()
    love.window.setMode(w, h, {resizable=false})
    font = love.graphics.newFont("assets/fonts/PressStart2P.ttf", 24)
    love.graphics.setFont(font)
    game = GameManager:new(w, h)
end

function love.update(dt)
    if game:getState() == "play" then
        game:update(dt)
    elseif game:getState() == "gameover" then
        game:showGameOverScreen()
    elseif game:getState() == "start" then
        game:showStartMenu()
    end
end

function love.draw()
    game:draw()
end

function love.keypressed(key)
    game:keypressed(key)
end