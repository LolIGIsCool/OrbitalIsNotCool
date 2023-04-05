--[[-------------------------------------------------------------------------
General
---------------------------------------------------------------------------]]

--Should items that have been removed due to blacklists be refunded when the blacklist expires. (Weapons removed since last respawn)
--NOTE: Value can be true/false.
jBlacklist.BLConfig.RefundItems = true

--[[-------------------------------------------------------------------------
Vehicles Blacklist
---------------------------------------------------------------------------]]

--Vehicle classes that wont be affected by a vehicle blacklist.
--NOTE: Look at the vehicle and type 'jblacklist_getvehicleclass' in your game console to get its class.
--NOTE: Separate multiple classes with a comma. Example: {"prop_vehicle_prisoner_pod", "prop_vehicle_jeep"}
jBlacklist.BLConfig.ClassWhitelist = {"prop_vehicle_prisoner_pod"}

--[[-------------------------------------------------------------------------
Weapons Blacklist
---------------------------------------------------------------------------]]

--These weapon classes are not allowed to be used when blacklisted from weapons.
--NOTE: Rightclick on weapon in the Q-Menu and select 'copy to clipboard' to get its class.
--NOTE: Use WeaponPacks-config below if you instead want to add multiple weapons starting with the same class-prefix.
--NOTE: Separate multiple weapons with a comma as done below.
jBlacklist.BLConfig.WeaponsBlacklist = {
	"stunstick",
	"gmod_camera",
	"climb_swep2",
}


--Weapon classes starting with the following prefix will not be allowed to be used.
--NOTE: Rightclick on weapon in the Q-Menu and select 'copy to clipboard' to get its class.
--NOTE: Separate multiple weaponpacks with a comma as done below.
jBlacklist.BLConfig.WeaponPacks = {
	"weapon_",
	"cw_",
	"fas2_",
	"m9k_",
	"rw_",
}

--The following weapon classes are to be ignored even if they are marked as not allowed above.
--NOTE: Rightclick on weapon in the Q-Menu and select 'copy to clipboard' to get its class.
--NOTE: Separate multiple weapons with a comma as done below.
jBlacklist.BLConfig.WeaponWhitelist = {
	"gmod_camera",

	"weapon_physcannon",
	"weapon_bugbait",
	"weapon_fists",
	"weapon_medkit",
	"weapon_physgun",
	"weapon_keypadchecker",

	"fas2_ammobox",
	"fas2_ifak",

	"cw_smoke_grenade",
	"cw_flash_grenade",
}

--[[-------------------------------------------------------------------------
NLR Blacklist
---------------------------------------------------------------------------]]

--How many minutes should you have to wait before respawning when you have an NLR blacklist.
jBlacklist.BLConfig.RespawnTimer = 5

--Should the time the player has left before respawning be shown on the player's screen.
jBlacklist.BLConfig.DrawNLRTime = true

--[[-------------------------------------------------------------------------
Toolgun Tools Blacklist
---------------------------------------------------------------------------]]

--The following tools should be ignored being added as a blacklist.
--NOTE: Use the same name as they are named in the JBlacklist adminmenu without the '[TOOL]' prefix.
--NOTE: Separate multiple tools with a comma as done below.
jBlacklist.BLConfig.IgnoredTools = {
	"editentity",
	"example",
}

--[[-------------------------------------------------------------------------
Props/Entities Blacklist
---------------------------------------------------------------------------]]

--What of the following should the Props/Entities blacklist restrict the user from spawning.
--NOTE: Value can be true/false.
jBlacklist.BLConfig.PropsEnts = {
	Props = true,
	Entities = true,
	Vehicles = true,
	NPCs = true,
	Ragdolls = true,
	SWEPs = true,
}