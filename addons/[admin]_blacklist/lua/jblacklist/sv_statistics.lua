util.AddNetworkString("jBlacklist_RequestStats")
util.AddNetworkString("jBlacklist_SendData")

--Create receiver for jBlacklist_RequestStats.
net.Receive("jBlacklist_RequestStats",function(_, ply )

	--Check if the user got the required rank.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( ply, "ACCESSADMINMENU" ) then return end

	--Check if we got a cooldown.
	if ply.jBlacklist.NetCooldown > CurTime() then return end

	--Set a cooldown for sending a new network message.
	ply.jBlacklist.NetCooldown = CurTime() + 0.5

	--Get the amount of issued blacklists.
	jBlacklist.Stats.GetIssued( function( Issued )

		--Check so we got a valid result.
		if Issued == false then Issued = "FAIL" end

		--Get the amount of removed blacklists.
		jBlacklist.Stats.GetRemoved( function( Removed )

			--Check so we got a valid result.
			if Removed == false then Removed = "FAIL" end

			--Get the most common blacklisttype.
			jBlacklist.Stats.GetCommon( function( Common )

				--Check so we got a valid result.
				if Common == false then Common = "FAIL" end

				jBlacklist.Stats.GetTop( function( Top )

					--Check so we got a valid result.
					if Top == false then Top = "FAIL" end

					--Send the information to the client.
					net.Start("jBlacklist_SendData")
						net.WriteTable({Issued = Issued, Removed = Removed, Common = Common, Top = Top})
					net.Send(ply)

				end )

			end )

		end )

	end )

end)

--Function to get the total issued.
function jBlacklist.Stats.GetIssued( callbackFunc )

	--Make sure we got a callbackFunc.
	callbackFunc = callbackFunc or function( ) end

	if jBlacklist.UseSQL == true then

		--Get the next Auto_increment ID.
		jBlacklist.SQLQuery("SHOW TABLE STATUS WHERE Name='jblacklist_blacklists'", function( _, data )

			if table.Count(data) == 0 then callbackFunc(0) return end

			--Return data.
			callbackFunc(tonumber(data[1]["Auto_increment"]) - 1)

		end, function( _, err )
			callbackFunc(0)
			jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )
		end)

	else

		--Get the next Auto_increment ID.
		jBlacklist.SQLQuery("SELECT seq FROM SQLITE_SEQUENCE WHERE name = 'jblacklist_blacklists'", function( _, data )

			if table.Count(data) == 0 then callbackFunc(0) return end

			--Return data.
			callbackFunc(tonumber(data[1]["seq"]))

		end, function( _, err )
			callbackFunc(0)
			jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )
		end)

	end

end

--Function to get the total removed.
function jBlacklist.Stats.GetRemoved( callbackFunc )

	--Make sure we got a callbackFunc.
	callbackFunc = callbackFunc or function( ) end

	--Get the amount of issued blacklists.
	jBlacklist.Stats.GetIssued( function( result )

		--Get the amount of rows.
		jBlacklist.SQLQuery("SELECT COUNT(*) FROM jblacklist_blacklists", function( _, data )

			if table.Count(data) == 0 then callbackFunc(0) return end

			--Return data.
			callbackFunc(result - tonumber(data[1]["COUNT(*)"]) )

		end, function( _, err )
			callbackFunc(0)
			jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )
		end)

	end )

end

--Function to get the most common blacklist.
function jBlacklist.Stats.GetCommon( callbackFunc )

	--Make sure we got a callbackFunc.
	callbackFunc = callbackFunc or function( ) end

	--Get the most common blacklist.
	jBlacklist.SQLQuery("SELECT TYPE, COUNT(TYPE) AS popularity FROM jblacklist_blacklists GROUP BY TYPE ORDER BY popularity DESC LIMIT 1", function( _, data )

		if table.Count(data) == 0 then callbackFunc(jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"]) return end

		--Return data.
		callbackFunc(data[1]["TYPE"])

	end, function( _, err )
		callbackFunc(jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"])
		jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )
	end)

end

--Function to get the top blacklister.
function jBlacklist.Stats.GetTop( callbackFunc )

	--Make sure we got a callbackFunc.
	callbackFunc = callbackFunc or function( ) end

	--Get the top blacklisters SteamID.
	jBlacklist.SQLQuery("SELECT ADMINID, COUNT(ADMINID) AS popularity FROM jblacklist_blacklists GROUP BY ADMINID ORDER BY popularity DESC LIMIT 1", function( _, data )

		if table.Count(data) == 0 then callbackFunc(jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"]) return end

		callbackFunc(util.SteamIDFrom64(data[1]["ADMINID"]))

	end, function( _, err )
		callbackFunc(jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"])
		jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )
	end)

end

--Function to get perplayer statistics.
function jBlacklist.Stats.GetPlayerStatistics( steamID, callbackFunc )

	--Make sure we got a callbackFunc.
	callbackFunc = callbackFunc or function( ) end

	--Convert the SteamID to a SteamID64.
	local steamID64 = steamID != "" and jBlacklist.Escape(util.SteamIDTo64(steamID)) or "ALL"

	--Make sure the conversion was successfull.
	if !steamID64 or steamID64 == "0" then callbackFunc( {Total = 0, Common = ""}, jBlacklist.LoadedLanguage["WARNING_READBLTABLE_FAIL"] .. " (" .. jBlacklist.LoadedLanguage["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] .. ")" ) return end

	local Query1, Query2

	if steamID64 == "ALL" then
		Query1 = "SELECT COUNT(*) FROM jblacklist_blacklists"
		Query2 = "SELECT TYPE, COUNT(TYPE) AS popularity FROM jblacklist_blacklists GROUP BY TYPE ORDER BY popularity DESC limit 1"
	else
		Query1 = "SELECT COUNT(*) FROM jblacklist_blacklists WHERE STEAMID64='" .. steamID64 .. "'"
		Query2 = "SELECT TYPE, COUNT(TYPE) AS popularity FROM jblacklist_blacklists WHERE STEAMID64='" .. steamID64 .. "' GROUP BY TYPE ORDER BY popularity DESC limit 1"
	end

	--Cache failfunc.
	local failfunc = function( _, err )

		callbackFunc({Total = 0, Common = ""})
		jBlacklist.ConNotify( "ALERT", "MySQL/SQLite query returned error: " .. err )

	end

	--perform SQL query.
	jBlacklist.SQLQuery(Query1, function( _, data )

		jBlacklist.SQLQuery(Query2, function( _, data2 )

			if !data[1] or !data2[1] or data[1]["COUNT(*)"] == 0 then
				callbackFunc({Total = 0, Common = ""})
			else
				callbackFunc({Total = data[1]["COUNT(*)"], Common = data2[1]["TYPE"]})
			end

		end, failfunc)

	end, failfunc)

end