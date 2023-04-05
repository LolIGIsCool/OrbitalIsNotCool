--[[-------------------------------------------------------------------------
Data
---------------------------------------------------------------------------]]

--Boolean if a conversion is in progress.
local inProgress = false

--A variable that holds the current progress.
local currentProgress = 0
local progressPerPlayer = 0

--A table that will store all queries.
local Queries = {}

--[[-------------------------------------------------------------------------
Functions
---------------------------------------------------------------------------]]

--Create a function to start data conversion.
local function StartConvert( finishFunc )

	--Make sure the server is awake by adding a bot due to the GMod server being frozen if no player have joined. (Timers wont work, etc..)
	--Will be kicked in a sec.
	RunConsoleCommand( "bot" )

	timer.Simple(1,function(  )
		
		--Set inProgress to true.
		inProgress = true

		--Make some spacing in the console.
		print("\n\n\n")

		--Notify the console what's going on.
		print( "[JBLACKLIST] : [DATA CONVERSION] : A conversion of all 1.x.x playerdata to 2.x.x playerdata was started." )
		print( "[JBLACKLIST] : [DATA CONVERSION] : Data will be converted to: " .. (jBlacklist.UseSQL == true and "MySQL" or "SQLite"))

		--Loop through all players that are online.
		for k,v in pairs(player.GetAll()) do

			--Kick the player from the server.
			v:Kick("JBlacklist have started converting playerdata as a request by the servermanager...")

		end

		--Make sure that no one joins the server when a conversion is in progress.
		hook.Add("CheckPassword","jBlacklist_DataConverter_CheckPassword",function(  )
			return false, "JBlacklist is currently updating playerdata. Check the server console for more information..." .. "\n\nProgress: " .. math.Round(currentProgress) .. "%"
		end)

		--Notify the console that we kicked all players.
		print("[JBLACKLIST] : [DATA CONVERSION] : All players have been kicked.")

		--Call the finishFunc.
		finishFunc()

	end)

end

