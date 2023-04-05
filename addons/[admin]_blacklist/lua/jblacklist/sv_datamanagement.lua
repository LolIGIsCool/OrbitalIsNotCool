--[[-------------------------------------------------------------------------
User Management
---------------------------------------------------------------------------]]

--Create a function to check if a steamID is valid.
function jBlacklist.DataMGT.SteamIDIsValid( steamID )

	--Check so we got a steamID.
	if !steamID then return false end

	--Return if the steamID now only have numbers. (Using ToString to make sure we got a string and not nil, a table, etc)
	return string.match(tostring(steamID),"^STEAM_%d:%d:%d+$") != nil

end

--[[-------------------------------------------------------------------------
Blacklist Management
---------------------------------------------------------------------------]]

--Create a function to get a blacklist table.
function jBlacklist.DataMGT.GetBlacklistTable( steamID, ID, callbackFunc )

	--Create a callbackfunction if none was given.
	callbackFunc = callbackFunc or function( ) end

	--[[-------------------------------------------------------------------------
	Data Validation
	---------------------------------------------------------------------------]]

	--Check so we got all arguments.
	if !steamID then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_READBLTABLE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_MISSINGARGS"] .. ")" ) return end

	--Check so the argument is of the right type.
	if !isstring(steamID) and (ID and !IsNumber(ID) or false) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_READBLTABLE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_WRONGDATATYPE"] .. ")" ) return end

	--Check so the steamid is valid.
	if !jBlacklist.DataMGT.SteamIDIsValid( steamID ) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_READBLTABLE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	--[[-------------------------------------------------------------------------
	Start reading data.
	---------------------------------------------------------------------------]]

	--Convert the SteamID to a SteamID64.
	local steamID64 = jBlacklist.Escape(util.SteamIDTo64(steamID))

	--Make sure the conversion was successfull.
	if !steamID64 or steamID64 == "0" then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_READBLTABLE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	--Create a variable that will hold the next query.
	local nextQuery

	--Check if we want to return the whole table or a single blacklist.
	if ID then
		nextQuery = "SELECT * FROM jblacklist_blacklists WHERE ID=" .. ID
	else
		nextQuery = "SELECT * FROM jblacklist_blacklists WHERE STEAMID64='" .. steamID64 .. "'"
	end

	--Peform query.
	jBlacklist.SQLQuery(nextQuery, function( _, data )

		local Blacklists = {}

		--Format the table.
		for k,v in pairs(data) do

			v.ID = tonumber(v.ID)
			v.TIME = tonumber(v.TIME)
			v.DATE = tonumber(v.DATE)
			v.LASTUPDATE = tonumber(v.LASTUPDATE)
			v.STEAMID = util.SteamIDFrom64(v.STEAMID64)
			v.STEAMID64 = nil

			--Add the blacklist to the Blacklists table.
			Blacklists[v.ID] = v

			--Replace ADMINID with ADMIN and convert from SteamID64.
			Blacklists[v.ID].ADMIN = Blacklists[v.ID].ADMINID == "CONSOLE" and "CONSOLE" or util.SteamIDFrom64(Blacklists[v.ID].ADMINID)

			--Remove some values.
			Blacklists[v.ID].ADMINID = nil
			Blacklists[v.ID].ID = nil

		end

		--Check what we read.
		if table.Count(Blacklists) == 0 then
			callbackFunc({},jBlacklist.LoadedLanguage["WARNING_READBLTABLE_SUCCESS"])
		else
			callbackFunc(Blacklists,jBlacklist.LoadedLanguage["WARNING_READBLTABLE_SUCCESS"])
		end

	end, function( _, err )
		callbackFunc(false, jBlacklist.LoadedLanguage["WARNING_READBLTABLE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")")
		jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )

		--Log the error.
		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_OTHER, "ERROR", jBlacklist.LoadedLanguage["WARNING_READBLTABLE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")" )
	end)

end

