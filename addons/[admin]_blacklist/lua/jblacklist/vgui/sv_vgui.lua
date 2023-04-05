--Pool network messages.
util.AddNetworkString("jBlacklist_Issue")
util.AddNetworkString("jBlacklist_RequestUserData")
util.AddNetworkString("jBlacklist_UserDataAnswer")
util.AddNetworkString("jBlacklist_RemoveBlacklist")
util.AddNetworkString("jBlacklist_RequestBlacklistData")
util.AddNetworkString("jBlacklist_SendBlacklistData")
util.AddNetworkString("jBlacklist_UpdateBlacklistData")
util.AddNetworkString("jBlacklist_RequestBlacklistDetails")
util.AddNetworkString("jBlacklist_SendBlacklistDetails")
util.AddNetworkString("jBlacklist_RequestPersonalBlacklists")
util.AddNetworkString("jBlacklist_SendPersonalBlacklists")
util.AddNetworkString("jBlacklist_DataChange")
util.AddNetworkString("jBlacklist_EraseData")
util.AddNetworkString("jBlacklist_OpenConfigurator")
util.AddNetworkString("jBlacklist_ChangeConfig")
util.AddNetworkString("jBlacklist_StopLoading")

--Add a receiver for jBlacklist_Issue.
net.Receive("jBlacklist_Issue",function( _, ply )

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Check if the user got the required rank.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( ply, "CANISSUE" ) then return end

	--Read all the information from the client.
	local BlacklistTypes = net.ReadTable() or {}
	local Targets = net.ReadTable() or {}
	local BlacklistLength = math.Max(net.ReadInt(32) or 0, -1)
	local BlacklistReason = string.Left(net.ReadString() or "Reason", 200)
	local Silent = net.ReadBool() or false

	local TargetsCount = table.Count(Targets)
	local BlacklistTypesCount = table.Count(BlacklistTypes)

	--Check if the maximum amount of allowed BlacklistTypes or Targets was extended.
	if TargetsCount > 10 or BlacklistTypesCount > 20 then return end

	--Get the max length for how long this player can blacklist someone in seconds.
	local maxLength = jBlacklist.Configuration.GetUsergroupConfigValue( ply, "ISSUEMAXLENGTH" ) * 60

	if maxLength == false then
		maxLength = 240
	end

	--Check if the user got a limit for how long to blacklist someone and if the limit was extended.
	if maxLength != 0 and (BlacklistLength == -1 or BlacklistLength > maxLength) then

		local Message = jBlacklist.LoadedLanguage["LENGTH_CHANGED"]

		Message = string.Replace(Message,"%L",maxLength / 60)

		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_POPUP, Message, ply)
		BlacklistLength = maxLength

	end

	--Make sure we got any types.
	if BlacklistTypesCount == 0 or TargetsCount == 0 then return end

	--Loop through all types.
	for k,type in pairs(BlacklistTypes) do

		--Remove all types that are non existant.
		if !jBlacklist.RegistredBlacklists[type] then
			BlacklistTypes[k] = nil
		end

	end

	--Get the SteamID of the administrator.
	local adminID = ply:SteamID()

	--Add the blacklist.
	jBlacklist.DataMGT.AddBlacklist( table.Copy(Targets), table.Copy(BlacklistTypes), BlacklistReason, BlacklistLength, adminID, function( result, reason )

		--Add the blacklist and if it returns false the notify admin.
		if result == false then

			--Tell the client we failed.
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, reason, ply)

			return

		end

		--Cache formatedtime.
		local FormatedTime = jBlacklist.FormatBlacklistTime(BlacklistLength)

		--Tell the clients we got a datachange.
		jBlacklist.DataChange( Targets )

		--Attempt to replace steamIDs with playername if player is online.
		for k,v in pairs(Targets) do

			--Try to find the player if the player would be online.
			local playerEnt = player.GetBySteamID( v )

			--Check if the target is online.
			if playerEnt then

				--Reload the player.
				jBlacklist.LoadPlayer(playerEnt)

				if jBlacklist.Configuration.GetConfigValue( "NOTIFY_TARGET_ONISSUED" ) == true then

					--Create messagevar.
					local advertMessage = jBlacklist.LoadedLanguage["BLACKLISTED_PERSONAL"]

					--Replace tags.
					advertMessage = string.Replace(advertMessage,"%A",Silent and jBlacklist.Configuration.GetUsergroupConfigValue( playerEnt, "SEESILENCED" ) == false and "******" or ply:Name())
					advertMessage = string.Replace(advertMessage,"%P",playerEnt:Name())
					advertMessage = string.Replace(advertMessage,"%R",BlacklistReason)
					advertMessage = string.Replace(advertMessage,"%T",FormatedTime)
					advertMessage = string.Replace(advertMessage,"%B",table.concat( BlacklistTypes, ", " ))

					--Tell the player.
					jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, advertMessage, playerEnt)

					Targets[k] = player.GetBySteamID(v):Name()
				end

			end

		end

		--Run the hook jBlacklist_BlacklistIssued.
		hook.Run("jBlacklist_BlacklistIssued", ply, BlacklistTypes, Targets, BlacklistLength, BlacklistReason, Silent)

		if jBlacklist.Configuration.GetConfigValue( "NOTIFY_SERVER_ONISSUED" ) == false then return end

		--Create messagevar.
		local advertMessage = jBlacklist.LoadedLanguage["BLACKLISTED_ADVERT"]

		--Replace tags.
		advertMessage = string.Replace(advertMessage,"%A",ply:Name())
		advertMessage = string.Replace(advertMessage,"%P",table.concat( Targets, ", "))
		advertMessage = string.Replace(advertMessage,"%R",BlacklistReason)
		advertMessage = string.Replace(advertMessage,"%T",FormatedTime)
		advertMessage = string.Replace(advertMessage,"%B",table.concat( BlacklistTypes, ", " ))

		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_ADMIN, "ADMIN", ply:Name() .. " (" .. ply:SteamID() .. ") blacklisted (" .. table.concat( Targets, ", ") .. ") for " .. BlacklistReason .. ". (" .. table.concat( BlacklistTypes, ", " ) .. ") (" .. FormatedTime .. ")")

		--Check if the blacklist was silent.
		if Silent == true then

			--Create a table where we cache the usergroups permissions.
			local usergroupsCache = {}

			--Loop through all players.
			for k,v in pairs(player.GetAll()) do

				--Get the usergroup of the current player.
				local userGroup = v:GetUserGroup()

				--Check if we need to cache the value.
				if !usergroupsCache[userGroup] then

					--Cache the value.
					usergroupsCache[userGroup] = jBlacklist.Configuration.GetUsergroupConfigValue( v, "SEESILENCED" )

				end

				--Check if the player should receive a message.
				if usergroupsCache[userGroup] == true then
					jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT,advertMessage,v, true)
				end

			end

		else
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT,advertMessage)
		end

	end )

