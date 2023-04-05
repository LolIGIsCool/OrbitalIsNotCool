--Create a table to store all consolecommands.
local ConsoleCommands = {}

--Create function to register consolecommands.
function jBlacklist.RegisterConCMD( cmdTbl )

	-- Make sure we have all needed arguments.
	cmdTbl.ID = cmdTbl.ID or "UNNAMED"
	cmdTbl.Args = cmdTbl.Args or {}

	-- Function that will run on command execution.
	cmdTbl.OnRun = cmdTbl.OnRun or function( ) end

	ConsoleCommands[cmdTbl.ID] = cmdTbl

end

--Create concommand to control jBlacklist from the console
concommand.Add("jblacklist",function( ply, cmd, args, argStr )

	--Check if ply is valid.
	if IsValid(ply) then jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, "This command can only be executed in the server console.", ply) return end

	-- Make all arguments lowercase.
	for k,v in pairs(args) do
		args[k] = string.lower(v)
	end

	--Save the command as the key will be removed.
	local cmdID = args[1] or ""

	--Remove key 1 from args.
	args[1] = nil

	--Call clearkeys to make key 2, key 1, etc.
	args = table.ClearKeys(args)

	-- Check so the command was valid.
	if ConsoleCommands[cmdID] then

		--Check so we arent missing any args.
		if #args < #ConsoleCommands[cmdID].Args then
			print("Command Usage: jblacklist " .. cmdID .. " " .. "<" .. table.concat(ConsoleCommands[cmdID].Args, "> <") .. ">")
		else

			--Loop through args.
			for i = 1,#args do

				--Make sure the argument exists.
				if !ConsoleCommands[cmdID].Args[i] then args[i] = nil continue end

				--Change the key of the value.
				args[ConsoleCommands[cmdID].Args[i]] = args[i]

				--Remove the old value.
				args[i] = nil

			end

			--Call the command's onRun function.
			ConsoleCommands[cmdID].OnRun(ply, args)

		end

	else
		print("Available jBlacklist commands are:")
		for k,v in pairs(ConsoleCommands) do
			print("jblacklist " .. k .. " " .. "<" .. table.concat(v.Args, "> <") .. ">")
		end
	end

end,function() end,"A way to control jBlacklist from the console.")


--[[-------------------------------------------------------------------------
Create consolecommands.
---------------------------------------------------------------------------]]

--Create 'jblacklist list' consolecommand.
jBlacklist.RegisterConCMD({
	ID = "list",
	Args = {"SteamID", "Page"},
	OnRun = function ( ply, args, target )

		--Convert args["page"] to number.
		args["Page"] = tonumber(args["Page"])

		--Make the steamID uppercase.
		args["SteamID"] = string.upper(args["SteamID"])

		--Check if all arguments were right.
		if jBlacklist.DataMGT.SteamIDIsValid( args["SteamID"] ) == false  then
			jBlacklist.ConNotify("ERROR", "Invalid SteamID. (Try using quotation marks around each argument)")
			return
		elseif !args["Page"] then
			jBlacklist.ConNotify("ERROR", "Invalid Page. (Try using quotation marks around each argument)")
			return
		end

		--Get the page.
		jBlacklist.DataMGT.GetBlacklistPage( args["SteamID"], args["Page"], function( result )

			if result == false then
				jBlacklist.ConNotify("ALERT", reason)
				return
			end

			local HeaderString = "[[ jBlacklist - Overview - " .. args["SteamID"] .. " - Page: " .. args["Page"] .. " ]]"
			local surroundingString = ""

			for i = 1,#HeaderString do
				surroundingString = surroundingString .. "_"
			end

			print(surroundingString)
			print(HeaderString .. "\n")
			print("Type 'jblacklist show <blacklistID>' to show more\ninformation about a specific blacklist.\n")
			print("ID | Type | Time Left\n")

			if table.Count(result) == 0 then
				print("There are no blacklists on page " .. math.Clamp(args["Page"],1,999) .. ".")
			end

			for k,v in SortedPairs(result, true) do

				print(k .. " | " .. v.TYPE .. " | " .. (v.TIME == -1 and "Permanent" or v.TIME - os.time() <= 0 and "Expired" or jBlacklist.FormatBlacklistTime( v.TIME - os.time() )))

			end

			print(surroundingString)

		end )

	end
})

