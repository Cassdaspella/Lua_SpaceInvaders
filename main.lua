--This is the basic Game Loop

--love.load() is the function that is run one time when the game is run
function love.load()
    spaceshipImage = {}
    spaceshipImage.x = 400
    spaceshipImage.y = 500
    spaceshipImage.speed = 4
    spaceshipImage.sprite = love.graphics.newImage('images/placeholder.png')
    background = love.graphics.newImage('images/background.png')
end

--Runs every frame, basically runs everything in here in inf loop as fast as possible
function love.update(dt)
    if love.keyboard.isDown("right") then
        spaceshipImage.x = spaceshipImage.x + spaceshipImage.speed
    end

    if love.keyboard.isDown("left") then
        spaceshipImage.x = spaceshipImage.x - spaceshipImage.speed
    end

    if love.keyboard.isDown("down") then
        spaceshipImage.y = spaceshipImage.y + spaceshipImage.speed
    end

    if love.keyboard.isDown("up") then
        spaceshipImage.y = spaceshipImage.y - spaceshipImage.speed
    end

    if spaceshipImage.x < 0 then
        spaceshipImage.x = 0
    end

    if spaceshipImage.x > 750 then
        spaceshipImage.x = 750
    end

    if spaceshipImage.y < 0 then
        spaceshipImage.y = 0
    end

    if spaceshipImage.y > 700 then
        spaceshipImage.y = 700
    end
    
end

--Also runs every frame, this renders graphics on screen
function love.draw()
    --running this will show you it runs every frame, this randomizes the image's position
    love.graphics.draw(background, 0, -200)
    love.graphics.draw(spaceshipImage.sprite, spaceshipImage.x, spaceshipImage.y)
    
end
