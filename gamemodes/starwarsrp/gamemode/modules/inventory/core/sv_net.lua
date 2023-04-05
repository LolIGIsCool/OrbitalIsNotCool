local MODULE = MODULE or RK.Modules:Get( "inventory" )

hook.Add( "PostNetInit", "Inventory:PostNetInit", function()
	RK.Net:ReceiveNetData( "RK.Inventory:Request", function( ply, data )
		if data.Command == "Remove" then
			ply:RemoveInventoryItem( data.ID, data.Amount )
		return end

		if data.Command == "Swap" then
			ply:GetInventory()

			local slot_1 = table.Copy( ply.Inventory[data.ID] )
			local slot_2 = table.Copy( ply.Inventory[data.Target] )

			ply.Inventory[data.ID] = slot_2
			ply.Inventory[data.Target] = slot_1

			ply:InventoryUpdate()
		return end
		
		if data.Command == "Equip" then
			ply:GetInventory()
			local item = ply.Inventory[data.ID]
			--print(item.name)
			local item_base = RK.Inventory:GetItemBase(item.base)
			--PrintTable(item_base.data.functions)
			--PrintTable(item_base.functions)
			local steamid = ply:SteamID64()
			item_base.data.functions.OnEquip(item, item, steamid)
			--if item_base.data.functions.OnEquip() then
				--item_base.data.functions.OnEquip(item, item, steamid)
			--end
			
		return end
		
		if data.Command == "UnEquip" then
			ply:GetInventory()
			local item = ply.Inventory[data.ID]
			local item_base = RK.Inventory:GetItemBase(item.base)
			local steamid = ply:SteamID64()
			item_base.data.functions.OnUnequip(item, item, steamid)
			
		return end
		
		local item = ply.Inventory[data.ID]
		if !item then return end
		if !item.base then item.base = "base" end

		local item_data = RK.Inventory:GetItem( item.data.base or item.name )
		local item_base = RK.Inventory:GetItemBase( item.base )

		if !item_base then return end

		if item_data[ "data" ][ "functions" ] and item_data[ "data" ][ "functions" ][ data.Command ] then
			if !item_data[ "data" ][ "functions" ][ data.Command ]( item, item_data, ply ) then
				ply.Inventory[ data.ID ].amount = ply.Inventory[ data.ID ].amount and ply.Inventory[ data.ID ].amount - 1 or 0

				if ply.Inventory[ data.ID ].amount <= 0 then
					ply.Inventory[ data.ID ] = nil
				end
			end
			ply:InventoryUpdate()
		return end

		if item_base[ "data" ][ "functions" ][ data.Command ] then
			if !item_base[ "data" ][ "functions" ][ data.Command ]( item, item_data, ply ) then
				ply.Inventory[ data.ID ].amount = ply.Inventory[ data.ID ].amount and ply.Inventory[ data.ID ].amount - 1 or 0

				if ply.Inventory[ data.ID ].amount <= 0 then
					ply.Inventory[ data.ID ] = nil
				end
			end
			ply:InventoryUpdate()
		return end
	end )
end )