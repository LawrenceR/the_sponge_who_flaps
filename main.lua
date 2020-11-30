-- add in required files
push = require 'push'
Class = require 'class'

require 'StateMachine'
require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleState'

require 'Sponge'
require 'Jelly'
require 'Patty'

-- define screen / window dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 289

-- delcare variables
local PAUSED = false

local floor = love.graphics.newImage('images/road.png')
local floorScroll = 0
local FLOOR_SCROLL_SPEED = 72

local background = love.graphics.newImage('images/background.png')
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 10

local BACKGROUND_LOOPING_POINT = 455

function love.load()
    -- nearest-neighbour filter thing
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- define RNG
    math.randomseed(os.time())

    -- set title
    love.window.setTitle('The Sponge Who Flaps')

    -- initialize fonts
    smallFont = love.graphics.newFont('fonts/open_sans.ttf', 10)
    mediumFont = love.graphics.newFont('fonts/pacifico.ttf', 16)
    funFont = love.graphics.newFont('fonts/pacifico.ttf', 26)
    hugeFont = love.graphics.newFont('fonts/pacifico.ttf', 56)
    love.graphics.setFont(funFont)
    
    -- initialize sounds
    sounds = {
        ['chung'] = love.audio.newSource('audio/big_chung.mp3', 'static'),
        ['electric'] = love.audio.newSource('audio/electric.mp3', 'static'),
        ['jump'] = love.audio.newSource('audio/jump.mp3', 'static'),
        ['munch'] = love.audio.newSource('audio/munch.mp3', 'static'),
        ['pause'] = love.audio.newSource('audio/pause.wav', 'static'),
        ['start'] = love.audio.newSource('audio/start.wav', 'static'),
        ['theme'] = love.audio.newSource('audio/theme_song.mp3', 'static'),
        ['victory'] = love.audio.newSource('audio/victory.mp3', 'static'),
        ['hello'] = love.audio.newSource('audio/hello.mp3', 'static')
    }

    -- start playing theme song
    sounds['theme']:setLooping(true)
    sounds['theme']:play()

    -- intialize screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initialize state machines as per code provided by Colton Ogden CS50
    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

    -- initialize input tables
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

-- function for resizing screen
function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    -- add pressed keys to table
    love.keyboard.keysPressed[key] = true
    -- pause functionality
    if key == 'p' and PAUSED == false then
        PAUSED = true
        sounds['pause']:play()
    elseif key == 'p' and PAUSED == true then
        PAUSED = false
        sounds['pause']:play()
    -- quit game functionality
    elseif key == 'escape' then
        love.event.quit()
    end
end

-- mouse button pressed function
function love.mousepressed(x, y, button)
    if love.mouse.buttonsPressed[button] then
        return true
    else
        return false
    end
end

-- function to return true if given key was pressed
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

-- function to return true if mouse button was pressed
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.update(dt)
    if PAUSED == false then
        -- scroll our background and ground, looping back to 0 after a certain amount
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
        floorScroll = (floorScroll + FLOOR_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

        gStateMachine:update(dt)

        love.keyboard.keysPressed = {}
        love.mouse.buttonsPressed = {}
    end
end

-- draw all game assets to screen
function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(floor, -floorScroll, VIRTUAL_HEIGHT - 16)

    push:finish()
end