// Init Module
local MODULE = MODULE or RK.Modules:Get( "inventory" )

// Module name
MODULE.name = "Inventory"
// Module author
MODULE.author = "Kirby#2015"
// Module description
MODULE.description = [[
	A core module required for the rest of the framework to work.
]]

function MODULE:GetItemCount()
	return table.Count( RK.Inventory.Items )
end
concommand.Add( "rk_getitemcount", function()
	print( MODULE:GetItemCount() )
end )

concommand.Add( "rk_generate_random", function()
	local txt = ""
	local complete = {}
	for i = 1, 500 do
		local v, k = table.Random( RK.Inventory.Items )
		if v.data.category and !complete[ k ] then
			complete[ k ] = true
			txt = txt .. [[
MODULE:RegisterCrafting( "]] .. k .. [[",
	{
		input = {
			[ "]] .. table.Random( RK.Inventory.Items ).name .. [[" ] = ]] .. math.random( 1, 20 ) .. [[,
		},
		output = {
			[ "]] .. k .. [[" ] = 1,
		}
	},
)
]]
		end
	end
	SetClipboardText( txt )
end )