end)


--Add a receiver for jBlacklist_PageRequest.
net.Receive("jBlacklist_RequestUserData", function( _, ply )

	--[[-------------------------------------------------------------------------
	Validation.
	---------------------------------------------------------------------------]]

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Check if the user got the required rank.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( ply, "ACCESSADMINMENU" ) then return end

	--Read the requested SteamID.
	local Target = string.Left(net.ReadString() or "",30)
	local Page = math.Clamp(net.ReadUInt(8) or 1,1,200)

	--[[-------------------------------------------------------------------------
	Start loading of blacklist.
	---------------------------------------------------------------------------]]

	--Try to read data.
	jBlacklist.DataMGT.GetBlacklistPage( Target, Page, function( result, reason )

		--Check so we read the data correctly.
		if result == false then

			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, reason, ply)

		end

		jBlacklist.Stats.GetPlayerStatistics( Target, function( stats )

			--Send the info.
			net.Start("jBlacklist_UserDataAnswer")
				net.WriteTable(result == false or table.Count(result) == 0 and {} or result)
				net.WriteInt(Page,8)
				net.WriteUInt(stats.Total,15)
				net.WriteString(stats.Common or "")
			net.Send(ply)

		end )

	end )

end)

--Create receiver for jBlacklist_RemoveBlacklist.
net.Receive("jBlacklist_RemoveBlacklist",function( _, ply )

	--[[-------------------------------------------------------------------------
	Validation.
	---------------------------------------------------------------------------]]

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Check if the user got the required rank.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( ply, "CANREMOVE" ) then return end

	--Read data.
	local SteamID = string.Left(net.ReadString() or "",30)
	local BlacklistID = math.Max(net.ReadUInt(25) or 0,1)

	--[[-------------------------------------------------------------------------
	Start removing of blacklist.
	---------------------------------------------------------------------------]]

	--Try to remove blacklist.
	jBlacklist.DataMGT.RemoveBlacklist( SteamID, BlacklistID, function( result, reason )

		--Stop if we failed.
		if result == false then

			--Notify admin what happened.
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, reason, ply)

			return

		end

		--[[-------------------------------------------------------------------------
		Do other stuff..
		---------------------------------------------------------------------------]]

		--Update the admin.
		jBlacklist.DataChange( {SteamID} )

		--Create a advertMessage.
		local advertMessage = jBlacklist.LoadedLanguage["REMOVED_ADVERT"]

		--Replace tags.
		advertMessage = string.Replace(advertMessage,"%A",ply:Name())
		advertMessage = string.Replace(advertMessage,"%I",BlacklistID)

		--Try to get the playerEntity if the player was online.
		local playerEntity = player.GetBySteamID(SteamID)

		--Update player if the player was online.
		if playerEntity then
			jBlacklist.LoadPlayer(playerEntity)
			advertMessage = string.Replace(advertMessage,"%P",playerEntity:Name())
		else
			advertMessage = string.Replace(advertMessage,"%P",SteamID)
		end

		--Broadcast to players.
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, advertMessage)

		--Run the hook jBlacklist_BlacklistRemoved.
		hook.Run("jBlacklist_BlacklistRemoved", ply, SteamID, BlacklistID)

		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_ADMIN, "ADMIN", ply:Name() .. " (" .. ply:SteamID() .. ") removed a blacklist from " .. SteamID .. ". (BlacklistID: " .. BlacklistID .. ")")

	end )

