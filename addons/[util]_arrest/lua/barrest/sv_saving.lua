local fileName = string.format("barrest_%s.txt", game.GetMap())

function bArrest.SavePositions()
	file.Write(fileName, util.TableToJSON(bArrest.Positions))
end

function bArrest.LoadPositions()
	local arrests = file.Read(fileName, "DATA")
	if not arrests or #arrests == 0 then
		bArrest.Positions = {}
	else
		bArrest.Positions = util.JSONToTable(arrests) or {}
	end
end