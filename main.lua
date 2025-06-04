--Next step is to mess with asteroids. Check for collisions between Bullets - Asteroids, Asteroids - Player

--START SHIP
local Ship = {mouseX=0, mouseY=0, health=1, shipVertices = {0,0,0,0,0,0}, shots = 0}

function Ship:new()
    ship = {mouseX, mouseY, health, shipVertices, shots}
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
--END SHIP

--START ASTEROIDS
local Asteroid = {x = 50, y = 50, shape = 0}

function Asteroid:new()
    asteroid = {x, y, shape = self.createAsteroidShape()}
    self.__index = self
    return setmetatable(asteroid, self)
end

function Asteroid.createAsteroidShape()
    math.randomseed(os.time())
    return math.random(4,10)
end
--END ASTEROIDS
asteroids = {} --List of asteroid objects

--START BULLETS
local Bullet = {x=0, y=0}

function Bullet:new(locationX, locationY)
    bullet = {x = locationX , y = locationY-15}
    self.__index = self
    return setmetatable(bullet, self)
end
--END BULLETS
bullets = {} --List of bullet objects


--One time setup
function love.load()
    love.mouse.setVisible(false)
    aste = Asteroid:new()
    player = Ship:new()
    player:shipMouse()
    shots = 1 -- Preloads one shot
    timer = 0 -- Used for updating bullets
end

--Updates each frame
function love.update()
    player:shipMouse()
    bulletControl()
    timer = timer + 1
end

--Draws objects in window
function love.draw()
    love.graphics.setColor(1,1,0)
    love.graphics.polygon("line", player.shipVertices)
    love.graphics.circle("fill", aste.x, aste.y, 10, aste.shape)
    drawBullets()
end


--Controls for physics and interactions
function bulletControl()
      if love.mouse.isDown(1) and shots > 0 then
        table.insert(bullets, Bullet:new(player.mouseX, player.mouseY))
    shots = shots - 1
    end
    for i = 1, #bullets do
        bullets[i].y = bullets[i].y-3
    end
    if timer >= 125 and shots == 0 then
        shots = shots + 1
        timer = 0
    end
end
--end controls for physics and interactions

-- Drawing functions
function drawBullets()
    for i = 1, #bullets do
        love.graphics.circle("fill", bullets[i].x, bullets[i].y, 3)
    end
end