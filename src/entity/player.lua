local PLAYERSPEED = 240

local IMAGE = love.graphics.newImage("assets/sprites/player.png")

loadFunc["player"] = function(self)
  self.class = "player"
  self.width = 48
  self.height = 48
  self.mask = 24
  self.image = IMAGE
  self.rotation = 0
  
  setPlayerPos(self.x,self.y)
end

updateFunc["player"] = function(self,dt)
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
  if (self.x + hspeed > 0 and self.x + self.width + hspeed < SCREENWIDTH) then
    self.x = self.x + hspeed
  end
  if (self.y + vspeed > 0 and self.y + self.height + vspeed < SCREENHEIGHT) then
    self.y = self.y + vspeed
  end

  setPlayerPos(self.x,self.y)
  
  return true
end
