local MODULE = MODULE or RK.Modules:Get( "inventory" )

local PLAYER = FindMetaTable( "Player" )

function PLAYER:GetHandsModel()

	-- return { model = "models/weapons/c_arms_cstrike.mdl", skin = 1, body = "0100000" }

	local playermodel = player_manager.TranslateToPlayerModelName( self:GetModel() )
	return player_manager.TranslatePlayerHands( playermodel )

end

function PLAYER:GetInventory()
	self.Inventory = self:GetData():GetVar( "Inventory", {} )
	return self.Inventory
end

function PLAYER:GetInventoryItemID( id )
	return self:GetInventory()[ id ]
end

function PLAYER:GetInventoryItemByMember( member, value )
	for k, v in pairs( self:GetInventory() ) do
		if !value then
			for _, v2 in pairs( v ) do
				if v2 == member then
					return v
				end
			end
		continue end
		if v[ member ] == value then
			return v
		end
	end
	return false
end

function PLAYER:InventoryUpdate()
	self:GetData():SetVar( "Inventory", self.Inventory )
end

function PLAYER:HasInventoryItem( ID )
	local item = self:FindInventoryItem( ID )
	if !item then return false end
	return item.amount and item.amount or 1
end

function PLAYER:FindInventoryItem( ID )
	local item = self:GetInventoryItemID( ID )
	if item then
		return item
	end
	return self:GetInventoryItemByMember( "name", ID )
end

function PLAYER:FindEmptyInventorySlot()
	local inventory = self:GetInventory()
	for i = 1, 64 do
		if not inventory[ i ] then
			return i
		end
	end
	return false
end

if SERVER then
	function PLAYER:AddInventoryItem( id, amount, data )
		--print(id, data)
		self:GetInventory()
		local data = data or {}
		--print(id, amount, data)
		local item_base
		
		if MODULE:GetItem( id ) then
			item_base = MODULE:GetItem( id )
			--print("bruh!")
		elseif(data == nil) then
			item_base = MODULE:GetItemBase( "base" )
			--print("bruh! asd")
		else
			item_base = MODULE:GetItem( id ) and MODULE:GetItem( id ) or
				data.data.base and MODULE:GetItem( data.data.base ) and MODULE:GetItem( data.data.base ) or
				MODULE:GetItemBase( "base" )
		end
		--[[PrintTable(data)
		print(istable(data))
		--print(table.IsEmpty(data))
		local item_base = ""
		if table.IsEmpty(data) then
			item_base = MODULE:GetItem( id ) or MODULE:GetItemBase( "base" )
			print("bruh")
		else
			item_base = MODULE:GetItem( id ) or (data.data.base and MODULE:GetItem( data.data.base )) or MODULE:GetItemBase( "base" )
		end
		
		PrintTable( item_base )
		print(item_base)]]--

		if item_base.data then
			if not item_base.data.nostack then
				--print("1")
				local item = self:FindInventoryItem( id )
				--print("2")
				if item then
					item.amount = item.amount + amount
					self:InventoryUpdate()
					return
				end
				--print("3")
			end
		else
			--print("1")
			local item = self:FindInventoryItem( id )
			--print(item)
			--print("2")
			if item then
				item.amount = item.amount + amount
				self:InventoryUpdate()
				return
			end
			--print("3")
		end

		local item = MODULE:GenerateItem( id, amount, data )
		local slot = self:FindEmptyInventorySlot()

		if !slot then
			self:Notify( "You dont have enough space in your inventory" )	
		return false end
		if !item then
			self:Notify( "Unknowing item ID: " .. id )	
		return false end

		self.Inventory[ slot ] = item
		self:InventoryUpdate()
		--print("4")
	end
	
	function PLAYER:RemoveInventoryItem( id, amount )
		self:GetInventory()
		--print("bruh!")
		if !self:HasInventoryItem(id) then return false end
		--PrintTable(self.Inventory)
		--print(self.Inventory["Hadrium"])
		--print(id, amount)
		--print(self:HasInventoryItem(id))
		--print(self.Inventory[tostring(id)])
		
		local item = self:FindInventoryItem( id )
		--print(item)
		--PrintTable(item)
		if amount then
			for i=1, #self.Inventory do
				if self.Inventory[i].name == id then
					--print("item Found!!!")
					if self.Inventory[i].amount == amount then
						self.Inventory[i] = nil
						--table.remove(self.Inventory, i)
					else
						item.amount = item.amount - amount
					end
					--print("Done!!!")
				end
			end
		
			--print(amount)
			--if item.amount == amount - 1 then
				-- remove item entirely 
			--	self.Inventory[ id ] = nil
			--	print("Removed")
			--else
			--	item.amount = item.amount - amount
			--	print("Reduced")
			--end
			--self.Inventory[ id ].amount = self.Inventory[ id ].amount - amount
			--if self.Inventory[ id ].amount <= 0 then
			--	self.Inventory[ id ] = nil
			--end
		else
			---print(" bruh sauce ")
			self.Inventory[ id ] = nil		
		end

		self:InventoryUpdate()
		--print("updates")
	end
end

hook.AddOrder( "PlayerOrderSpawnInit", 2, function( ply )
	ply:GetInventory() -- Init the inventory
end )