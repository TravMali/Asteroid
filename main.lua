--Next step is to create unique asteroids and an iterator to draw a dynamic number of objects

--This keeps the ship glued to the mouse
function shipMouse()
    mouseX, mouseY = love.mouse.getPosition()
    shipVertices = {mouseX+10,mouseY+15,mouseX,mouseY-15,mouseX-10,mouseY+15}
end

local function asteroidShape()
math.randomseed(os.time())
return math.random(4,10)
end

--One time setup
function love.load()
    mouseX, mouseY = 0
    love.mouse.setVisible(false)
    ast = asteroidShape()
end

--updates each frame
function love.update()
    shipMouse()
end

--Eventually need to use a table with a linked list+iterator to draw shapes...otherwise static asteroids
function love.draw()
    love.graphics.setColor(1,1,0)
    love.graphics.polygon("line", shipVertices)
    love.graphics.circle("fill", 50,50,10,ast)
end
