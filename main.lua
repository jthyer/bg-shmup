require("src.level")

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  love.window.setTitle("BG Shmup")

  SCREENWIDTH = love.graphics.getWidth()
  SCREENHEIGHT = love.graphics.getHeight()
  
  loadLevel()
end

function love.update(dt)
  local delta = dt
  if delta > 0.1 then delta = 0.1 end
  
  updateLevel(delta)
end

function love.draw()
  drawLevel()
end

function love.keypressed(key, scancode)
   if key == "escape" then
      love.event.quit()
   end
end