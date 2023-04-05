--Add a hook to load the blacklist when DarkRP have finished loading.
hook.Add("loadCustomDarkRPItems","jBlacklist_LoadAdvertBlacklist",function( )

	--[[-------------------------------------------------------------------------
	Create the blacklist.
	---------------------------------------------------------------------------]]

	--Create a new blacklist table to work in.
	local BLACKLIST = {}

	--Define some basic vars for the blacklist.
	BLACKLIST.Name = "[DarkRP] Advert"
	BLACKLIST.Enabled = true

	--Register the blacklist.
	jBlacklist.RegisterBL(BLACKLIST)

	--[[-------------------------------------------------------------------------
	Non-optional functions.
	---------------------------------------------------------------------------]]

	--Create a function to get the blacklist description.
	BLACKLIST.GetDescription = function(  )
		return jBlacklist.LoadedLanguage["BLACKLISTDESC_DarkRPAdvert"]
	end

	--Create a function to get the blacklist's blacklisted-phrase.
	BLACKLIST.GetBlacklistedPhrase = function()
		return jBlacklist.LoadedLanguage["BLACKLIST_CANADVERT"]
	end

	--[[------------------------------------------------------------------------
	Hooks
	---------------------------------------------------------------------------]]

	--jBlacklist.AddHook will only be called on the server. (It works the same)
	jBlacklist.AddHook("canAdvert","jBlacklist_LoadAdvertBlacklist",function( ply )

		--Add this to prevent this action if the player's blacklists havent loaded in yet.
		if !ply.jBlacklist then return false end

		if ply:IsBlacklisted(BLACKLIST) then

			jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

			return false

		end

	end)

	--Stop the player from saying "/advert" and "!advert"
	jBlacklist.AddHook("PlayerSay","jBlacklist_AdvertBlacklist",function( ply, text )

		--Add this to prevent this action if the player's blacklists havent loaded in yet.
		if !ply.jBlacklist then return "" end

		text = string.Left( string.lower(text), 7 )

		if ply:IsBlacklisted(BLACKLIST) && text == "/advert" or text == "!advert" then

			jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

			return ""
		end

	end)

end)
