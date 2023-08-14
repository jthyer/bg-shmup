require("src.enemyManager")
require("src.player")
require("src.bg")

function loadLevel(dt)
  loadBG()
  loadPlayer()
end

function updateLevel(dt)
  updateEnemies(dt)
  updatePlayer(dt)
end

function drawLevel()
  drawBG(1)
  drawEnemies()
  drawPlayer()
end