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
    local target_x, target_y = getPlayerPos()
    local angle = math.atan2((target_y - e.y), (target_x - e.x))
  
    --e.rotation = angle + 1.571
  
    e.hspeed = 300 * math.cos(angle)
    e.vspeed = 300 * math.sin(angle)
  end,
  
  ["fire"] = function(e,bulletIndex)
    print("test")
    createEnemy("aimedBullet",e.x,e.y)
  end,
    
  
  ["break"] = function(e)
    e.active = false
  end,
}

return enemyBehavior