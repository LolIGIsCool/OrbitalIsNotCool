hook.Add("DarkRPFinishedLoading","jBlacklist_LoadOOCBL",function( )

	--[[-------------------------------------------------------------------------
	Create the blacklist.
	---------------------------------------------------------------------------]]

	--Create a new blacklist table to work in.
	local BLACKLIST = {}

	--Define some basic vars for the blacklist.
	BLACKLIST.Name = "OOC"
	BLACKLIST.Enabled = true

	--Register the blacklist.
	jBlacklist.RegisterBL(BLACKLIST)

	--[[-------------------------------------------------------------------------
	Non-optional functions.
	---------------------------------------------------------------------------]]

	--Create a function to get the blacklist description.
	BLACKLIST.GetDescription = function(  )
		return jBlacklist.LoadedLanguage["BLACKLISTDESC_DarkRPOOC"]
	end

	--Create a function to get the blacklist's blacklisted-phrase.
	BLACKLIST.GetBlacklistedPhrase = function()
		return jBlacklist.LoadedLanguage["BLACKLIST_OOC"]
	end

	--[[-------------------------------------------------------------------------
	Hooks
	---------------------------------------------------------------------------]]

	--Stop the player from respawning.
	jBlacklist.AddHook("PlayerSay","jBlacklist_OOCBlacklist",function( ply, text )

		--Add this to prevent this action if the player's blacklists havent loaded in yet.
		if !ply.jBlacklist then return "" end

		text = string.lower(text)

		if ply:IsBlacklisted(BLACKLIST) && (string.Left(text, 2) == "//" or string.Left(text, 4) == "/ooc") then

			jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

			return ""
		end

	end)

end)