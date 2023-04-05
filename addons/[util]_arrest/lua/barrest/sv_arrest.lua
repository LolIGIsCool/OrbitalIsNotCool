function bArrest.Arrest(ply, arrester)
	local timeEnd = CurTime() + bArrest.Config.Time
	local tbl = {Player = ply, Time = CurTime(), TimeEnd = timeEnd}
	local index = table.insert(bArrest.Players, tbl)
	local cell = ((index - 1) % #bArrest.Positions) + 1
	tbl.Cell = cell
	ply:SetPos(bArrest.Positions[cell].Position)
	ply:PrintMessage(HUD_PRINTTALK, "You have been arrested by " .. arrester:Nick() .. ".")
	bArrest.NetworkPlayers()
	ply:StripWeapons()
	ply.Arrested = timeEnd
	
	net.Start("ArrestedPly")
		net.WriteString(ply:Nick())
	net.Send()
	if not arrester.ArrestedPlayers then
		arrester.ArrestedPlayers = {}
	end
	table.insert(arrester.ArrestedPlayers, ply:SteamID64())
	PrintTable(arrester.ArrestedPlayers)
	
	
	-- Timer has been disabled as per request
	-- timer.Simple(bArrest.Config.Time, function()
	-- 	if IsValid(ply) and ply.Arrested == timeEnd then
	-- 		bArrest.UnArrest(ply)
	-- 	end
	-- end)
	hook.Call("onArrest", nil, arrester, ply)
end

local respawn_timer = 1 -- How long it takes to set the position of the player after the spawn function is called

function bArrest.UnArrest(ply, unarrester)
	for i, player in pairs(bArrest.Players) do
		if ply == player.Player then
			local pos = ply:GetPos()

			bArrest.Players[i] = nil
			ply.Arrested = false
			ply:Spawn()
			ply:SetPos(pos)
			hook.Add( "PostRegimentLoad", "PostRegimentLoad.Arrest" .. ply:SteamID(), function( target )
				if target == ply then
					ply:SetPos(pos)
					hook.Remove( "PostRegimentLoad", "PostRegimentLoad.Arrest" .. ply:SteamID() )
				end
			end )
			bArrest.NetworkPlayers()
			break
		end
	end
	if IsValid( unarrester ) then
		hook.Call("onUnArrest", nil, unarrester, ply)
	end
end
