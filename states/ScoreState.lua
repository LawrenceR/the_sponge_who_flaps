ScoreState = Class{__includes = BaseState}

local cave_sponge = love.graphics.newImage('images/cave_sponge.png')
local patrick_image = love.graphics.newImage('images/patrick.png')
local squidward = love.graphics.newImage('images/squidward.png')

function ScoreState:enter(params)
    self.score = params.score
    sounds['victory']:play()
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen nd give an award based on the score
    if self.score >= 5 and self.score < 12 then
        love.graphics.setFont(funFont)
        love.graphics.printf('You got the cave sponge award! Not bad, but you can do better.', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 103, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Play Again!', 0, 220, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(cave_sponge, 200, 140, 0, 0.12, 0.12)
    elseif self.score >= 12 and self.score < 27 then
        love.graphics.setFont(funFont)
        love.graphics.printf('You got a lovely Patrick Award! Getting good huh?', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 103, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Play Again!', 0, 220, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(patrick_image, 225, 128, 0, 0.08, 0.08)
    elseif self.score >= 27 then
        love.graphics.setFont(funFont)
        love.graphics.printf('The impossible glorious Squidward award! This is the peak.', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 103, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Play Again!', 0, 220, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(squidward, 225, 135, 0, 0.08, 0.08)
    else    
        love.graphics.setFont(funFont)
        love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
    end
end