end)

--Add a receiver for jBlacklist_RequestBlacklistData.
net.Receive("jBlacklist_RequestBlacklistData",function( _, ply )

	--[[-------------------------------------------------------------------------
	Validation
	---------------------------------------------------------------------------]]

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Read data.
	local SteamID = string.Left(net.ReadString() or "",30)
	local BlacklistID = math.Max(net.ReadUInt(25) or 0,1)

	--Check if the user got the required rank.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( ply, "CANMODIFYBLACKLIST" ) then SteamID = ply:SteamID() end

	--[[-------------------------------------------------------------------------
	Start loading of blacklist.
	---------------------------------------------------------------------------]]

	--Read blacklist.
	jBlacklist.DataMGT.GetBlacklistTable( SteamID, BlacklistID, function( result, reason )

		--Check so we read the data correctly.
		if result == false then jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, reason, ply) return end

		if !result[BlacklistID] then
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["WARNING_READBLTABLE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_BLNOTEXIST"] .. ")", ply)
			jBlacklist.StopLoading(ply)
			return
		end

		--[[-------------------------------------------------------------------------
		Start sending data.
		---------------------------------------------------------------------------]]

		--Start sending the data back to the client.
		net.Start("jBlacklist_SendBlacklistData")
			net.WriteString(result[BlacklistID].REASON)
			net.WriteInt(result[BlacklistID].TIME == -1 and -1 or result[BlacklistID].TIME - result[BlacklistID].LASTUPDATE,32)
		net.Send(ply)

	end )

end)

