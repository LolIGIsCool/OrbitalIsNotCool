local MODULE = MODULE or RK.Modules:Get( "inventory" )

MODULE.RegisterItems = {}

for _, mod in pairs( RK.Modules:Get() ) do
	if mod.RegisterItems then
		for k, v in pairs( mod.RegisterItems ) do
			for _, item in pairs( v ) do
				item.category = k
				if !item.base then item.base = "base" end
				MODULE:AddItem( item.name, item.base, item )
			end
		end
	end
end

function RegisterItemsFuckYa()

	for _, mod in pairs( RK.Modules:Get() ) do
		if mod.RegisterItems then
			for k, v in pairs( mod.RegisterItems ) do
				for _, item in pairs( v ) do
					item.category = k
					if !item.base then item.base = "base" end
					MODULE:AddItem( item.name, item.base, item )
				end
			end
		end
	end
end

RegisterItemsFuckYa()

timer.Simple(2, function() RegisterItemsFuckYa() end )