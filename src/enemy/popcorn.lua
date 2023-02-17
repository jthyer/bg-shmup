local SPEED = 300
local ACCEL = 120
local IMAGE = love.graphics.newImage("assets/sprites/popcorn.png")

loadEnemyFunc["popcorn"] = function(self)
  self.class = "enemy"
  self.width = 48
  self.height = 48
  self.mask = 32
  self.hspeed = SPEED
  self.vspeed = 0  
  self.image = IMAGE
  self.rotation = 0
  self.bulletTimer = 1
  
  if self.x < 0 then 
    self.dir = 1
  else
    self.dir = -1
  end
end

updateEnemyFunc["popcorn"] = function(self,dt)
  self.x = self.x + (self.hspeed * self.dir * dt)
  self.y = self.y + (self.vspeed * dt)
 
  self.hspeed = self.hspeed - dt * ACCEL
  self.vspeed = self.vspeed + dt * ACCEL
  
  if self.bulletTimer >= 0 then
    self.bulletTimer = self.bulletTimer - dt
    if self.bulletTimer < 0 then
      local target_x, target_y = getPlayerPos()
      --addBullet("bullet",self.x,self.y,target_x,target_y)
    end
  end
  
  if self.y > SCREENHEIGHT then return false end
  
  return true
end