--Create a function to get a page of blacklists.
function jBlacklist.DataMGT.GetBlacklistPage( steamID, page, callbackFunc )

	--Create a callbackfunction if none was given.
	callbackFunc = callbackFunc or function( ) end

	--[[-------------------------------------------------------------------------
	Data Validation
	---------------------------------------------------------------------------]]

	--Check so we got all arguments.
	if !steamID or !page then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_GETBLPAGE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_MISSINGARGS"] .. ")" ) return end

	--Check so the argument is of the right type.
	if !isstring(steamID) or !isnumber(page) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_GETBLPAGE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_WRONGDATATYPE"] .. ")" ) return end

	--Check so the steamid is valid.
	if !jBlacklist.DataMGT.SteamIDIsValid( steamID ) and steamID != "" then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_GETBLPAGE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	--Make sure page is not less than 1.
	page = math.max(page, 1)

	--[[-------------------------------------------------------------------------
	Start reading data.
	---------------------------------------------------------------------------]]

	--Convert the SteamID to a SteamID64.
	local steamID64 = steamID != "" and jBlacklist.Escape(util.SteamIDTo64(steamID)) or "ALL"

	--Make sure the conversion was successfull.
	if !steamID64 or steamID64 == "0" then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_GETBLPAGE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	local Query

	if steamID64 == "ALL" then
		Query = "SELECT * FROM jblacklist_blacklists ORDER BY ID DESC limit " .. 20 * (page - 1) .. ",20"
	else
		Query = "SELECT * FROM jblacklist_blacklists WHERE STEAMID64='" .. steamID64 .. "' ORDER BY ID DESC limit " .. 20 * (page - 1) .. ",20"
	end


	--Update the blacklist.
	jBlacklist.SQLQuery(Query, function( _, data )

		local Blacklists = {}

		--Format the table.
		for k,v in pairs(data) do

			v.ID = tonumber(v.ID)
			v.TIME = tonumber(v.TIME)
			v.DATE = tonumber(v.DATE)
			v.LASTUPDATE = tonumber(v.LASTUPDATE)

			--Add the blacklist to the Blacklists table.
			Blacklists[v.ID] = v

			--Replace ADMINID with ADMIN and convert from SteamID64.
			Blacklists[v.ID].ADMIN = Blacklists[v.ID].ADMINID == "CONSOLE" and "CONSOLE" or util.SteamIDFrom64(Blacklists[v.ID].ADMINID)

			--Remove some values.
			Blacklists[v.ID].ADMINID = nil
			Blacklists[v.ID].ID = nil

		end

		--Check what we read.
		if table.Count(Blacklists) == 0 then
			callbackFunc({},jBlacklist.LoadedLanguage["WARNING_GETBLPAGE_SUCCESS"])
		else
			callbackFunc(Blacklists,jBlacklist.LoadedLanguage["WARNING_GETBLPAGE_SUCCESS"])
		end

	end, function( _, err )

		callbackFunc(false, jBlacklist.LoadedLanguage["WARNING_GETBLPAGE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")")
		jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )

		--Log the error.
		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_OTHER, "ERROR", jBlacklist.LoadedLanguage["WARNING_GETBLPAGE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")" )

	end)

end

