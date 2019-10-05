function love.load()
    WW, WH = love.graphics.getDimensions()
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    scale = 10
    mainCanvas = love.graphics.newCanvas()

    scrollSpeed = 25
    bg = love.graphics.newImage("tracks.png")
    bgY =  - bg:getHeight() / 2

    player = {
        x = 1,
        y = 25,
        image = love.graphics.newImage("trolley.png")
    }

    people = {
        x = 0,
        y = 0,
        image = love.graphics.newImage("people.png")
    }
    
    person = {
        x = 0,
        y = 0,
        image = love.graphics.newImage("person.png")
    }

    score = 0

    restart()
end

function love.draw()
    love.graphics.setCanvas(mainCanvas)
    love.graphics.clear()

    love.graphics.draw(bg, 0, math.floor(bgY))
    love.graphics.draw(people.image, people.x, people.y)
    love.graphics.draw(person.image, person.x, person.y)
    love.graphics.draw(player.image, player.x, player.y)

    love.graphics.setCanvas()
    love.graphics.draw(mainCanvas, 0, 0, 0, scale, scale)
    
    love.graphics.print("left and right to move", 5, 5)
    love.graphics.print("points for running over 1 person", 5, 20)
    love.graphics.print("you lose if you run over 5 people", 5, 35)
    love.graphics.print("score: "..score, 100, 100)
end

function love.update(dt)

    bgY = bgY + scrollSpeed * dt
    if bgY > 0 then
        bgY = - bg:getHeight() / 2
    end

    person.y = person.y + scrollSpeed * dt
    people.y = people.y + scrollSpeed * dt

    if person.y > WH / scale then
        person.x = love.math.random(0, 4) * 10 + 1
        person.y = - 50 
    end
    if people.y > WH / scale then
        people.x = love.math.random(0, 4) * 10 + 1
        people.y = - 50 
    end

    scrollSpeed = scrollSpeed + dt * 3

    if player.x + player.image:getWidth() > person.x and player.x < person.x + person.image:getWidth() and 
        player.y + player.image:getHeight() > person.y and player.y < person.y + person.image:getHeight() then
        score = score + 1
    end

    if player.x + player.image:getWidth() > people.x and player.x < people.x + people.image:getWidth() and 
    player.y + player.image:getHeight() > people.y and player.y < people.y + people.image:getHeight() then
        restart()
    end
end

function love.keypressed(key) 
    if key == "escape" then love.event.quit() end
    if key == "right" and not (player.x == 41) then
        player.x = player.x + 10
    end
    if key == "left" and not (player.x == 1) then
        player.x = player.x - 10
    end
end

function restart()
    person.x = 1
    person.y = 25
    
    people.x = love.math.random(0, 4) * 10 + 1
    people.y = - 100
    
    person.x = love.math.random(0, 4) * 10 + 1
    person.y = - 50

    score = 0

    scrollSpeed = 25
end