--Create 'jblacklist show' consolecommand.
jBlacklist.RegisterConCMD({
	ID = "show",
	Args = {"BlacklistID"},
	OnRun = function ( ply, args, target )

		--Convert args["BlacklistID"] to number.
		args["BlacklistID"] = tonumber(args["BlacklistID"])

		--Check if all arguments were right.
		if !args["BlacklistID"] then
			jBlacklist.ConNotify("ERROR", "Invalid BlacklistID.")
			return
		end

		--Make sure the ID isnt negative.
		args["BlacklistID"] = math.max(args["BlacklistID"], 1)

		--Get the blacklist.
		jBlacklist.DataMGT.GetBlacklistTable( "STEAM_0:0:0", args["BlacklistID"], function( result, reason )

			if result == false then
				jBlacklist.ConNotify("ALERT", reason)
				return
			end

			local HeaderString = "[[ jBlacklist - Blacklist Info - BlacklistID: " .. args["BlacklistID"] .. " ]]"
			local surroundingString = ""

			for i = 1,#HeaderString do
				surroundingString = surroundingString .. "_"
			end

			print(surroundingString)
			print(HeaderString .. "\n")

			if table.Count(result) == 0 then
				print("There are no blacklists with BlacklistID " .. args["BlacklistID"] .. ".\n")
			else

				result[args["BlacklistID"]].TIME = result[args["BlacklistID"]].TIME 

				print("ID: " .. args["BlacklistID"])
				print("SteamID: " .. result[args["BlacklistID"]].STEAMID)
				print("Type: " .. result[args["BlacklistID"]].TYPE)
				print("Reason: " .. result[args["BlacklistID"]].REASON)
				print("Given On: " .. os.date( "%H:%M:%S - %d/%m/%Y" , result[args["BlacklistID"]].DATE ))
				print("Time Left: " .. (result[args["BlacklistID"]].TIME == - 1 and "Permanent" or result[args["BlacklistID"]].TIME - os.time() <= 0 and "Expired" or jBlacklist.FormatBlacklistTime( result[args["BlacklistID"]].TIME - os.time() )))
				print("Given By: " .. result[args["BlacklistID"]].ADMIN)

			end

			print(surroundingString)

		end )

	end
})

--Create 'jblacklist add' consolecommand.
jBlacklist.RegisterConCMD({
	ID = "add",
	Args = {"SteamID", "Types", "Length:Hours", "Reason", "Silent"},
	OnRun = function ( ply, args, target )

		--Convert args["Length:Hours"] into number.
		args["Length:Hours"] = tonumber(args["Length:Hours"])

		--Convert args["Silent"] into boolean.
		args["Silent"] = tobool(args["Silent"])

		--Convert args["Types"] into a table.
		args["Types"] = string.Explode(",", args["Types"])

		--Make the steamID uppercase.
		args["SteamID"] = string.upper(args["SteamID"])

		--Make sure the args["Reason"] isnt longer than 50 characters.
		args["Reason"] = string.Left(args["Reason"], 50)

		--Check if all arguments were right.
		if jBlacklist.DataMGT.SteamIDIsValid( args["SteamID"] ) == false  then
			jBlacklist.ConNotify("ERROR", "Invalid SteamID. (Try using quotation marks around each argument)")
			return
		elseif !args["Length:Hours"] then
			jBlacklist.ConNotify("ERROR", "Invalid length. (Try using quotation marks around each argument)")
			return
		end

		--Check so we got any types.
		if table.Count(args["Types"]) == 0 or table.Count(args["Types"]) > 15 then return end

		--Make sure all types are valid.
		for k,v in pairs(args["Types"])	do

			--Try to find a matching type.
			for _,v2 in pairs(table.GetKeys(jBlacklist.RegistredBlacklists)) do
				if string.lower(v2) == string.lower(v) then
					args["Types"][k] = v2
				end
			end

			if !jBlacklist.RegistredBlacklists[args["Types"][k]] then
				args["Types"][k] = nil
				jBlacklist.ConNotify("ERROR", "Invalid type: " .. v)
				return
			end

		end

		--Check if we got any types left.
		if table.Count(args["Types"]) == 0 then
			jBlacklist.ConNotify("ERROR", "Invalid types.")
			return
		end

		--Add the blacklist.
		jBlacklist.DataMGT.AddBlacklist( {args["SteamID"]}, args["Types"], args["Reason"], math.Max(args["Length:Hours"] * 3600, -1), "CONSOLE", function( result, reason )

			jBlacklist.ConNotify("INFO", reason)

			--Add the blacklist and if it returns false, notify admin.
			if result == true then

				--Tell the clients we got a datachange.
				jBlacklist.DataChange( {args["SteamID"]}, "Console" )

				--Cache formatedtime.
				local FormatedTime = jBlacklist.FormatBlacklistTime(math.Max(args["Length:Hours"] * 3600, -1))

				--Try to find the player if the player would be online.
				local playerEnt = player.GetBySteamID( args["SteamID"] )

				--Check if the target is online.
				if playerEnt then

					--Reload the player.
					jBlacklist.LoadPlayer(playerEnt)

					--Check if a message should be sent.
					if jBlacklist.Configuration.GetConfigValue( "NOTIFY_TARGET_ONISSUED" ) == true then

						--Create messagevar.
						local advertMessage = jBlacklist.LoadedLanguage["BLACKLISTED_PERSONAL"]

						--Replace tags.
						advertMessage = string.Replace(advertMessage,"%A",args["Silent"] and jBlacklist.Configuration.GetUsergroupConfigValue( playerEnt, "SEESILENCED" ) == false and "******" or "CONSOLE")
						advertMessage = string.Replace(advertMessage,"%P",playerEnt:Name())
						advertMessage = string.Replace(advertMessage,"%R",args["Reason"])
						advertMessage = string.Replace(advertMessage,"%T",FormatedTime)
						advertMessage = string.Replace(advertMessage,"%B",table.concat( args["Types"], ", " ))

						--Tell the player.
						jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, advertMessage, playerEnt)

						args["SteamID"] = playerEnt:Name()

					end

				end

				if jBlacklist.Configuration.GetConfigValue( "NOTIFY_SERVER_ONISSUED" ) == false then return end

				--Create messagevar.
				local advertMessage = jBlacklist.LoadedLanguage["BLACKLISTED_ADVERT"]

				--Replace tags.
				advertMessage = string.Replace(advertMessage,"%A","CONSOLE")
				advertMessage = string.Replace(advertMessage,"%P",args["SteamID"])
				advertMessage = string.Replace(advertMessage,"%R",args["Reason"])
				advertMessage = string.Replace(advertMessage,"%T",FormatedTime)
				advertMessage = string.Replace(advertMessage,"%B",table.concat( args["Types"], ", " ))

				if args["Silent"] == true then

					--Create a table of all players that should receive the message.
					local receivingPlayers = {}

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

			end

		end )

	end
})

