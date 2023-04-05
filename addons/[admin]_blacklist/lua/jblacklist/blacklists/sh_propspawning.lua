--[[-------------------------------------------------------------------------
Create the blacklist.
---------------------------------------------------------------------------]]

--Create a new blacklist table to work in.
local BLACKLIST = {}

--Define some basic vars for the blacklist.
BLACKLIST.Name = "Entities/Props"
BLACKLIST.Enabled = true

--Register the blacklist.
jBlacklist.RegisterBL(BLACKLIST)

--[[-------------------------------------------------------------------------
Type specific functions.
---------------------------------------------------------------------------]]

--Create a local function for the hooks.
local hookFunction = function( ply, ent )

	--Add this to prevent this action if the player's blacklists havent loaded in yet.
	if !ply.jBlacklist then ent:Remove() return end

	if ply:IsBlacklisted(BLACKLIST) then

		ent:Remove()

		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

	end

end

--[[-------------------------------------------------------------------------
Non-optional functions.
---------------------------------------------------------------------------]]

--Create a function to get the blacklist description.
BLACKLIST.GetDescription = function(  )
	return jBlacklist.LoadedLanguage["BLACKLISTDESC_Props"]
end

--Create a function to get the blacklist's blacklisted-phrase.
BLACKLIST.GetBlacklistedPhrase = function()
	return jBlacklist.LoadedLanguage["BLACKLIST_PROPS"]
end

--[[-------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------]]

--Add PlayerSpawnedProp hook to avoid propspawning.
jBlacklist.AddHook("PlayerSpawnedProp","jBlacklist_Propblacklist_Props",function( ply, _, ent )
	if jBlacklist.BLConfig.PropsEnts.Props == true then hookFunction( ply, ent ) end
end)

--Add PlayerSpawnedSENT hook to avoid sents spawning.
jBlacklist.AddHook("PlayerSpawnedSENT","jBlacklist_Propblacklist_Sents",function( ply, ent )
	if jBlacklist.BLConfig.PropsEnts.Entities == true then hookFunction( ply, ent ) end
end)

--Add PlayerSpawnedVehicle hook to avoid vehicle spawning.
jBlacklist.AddHook("PlayerSpawnedVehicle","jBlacklist_Propblacklist_Vehicles",function( ply, ent )
	if jBlacklist.BLConfig.PropsEnts.Vehicles == true then hookFunction( ply, ent ) end
end)

--Add PlayerSpawnedNPC hook to avoid NPC spawning.
jBlacklist.AddHook("PlayerSpawnedNPC","jBlacklist_Propblacklist_NPCs",function( ply, ent )
	if jBlacklist.BLConfig.PropsEnts.NPCs == true then hookFunction( ply, ent ) end
end)

--Add PlayerSpawnedRagdoll hook to avoid ragdoll spawning.
jBlacklist.AddHook("PlayerSpawnedRagdoll","jBlacklist_Propblacklist_Ragdolls",function(ply, _, ent)
	if jBlacklist.BLConfig.PropsEnts.Ragdolls == true then hookFunction( ply, ent ) end
end)

--Add PlayerSpawnedSWEP hook to avoid SWEP spawning.
jBlacklist.AddHook("PlayerSpawnedSWEP","jBlacklist_Propblacklist_SWEPs",function( ply, ent )
	if jBlacklist.BLConfig.PropsEnts.SWEPs == true then hookFunction( ply, ent ) end
end)