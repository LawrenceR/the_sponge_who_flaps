Sponge = Class{}

-- define gravity constant
local GRAVITY = 19

function Sponge:init()
    -- initialize spongebob image
    self.image = love.graphics.newImage('images/sponge.png')

    -- draw image at centre of screen
    self.x = VIRTUAL_WIDTH / 2 - 140
    self.y = VIRTUAL_HEIGHT - SPONGE_HEIGHT - 10

    self.width = SPONGE_WIDTH
    self.height = SPONGE_HEIGHT

    self.dy = 0
end

-- AABB collision for the jelly
function Sponge:collidesJelly(jelly)
    if (self.x + 4) + (self.width - 15) >= jelly.x and self.x + 12 <= jelly.x + JELLY_WIDTH then
        if (self.y + 4) + (self.height - 15) >= jelly.y and self.y + 12 <= jelly.y + JELLY_HEIGHT then
            return true
        end
    end

    return false
end

-- AABB collision for the patty
function Sponge:collidesPatty(patty)
    if (self.x + 2) + (self.width - 4) >= patty.x and self.x + 2 <= patty.x + PATTY_WIDTH then
        if (self.y + 2) + (self.height - 4) >= patty.y and self.y + 2 <= patty.y + PATTY_HEIGHT then
            return true
        end
    end

    return false
end

function Sponge:update(dt)
    -- set sponge down velocity based on gravity
    self.dy = self.dy + GRAVITY * dt

    -- apply jump functionality
    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = -6
        sounds['jump']:stop()
        sounds['jump']:play()
    end

    -- update spongebob position
    self.y = self.y + self.dy
end

function Sponge:render()
    love.graphics.draw(self.image, self.x, self.y, 0)
end