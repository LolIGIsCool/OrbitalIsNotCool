local MODULE = MODULE or RK.Modules:Get( "crafting" )

MODULE:RegisterCrafting( "DC-15A",
	{
		input = {
			[ "Hadrium" ] = 5,
		},
		output = {
			[ "DC-15A" ] = 1,
		}
	},
	function( ply, item ) return ply:IsAdmin() end, -- Can See
	function( ply, item ) return true end, -- Can Craft
	false -- Require Entity
)