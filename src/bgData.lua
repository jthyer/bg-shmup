NUMLEVELS = 1
SCREENTILEWIDTH = 15
SCREENTILEHEIGHT = 20

local json = require("lib.json")
local bgData = {}

for level = 1,NUMLEVELS do
  table.insert(bgData,{})
  local raw = love.filesystem.read("levels/level"..tostring(level)..".json")
  local jsonData = json.decode(raw)

  local tileTable = jsonData["layers"][1]["data"]

  for i = 1, 20 do
    local row = {}
    for i2 = 1, 15 do
      table.insert(row,tileTable[i2+((i-1)*15)])
    end
    table.insert(bgData[level],row)
  end
  
  --for y=1,20 do for x=1,15 do print(x..","..y..","..bgData[1][y][x])  end end
end

return bgData