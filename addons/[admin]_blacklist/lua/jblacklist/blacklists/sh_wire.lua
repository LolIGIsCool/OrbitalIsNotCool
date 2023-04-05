--[[-------------------------------------------------------------------------
Create the blacklist.
---------------------------------------------------------------------------]]

--Create a new blacklist table to work in.
local BLACKLIST = {}

--Define some basic vars for the blacklist.
BLACKLIST.Name = "Wiremod"
BLACKLIST.Enabled = true

--Register the blacklist.
jBlacklist.RegisterBL(BLACKLIST)

--[[-------------------------------------------------------------------------
Non-optional functions.
---------------------------------------------------------------------------]]

--Create a function to get the blacklist description.
BLACKLIST.GetDescription = function(  )
	return jBlacklist.LoadedLanguage["BLACKLISTDESC_WireMod"]
end

--Create a function to get the blacklist's blacklisted-phrase.
BLACKLIST.GetBlacklistedPhrase = function()
	return jBlacklist.LoadedLanguage["BLACKLIST_WIREMOD"]
end

--[[-------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------]]

--jBlacklist.AddHook will only be called on the server. (It works the same)
jBlacklist.AddHook("CanTool","jBlacklist_WiremodBlacklist",function( ply, _, tool )

	--Add this to prevent this action if the player's blacklists havent loaded in yet.
	if !ply.jBlacklist then return false end

	if ply:IsBlacklisted(BLACKLIST) && string.Left(tool, 5) == "wire_" then

		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

		return false

	end

end)
