local SPEED = 300
local ACCEL = 120

local IMAGE = love.graphics.newImage("assets/sprites/popcorn.png")

loadFunc["popcorn"] = function(self)
  self.class = "enemy"
  self.width = 48
  self.height = 48
  self.mask = 32
  self.hspeed = SPEED
  self.vspeed = 0  
  self.image = IMAGE
  
  if self.x < 0 then 
    self.dir = 1
  else
    self.dir = -1
  end
end

updateFunc["popcorn"] = function(self,dt)
  self.x = self.x + (self.hspeed * self.dir * dt)
  self.y = self.y + (self.vspeed * dt)
 
  self.hspeed = self.hspeed - dt * ACCEL
  self.vspeed = self.vspeed + dt * ACCEL
  
  if self.y > SCREENHEIGHT then return false end
  
  return true
end