--Add receiver for jBlacklist_UpdateBlacklistData-
net.Receive("jBlacklist_UpdateBlacklistData",function( _, ply )

	--[[-------------------------------------------------------------------------
	Validation.
	---------------------------------------------------------------------------]]

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Check if the user got the required rank.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( ply, "CANMODIFYBLACKLIST" ) then return end

	--Read data.
	local BlacklistID = net.ReadUInt(25) or 0
	local SteamID = string.Left(net.ReadString() or "",30)
	local Reason = string.Left(net.ReadString() or "", 200)
	local Time = math.Clamp(net.ReadInt(32) or 0, -1, 2147483647)

	--Get the max length for how long this player can blacklist someone in seconds.
	local maxLength = jBlacklist.Configuration.GetUsergroupConfigValue( ply, "ISSUEMAXLENGTH" ) * 60

	if maxLength == false then
		maxLength = 240
	end

	--Check if the user got a limit for how long to blacklist someone and if the limit was extended.
	if maxLength != 0 and (Time == -1 or Time > maxLength) then

		local Message = jBlacklist.LoadedLanguage["LENGTH_CHANGED"]

		Message = string.Replace(Message,"%L",maxLength / 60)

		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_POPUP, Message, ply)
		Time = maxLength

	end

	--[[-------------------------------------------------------------------------
	Start loading of blacklist.
	---------------------------------------------------------------------------]]

	--Read blacklist.
	jBlacklist.DataMGT.GetBlacklistTable( SteamID, BlacklistID, function( result, reason )

		--Check so we read the data correctly.
		if result == false then

			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, reason, ply)
			return

		end

		--Update the time, lastupdate and reason of the blacklist.
		result[BlacklistID].TIME = Time == -1 and -1 or Time + os.time()
		result[BlacklistID].LASTUPDATE = os.time()
		result[BlacklistID].REASON = Reason

		--Update the blacklist.
		jBlacklist.DataMGT.UpdateBlacklist( SteamID, BlacklistID, result[BlacklistID], function( result2, reason2 )

			--Return if we failed.
			if result2 == false then

				jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, reason2, ply)
				return

			end

			--Try to find the player if the player is online.
			local playerEnt = player.GetBySteamID(SteamID)

			--Check if we found a player.
			if playerEnt then

				--Call the blacklist OnIssued function again if the blacklist had expired and how is active again.
				jBlacklist.RegistredBlacklists[result[BlacklistID].TYPE].OnIssued(playerEnt)

				--Reload the player.
				jBlacklist.LoadPlayer(playerEnt)

			end

			--Tell the clients we got a datachange.
			jBlacklist.DataChange( {SteamID} )

			--Run the hook jBlacklist_BlacklistModified.
			hook.Run("jBlacklist_BlacklistModified", ply, SteamID, BlacklistID, result[BlacklistID])

			jBlacklist.Log( JBLACKLIST_LOGGINGENUM_ADMIN, "ADMIN", ply:Name() .. " (" .. ply:SteamID() .. ") updated a blacklist from " .. SteamID .. ". (Reason: " .. Reason .. ") (Length: " .. jBlacklist.FormatBlacklistTime(Time) .. ") (BlacklistID: " .. BlacklistID .. ")")

		end )

	end )

end)

--Add a receiver for jBlacklist_RequestBlacklistDetails.
net.Receive("jBlacklist_RequestBlacklistDetails",function( _, ply )

	--[[-------------------------------------------------------------------------
	Validation.
	---------------------------------------------------------------------------]]

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Check if the user got the required rank.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( ply, "ACCESSADMINMENU" ) then return end

	--Read data.
	local SteamID = string.Left(net.ReadString() or "",30)
	local BlacklistID = math.Max(net.ReadUInt(25) or 1,1)

	--[[-------------------------------------------------------------------------
	Start loading of blacklist.
	---------------------------------------------------------------------------]]

	--Try to read blacklists.
	jBlacklist.DataMGT.GetBlacklistTable( SteamID, BlacklistID, function( result, reason )

		--Check if we read the file successfully.
		if result == false then
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, reason, ply)
			return
		end

		if !result[BlacklistID] then
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["WARNING_READBLTABLE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_BLNOTEXIST"] .. ")", ply)
			jBlacklist.StopLoading(ply)
			return
		end

		--[[-------------------------------------------------------------------------
		Send data to the client.
		---------------------------------------------------------------------------]]
		net.Start("jBlacklist_SendBlacklistDetails")
			net.WriteTable(result[BlacklistID])
		net.Send(ply)

	end )