--Create function to create a new blacklist.
function jBlacklist.DataMGT.AddBlacklist( targets, types, reason, length, adminID, callbackFunc )

	--Create a callbackfunction if none was given.
	callbackFunc = callbackFunc or function( ) end

	--[[-------------------------------------------------------------------------
	Data Validation
	---------------------------------------------------------------------------]]

	--Validate arguments.
	if !targets or !types or !reason or !length or !adminID then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_MISSINGARGS"] .. ")" ) return end
	if !istable(targets) or !istable(types) or !isstring(reason) or !isnumber(length) or !isstring(adminID) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_WRONGDATATYPE"] .. ")" ) return end
	if adminID != "CONSOLE" and !jBlacklist.DataMGT.SteamIDIsValid( adminID ) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	--Make sure the targets or types tables are not empty.
	if table.Count(targets) == 0 or table.Count(types) == 0 then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_WRONGDATATYPE"] .. ")" ) return end

	--Make sure all targets are valid.
	for k,v in pairs(targets) do

		--Make sure the value is valid.
		if !isstring(v) or !jBlacklist.DataMGT.SteamIDIsValid( v ) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

		--Convert the SteamID to a SteamID64.
		targets[k] = jBlacklist.Escape(util.SteamIDTo64(v))

		--Make sure the conversion was successfull.
		if !targets[k] or targets[k] == "0" then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	end

	--Make sure all types are valid.
	for k,v in pairs(types) do

		--Make sure the value is valid.
		if !isstring(v) or !jBlacklist.RegistredBlacklists[v] then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_TYPENOTEXIST"] .. ")" ) return end

		types[k] = jBlacklist.Escape(v)

	end

	--Escape all values.
	reason = jBlacklist.Escape(reason)
	adminID = adminID == "CONSOLE" and adminID or jBlacklist.Escape(util.SteamIDTo64(adminID))

	--Make sure the conversion was successfull.
	if !adminID or adminID == "0" then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	--[[-------------------------------------------------------------------------
	Start making the query
	---------------------------------------------------------------------------]]

	--Create a var to store the query in.
	local Query = "INSERT INTO jblacklist_blacklists(STEAMID64, TYPE, REASON, TIME, DATE, LASTUPDATE, ADMINID) VALUES"

	--Create a template for the query.
	local QueryTemplate = "', '" .. reason .. "', " .. (length == -1 and -1 or math.Clamp(length + os.time(), -1, 2147483647)) .. ", " .. os.time() .. ", " .. os.time() .. ", '" .. adminID .. "')"

	for k,v in pairs(targets) do

		for k2, v2 in pairs(types) do

			--Add into query.
			Query = Query .. "('" .. v .. "', '" .. v2 .. QueryTemplate .. ", "

		end

	end

	--Remove the last colon.
	Query = string.Left(Query,#Query - 2)

	--Create errorFunc.
	local errorFunc = function( err )
		callbackFunc(false, jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")")
		jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )

		--Log the error.
		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_OTHER, "ERROR", jBlacklist.LoadedLanguage["WARNING_ADDBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")" )
	end

	--Peform a SQL query.
	jBlacklist.SQLQuery(Query, function(  )

		--Loop through the targets.
		for k,v in pairs(targets) do

			--Try to find the player if the player would be online.
			local playerEnt = player.GetBySteamID( util.SteamIDFrom64(v) )

			--Check if the target is online.
			if playerEnt then

				--Call blacklist OnIssued functions.
				for k2, v2 in pairs(types) do
					jBlacklist.RegistredBlacklists[v2].OnIssued(playerEnt)
				end

			end

		end

		--Return.
		callbackFunc( true, jBlacklist.LoadedLanguage["WARNING_ADDBL_SUCCESS"] )

	end, function( _, err )
		errorFunc(err)
	end)


end

