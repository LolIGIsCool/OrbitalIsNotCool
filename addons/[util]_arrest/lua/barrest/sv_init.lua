bArrest.LoadPositions()
bArrest.Players = {}

local meta = FindMetaTable("Player")

function meta:CanArrest()
	return true
end