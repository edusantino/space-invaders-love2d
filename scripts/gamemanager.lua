local Player = require("scripts.actors.player")
local Enemy = require("scripts.actors.enemy")
local Hud = require("scripts.components.hudcomp")

local GameManager = {}
GameManager.__index = GameManager

local enemies = {}

function GameManager:new(screenWidth, screenHeight)
    local self = setmetatable({}, GameManager)
    self.state = "start"
    self.player = Player:new(screenWidth / 2, screenHeight - 50)
    self.enemy = Enemy:new(32, 32) -- exemplo de posição inicial
    self.menuSelected = 1 -- 1 = "Começar", 2 = "Sair"
    self.hud = Hud:new(screenWidth, screenHeight)
    self.score = 0

    self.playerBullets = {}
    self.enemyBullets = {}

    return self
end

function GameManager:getState()
    return self.state
end

-- Player atira
function GameManager:keypressed(key)
    if self.state == "play" then
        if key == "space" then
            self.player:shoot(self.playerBullets)
        end
    elseif self.state == "start" then
        if key == "down" then
            self.menuSelected = 2
        elseif key == "up" then
            self.menuSelected = 1
        elseif key == "return" then
            if self.menuSelected == 1 then
                self.state = "play"
            elseif self.menuSelected == 2 then
                love.event.quit()
            end
        end
    elseif self.state == "gameover" and key == "r" then
        self:reset()
    end
end

-- Enemy atira (exemplo: atira a cada X segundos, ou aleatório)
function GameManager:update(dt)
    if self.state == "play" then
        -- Atualize balas
        for i = #self.playerBullets, 1, -1 do
            local bullet = self.playerBullets[i]
            bullet:update(dt)
            if bullet:isOffScreen(self.hud.height) then
                table.remove(self.playerBullets, i)
            end
        end
        for i = #self.enemyBullets, 1, -1 do
            local bullet = self.enemyBullets[i]
            bullet:update(dt)
            if bullet:isOffScreen(self.hud.height) then
                table.remove(self.enemyBullets, i)
            end
        end

        -- Atualize player, inimigos, etc
        self.player:update(dt)
        self.enemy:update(dt)
        self.hud:updateScore(self.score)

        -- Colisões
        self:checkCollisions()
    end
end

function GameManager:draw()
    if self.state == "start" then
        self:showStartMenu()
    elseif self.state == "play" then
        self.player:draw()
        self.enemy:draw()
        for _, bullet in ipairs(self.playerBullets) do bullet:draw() end
        for _, bullet in ipairs(self.enemyBullets) do bullet:draw() end
        self.hud:draw()
    elseif self.state == "gameover" then
        self:showGameOverScreen()
    end
end

function GameManager:showStartMenu()
    love.graphics.push()
    love.graphics.translate(400, 300)

    -- Anima apenas a opção selecionada
    local scale1 = self.menuSelected == 1 and (1 + 0.1 * math.sin(love.timer.getTime() * 2)) or 1
    local scale2 = self.menuSelected == 2 and (1 + 0.1 * math.sin(love.timer.getTime() * 2)) or 1

    -- "Pressione ENTER para começar"
    love.graphics.push()
    love.graphics.scale(scale1, scale1)
    love.graphics.printf("Pressione ENTER para começar", -400, -50, 800, "center")
    love.graphics.pop()

    -- "Pressione Q para sair"
    love.graphics.push()
    love.graphics.translate(0, 60) -- Move para baixo para não sobrepor
    love.graphics.scale(scale2, scale2)
    love.graphics.printf("Pressione Q para sair", -400, -50, 800, "center")
    love.graphics.pop()

    love.graphics.pop()
end

function GameManager:showGameOverScreen()
    love.graphics.printf("Game Over! Pressione R para reiniciar", 0, 250, 800, "center")
end

function GameManager:reset()
    self.state = "play"
    self.player = Player:new()
    self.enemy = Enemy:new(100, 100)
    -- Reinicialize outros elementos do jogo
end

function GameManager:checkCollisions()
    -- Player bullets vs Enemy
    for i = #self.playerBullets, 1, -1 do
        local bullet = self.playerBullets[i]
        if self:checkAABB(bullet, self.enemy) then
            -- Collide, update hub score and remove bullet from screen
            self.enemy.health = self.enemy.health - 10
            table.remove(self.playerBullets, i)
            self:updateScore()
            print("score atualizado!" .. self.score)
        end
    end
    -- Enemy bullets vs Player
    for i = #self.enemyBullets, 1, -1 do
        local bullet = self.enemyBullets[i]
        if self:checkAABB(bullet, self.player) then
            -- Colidiu!
            -- self.player.health = self.player.health - 10
            table.remove(self.enemyBullets, i)
        end
    end
end

function GameManager:checkAABB(a, b)
    return a.position.x < b.position.x + b.width and
           b.position.x < a.position.x + a.width and
           a.position.y < b.position.y + b.height and
           b.position.y < a.position.y + a.height
end

function GameManager:updateScore()
    self.score = self.score + 20
end

return GameManager