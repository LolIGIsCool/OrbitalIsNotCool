if !bLogs then return end

local MODULE = bLogs:Module()

MODULE.Category = "Gamemode"
MODULE.Name     = "Arrests"
MODULE.Colour   = Color( 0, 150, 255 )

MODULE:Hook( "onArrest", "onArrest", function( ply, target )
	MODULE:Log( "{1} arrested {2}", bLogs:FormatPlayer( ply ), bLogs:FormatPlayer( target ) )
end )

MODULE:Hook( "onUnArrest", "onUnArrest", function( ply, target )
	MODULE:Log( "{1} unarrested {2}", bLogs:FormatPlayer( ply ), bLogs:FormatPlayer( target ) )
end )

bLogs:AddModule( MODULE )