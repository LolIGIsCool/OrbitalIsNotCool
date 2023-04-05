local MODULE = MODULE or RK.Modules:Get( "zones" )

// Zone Functions
MODULE.ZoneFunctions = {}
MODULE.ZoneFunctions[ "Message" ] = function( ply, message )
	if !ply or !ply:IsValid() then return end
	if !message then return end

	ply:PrintMessage( HUD_PRINTCENTER, message )
end