end)

--Create receiver for jBlacklist_RequestPersonalBlacklists.
net.Receive("jBlacklist_RequestPersonalBlacklists",function( _, ply )

	--[[-------------------------------------------------------------------------
	Validation and data reading.
	---------------------------------------------------------------------------]]

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	local Page = math.Clamp(net.ReadUInt(8) or 1,1,200)

	--[[-------------------------------------------------------------------------
	Start loading of blacklist.
	---------------------------------------------------------------------------]]

	--Try to read data.
	jBlacklist.DataMGT.GetBlacklistPage( ply:SteamID(), Page, function( result, reason )

		--Check so we read the data correctly.
		if result == false then

			--Notify the user about the error.
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, reason, ply) jBlacklist.StopLoading(ply)

		end

		jBlacklist.Stats.GetPlayerStatistics( ply:SteamID(), function( stats )

			--Send the info.
			net.Start("jBlacklist_SendPersonalBlacklists")
				net.WriteTable(result == false or table.Count(result) == 0 and {} or result)
				net.WriteInt(Page,8)
				net.WriteUInt(stats.Total,15)
				net.WriteString(stats.Common or "")
			net.Send(ply)

		end )

	end )

end)

net.Receive("jBlacklist_EraseData",function( _, ply )

	--[[-------------------------------------------------------------------------
	Validation.
	---------------------------------------------------------------------------]]

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Check if the user got the required rank.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( ply, "ERASEDATA" ) then return end

	--Read data.
	local steamID = string.Left(net.ReadString() or "",30)

	--[[-------------------------------------------------------------------------
	Start removing blacklists.
	---------------------------------------------------------------------------]]

	jBlacklist.DataMGT.EraseBlacklists( steamID, function( result, reason )

		--[[-------------------------------------------------------------------------
		Do other stuff..
		---------------------------------------------------------------------------]]

		--Check if we succeeded.
		if result == true then

			jBlacklist.DataChange( {steamID} )

			--Create a advertMessage.
			local advertMessage = jBlacklist.LoadedLanguage["ERASED_ADVERT"]

			--Replace tags.
			advertMessage = string.Replace(advertMessage,"%A",ply:Name())

			--Try to get the playerEntity if the player was online.
			local playerEntity = player.GetBySteamID(steamID)

			--Update player if the player was online.
			if playerEntity then
				jBlacklist.LoadPlayer(playerEntity)
				advertMessage = string.Replace(advertMessage,"%P",playerEntity:Name() )
			else
				advertMessage = string.Replace(advertMessage,"%P",steamID )
			end

			--Broadcast to players.
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, advertMessage)

			--Run the hook jBlacklist_BlacklistsErased.
			hook.Run("jBlacklist_BlacklistsErased", ply, steamID)

			jBlacklist.Log( JBLACKLIST_LOGGINGENUM_ADMIN, "ADMIN", ply:Name() .. " (" .. ply:SteamID() .. ") erased all playerdata from " .. steamID .. ".")

		else

			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, reason, ply)

		end

	end )

end)

net.Receive("jBlacklist_OpenConfigurator",function( _, ply )

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Check if the user got the required rank.
	if !(jBlacklist.Configuration.GetUsergroupConfigValue( ply, "CANCONFIG" ) or ply:SteamID64() == jBlacklist.Owner) then jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, jBlacklist.LoadedLanguage["INFO_NOTAUTHORIZED"], ply) return end

	--Send a message to the client to open the configurator window & the current configuration to make sure the client haven't missed something.
	net.Start("jBlacklist_OpenConfigurator")
		net.WriteTable(jBlacklist.Configuration.Config)
		net.WriteTable(jBlacklist.Configuration.Usergroups)
	net.Send(ply)

