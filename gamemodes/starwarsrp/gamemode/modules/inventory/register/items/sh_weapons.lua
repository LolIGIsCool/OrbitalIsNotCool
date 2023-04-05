local MODULE = MODULE or RK.Modules:Get( "inventory" )

local weapon_items = {
	{
		name = "DC-15A", model = "models/weapons/w_rif_m4a1_silencer.mdl", price = 2200,
		class = "rw_sw_e11", weight = 4.15,
		description = "DC-15A: The standard battle rifle of the Grand Army of the Republic.",
		category = "Assault Rifles"
	},
	{
		name = "DC-15B", model = "models/weapons/w_rif_m4a1_silencer.mdl", price = 18480,
		class = "weapon_dc15a", weight = 3.45,
		description = "DC-15B: The rare battle rifle used by the select few in the Republic.",
		category = "Assault Rifles"
	},
	-- { name = "", model = "", price = , class = "", description = "" },
}

for k, v in pairs( weapon_items ) do
	
	v.nostack = true
	v.base = "base_weapon"

	MODULE:AddItem( v.name, v.base, v )

end