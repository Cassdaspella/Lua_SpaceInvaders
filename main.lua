
--This is the basic Game Loop

--love.load() is the function that is run one time when the game is run
function love.load()
    spaceshipImage = {}
    spaceshipImage.x = 400
    spaceshipImage.y = 500
    spaceshipImage.speed = 600
    spaceshipImage.sprite = love.graphics.newImage('images/placeholder.png')
    background = love.graphics.newImage('images/background.png')
    
    asteroidImages = {}
    asteroidTimer = 1 
    
    pewpewImages = {}
    -- pewpewImages.x = spaceshipImage.x 
    -- pewpewImages.y = spaceshipImage.y
    -- pewpewImages.speed = 8
    -- pewpewImages.active = false
    -- pewpewImages.sprite = love.graphics.newImage('images/pewpew.png')
    shootThisKeyPress = false; --this bool is used to make sure only one bullet is produced per spacebar press
    
    sounds = {}
    sounds.pew = love.audio.newSource("sounds/pew.mp3", "static")
    sounds.music = love.audio.newSource("sounds/music.mp3", "stream")
    sounds.music:setLooping(true)
    sounds.music:play()

end


--Runs every frame, basically runs everything in here in inf loop as fast as possible
function love.update(dt)
    asteroidTimer = asteroidTimer - dt
    if  asteroidTimer <= 0 then --if 3 seconds have passed
            asteroidImages[#asteroidImages+1] = { --add another asteroid
            active = true,
            x = love.math.random(0, 800),
            y = 0,
            speed = 200,
            sprite = love.graphics.newImage('images/asteroid.png') --TODO change to asteroid pic
        }
        asteroidTimer = asteroidTimer + 1 --reset 1 second timer
    end


    if love.keyboard.isDown("right") then
        spaceshipImage.x = spaceshipImage.x + spaceshipImage.speed*dt
    end

    if love.keyboard.isDown("left") then
        spaceshipImage.x = spaceshipImage.x - spaceshipImage.speed*dt
    end

    if love.keyboard.isDown("down") then
        spaceshipImage.y = spaceshipImage.y + spaceshipImage.speed*dt
    end

    if love.keyboard.isDown("up") then
        spaceshipImage.y = spaceshipImage.y - spaceshipImage.speed*dt
    end

    if love.keyboard.isDown("space") and shootThisKeyPress == false then
        shootThisKeyPress = true
        pewpewImages[#pewpewImages+1] = {
            active = true,
            x = spaceshipImage.x,
            y = spaceshipImage.y,
            speed = 600,
            sprite = love.graphics.newImage('images/pewpew.png')
        }
    end

    if love.keyboard.isDown("space") == false and shootThisKeyPress == true then
        shootThisKeyPress = false
    end

    for x,i in pairs(pewpewImages) do
        if i.active then
            i.y = i.y-i.speed*dt
        end
        if i.y < 0 then
            i.active = false
        end
    end

    for x,i in pairs(asteroidImages) do
        if i.active then
            i.y = i.y+i.speed*dt -- y+ speed here since the asteroids are moving downward
        end
        if i.y > 550 then --disable sprite one out of canvas bounds
            i.active = false
        end
        -- if asteroid sprite is outside of bounds put it inside bounds
        if i.y < 0 then 
            i.y = 0
        end
        if i.y > 750 then
            i.y = 750
        end
    end

    -- if pewpewImages[#pewpewImages].active then
    --     -- Move the pewpewImages up when it's active
    --     pewpewImages[#pewpewImages].y = pewpewImages[#pewpewImages].y - pewpewImages[#pewpewImages].speed

    --     -- Check if the pewpewImages is out of the screen and deactivate it
    --     if pewpewImages.y < 0 then
    --         pewpewImages.active = false
    --     end
    -- end

    if spaceshipImage.x < 0 then
        spaceshipImage.x = 0
    end

    if spaceshipImage.x > 750 then
        spaceshipImage.x = 750
    end

    if spaceshipImage.y < 0 then
        spaceshipImage.y = 0
    end

    if spaceshipImage.y > 550 then
        spaceshipImage.y = 550
    end


    
end

--Also runs every frame, this renders graphics on screen
function love.draw()
    --running this will show you it runs every frame, this randomizes the image's position
    love.graphics.draw(background, 0, -200)
    love.graphics.draw(spaceshipImage.sprite, spaceshipImage.x, spaceshipImage.y)

    -- if pewpewImages.active then
    --     love.graphics.draw(pewpewImages.sprite, pewpewImages.x, pewpewImages.y)
    -- end
    for x,i in pairs(pewpewImages) do
        if i.active == true then
            love.graphics.draw(i.sprite, i.x, i.y)
        end
    end

    for x,i in pairs(asteroidImages) do
        if i.active == true then
            love.graphics.draw(i.sprite, i.x, i.y)
        end
    end
    
end

--If spacebar is pressed, play pew sound effect
function love.keypressed(key)
    if key == "space" then
        sounds.pew:play()
    end
end
