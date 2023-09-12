-- try variable shot rates later!

local BULLETSPEED = 450
local IMAGE = love.graphics.newImage("assets/sprites/player.png")

local bullets

function checkBulletCollision(enemy_x,enemy_y,enemy_w,enemy_h)
  local collide = false
  for i,v in ipairs(bullets) do
    if checkCollision(enemy_x,enemy_y,enemy_w,enemy_h,v.x,v.y,32,32) then
      collide = true
      table.remove(bullets,i)
    end
  end
  
  return collide    
end

function loadBullets()
  bullets = {}
end

function loadBullet(x,y)
  local b = {}
  b.x = x
  b.y = y
  
  table.insert(bullets,b)
end

function updateBullets(dt)
  for i,v in ipairs(bullets) do
    if v.y < -32 then
      table.remove(bullets, i)
    else
      updateBullet(v,dt)
    end
  end
  
end

function updateBullet(b,dt)
  b.y = b.y - (dt*BULLETSPEED)
end

function drawBullets()
  for i,v in ipairs(bullets) do
    love.graphics.setColor(0.5,1,0.5)
    love.graphics.rectangle("fill",v.x+8,v.y,16,32)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",v.x+12,v.y+4,8,24)
  end
end

function getBulletCount()
  return #bullets
end