--Create 'jblacklist remove' consolecommand.
jBlacklist.RegisterConCMD({
	ID = "remove",
	Args = {"SteamID", "BlacklistID"},
	OnRun = function ( ply, args, target )

		--Make the steamID uppercase.
		args["SteamID"] = string.upper(args["SteamID"])

		--Convert args["BlacklistID"] to number.
		args["BlacklistID"] = tonumber(args["BlacklistID"])

		--Check if all arguments were right.
		if jBlacklist.DataMGT.SteamIDIsValid( args["SteamID"] ) == false  then
			jBlacklist.ConNotify("ERROR", "Invalid SteamID. (Try using quotation marks around each argument)")
			return
		elseif !args["BlacklistID"] then
			jBlacklist.ConNotify("ERROR", "Invalid BlacklistID.")
			return
		end

		--Make sure the ID isnt negative.
		args["BlacklistID"] = math.max(args["BlacklistID"], 1)

		--Get the blacklist.
		jBlacklist.DataMGT.RemoveBlacklist( args["SteamID"], args["BlacklistID"], function( result, reason )

			jBlacklist.ConNotify("INFO", reason)

			--Stop if we failed.
			if result == false then return end

			--[[-------------------------------------------------------------------------
			Do other stuff..
			---------------------------------------------------------------------------]]

			--Update the admin.
			jBlacklist.DataChange( {args["SteamID"]}, "Console" )

			--Create a advertMessage.
			local advertMessage = jBlacklist.LoadedLanguage["REMOVED_ADVERT"]

			--Replace tags.
			advertMessage = string.Replace(advertMessage,"%A","CONSOLE")
			advertMessage = string.Replace(advertMessage,"%I",args["BlacklistID"])

			--Try to get the playerEntity if the player was online.
			local playerEntity = player.GetBySteamID(args["SteamID"])

			--Update player if the player was online.
			if playerEntity then
				jBlacklist.LoadPlayer(playerEntity)
				advertMessage = string.Replace(advertMessage,"%P",playerEntity:Name())
			else
				advertMessage = string.Replace(advertMessage,"%P",args["SteamID"])
			end

			--Broadcast to players.
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, advertMessage)

		end )

	end
})


--[[-------------------------------------------------------------------------
Other console commands.
---------------------------------------------------------------------------]]
concommand.Add("jblacklist_getvehicleclass",function( ply )

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Get the entity.
	local traceEnt = ply:GetEyeTrace().Entity

	--Make sure that the entity is valid and that it's a vehicle.
	if !IsValid(traceEnt) or !traceEnt:IsVehicle() then
		ply:PrintMessage(HUD_PRINTCONSOLE,"[JBLACKLIST] : [Info] : This is not a vehicle.")
		return
	end

	--Print the vehicleclass for the player.
	jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_CHAT, traceEnt:GetClass(), ply)

end)