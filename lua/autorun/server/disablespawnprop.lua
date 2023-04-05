hook.Add( "PlayerSpawnProp", "ToolsCheck", function( ply, mdl )
	return ( ply:HasWeapon("gmod_tool") and ply:HasWeapon("weapon_physgun") )
end)
