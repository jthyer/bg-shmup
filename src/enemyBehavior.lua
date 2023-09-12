local enemyBehavior = {
  
  ["setSpeed"] = function(e)
    e.hspeed = e.behavior[e.behaviorItr][3]
    e.vspeed = e.behavior[e.behaviorItr][4] 
  end,
  
  ["setAccel"] = function(e)
    e.haccel = e.behavior[e.behaviorItr][3]
    e.vaccel = e.behavior[e.behaviorItr][4]
  end,
  
  ["moveTowardsPlayer"] = function(e)
    local b = e.behavior[e.behaviorItr]
    local target_x, target_y = getPlayerPos()
       
    local angle = math.atan2((target_y - e.y), (target_x - e.x))
    angle = angle + b[4]          -- add target offset
    --e.rotation = angle + 1.571  -- rotate bullet, add argument?
  
    e.hspeed = b[3] * math.cos(angle)
    e.vspeed = b[3] * math.sin(angle)
  end,
  
  ["fire"] = function(e)
    local b = e.behavior[e.behaviorItr]
    local bullet = createEnemy(b[3],e.x+16,e.y+16)
    if b[3] == "staticBullet" then
      bullet.hspeed = b[4][1]
      bullet.vspeed = b[4][2]
      bullet.haccel = b[4][3]
      bullet.vaccel = b[4][4]
    end
  end,
  
  ["break"] = function(e)
    e.active = false
  end,
}

return enemyBehavior