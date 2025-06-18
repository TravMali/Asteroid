--Still need player and asteroid collisions. Asteroid creation for menu and levels.
--Setup up menu options bullet collisions next.

--SHIP
local Ship = {mouseX=0, mouseY=0, health=1, shipVertices = {0,0,0,0,0,0}}

function Ship:new()
    ship = {mouseX, mouseY, health, shipVertices}
    self.__index = self
    return setmetatable(ship, self)
end

function Ship:shipMouse()
    self.mouseX, self.mouseY = love.mouse.getPosition()
    self.shipVertices = {
                    self.mouseX+10,self.mouseY+15,
                    self.mouseX,self.mouseY-15,
                    self.mouseX-10,self.mouseY+15
                    }
end
--SHIP

--ASTEROIDS
local Asteroid = {x = 50, y = 50, radius = 10, shape = 0}

function Asteroid:new(locationX, locationY, r)
    asteroid = {x = locationX, y = locationY, radius = r, shape = self.createAsteroidShape()}
    self.__index = self
    return setmetatable(asteroid, self)
end

function Asteroid.createAsteroidShape()
    math.randomseed(os.time())
    return math.random(4,10)
end
--ASTEROIDS
asteroids = {} --List of asteroid objects

--BULLETS
local Bullet = {x=0, y=0}

function Bullet:new(locationX, locationY)
    bullet = {x = locationX , y = locationY-15}
    self.__index = self
    return setmetatable(bullet, self)
end
--BULLETS
bullets = {} --List of bullet objects

--WINDOW
local w = 768
local h = 768
love.window.setMode(w,h)
--WINDOW

--BUTTONS
local buttonWidth = 120
local buttonHeight = 30
local startButton = {
  width = buttonWidth,
  height = buttonHeight,
  x = w/2 - buttonWidth/2 - buttonWidth - 10,
  y = h * 1/2
  }

local quitButton = {
  width = buttonWidth,
  height = buttonHeight,
  x = w/2 - buttonWidth/2 + buttonWidth + 10,
  y = h * 1/2
  }
--BUTTONS

--GAME CONDITIONS
local menu = false
local level1 = false
local win = false
local lose = false
--GAME CONDITIONS

--LOVE
function love.load() -- One time setup
    menu = true
    love.mouse.setVisible(false)
    --some things will need to be moved to another block
    table.insert(asteroids, Asteroid:new(50,50,10))
    player = Ship:new()
    player:shipMouse()
    shots = 1 -- Preloads one shot
    timer = 0 -- Used for updating bullets
end

function love.update() --Updates each frame
    player:shipMouse()
    bulletControl()
    bulletAsteroidCollisionCheck()
    timer = timer + 1
end

function love.draw() --Draws objects in window
    love.graphics.print(tostring(love.timer.getFPS()), 10, 10)

    if menu == true then
        displayMenu()
    end
    if level1 == true then
    end
    if win == true then
    elseif lose ==true then
    end
    love.graphics.setColor(1,1,1,1)
    love.graphics.polygon("line", player.shipVertices)
    drawAsteroids()
    drawBullets()
end
--END LOVE

--Varios controls and interactions
function bulletControl()--Bullet firing and movement
      if love.mouse.isDown(1) and shots > 0 then
        shots = shots - 1
        table.insert(bullets, Bullet:new(player.mouseX, player.mouseY))
    end
    for i = 1, #bullets do
        bullets[i].y = bullets[i].y-3
    end
    if timer >= 125 and shots == 0 then
        shots = shots + 1
        timer = 0
    end
end

function bulletAsteroidCollisionCheck() --Iterates through bullets and asteroids to check if collisions happen
    for i = #bullets, 1, -1 do
        for j = #asteroids, 1, -1 do
            if bulletAsteroidCollisionHelper(bullets[i], asteroids[j]) then
                table.remove(bullets,i)
                table.remove(asteroids,j)
                break
            end
        end
    end
end

function bulletAsteroidCollisionHelper(b, a) --Checks for collisions between individual bullets and asteroids 
    local dx = b.x - a.x
    local dy = b.y - a.y
    local distanceSquared = dx*dx + dy*dy

    local sumRadii = 3 + a.radius
    local sumRadiiSquared = sumRadii * sumRadii

    if distanceSquared <= sumRadiiSquared then
        return true
    else 
        return false 
    end
end

function shipAsteroidCollision(sx,sy,ax,ay) --Checks for collisions between the ship and asteroids

    return false
end

function bulletMenuCollision(b, m)

end
--end controls for physics and interactions

--DRAWING FUNCTIONS
function drawBullets()
    for i = 1, #bullets do
        love.graphics.circle("fill", bullets[i].x, bullets[i].y, 3)
    end
end

function drawAsteroids()
    for i = 1, #asteroids do
        love.graphics.circle("fill", asteroids[i].x, asteroids[i].y, asteroids[i].radius)
    end
end
--END DRAWING FUNCTIONS

--LEVELS
function displayMenu() --Text is positioned semi-manually. Be prepared to edit if resized
        local startTextOffsetX = 2;
        local startTextOffsetY = 2;
        local quitTextOffsetX = 7;
        local quitTextOffsetY = 2;
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("fill", startButton.x, startButton.y, startButton.width, startButton.height)
        love.graphics.setColor(0,0,0,1)
        love.graphics.print("Start", startButton.x + (buttonWidth/3) + startTextOffsetX, startButton.y + buttonHeight/3 - startTextOffsetY)
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("fill", quitButton.x, quitButton.y, quitButton.width, quitButton.height)
        love.graphics.setColor(0,0,0,1)
        love.graphics.print("Quit", quitButton.x + (buttonWidth/3) + quitTextOffsetX, quitButton.y + buttonHeight/3 - quitTextOffsetY)
end

function asteroidsLevel1() --Initializes the asteroids and their positions for level 1. Also controls for their movement
level1 = true
end
--END LEVELS