--[[-------------------------------------------------------------------------
Create the blacklist.
---------------------------------------------------------------------------]]

--Create a new blacklist table to work in.
local BLACKLIST = {}

--Define some basic vars for the blacklist.
BLACKLIST.Name = "Physics Gun"
BLACKLIST.Enabled = true

--Register the blacklist.
jBlacklist.RegisterBL(BLACKLIST)

--[[-------------------------------------------------------------------------
Optional functions.
---------------------------------------------------------------------------]]

local RemovedWeapons = {}

--Creating function that will be called when a blacklist is issued. (Only called if target is online)
BLACKLIST.OnIssued = function( ply )

	if ply:HasWeapon( "weapon_physgun" ) then
		ply:StripWeapon( "weapon_physgun" )
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
	ply:Give("weapon_physgun")

	--Remove the table.
	RemovedWeapons[ply:SteamID()] = nil

end

--[[-------------------------------------------------------------------------
Non-optional functions.
---------------------------------------------------------------------------]]

--Create a function to get the blacklist description.
BLACKLIST.GetDescription = function(  )
	return jBlacklist.LoadedLanguage["BLACKLISTDESC_PhysGun"]
end

--Create a function to get the blacklist's blacklisted-phrase.
BLACKLIST.GetBlacklistedPhrase = function()
	return jBlacklist.LoadedLanguage["BLACKLIST_PHYSGUN"]
end

--[[-------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------]]

--Add a hook that will reset the players RemovedWeapons table when they die.
jBlacklist.AddHook("PlayerDeath","jBlacklist_PhysGunBlacklist_PlayerDeath",function( ply )

	--Reset the table.
	RemovedWeapons[ply:SteamID()] = false

end)

--Add a hook that will remove the players RemovedWeapons table when they disconnect.
jBlacklist.AddHook("PlayerDisconnected","jBlacklist_PhysGunBlacklist_PlayerDisconnected",function( ply )

	--Reset the table.
	RemovedWeapons[ply:SteamID()] = nil

end)

--jBlacklist.AddHook will only be called on the server. (It works the same)
jBlacklist.AddHook("PlayerCanPickupWeapon","jBlacklist_PhysGunBlacklist",function( ply, wep )

	if ply:IsBlacklisted(BLACKLIST) && wep:GetClass() == "weapon_physgun" then

		wep:Remove()

		RemovedWeapons[ply:SteamID()] = true

		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

	end

end)

jBlacklist.AddHook("jBlacklist_InitialPlayerLoaded", "jBlacklist_PhysGunBlacklist_InitialPlayerLoaded", function( ply )

	if ply:IsBlacklisted(BLACKLIST) && ply:HasWeapon("weapon_physgun") then

		ply:StripWeapon("weapon_physgun")

		RemovedWeapons[ply:SteamID()] = true

		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

	end

end)