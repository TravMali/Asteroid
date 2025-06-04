--Next step is to mess with asteroids. Check for collisions between Bullets - Asteroids, Asteroids - Player

--START SHIP
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
end

--updates each frame
function love.update()
    player:shipMouse()
    if love.mouse.isDown(1) then
        table.insert(bullets, Bullet:new(player.mouseX, player.mouseY))
    end
    for i = 1, #bullets do
        bullets[i].y = bullets[i].y-1
    end
end

--Draws objects in window
function love.draw()
    love.graphics.setColor(1,1,0)
    love.graphics.polygon("line", player.shipVertices)
    love.graphics.circle("fill", aste.x, aste.y, 10, aste.shape)
    for i = 1, #bullets do
        love.graphics.circle("fill", bullets[i].x, bullets[i].y, 3)
    end
end