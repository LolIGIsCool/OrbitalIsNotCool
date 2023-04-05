--Let all tools load before we create the blacklist-types.
timer.Simple(3,function(  )

	--Should the whole blacklist be disabled?
	local DisableBlacklist = false

	--Make sure all IgnoredTools are lowercase.
	for k,v in pairs(jBlacklist.BLConfig.IgnoredTools) do
		jBlacklist.BLConfig.IgnoredTools[k] = string.lower(v)
	end

	--Find all tools.
	local files = file.Find("weapons/gmod_tool/stools/*","LUA")

	for k,v in pairs(files) do

		--Get the name of the current tool.
		local tool = string.Left(v,#v - 4)

		--Check if the current tool should be ignored.
		if table.HasValue(jBlacklist.BLConfig.IgnoredTools,tool) then continue end

		--Make the first character uppercase.
		tool = string.upper(string.Left(tool,1)) .. string.Right(tool,#tool - 1)

		--[[-------------------------------------------------------------------------
		Create the blacklist.
		---------------------------------------------------------------------------]]

		--Create a new blacklist table to work in.
		local BLACKLIST = {}

		--Define some basic vars for the blacklist.
		BLACKLIST.Name = "[TOOL] " .. tool
		BLACKLIST.Enabled = v and !DisableBlacklist

		--Register the blacklist.
		jBlacklist.RegisterBL(BLACKLIST)

		--[[-------------------------------------------------------------------------
		Non-optional functions.
		---------------------------------------------------------------------------]]

		--Create a function to get the blacklist description.
		BLACKLIST.GetDescription = function(  )
			return jBlacklist.LoadedLanguage["BLACKLISTDESC_Tools"]
		end

		--Create a function to get the blacklist's blacklisted-phrase.
		BLACKLIST.GetBlacklistedPhrase = function()
			return jBlacklist.LoadedLanguage["BLACKLIST_TOOL"]
		end

	end

	--[[-------------------------------------------------------------------------
	Hooks
	---------------------------------------------------------------------------]]

	--jBlacklist.AddHook will only be called on the server. (It works the same)
	jBlacklist.AddHook("CanTool","jBlacklist_ToolsBlacklist",function( ply, _, tool )

		--Add this to prevent this action if the player's blacklists havent loaded in yet.
		if !ply.jBlacklist then return false end

		local ToolName = "[TOOL] " .. string.upper(string.Left(tool,1)) .. string.Right(tool,#tool - 1)

		if !jBlacklist.RegistredBlacklists[ToolName] then return end

		if ply:IsBlacklisted(jBlacklist.RegistredBlacklists[ToolName]) then

			jBlacklist.ShowBlacklistedPopup( ply, jBlacklist.RegistredBlacklists[ToolName] )

			return false

		end

	end)

end)


