local SPEED = 300
local IMAGE = love.graphics.newImage("assets/sprites/popcorn.png")

loadFunc["bullet"] = function(self,target_x,target_y)
  self.class = "bullet"
  self.width = 48
  self.height = 48
  self.mask = 32
  self.hspeed = SPEED
  self.vspeed = 0  
  self.image = IMAGE
  
  local angle = math.atan2((self.target_y - self.y), (self.target_x - self.x))
  
  self.rotation = angle + 1.571
  
  self.hspeed = SPEED * math.cos(angle)
  self.vspeed = SPEED * math.sin(angle)
end

updateFunc["bullet"] = function(self,dt)
  self.x = self.x + (self.hspeed * dt)
  self.y = self.y + (self.vspeed * dt)
  
  return true
end