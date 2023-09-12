local PLAYERSPEED = 240
local IMAGE = love.graphics.newImage("assets/sprites/player.png")

local player = {}

function getPlayerPos()
  return player.x, player.y
end

function getPlayerMask()
  return player.mask_x, player.mask_y,
    player.mask_w, player.mask_h
end

function setPlayerMask()
  player.mask_x = player.x+player.mask
  player.mask_y = player.y+player.mask
  player.mask_w = player.w-(2*player.mask)
  player.mask_h = player.h-(2*player.mask)
end

function loadPlayer()
  player.x = 208
  player.y = 480
  player.w = 48
  player.h = 48
  player.mask = 16
  setPlayerMask()
  player.image = IMAGE
  player.rotation = 0
  player.death = false
  player.deathTimer = 1
end

function killPlayer()
  player.death = true
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
  if (player.x + hspeed > 0 and player.x + player.w + hspeed < SCREENWIDTH) then
    player.x = player.x + hspeed
  end
  if (player.y + vspeed > 0 and player.y + player.h + vspeed < SCREENHEIGHT) then
    player.y = player.y + vspeed
  end

  if player.death then
    player.deathTimer = player.deathTimer - dt
    if player.deathTimer < 0 then
      restartLevel()
    end
  end

  setPlayerMask()

  return true
end

function drawPlayer()
  love.graphics.setColor(0,1,0)
  love.graphics.rectangle("fill",player.x,player.y,player.w,player.h)
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill",player.mask_x,player.mask_y,
    player.mask_w,player.mask_h)
 --   love.graphics.draw(player.image,player.x,player.y,0,1.2,1.2)
end

function drawDeath()
  if player.death then 
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill",0,0,480,640)
    love.graphics.setColor(1,1,1)
  end
end