TitleState = Class{__includes = BaseState}

function TitleState:update(dt)
    -- countdown
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleState:render()
    -- set fonts
    love.graphics.setFont(funFont)
    love.graphics.printf('The Flapping Sponge', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 150, VIRTUAL_WIDTH, 'center')
end