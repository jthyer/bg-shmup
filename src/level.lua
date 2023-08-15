require("src.enemyManager")
require("src.player")
require("src.bg")

local level = 1


function loadLevel(dt)
  loadBG(level)
  loadPlayer()
end

function updateLevel(dt)
  updateBG(dt)
  updateEnemies(dt)
  updatePlayer(dt)
end

function drawLevel()
  drawBG()
  drawEnemies()
  drawPlayer()
end