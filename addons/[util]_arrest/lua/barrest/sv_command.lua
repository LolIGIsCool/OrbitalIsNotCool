hook.Add("PlayerSay", "ArrestPositionCommand", function(ply, text)
	if not ply:IsSuperAdmin() then return end
	text = string.Explode(" ", string.lower(text))

	if text[1] == "/addjail" then
		-- local tr = ply:GetEyeTrace()
		-- if not IsValid(tr.Entity) then
		-- 	ply:PrintMessage(HUD_PRINTTALK, "You need to look at a valid door")
		-- 	return
		-- end

		local arrest = {}
		-- arrest.Door = tr.Entity:EntIndex()
		arrest.Position = ply:GetPos()

		table.insert(bArrest.Positions, arrest)
		bArrest.SavePositions()
		bArrest.NetworkPositions()
		ply:PrintMessage(HUD_PRINTTALK, "Created arrest position")
		return ""
	elseif text[1] == "/removejail" then
		local index = tonumber(text[2])
		if index and bArrest.Positions[index] then
			table.remove(bArrest.Positions, index)
			bArrest.SavePositions()
			bArrest.NetworkPositions()
			ply:PrintMessage(HUD_PRINTTALK, "Removed arrest position")
		end
		return ""
	elseif text[1] == "/listjail" then
		ply:PrintMessage(HUD_PRINTTALK, "Arrests:")
		for i, arrest in ipairs(bArrest.Positions) do
			ply:PrintMessage(HUD_PRINTTALK, "\t" .. tostring(i) .. ": " .. tostring(arrest.Position))
		end
		return ""
	end
end)