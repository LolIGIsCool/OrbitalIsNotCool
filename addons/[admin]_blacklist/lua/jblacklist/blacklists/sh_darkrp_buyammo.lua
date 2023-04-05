--Add a hook to load the blacklist when DarkRP have finished loading.
hook.Add("loadCustomDarkRPItems","jBlacklist_LoadBuyAmmoBlacklist",function( )

	--[[-------------------------------------------------------------------------
	Create the blacklist.
	---------------------------------------------------------------------------]]

	--Create a new blacklist table to work in.
	local BLACKLIST = {}

	--Define some basic vars for the blacklist.
	BLACKLIST.Name = "[DarkRP] Buy Ammo"
	BLACKLIST.Enabled = true

	--Register the blacklist.
	jBlacklist.RegisterBL(BLACKLIST)

	--[[-------------------------------------------------------------------------
	Non-optional functions.
	---------------------------------------------------------------------------]]

	--Create a function to get the blacklist description.
	BLACKLIST.GetDescription = function(  )
		return jBlacklist.LoadedLanguage["BLACKLISTDESC_DarkRPBuyAmmo"]
	end

	--Create a function to get the blacklist's blacklisted-phrase.
	BLACKLIST.GetBlacklistedPhrase = function()
		return jBlacklist.LoadedLanguage["BLACKLIST_BUYAMMO"]
	end

	--[[-------------------------------------------------------------------------
	Optional functions.
	---------------------------------------------------------------------------]]

	--jBlacklist.AddHook will only be called on the server. (It works the same)
	jBlacklist.AddHook("canBuyAmmo","jBlacklist_LoadBuyAmmoBlacklist",function( ply )

		--Add this to prevent this action if the player's blacklists havent loaded in yet.
		if !ply.jBlacklist then return false, true end

		if ply:IsBlacklisted(BLACKLIST) then

			jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

			return false, true

		end

	end)

end)
