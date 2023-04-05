local MODULE = MODULE or RK.Modules:Get( "zones" )

RK.Zones = RK.Zones or RK.Register:New( {} )
function RK.Zones:OnRegister( data )
	for k, v in pairs( data ) do
		if v and v[ "position" ] and isstring( v[ "position" ] ) then
			v[ "position" ] = util.JSONToTable( v[ "position" ] )
		end
	end

	if self:Get( data.name ) then
		data = table.Merge( data, self:Get( data.name ) )
	end

	return data
end

function RK.Zones:GetZone( name, callback )
	// Gets a zone by name
	// @param name string - The name of the zone to get
	// @param callback function - The callback to run when the zone is found
	// @returns table - The zone

	if !name then return false end
	if !callback then return self.Zones[ name ] end

	if self:Get( game.GetMap() ) then
		callback( self:Get( game.GetMap() )[ name ] )
		return self:Get( game.GetMap() )[ name ]
	end
end

function RK.Zones:GetZones( callback )
	// Gets all zones on the current map
	// @param callback function - The callback to run when the zones are found
	// @returns table - The zones
	if !callback then return self:Get( game.GetMap() ) end
	callback( self:Get( game.GetMap() ) )
end

function RK.Zones:GetZonePosition( name, callback )
	// Gets the position of a zone by name
	// @param name string - The name of the zone to get
	// @param callback function - The callback to run when the zone is found
	// @returns vector - The position of the zone
	if !name then return false end
	if !callback then return self:Get( game.GetMap() )[ name ][ "position" ] end
	if self:Get( game.GetMap() )[ name ] then
		callback( self:Get( game.GetMap() )[ name ][ "position" ] )
		return self:Get( game.GetMap() )[ name ][ "position" ]
	end
end

function RK.Zones:GetZoneAt( pos, callback )
	// Gets the zone at a position
	// @param pos vector - The position to check
	// @param callback function - The callback to run when the zone is found
	// @returns table - The zone
	if !pos then return false end
	for k, v in pairs( self:Get( game.GetMap() ) ) do
		if !v["position"] then continue end
		if pos:WithinAABox( v["position"][1], v["position"][2] ) then
			if callback then callback( v ) end
			return v
		end
	end
	return false
end

function RK.Zones:SaveZone( data, callback )

	if !file.Exists( "swrp", "DATA" ) then
		file.CreateDir( "swrp" )
	end
	
	if !file.Exists( "swrp/zones", "DATA" ) then
		file.CreateDir( "swrp/zones" )
	end

	if !file.Exists( "swrp/zones/" .. game.GetMap(), "DATA" ) then
		file.CreateDir( "swrp/zones/" .. game.GetMap() )
	end

	file.Write( "swrp/zones/" .. game.GetMap() .. "/" .. data.name .. ".txt", util.TableToJSON( data ) )

end

function RK.Zones:LoadZones( callback )
	for k, v in pairs( file.Find( "swrp/zones/" .. game.GetMap() .. "/*", "DATA" ) ) do
		local data = util.JSONToTable( file.Read( "swrp/zones/" .. game.GetMap() .. "/".. v, "DATA" ) )
		local clean = {
			[ data.name ] = {
				[ "position" ] = {
					data.position[1],
					data.position[2]
				},
			},
		}
		RK.Zones:Add( game.GetMap(), clean )
	end

	if callback then callback() end
end

RK.Zones:Add( "gm_construct", {
	[ "Safe Zone" ] = {
		[ "position" ] = '["[-896.3073 -1024.978 240.9688]","[495.5973 -1903.6964 -143.9688]"]',
		[ "OnEntered" ] = function( ply )
			MODULE.ZoneFunctions[ "Message" ]( ply, "Welcome to the safe zone!" )
		end,
		[ "NoDamage" ] = true,
	},
	[ "Battle Building 1" ] = {
		[ "position" ] = '["[-1029.025 -1915.6973 240.0313]","[-3519.9688 -1025.7059 -160.1277]"]',
		[ "OnEntered" ] = function( ply )
			MODULE.ZoneFunctions[ "Message" ]( ply, "Welcome to the battle building 1!" )
		end,
	},
	[ "Battle Building 2" ] = {
		[ "position" ] = '["[1838.1611 875.3199 64.0313]","[1023.9688 -884.7314 -150.7074]"]',
		[ "OnEntered" ] = function( ply )
			MODULE.ZoneFunctions[ "Message" ]( ply, "Welcome to the battle building 2!" )
		end,
	},
} )

RK.Zones:LoadZones()