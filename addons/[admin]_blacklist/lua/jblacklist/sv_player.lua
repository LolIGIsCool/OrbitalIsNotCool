--[[-------------------------------------------------------------------------
Functions
---------------------------------------------------------------------------]]

--Adding function to load player data.
function jBlacklist.LoadPlayer( ply )

	--[[-------------------------------------------------------------------------
	Check for expired blacklists.
	---------------------------------------------------------------------------]]

	local InitialLoad = ply.jBlacklist == nil
	local previousBlacklists = InitialLoad == false and table.Copy(ply.jBlacklist.Blacklists) or {}

	--[[-------------------------------------------------------------------------
	Setup player
	---------------------------------------------------------------------------]]

	--Create storage table in the player entity.
	ply.jBlacklist = ply.jBlacklist or { Blacklists = {}, NetCooldown = 0, MsgCooldowns = {} }

	--[[-------------------------------------------------------------------------
	Load blacklists.
	---------------------------------------------------------------------------]]

	--Print a console notification that we are loading the data of the player.
	os.print(jBlacklist.LoadedLanguage["INFO_LOADINGDATA"] .. " (" .. ply:Name() .. ")")

	--Get all the blacklists.
	jBlacklist.DataMGT.GetBlacklistTable(ply:SteamID(), nil, function( result, reason )

		--Check so we read all blacklists successfully.
		if result == false then
			if reason != jBlacklist.LoadedLanguage["WARNING_GETALLBL_NOTHINGTOREAD"] then jBlacklist.ConNotify("ALERT", jBlacklist.LoadedLanguage["WARNING_LOADPLAYER_FAIL"] .. " (" .. ply:SteamID() .. ")") end
			return
		end

		--Reset the Blacklists subtable.
		ply.jBlacklist.Blacklists = {}

		--Loop through all the blacklists.
		for k,v in pairs(result) do

			--Check if the blacklist have expired.
			if v.TIME < os.time() and v.TIME != -1 then continue end

			--Make sure we got a value.
			ply.jBlacklist.Blacklists[v.TYPE] = ply.jBlacklist.Blacklists[v.TYPE] or 0

			--Load the blacklist.
			ply.jBlacklist.Blacklists[v.TYPE] = v.TIME == -1 and -1 or ply.jBlacklist.Blacklists[v.TYPE] == -1 and -1 or math.max(ply.jBlacklist.Blacklists[v.TYPE], v.TIME)

		end

		--[[-------------------------------------------------------------------------
		Do other stuff.
		---------------------------------------------------------------------------]]

		if InitialLoad == false then

			for k,v in pairs(previousBlacklists) do

				if !ply.jBlacklist.Blacklists[k] then

					--Set the advertMEssage.
					local AdvertMessage = jBlacklist.LoadedLanguage["BLACKLIST_EXPIRED"]

					--Replace tags with their information.
					AdvertMessage = string.Replace(AdvertMessage,"%B",k)

					--INform the player that their blacklist has expired.
					jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_POPUP, AdvertMessage , ply)

					--Call the OnExpire function.
					jBlacklist.RegistredBlacklists[k].OnExpire(ply)

				end

			end

		end

		if InitialLoad == true then
			--Run the hook jBlacklist_InitialPlayerLoaded.
			hook.Run("jBlacklist_InitialPlayerLoaded", ply)
		end

		--Run the hook jBlacklist_PlayerLoaded.
		hook.Run("jBlacklist_PlayerLoaded", ply)

	end)

end

--Adding hook to load playerdata.
hook.Add("PlayerAuthed","jBlacklist_LoadPlayerData",function( ply )

		--Load the player's data.
		jBlacklist.LoadPlayer(ply)

end)

--ADd a timer that will check if a blacklist has expired.
timer.Create("jBlacklist_CheckHasExpired",300,0,function(  )

	--Loop through all players on the server.
	for _, ply in pairs(player.GetAll()) do

		if !ply.jBlacklist then continue end

		--Loop through their jBlacklist.Blacklists table.
		for type, expireDate in pairs(ply.jBlacklist.Blacklists) do

			--Check if the blacklist have expired.
			if expireDate < os.time() and expireDate != -1 then

				--Remove the blacklist from the user's loaded blacklists.
				ply.jBlacklist.Blacklists[type] = nil

				--Set the advertMEssage.
				local AdvertMessage = jBlacklist.LoadedLanguage["BLACKLIST_EXPIRED"]

				--Replace tags with their information.
				AdvertMessage = string.Replace(AdvertMessage,"%B",type)

				--INform the player that their blacklist has expired.
				jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_POPUP, AdvertMessage , ply)

				--Call the OnExpire function.
				jBlacklist.RegistredBlacklists[type].OnExpire(ply)

			end

		end

	end

end)