local MODULE = MODULE or RK.Modules:Get( "inventory" )

MODULE:AddItemBase( "base", {
	name = "Base",
	description = "Base item",
	model = "models/maxofs2d/hover_rings.mdl",
	weight = 1,
	max_amount = 64,
	colour = Color( 200, 200, 200, 100 ),
	
	functions = {
		OnDrop = function( self, item, player )
			player:ChatPrint( "You dropped the " .. self.name .. "." )
		return true end,
	}
} )

MODULE:AddItemBase( "base_armour", {
	name = "Base Armour",
	description = "Base armour item",
	model = "models/maxofs2d/hover_rings.mdl",
	weight = 1,
	max_amount = 1,
	colour = Color( 0, 200, 200, 100 ),
	
	functions = {
		OnEquip = function( self, item, player )
			player:ChatPrint( "You equipped the " .. self.name .. "." )
		return true end,

		OnUnequip = function( self, item, player )
			player:ChatPrint( "You unequipped the " .. self.name .. "." )
		return true end,
	}
}, "base" )

MODULE:AddItemBase( "base_weapon", {
	name = "Base Weapon",
	description = "Base weapon item",
	model = "models/maxofs2d/hover_rings.mdl",
	weight = 1,
	max_amount = 1,
	colour = Color( 200, 200, 0, 100 ),
	
	functions = {
		OnEquip = function( self, item, steamid )
			if self.Equipped then return true end
			local ply = player.GetBySteamID64(steamid)
			local item2 = MODULE:GetItem(item.name)
			PrintTable(item2)
			PrintTable(self)
			print(self,item,steamid)
			ply:ChatPrint( "You equipped the " .. self.name .. "." )
			
			--if item.name then
				--ply:Give( item.name )
			--end
			
			if item2.data.class then
				ply:Give( item2.data.class )
			end

			self.Equipped = true
		return true end,

		OnUnequip = function( self, item, steamid )
			if !self.Equipped then return true end
			local ply = player.GetBySteamID64(steamid)
			local item2 = MODULE:GetItem(item.name)
			ply:ChatPrint( "You unequipped the " .. self.name .. "." )

			if item2.data.class then
				ply:StripWeapon( item2.data.class )
			end

			self.Equipped = false
		return true end,
	}
}, "base" )

MODULE:AddItemBase( "base_consumable", {
	name = "Base Consumable",
	description = "Base consumable item",
	model = "models/maxofs2d/hover_rings.mdl",
	weight = 1,
	max_amount = 1,
	colour = Color( 0, 200, 0, 100 ),
	
	functions = {
		OnUse = function( self, item, player )
			player:ChatPrint( "You used the " .. self.name .. "." )
		return false end,
	}
}, "base" )

