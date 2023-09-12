require("src.enemyManager")
require("src.player")
require("src.bg")
require("src.collide")

local level = 1
local instanceCount

function restartLevel()
  restartBG()
  loadPlayer()
  loadEnemies()
end

function loadLevel(dt)
  loadBG(level)
  loadPlayer()
  loadEnemies()
end

function updateLevel(dt)
  updateBG(dt)
  updatePlayer(dt)
  updateEnemies(dt)
  
  instanceCount = getEnemyCount()+getBulletCount()+1
end

function drawLevel()
  drawBG()
  drawPlayer()
  drawEnemies()
  drawDeath()
  drawInstanceCount()
end

function drawInstanceCount()
  love.graphics.printf(instanceCount,0,0,500,"left")
end