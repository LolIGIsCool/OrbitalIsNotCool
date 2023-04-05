--[[-------------------------------------------------------------------------
Create the blacklist.
---------------------------------------------------------------------------]]

--Create a new blacklist table to work in.
local BLACKLIST = {}

--Define some basic vars for the blacklist.
BLACKLIST.Name = "Tool Gun"
BLACKLIST.Enabled = true

--Register the blacklist.
jBlacklist.RegisterBL(BLACKLIST)

--[[-------------------------------------------------------------------------
Optional functions.
---------------------------------------------------------------------------]]

local RemovedWeapons = {}

--Creating function that will be called when a blacklist is issued. (Only called if target is online)
BLACKLIST.OnIssued = function( ply )

	if ply:HasWeapon( "gmod_tool" ) then
		ply:StripWeapon( "gmod_tool" )
		RemovedWeapons[ply:SteamID()] = true
	end

end

--Create a function that will be called when the blacklist expires.
BLACKLIST.OnExpire = function( ply )

	--Check if a refund should be done.
	if !jBlacklist.BLConfig.RefundItems then return end

	--Check if a refund should be given.
	if RemovedWeapons[ply:SteamID()] != true then return end

	--Refund the weapon.
	ply:Give("gmod_tool")

	--Remove the table.
	RemovedWeapons[ply:SteamID()] = nil

end

--[[-------------------------------------------------------------------------
Non-optional functions.
---------------------------------------------------------------------------]]

--Create a function to get the blacklist description.
BLACKLIST.GetDescription = function(  )
	return jBlacklist.LoadedLanguage["BLACKLISTDESC_ToolGun"]
end

--Create a function to get the blacklist's blacklisted-phrase.
BLACKLIST.GetBlacklistedPhrase = function()
	return jBlacklist.LoadedLanguage["BLACKLIST_TOOLGUN"]
end

--[[-------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------]]

--Add a hook that will reset the players RemovedWeapons table when they die.
jBlacklist.AddHook("PlayerDeath","jBlacklist_ToolGunBlacklist_PlayerDeath",function( ply )

	--Reset the table.
	RemovedWeapons[ply:SteamID()] = false

end)

--Add a hook that will remove the players RemovedWeapons table when they disconnect.
jBlacklist.AddHook("PlayerDisconnected","jBlacklist_ToolGunBlacklist_PlayerDisconnected",function( ply )

	--Reset the table.
	RemovedWeapons[ply:SteamID()] = nil

end)

--jBlacklist.AddHook will only be called on the server. (It works the same)
jBlacklist.AddHook("PlayerCanPickupWeapon","jBlacklist_ToolGunBlacklist",function( ply, wep )

	if ply:IsBlacklisted(BLACKLIST) && wep:GetClass() == "gmod_tool" then

		wep:Remove()

		RemovedWeapons[ply:SteamID()] = true

		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

	end

end)

jBlacklist.AddHook("jBlacklist_InitialPlayerLoaded", "jBlacklist_ToolGunBlacklist_InitialPlayerLoaded", function( ply )

	if ply:IsBlacklisted(BLACKLIST) && ply:HasWeapon("gmod_tool") then

		ply:StripWeapon("gmod_tool")

		RemovedWeapons[ply:SteamID()] = true

		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

	end

end)