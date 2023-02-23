require("src.enemyManager")
require("src.player")

function loadLevel(dt)
  loadPlayer()
end

function updateLevel(dt)
  updateEnemies(dt)
  updatePlayer(dt)
end

function drawLevel()
  drawEnemies()
  drawPlayer()
end