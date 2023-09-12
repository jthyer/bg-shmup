require("src.level")

local framerate = 0
local timer = 0

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  love.window.setTitle("BG Shmup")

  SCREENWIDTH = love.graphics.getWidth()
  SCREENHEIGHT = love.graphics.getHeight()
  
  loadLevel()
end

function love.update(dt)
  local delta = dt
  --delta = delta * 100 -- fast forward
  if delta > 0.1 then delta = 0.1 end
  
  updateLevel(delta)
  setFramerate(dt)
end

function love.draw()
  drawLevel()
  drawFramerate()
end

function love.keypressed(key, scancode)
   if key == "escape" then
      love.event.quit()
   end
end

function setFramerate(dt)
  timer = timer + dt
  if timer > 1 then
    framerate = math.floor(1/dt)
    timer = 0
  end
end

function drawFramerate()
  -- code to deliberately choke performance and see impact on framerate
  --local x = 0
  --for i=0,50000000 do
  --  x = x + math.sqrt(2)
  --end
  --print(x)
  love.graphics.printf(framerate,0,20,500,"left")
end