end)

net.Receive("jBlacklist_ChangeConfig",function( _, ply )

	--[[-------------------------------------------------------------------------
	Validation.
	---------------------------------------------------------------------------]]

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Check if the user got the required rank.
	if !(jBlacklist.Configuration.GetUsergroupConfigValue( ply, "CANCONFIG" ) or ply:SteamID64() == jBlacklist.Owner) then
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, jBlacklist.LoadedLanguage["INFO_NOTAUTHORIZED"], ply)
		return
	end

	--Read data.
	local cfgTable = net.ReadTable() or {}

	--Create a boolean if the user reset the configuration or not.
	local didResetConfig = table.Count(cfgTable.Config) == 0

	--[[-------------------------------------------------------------------------
	Validate the table.
	---------------------------------------------------------------------------]]

	--Check so the table format is valid.
	if !cfgTable.Config or !cfgTable.Usergroups then return end

	--Make sure we only have Config and Usergroups.
	cfgTable = {Config = cfgTable.Config, Usergroups = cfgTable.Usergroups}

	--Make sure Config and Usergroups are tables and not something else.
	if !istable(cfgTable.Config) or !istable(cfgTable.Usergroups) then return end

	--Create a table with all enums and their function.
	local ConfigTypes = {
		{JBLACKLIST_CONFIG_BOOL, isbool},
		{JBLACKLIST_CONFIG_STRING, isstring},
		{JBLACKLIST_CONFIG_NUMBER, isnumber},
	}

	--Check so no unvalid keys exists in cfgTable.Config.
	for k,v in pairs(cfgTable.Config) do

		--Check if the key is valid.
		if !jBlacklist.Configurator.Config[k] then

			--Remove unvalid data.
			cfgTable.Config[k] = nil

			--Continue to the next value.
			continue

		end

		--Check if the value is accepted if it's a table.
		if jBlacklist.Configurator.Config[k].ConfigType == JBLACKLIST_CONFIG_TABLE and !table.HasValue(jBlacklist.Configurator.Config[k].AcceptedValues,v) then

				--Remove unvalid data.
				cfgTable.Config[k] = nil

				--Continue to the next value.
				continue

		end

		--Loop through to check if the value given is of the right type.
		for _,v2 in pairs(ConfigTypes) do

			--Check if the value is of the right type.
			if jBlacklist.Configurator.Config[k].ConfigType == v2[1] and !v2[2](v) then

				--Remove unvalid data.
				cfgTable.Config[k] = jBlacklist.Configurator.Config[k].Value

			end

		end

	end

	--Check so no unvalid keys exists any of the usergroups in cfgTable.Usergroups.
	for k,v in pairs(cfgTable.Usergroups) do

		--Check so the value is a table.
		if !istable(v) then cfgTable.Usergroups[k] = nil continue end

		--Loop through each usergroup.
		for k2,v2 in pairs(v) do

			--Check if the key is valid.
			if !jBlacklist.Configurator.Usergroups[k2] then

				--Remove unvalid data.
				cfgTable.Usergroups[k][k2] = nil

				--Continue to the next usergroup.
				continue

			end

			--Check if the value is accepted if it's a table.
			if jBlacklist.Configurator.Usergroups[k2].ConfigType == JBLACKLIST_CONFIG_TABLE and !table.HasValue(jBlacklist.Configurator.Usergroups[k2].AcceptedValues,v2) then

					--Remove unvalid data.
					cfgTable.Usergroups[k][k2] = nil

					--Continue to the next value.
					continue

			end

			--Loop through to check if the value given is of the right type.
			for _,v3 in pairs(ConfigTypes) do

				--Check if the value is of the right type.
				if jBlacklist.Configurator.Usergroups[k2].ConfigType == v3[1] and !v3[2](v2) then

					--Remove unvalid data.
					cfgTable.Usergroups[k][k2] = jBlacklist.Configurator.Usergroups[k2].Value

				end

			end

		end

	end

	--[[-------------------------------------------------------------------------
	Logging
	---------------------------------------------------------------------------]]

	--Make sure cfgTable.Config["LOGGING"] is set to something.
	cfgTable.Config["LOGGING"] = cfgTable.Config["LOGGING"] or jBlacklist.Configurator.Config["LOGGING"].Value

	if didResetConfig == false then

		--Log that the config was modified.
		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_OTHER, "INFO", ply:Name() .. " ("  .. ply:SteamID() ..  ")" .. " modified the jBlacklist configuration." )

	end

	--Check if the user reset the configuration.
	if didResetConfig == true then

		--Send a warning to the console that the logging config was modified.
		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_OTHER, "WARNING", ply:Name() .. " ("  .. ply:SteamID() ..  ")" .. " reset the jBlacklist configuration.")


	--Check if the user made any changes to logging in the configuration.
	elseif jBlacklist.Configuration.Config["LOGGING"] != cfgTable.Config["LOGGING"] then

		--Send a warning to the console that the logging config was modified.
		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_OTHER, "WARNING", ply:Name() .. " ("  .. ply:SteamID() ..  ")" .. " set the jBlacklist logging config to: " .. cfgTable.Config["LOGGING"] .. (cfgTable.Config["LOGGING"] == "None" and " (Further actions will not be logged)" or ""))

	end

	--[[-------------------------------------------------------------------------
	Save and load the new config.
	---------------------------------------------------------------------------]]

	--Save the config.
	jBlacklist.Configuration.SaveConfig( cfgTable )

	--Load the config.
	jBlacklist.Configuration.LoadConfig(  )

	--[[-------------------------------------------------------------------------
	Other
	---------------------------------------------------------------------------]]

	jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_CHAT, "Configuration has been updated successfully.", ply)

