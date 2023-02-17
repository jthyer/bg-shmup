local SPEED = 300
local ACCEL = 120

local IMAGE = love.graphics.newImage("assets/sprites/popcorn.png")

loadFunc["turret"] = function(self)
  self.class = "enemy"
  self.width = 48
  self.height = 48
  self.mask = 32
  self.hspeed = SPEED
  self.vspeed = 0  
  self.image = IMAGE
end

updateFunc["turret"] = function(self,dt)

  if self.y > SCREENHEIGHT then return false end
  
  return true
end