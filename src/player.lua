local PLAYERSPEED = 240
local IMAGE = love.graphics.newImage("assets/sprites/player.png")

local player = {}

function getPlayerPos()
  return player.x, player.y
end

function loadPlayer()
  player.x = 208
  player.y = 480
  player.width = 48
  player.height = 48
  player.mask = 24
  player.image = IMAGE
  player.rotation = 0
end

function updatePlayer(dt)
  local hspeed = 0
  local vspeed = 0
  
  -- set speed based on keyboard input
  if love.keyboard.isDown("left") then
    hspeed = -PLAYERSPEED * dt    
  elseif love.keyboard.isDown("right") then
    hspeed = PLAYERSPEED * dt   
  end

  if love.keyboard.isDown("up") then 
    vspeed = -PLAYERSPEED * dt 
  elseif love.keyboard.isDown("down") then
    vspeed = PLAYERSPEED * dt
  end
  
  -- normalize diagonal movement
  if hspeed ~= 0 and vspeed ~= 0 then
    hspeed = hspeed * .71
    vspeed = vspeed * .71
  end
  
  -- update position, don't move off side of screen
  if (player.x + hspeed > 0 and player.x + player.width + hspeed < SCREENWIDTH) then
    player.x = player.x + hspeed
  end
  if (player.y + vspeed > 0 and player.y + player.height + vspeed < SCREENHEIGHT) then
    player.y = player.y + vspeed
  end

  return true
end

function drawPlayer()
  love.graphics.draw(player.image,player.x,player.y,0,1.2,1.2)
end