PlayState = Class{__includes = BaseState}

-- define variables
JELLY_SCROLL = -83
JELLY_WIDTH = 27
JELLY_HEIGHT = 39

PATTY_SCROLL = -65
PATTY_WIDTH = 39
PATTY_HEIGHT = 37

SPONGE_WIDTH = 71
SPONGE_HEIGHT = 69

function PlayState:init()
    self.sponge = Sponge()
    self.jellies = {}
    self.patties = {}
    self.jellyTimer = 0
    self.pattyTimer = 0
    self.score = 0
end

function PlayState:update(dt)
    -- spawn jelly
    self.jellyTimer = self.jellyTimer + dt
    if self.jellyTimer > math.random(1.25, 5) then
        table.insert(self.jellies, Jelly())
        self.jellyTimer = 0
    end

    -- spawn patty
    self.pattyTimer = self.pattyTimer + dt
    if self.pattyTimer > math.random(5, 10) then
        table.insert(self.patties, Patty())
        self.pattyTimer = 0   
    end

    -- if collide with patty, get 1 point
    for i, patty in pairs(self.patties) do
        if not patty.scored then
            if self.sponge:collidesPatty(patty) then
                self.score = self.score + 1
                patty.scored = true
                patty.remove = true
                if self.score == 9 or self.score == 21 then
                    sounds['hello']:play()
                else
                    sounds['munch']:play()
                end

                -- music changes when high enough score is reached
                if self.score == 27 then
                    sounds['theme']:stop()
                    sounds['chung']:setLooping(true)
                    sounds['chung']:play()
                end
            end
        end

        patty:update(dt)
    end

    -- if collide with jelly, die and game ends
    for k, jelly in pairs(self.jellies) do
        if self.sponge:collidesJelly(jelly) then
            sounds['electric']:play()

            love.timer.sleep(1.3)

            gStateMachine:change('score', {
                score = self.score
            })
        end

        jelly:update(dt)
    end

    -- remove patties from patty table
    for i, patty in pairs(self.patties) do
        if patty.remove == true then
            table.remove(self.patties, i)
        end
    end
    
    -- remove jelly from jelly table
    for k, jelly in pairs(self.jellies) do
        if jelly.remove == true then
            table.remove(self.jellies, k)
        end
    end

    self.sponge:update(dt)

    -- cap the floor
    if self.sponge.y > VIRTUAL_HEIGHT - SPONGE_HEIGHT - 10 then
        self.sponge.y = VIRTUAL_HEIGHT - SPONGE_HEIGHT - 10
    end

    -- cap the height
    if self.sponge.y < 0 then
        self.sponge.y = 0
    end
end

function PlayState:render()
    -- render jelly
    for k, jelly in pairs(self.jellies) do
        jelly:render()
    end

    -- render patty
    for i, patty in pairs(self.patties) do
        patty:render()
    end

    -- print score
    love.graphics.setFont(funFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    -- render spongebob himself
    self.sponge:render()
end

function PlayState:enter()
    scrolling = true
end

function PlayState:exit()
    scrolling = false
end