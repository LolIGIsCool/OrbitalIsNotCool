local MODULE = MODULE or RK.Modules:Get( "zones" )

local META = FindMetaTable( "Player" )

function META:GetZone()
	// Gets the zone the player is in
	// @returns table - The zone
	local pos = self:GetPos()
	return RK.Zones:GetZoneAt( pos )
end