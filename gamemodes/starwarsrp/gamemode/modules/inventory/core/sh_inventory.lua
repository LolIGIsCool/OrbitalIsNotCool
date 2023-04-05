local MODULE = MODULE or RK.Modules:Get( "inventory" )
MODULE.Items = MODULE.Items or {}
MODULE.Bases = MODULE.Bases or {}

function MODULE:GetItemBase( name )
	return self.Bases[ name ]
end

function MODULE:AddItemBase( name, data, base )
	--print(name, " man idfk")
	if base and self.Bases[ base ] then
		self.Bases[ name ] = table.Copy( self.Bases[ base ] )
		self.Bases[ name ].name = name
		self.Bases[ name ].data = data
	else
		self.Bases[ name ] = {
			name = name,
			data = data
		}
	end
end

function MODULE:AddItem( name, base, data )
	self.Items[ name ] = {
		name = name,
		base = base,
		data = data and data or {}
	}
end

function MODULE:GetItem( name )
	if isstring( name ) then
		return self.Items[ name ]
	elseif istable( name ) then
		return self.Items[ name.name ] and self.Items[ name.name ] or self.Items[ name.base ] and self.Items[ name.base ] or nil
	end
	return nil
end

function MODULE:GenerateItem( item_name, amount, data )
	local item = {}
	data = data or {}

	local item_data = self:GetItem( item_name )

	item.name = data.name and data.name or item_data.name or item_name
	item.amount = amount and amount or 1
	item.base = item_data.base and item_data.base or "base"
	item.data = data
	
	return item
end

hook.AddOrder( "PlayerOrderSpawn", 150, function( ply )

	local inv = ply:GetInventory()
	for i = 1, 100 do
		if inv and inv[ i ] and inv[ i ][ "Equipped" ] then
			local item_id = inv[ i ].data.name and inv[ i ].data.name or inv[ i ].name
			local item_data = MODULE:GetItem( item_id )

			if item_data.data.class then
				ply:Give( item_data.data.class )
			end
		end
	end


end )

RK.Inventory = RK.Modules:Get( "inventory" )

function MODULE:PostGamemodeLoaded()
	RK.Inventory = RK.Modules:Get( "inventory" )
end