end)

--[[-------------------------------------------------------------------------
Functions
---------------------------------------------------------------------------]]

--Create a function to tell the player that it needs to stop it's loading animation..
function jBlacklist.StopLoading( ply )

	net.Start("jBlacklist_StopLoading")
	net.Send(ply)

end

--Create a function to tell the players that a datachange occoured.
function jBlacklist.DataChange( SteamIDTbl )

	net.Start("jBlacklist_DataChange")
		net.WriteTable(SteamIDTbl)
	net.Broadcast()

end

--[[-------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------]]

--Create a hook for all commands.
hook.Add("PlayerSay","jBlacklist_ChatCommands",function( ply, text )

	--Check if command was ran.
	if string.lower(text) == jBlacklist.Configuration.GetConfigValue( "ADMINCMD" ):lower() then
		ply:ConCommand("jblacklist_openadmin")
	elseif string.lower(text) == jBlacklist.Configuration.GetConfigValue( "OVERVIEWCMD" ):lower() then
		ply:ConCommand("jblacklist_openoverview")
	elseif string.lower(text) == "!jblacklist_config" then

		if !(jBlacklist.Configuration.GetUsergroupConfigValue( ply, "CANCONFIG" ) or ply:SteamID64() == jBlacklist.Owner) then return end

		net.Start("jBlacklist_OpenConfigurator")
			net.WriteTable(jBlacklist.Configuration.Config)
			net.WriteTable(jBlacklist.Configuration.Usergroups)
		net.Send(ply)

	end

end)

--Create a hook to open the newupdate window for server owners.
hook.Add("PlayerInitialSpawn","jBlacklist_NewUpdateWindow",function( ply )

	--Check if the user is the owner of the script.
	if ply:SteamID64() == jBlacklist.Owner and ply:GetPData("jBlacklist_SeenSetup",-1) == -1 then
		ply:ConCommand("jblacklist_setup")
		ply:SetPData("jBlacklist_SeenSetup",jBlacklist.Version)
	end

end)