require("src.enemyManager")
require("src.player")
require("src.bg")
require("src.collide")

local level = 1

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
end

function drawLevel()
  drawBG()
  drawPlayer()
  drawEnemies()
end