--Create a function to update a blacklist.
function jBlacklist.DataMGT.UpdateBlacklist( steamID, blacklistID, blacklistData, callbackFunc )

	--Create a callbackfunction if none was given.
	callbackFunc = callbackFunc or function( ) end

	--[[-------------------------------------------------------------------------
	Data Validation
	---------------------------------------------------------------------------]]

	--Check so we got all required arguments.
	if !steamID or !blacklistID or !blacklistData then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_UPDATEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_MISSINGARGS"] .. ")" ) return end

	--Check so the arguments are of the right type.
	if !isstring(steamID) or !isnumber(blacklistID) or !istable(blacklistData)  then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_UPDATEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_WRONGDATATYPE"] .. ")" ) return end

	--Check so the table have all the required data.
	if !blacklistData.REASON or !blacklistData.TIME then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_UPDATEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTBLFORMAT"] .. ")" ) return end

	--Check so the arguments are of the right type.
	if !isstring(blacklistData.REASON) or !isnumber(blacklistData.TIME)  then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_UPDATEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_WRONGDATATYPE"] .. ")" ) return end


	--Check so the steamid starts with STEAM_
	if !jBlacklist.DataMGT.SteamIDIsValid( steamID ) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_UPDATEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	--[[-------------------------------------------------------------------------
	Start updating blacklist.
	---------------------------------------------------------------------------]]

	--Escape all strings to avoid SQL injection.
	steamID = jBlacklist.Escape(steamID)
	blacklistData.REASON = jBlacklist.Escape(blacklistData.REASON)

	--Check if the BlacklistID exists.
	jBlacklist.DataMGT.GetBlacklistTable( steamID, blacklistID, function( result, reason )

		--Check so we executed the function successfully.
		if result == false then
			callbackFunc(false, reason)
			return
		end

		--Check if the BlacklistID exists.
		if table.Count(result) == 0 then
			callbackFunc(false, jBlacklist.LoadedLanguage["WARNING_UPDATEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_BLNOTEXIST"] .. ")")
			return
		end

		--Update the blacklist.
		jBlacklist.SQLQuery("UPDATE jblacklist_blacklists SET REASON='" .. blacklistData.REASON .. "', TIME=" .. blacklistData.TIME .. ", LASTUPDATE=" .. os.time() .. " WHERE ID=" .. blacklistID, function(  )
			callbackFunc(true, jBlacklist.LoadedLanguage["WARNING_UPDATEBL_SUCCESS"])
		end, function( _, err )
			callbackFunc(false, jBlacklist.LoadedLanguage["WARNING_UPDATEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")")
			jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )

			--Log the error.
			jBlacklist.Log( JBLACKLIST_LOGGINGENUM_OTHER, "ERROR", jBlacklist.LoadedLanguage["WARNING_UPDATEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")" )

		end)

	end )

end

--Create a function to remove a blacklist.
function jBlacklist.DataMGT.RemoveBlacklist( steamID, blacklistID, callbackFunc )

	--Create a callbackfunction if none was given.
	callbackFunc = callbackFunc or function( ) end

	--[[-------------------------------------------------------------------------
	Data Validation
	---------------------------------------------------------------------------]]

	--Check so we got all required arguments.
	if !steamID or !blacklistID then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_REMOVEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_MISSINGARGS"] .. ")" ) return end

	--Check so the arguments are of the right type.
	if !isstring(steamID) or !isnumber(blacklistID) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_REMOVEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_WRONGDATATYPE"] .. ")" ) return end

	--Check so the steamid starts with STEAM_
	if !jBlacklist.DataMGT.SteamIDIsValid( steamID ) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_REMOVEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	--[[-------------------------------------------------------------------------
	Start removing blacklist.
	---------------------------------------------------------------------------]]

	--Remove the blacklist.
	jBlacklist.SQLQuery("DELETE FROM jblacklist_blacklists WHERE ID = " .. blacklistID, function(  )
		callbackFunc(true, jBlacklist.LoadedLanguage["WARNING_REMOVEBL_SUCCESS"])
	end, function( _, err )
		callbackFunc(false, jBlacklist.LoadedLanguage["WARNING_REMOVEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")")
		jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )

		--Log the error.
		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_OTHER, "ERROR", jBlacklist.LoadedLanguage["WARNING_REMOVEBL_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")" )
	end)

end

--Create a function to erase all blacklists from a player.
function jBlacklist.DataMGT.EraseBlacklists( steamID, callbackFunc )

	--Create a callbackfunction if none was given.
	callbackFunc = callbackFunc or function( ) end

	--[[-------------------------------------------------------------------------
	Data Validation
	---------------------------------------------------------------------------]]

	--Check so we got all required arguments.
	if !steamID then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ERASEBLACKLISTS_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_MISSINGARGS"] .. ")" ) return end

	--Check so the arguments are of the right type.
	if !isstring(steamID) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ERASEBLACKLISTS_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_WRONGDATATYPE"] .. ")" ) return end

	--Check so the steamid starts with STEAM_
	if !jBlacklist.DataMGT.SteamIDIsValid( steamID ) then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ERASEBLACKLISTS_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	--[[-------------------------------------------------------------------------
	Start removing blacklist.
	---------------------------------------------------------------------------]]

	--Convert the SteamID to a SteamID64.
	local steamID64 = jBlacklist.Escape(util.SteamIDTo64(steamID))

	--Make sure the conversion was successfull.
	if !steamID64 or steamID64 == "0" then callbackFunc( false, jBlacklist.LoadedLanguage["WARNING_ERASEBLACKLISTS_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	--Remove the blacklist.
	jBlacklist.SQLQuery("DELETE FROM jblacklist_blacklists WHERE STEAMID64 = '" .. steamID64 .. "'", function(  )
		callbackFunc(true, jBlacklist.LoadedLanguage["WARNING_ERASEBLACKLISTS_SUCCESS"])
	end, function( _, err)

		callbackFunc(false, jBlacklist.LoadedLanguage["WARNING_ERASEBLACKLISTS_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")")
		jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )

		--Log the error.
		jBlacklist.Log( JBLACKLIST_LOGGINGENUM_OTHER, "ERROR", jBlacklist.LoadedLanguage["WARNING_ERASEBLACKLISTS_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_SQLERROR"] .. ")" )

	end)

end