local BGDATA = require("src.bgData")
local LEVELWIDTH = 480
local LEVELHEIGHT = 1984

local quads = {}
local canvas = love.graphics.newCanvas(LEVELWIDTH,LEVELHEIGHT)
local y = -LEVELHEIGHT+ 640

function restartBG()
  y = -LEVELHEIGHT+ 640 
end

function loadBG(level)
  bg_tileset = love.graphics.newImage("assets/tilesets/tileset1.png")
  
  local image_width = bg_tileset:getWidth()
  local image_height = bg_tileset:getHeight()
  
  local cols = image_width / 32
  local rows = image_height / 32

  for i = 0, rows-1 do
    for j = 0, cols-1 do
      table.insert(quads,love.graphics.newQuad(
          j * 32, i * 32, 32, 32, image_width,image_height))
    end
  end 
  
  love.graphics.setCanvas(canvas)
  drawCanvas(level)
  love.graphics.setCanvas()
end

function updateBG(dt)
  y = y + (50*dt)
end

function drawCanvas(level)
  love.graphics.setColor(1,1,1)
  for i,v in ipairs(BGDATA[level]) do
    for j,v2 in ipairs(v) do
      love.graphics.draw(bg_tileset, quads[1], (j-1) * 32 + 16,(i-1) * 32 + 16,
        0,frameCount,1,16,16)
      if v2 ~= -1 then
        love.graphics.draw(bg_tileset, quads[v2+1], (j-1) * 32,(i-1) * 32)
      end
    end
  end
end

function drawBG()
  love.graphics.draw(canvas, 0, y, 0, 1, 1)
end