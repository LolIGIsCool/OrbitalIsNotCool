local StartTime = SysTime()

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function GM:PlayerSpawn( ply )
	if !ply.FirstSpawn then
		hook.Add( "SetupMove", ply, function( self, ply, _, cmd )
			if !IsValid( ply ) then return end
			if self == ply and not cmd:IsForced() then
				-- timer.Simple( engine.TickInterval() * 6, function() ply:SetPos( Vector( -14848.621094, -10732.368164, 11840.031250 ) ) end )
				ply:KillSilent() -- Kill the player to run the else statement
				ply.FirstSpawn = true -- Set the player's first spawn var to true so we dont run this more than once
				ply:GetData() -- Force the data to be loaded earlier than the hooks

				if IsValid( ply:GetRagdollEntity() ) then
					ply:GetRagdollEntity():Remove() -- Remove the ragdoll if it exists
				end
				
				timer.Simple( engine.TickInterval() * 50, function()
					hook.RunOrder( "PlayerOrderSpawnInit", ply )
					ply:Spawn()
				end ) -- Delay this by 50 ticks so the player has time to load the data
				hook.Remove( "SetupMove", self ) -- Remove the hook so we dont run this more than once
			end
		end )
	else
		hook.RunOrder( "PlayerOrderSpawn", ply ) -- Run the player order spawn hook
		hook.RunOrder( "DataStorage:Initialized", ply ) -- Run the data storage initialized hook
	end
end

hook.Add("PlayerDeathSound", "OverrideDeathSound", function() return true end )

function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

local dist = 750 * 750
function GM:PlayerCanHearPlayersVoice( listener, talker )
	return listener:GetPos():DistToSqr( talker:GetPos() ) < dist, true
end

function GM:PlayerSelectSpawn() end

hook.Add( "InitPostEntity", "SWRP:InitPostEntity:RemoveSoundscape", function()
	for _, ent in pairs( ents.FindByClass( "env_soundscape" ) ) do
		ent:Remove()
	end
end )

function GM:PlayerSpray()
	return true
end

MsgC( Color( 255, 0, 0 ), "[LOG]: ", Color( 200, 200, 200 ), "Server Files took - " .. SysTime() - StartTime .. " seconds to load.\n" )
hook.Add( "DatabaseConnected", "Log:DatabaseConnected", function()
	MsgC( Color( 255, 0, 0 ), "[LOG]: ", Color( 200, 200, 200 ), "Database took - " .. SysTime() - StartTime .. " seconds to load.\n" )
end )