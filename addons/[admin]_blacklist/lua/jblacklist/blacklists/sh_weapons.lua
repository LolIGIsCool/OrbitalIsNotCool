--[[-------------------------------------------------------------------------
Create the blacklist.
---------------------------------------------------------------------------]]

--Create a new blacklist table to work in.
local BLACKLIST = {}

--Define some basic vars for the blacklist.
BLACKLIST.Name = "Weapons"
BLACKLIST.Enabled = true

--Register the blacklist.
jBlacklist.RegisterBL(BLACKLIST)

--[[-------------------------------------------------------------------------
Non-optional functions.
---------------------------------------------------------------------------]]

--Create a function to get the blacklist description.
BLACKLIST.GetDescription = function(  )
	return jBlacklist.LoadedLanguage["BLACKLISTDESC_Weapons"]
end

--Create a function to get the blacklist's blacklisted-phrase.
BLACKLIST.GetBlacklistedPhrase = function()
	return jBlacklist.LoadedLanguage["BLACKLIST_WEAPONS"]
end


--[[-------------------------------------------------------------------------
Type specific functions
---------------------------------------------------------------------------]]

--Create function to check if a weapon is allowed.
local AllowedWeapon = function(className)

	--Check if the weapon is whitelisted.
	if table.HasValue(jBlacklist.BLConfig.WeaponWhitelist,className) then return true end

	for k,v in pairs(jBlacklist.BLConfig.WeaponPacks) do
		if string.StartWith(className,v) then return false end
	end

	return !table.HasValue(jBlacklist.BLConfig.WeaponsBlacklist,className)

end

--Create a table of weapons that we have removed from each player so we can give them back later.
local RemovedWeapons = {}

--Create a function to remove weapons from a player.
local RemoveWeapon = function( ply, weaponClass )

	--Make sure the player got a table.
	RemovedWeapons[ply:SteamID()] = RemovedWeapons[ply:SteamID()] or {}

	--Remove the weapon.
	ply:StripWeapon(weaponClass)

	--Add the weapon to the list of removed weapons.
	RemovedWeapons[ply:SteamID()][weaponClass] = true

end

--Create a function to strip all weapons from a player.
local StripAllWeapons = function ( ply )

	--Get all weapons that the player has.
	for k,v in pairs(ply:GetWeapons()) do

		--Remove weapons that the user isn't allowed to have.
		if !AllowedWeapon(v:GetClass()) then
			RemoveWeapon(ply, v:GetClass())
		end

	end

end

--[[-------------------------------------------------------------------------
Optional functions.
---------------------------------------------------------------------------]]

--Create a function that will be called when the blacklist expires.
BLACKLIST.OnExpire = function( ply )

	--Check if a refund should be done.
	if !jBlacklist.BLConfig.RefundItems then return end

	--Check if the REmovedWeapon table exists.
	if !RemovedWeapons[ply:SteamID()] then return end

	--Loop through all the player's removed weapons.
	for k,v in pairs(RemovedWeapons[ply:SteamID()]) do
		ply:Give(k)
	end

	--Remove the table.
	RemovedWeapons[ply:SteamID()] = nil

end

--Creating function that will be called when a blacklist is issued. (Only called if target is online)
BLACKLIST.OnIssued = StripAllWeapons

--[[-------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------]]

--Add a hook that will check so the player wasn't given any weapons if the SQL response was slow.
jBlacklist.AddHook("jBlacklist_InitialPlayerLoaded", "jBlacklist_WeaponsBlacklist_InitialPlayerLoaded", function ( ply )

	--Check if the player is blacklisted.
	if ply:IsBlacklisted(BLACKLIST) then

		--Strip all the weapons that the player shouldnt have.
		StripAllWeapons(ply)

	end

end)

--Add a hook that will reset the players RemovedWeapons table when they die.
jBlacklist.AddHook("PlayerDeath","jBlacklist_WeaponsBlacklist_PlayerDeath",function( ply )

	--Reset the table.
	RemovedWeapons[ply:SteamID()] = {}

end)

--Add a hook that will remove the players RemovedWeapons table when they disconnect.
jBlacklist.AddHook("PlayerDisconnected","jBlacklist_WeaponsBlacklist_PlayerDisconnected",function( ply )

	--Reset the table.
	RemovedWeapons[ply:SteamID()] = nil

end)

--Add a hook that prevents us from picking up weapons when blacklisted.
jBlacklist.AddHook("PlayerCanPickupWeapon","jBlacklist_WeaponsBlacklist",function( ply, wep )

	if ply:IsBlacklisted(BLACKLIST) && !AllowedWeapon(wep:GetClass()) then

		RemovedWeapons[ply:SteamID()] = RemovedWeapons[ply:SteamID()] or {}

		RemovedWeapons[ply:SteamID()][wep:GetClass()] = true

		wep:Remove()

		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

	end

end)