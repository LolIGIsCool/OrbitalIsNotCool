--[[-------------------------------------------------------------------------
Create the blacklist.
---------------------------------------------------------------------------]]

--Create a new blacklist table to work in.
local BLACKLIST = {}

--Define some basic vars for the blacklist.
BLACKLIST.Name = "Vehicles"
BLACKLIST.Enabled = true

--Register the blacklist.
jBlacklist.RegisterBL(BLACKLIST)

--[[-------------------------------------------------------------------------
Non-optional functions.
---------------------------------------------------------------------------]]

--Create a function to get the blacklist description.
BLACKLIST.GetDescription = function(  )
	return jBlacklist.LoadedLanguage["BLACKLISTDESC_Vehicles"]
end

--Create a function to get the blacklist's blacklisted-phrase.
BLACKLIST.GetBlacklistedPhrase = function()
	return jBlacklist.LoadedLanguage["BLACKLIST_VEHICLES"]
end

--[[-------------------------------------------------------------------------
Optional functions.
---------------------------------------------------------------------------]]

--Creating function that will be called when a blacklist is issued. (Only called if target is online)
BLACKLIST.OnIssued = function( ply )

	if ply:InVehicle() then
		ply:ExitVehicle()
	end

end

--[[-------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------]]

jBlacklist.AddHook("PlayerEnteredVehicle","jBlacklist_VehicleBlacklist",function( ply, vec )

	--Add this to prevent this action if the player's blacklists havent loaded in yet.
	if !ply.jBlacklist then ply:ExitVehicle() return end

	if ply:IsBlacklisted(BLACKLIST) && vec:GetDriver() == ply && !table.HasValue(jBlacklist.BLConfig.ClassWhitelist, vec:GetClass()) then

		ply:ExitVehicle()

		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

	end

end)