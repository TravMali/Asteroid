--Next step is to create bullet objects and mouse press functionality. Check for collisions between Bullets - Asteroids, Asteroids - Player

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
--Needs iterator

--START BULLETS

--END BULLETS
bullets = {} --List of bullet objects
--needs iterator

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
end

--Eventually need to use a table with a linked list+iterator to draw shapes...otherwise static asteroids
function love.draw()
    love.graphics.setColor(1,1,0)
    love.graphics.polygon("line", player.shipVertices)
    love.graphics.circle("fill", aste.x, aste.y, 10, aste.shape)
end