--Create a function to start preparing SQLQueries.
local function PrepareQueries( finishFunc )

	--Find all folders inside of the jblacklist folder.
	local _, dirs = file.Find("jblacklist/*","DATA")

	--Set the progressPerPlayer & currentProgress var.
	progressPerPlayer = 100 / #dirs
	currentProgress = 0

	--Reset the Queries table.
	Queries = {}

	--Create a variable that keeps track of what directory we are at.
	local LoopIndex = 0

	--Check if there even is something to convert.
	if #dirs == 0 then finishFunc() return end

	--Create a timer instead of a loop to make sure the server wont crash.
	timer.Create("jBlacklist_DataConverter",0.05,#dirs,function(  )

		--Add 1 to LoopIndex.
		LoopIndex = LoopIndex + 1

		--Create a variable for the current directory.
		local curDir = dirs[LoopIndex]

		--Check if the blacklists.txt file exists.
		if !file.Exists("jblacklist/" .. curDir .. "/blacklists.txt","DATA") then

			--Check if we were the last.
			if #dirs == LoopIndex then

				--Call the finishFunc.
				finishFunc()

			end

			currentProgress = currentProgress + progressPerPlayer

			return

		end

		--Read the blacklists.txt file.
		local blacklistsFile = file.Read("jblacklist/" .. curDir .. "/blacklists.txt", "DATA")

		--Get SteamID for the current user.
		local currentSteamID = util.SteamIDFrom64(curDir)

		--Check if the file is empty.
		if blacklistsFile == "" or blacklistsFile == "[]" then
			print( "[JBLACKLIST] : [DATA CONVERSION - " .. math.Round(currentProgress) .. "%] : Successfully to prepared player. (" .. currentSteamID .. ")")
			currentProgress = currentProgress + progressPerPlayer

			--Check if we were the last.
			if #dirs == LoopIndex then

				--Call the finishFunc.
				finishFunc()

			end

			return

		end

		--Convert the file from json to a table.
		local blacklistsTable = util.JSONToTable(blacklistsFile)

		--Make sure the convert was successfull.
		if !blacklistsTable then

			--Tell the console we failed.
			print( "[JBLACKLIST] : [DATA CONVERSION - " .. math.Round(currentProgress) .. "%] : Failed to prepare player. (" .. currentSteamID .. ")")

			currentProgress = currentProgress + progressPerPlayer

			--Check if we were the last.
			if #dirs == LoopIndex then

				--Call the finishFunc.
				finishFunc()

			end

			--Return
			return

		end

		--Clear unnceccessary keys.
		blacklistsTable = table.ClearKeys( blacklistsTable, true )

		--Create a local query.
		local Query = ""

		--Loop through all blacklists.
		for k,v in pairs(blacklistsTable) do

			if !isnumber(v.TIME) or !isnumber(v.DATE) or !isnumber(v.LASTUPDATE) then continue end

			--Add the blacklist to the query.
			Query = Query .. "('" .. curDir .. "', '" .. jBlacklist.Escape( v.TYPE ) .. "', '" .. jBlacklist.Escape( v.REASON ) .. "', " .. v.TIME .. ", " .. v.DATE .. ", " .. v.LASTUPDATE .. ", '" .. jBlacklist.Escape( util.SteamIDTo64(v.ADMIN) ) .. "'), \n"

		end

		--Insert the Query into the masterquery.
		if #Queries == 0 then
				Queries[1] = Query
		elseif #Queries[#Queries] + #Query > 5000000 then
			Queries[#Queries + 1] = Query
		else
			Queries[#Queries] = Queries[#Queries] .. Query
		end

		--Tell the console we succeeded.
		print( "[JBLACKLIST] : [DATA CONVERSION - " .. math.Round(currentProgress) .. "%] : Successfully prepared player. (" .. currentSteamID .. ")")

		--Add to progress.
		currentProgress = currentProgress + progressPerPlayer

		--Check if we were the last.
		if #dirs == LoopIndex then

			--Call the finishFunc.
			finishFunc()

		end

	end)

end

--Create a function to start sending the SQLQueries.
local function SendQueries( finishFunc )

	--Make sure that Queries got at least 1 key.
	if #Queries < 1 then

		print( "[JBLACKLIST] : [DATA CONVERSION - " .. math.Round(currentProgress) .. "%] : Data conversion finished.")

		finishFunc()

		return

	end

	print( "[JBLACKLIST] : [DATA CONVERSION - " .. math.Round(currentProgress) .. "%] : Performing queries. (DO NOT TURN OFF YOUR SERVER)")

	for k,v in pairs(Queries) do

		print( "[JBLACKLIST] : [DATA CONVERSION - " .. math.Round(currentProgress) .. "%] : Performing query " .. k .. "/" .. #Queries .. ".")

		v = string.Left(v,string.len(v) - 3)

		file.Write("query_" .. k .. ".txt","INSERT INTO jblacklist_blacklists(STEAMID64 TYPE, REASON, TIME, DATE, LASTUPDATE, ADMINID) VALUES " .. v)

		jBlacklist.SQLQuery( "INSERT INTO jblacklist_blacklists(STEAMID64, TYPE, REASON, TIME, DATE, LASTUPDATE, ADMINID) VALUES " .. v, function( )

			print( "[JBLACKLIST] : [DATA CONVERSION - " .. math.Round(currentProgress) .. "%] : Query #" .. k .. " was performed successfully.")

			if k == #Queries then
				finishFunc()
			end

		end, function( _, err )

			print("Error: ", err)

			print( "[JBLACKLIST] : [DATA CONVERSION - " .. math.Round(currentProgress) .. "%] : Failed to perform query #" .. k .. ".")

			if k == #Queries then
				finishFunc()
			end

		end )

	end



end

--Create a function to end the data conversion.
local function EndConvert( finishFunc )

	--Set inProgress to false.
	inProgress = false

	hook.Remove("CheckPassword","jBlacklist_DataConverter_CheckPassword")

	--Reset other vars.
	currentProgress = 0
	progressPerPlayer = 0
	Queries = {}

	print( "[JBLACKLIST] : [DATA CONVERSION - COMPLETE] : Data conversion have been completed. Your server is now open again...")

end

--[[-------------------------------------------------------------------------
Commands
---------------------------------------------------------------------------]]

local canStart = false

--Create a consolecommand used to start a convert of data.
concommand.Add("jblacklist_convertdata",function( ply )

	--Make sure that the command is only executed by the serverconsole.
	if IsValid(ply) then return end

	--Check if we are already performing this action.
	if inProgress == true then

		print("You are already performing this action...")

		return

	end

	--Check if we can start a data convert.
	if canStart == true then

		--Set canStart to false.
		canStart = false

		--Prepare the server for the conversion.
		StartConvert(function( )

			--Start preparing all SQLQueries.
			PrepareQueries( function( )

				--Send the queries.
				SendQueries(function(  )

					EndConvert()

				end)

			end )

		end)

	else

		local _, dirs = file.Find("jblacklist/*","DATA")

		--Make a gap above.
		print("\n\n\n\n\n\n\n\n\n\n\n")

		--Print the warningtext.
		print([[  |---------------------------------------------------------------|]])
		print([[  |    __        __                         _                     |]])
		print([[  |    \ \      / /   __ _   _ __   _ __   (_)  _ __     __ _     |]])
		print([[  |     \ \ /\ / /   / _` | | '__| | '_ \  | | | '_ \   / _` |    |]])
		print([[  |      \ V  V /   | (_| | | |    | | | | | | | | | | | (_| |    |]])
		print([[  |       \_/\_/     \__,_| |_|    |_| |_| |_| |_| |_|  \__, |    |]])
		print([[  |                                                     |___/     |]])
		print([[  |---------------------------------------------------------------|]])

		--Show some information to the console.
		Msg("\nYou are about to start a conversion of all version 1.x.x savedata to version 2.x.x savedata!\n\n")
		Msg("DO NOT TURN OFF YOUR SERVER DURING THE PROCESS. \n\n")
		Msg("This will kick all currently connected players on your server and can take a while to complete. ")
		Msg("No one will be able join your server while the data conversion is in progress. ")
		Msg("You will be able track the progress in the server console.\n\n")

		print("Conversion information:")
		print("There is around " .. #dirs .. " players that will be converted.")
		print("Convert from: File I/O")
		print("Convert to: " .. (jBlacklist.UseSQL == true and "MySQL" or "SQLite"))

		print("\n\nPlease make sure that the settings above are correct and that you have read everything. You can change how you want the information to be converted by enabling or disabling MySQL.")
		print("\nStart conversion by typing the command jblacklist_convertdata again...\n")

		--Set canStart to true.
		canStart = true

	end

end)