CountdownState = Class{__includes = BaseState}

sounds = {
    ['start'] = love.audio.newSource('audio/start.wav', 'static'),
}

-- countdown by 1 second but actually less because 1 second is too long
COUNTDOWN_TIME = 0.8

function CountdownState:init()
    self.count = 3
    self.timer = 0
    sounds['start']:play()
end

-- track the countdown and switch to the play state when 0 is reached
function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountdownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), 0, 90, VIRTUAL_WIDTH, 'center')
end