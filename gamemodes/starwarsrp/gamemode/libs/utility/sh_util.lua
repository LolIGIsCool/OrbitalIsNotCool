util = util
util._delayTable = {}

function util.Delay( time )
	time = time or engine.TickInterval()
	local id = string.Explode( "\n", debug.traceback() )[3]
	util._delayTable[ id ] = util._delayTable[ id ] or SysTime() + time

	if util._delayTable[ id ] < SysTime() then
		util._delayTable[ id ] = nil
		return true
	else
		return false
	end

end
util.delay = util.Delay

if SERVER then
	function GM:GetFallDamage( ply, speed )

		local meters_per_second = math.Clamp( ( speed / 72 ) - 5, 0, 100000 )
		local damage = math.ceil( ( meters_per_second * meters_per_second ) * 0.4285 )

		local zone = ply:GetZone()
		if zone then
			if zone[ "NoFallDamage" ] then return 0 end
			if zone[ "FallDamageMult" ] then return damage * FallDamageMult end
		end

		return math.max( 0, damage )
	end
end