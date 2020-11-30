Jelly = Class{}

local JELLY_IMAGE = love.graphics.newImage('images/jellyfish.png')

function Jelly:init()
    -- set location of jelly to spawn
    self.x = VIRTUAL_WIDTH + JELLY_WIDTH
    self.y = math.random(0, VIRTUAL_HEIGHT - JELLY_HEIGHT - 10)

    -- set dimensions of image
    self.width = JELLY_WIDTH
    self.height = JELLY_HEIGHT

    self.remove = false
end

function Jelly:update(dt)
    -- set jelly movement
    if self.x > -JELLY_WIDTH then
        self.x = self.x + JELLY_SCROLL * dt
    else
        self.remove = true
    end
end

function Jelly:render()
    -- render jelly
    love.graphics.draw(JELLY_IMAGE, self.x, self.y)
end