local MODULE = MODULE or RK.Modules:Get( "zones" )

MODULE.ZoneHandler = MODULE.ZoneHandler or {}

hook.Add( "Tick", "SWRPZones:Tick", function()
	if !util.Delay( 0.5 ) then return end
	if !RK.Zones:GetZones() then return end

	for name, v in pairs( RK.Zones:GetZones() ) do
		if !v.position then continue end

		if !MODULE.ZoneHandler[ name ] then MODULE.ZoneHandler[ name ] = {} end
		
		local comp_table = ents.FindPlayersInBox( v["position"][1], v["position"][2] )
		for key, var in pairs( comp_table ) do
			if table.HasValue( MODULE.ZoneHandler[ name ], var ) then continue end

			table.insert( MODULE.ZoneHandler[ name ], var )
			
			if v[ "OnEntered" ] then v[ "OnEntered" ]( var ) end
		end

		for key, var in pairs( MODULE.ZoneHandler[ name ] ) do
			if table.HasValue( comp_table, var ) then continue end
			table.RemoveByValue( MODULE.ZoneHandler[ name ], var )

			if v[ "OnExit" ] then v[ "OnExit" ]( var ) end
		end

	end
end )


hook.Add( "PlayerShouldTakeDamage", "SWRPZones:PlayerShouldTakeDamage", function( ply, attacker )
	if IsValid( ply ) and IsValid( attacker ) and ( ply:IsPlayer() and attacker:IsPlayer() ) then
		-- if ply:GetRegiment() == attacker:GetRegiment() then return false end
	end

	if ply:GetZone() then

		if ply:GetZone()[ "NoDamage" ] then return false end

	end

end )