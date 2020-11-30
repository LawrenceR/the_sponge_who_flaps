Patty = Class{}

local PATTY_IMAGE = love.graphics.newImage('images/krabby_patty.png')

function Patty:init()
    -- set location of patty to spawn
    self.x = VIRTUAL_WIDTH + PATTY_WIDTH
    self.y = math.random(0, VIRTUAL_HEIGHT - PATTY_HEIGHT - 10)

    self.scored = false

    -- set dimensions of image
    self.width = PATTY_WIDTH
    self.height = PATTY_HEIGHT

    self.remove = false
end

function Patty:update(dt)
    -- set patty movement
    if self.width > -PATTY_WIDTH then
        self.x = self.x + PATTY_SCROLL * dt
    else
        self.remove = true
    end
end

function Patty:render()
    -- render patty
    love.graphics.draw(PATTY_IMAGE, self.x, self.y)
end