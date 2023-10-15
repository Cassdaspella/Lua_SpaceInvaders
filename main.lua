--This is the basic Game Loop

--love.load() is the function that is run one time when the game is run
function love.load()
    spaceshipImage = love.graphics.newImage('placeholder.png')
end

--Runs every frame, basically runs everything in here in inf loop as fast as possible
function love.update(dt)
end

--Also runs every frame, this renders graphics on screen
function love.draw()
    --running this will show you it runs every frame, this randomizes the image's position
    love.graphics.draw(spaceshipImage, love.math.random(0, 800), love.math.random(0, 600))
end