local items = {}

local hyper_colours = {
	[ "price" ] = Color( 200, 150, 0 ),
	[ "republic" ] = Color( 100, 150, 150 ),
	[ "class" ] = Color( 200, 20, 80 ),
	[ "credits" ] = Color( 0, 150, 200 ),
	[ "weight" ] = Color( 100, 255, 150 ),
}

local function number_checker( txt )
	local num_check = string.Explode( "", txt )

	local num_check_bool = true
	for k, v in pairs( num_check ) do
		if ( tonumber( v ) ) then
			return true
		end
	end
	return false
end

local function string_formater( txt )

	txt = txt:gsub( "\n", "" )
	local txt_check = string.Explode( "", txt )
	local txt_check_bool = true
	local new_txt = ""
	
	for k, v in pairs( txt_check ) do
		if v == "." then continue end
		if v == ":" then continue end
		if v == "," then continue end
		if v == "\n" then continue end
		new_txt = new_txt .. v
	end
	return new_txt
end

local function get_text_colour_table( txt )

	local new_txt = {}

	for k, v in pairs( txt ) do
		local tbl = string.Explode( " ", v )

		for _, var in pairs( tbl ) do
			if number_checker( var ) then
				table.insert( new_txt, Color( 0, 150, 200 ) )
				table.insert( new_txt, string.Comma( var ) )
			continue end

			local var_sort = string.lower( string_formater( var ) )

			if hyper_colours[ string.lower( var_sort ) ] then
				table.insert( new_txt, hyper_colours[ var_sort ] )
				table.insert( new_txt, var )
			else
				table.insert( new_txt, Color( 200, 200, 200 ) )
				table.insert( new_txt, var )
			end
		end
	end

	return new_txt
end

hook.Add( "MainMenu:LoadTabs", "MainMenu:LoadInventory", function( mainmenu )
	mainmenu:RegisterTab( "Inventory", {
		Order = 1,
		OnCreate = function( container )
			local cols = 8
			local size = ( ( container:GetWide() * 0.8 ) / cols ) - 6.5 -- 5 is the padding
			local ply = LocalPlayer()
			local inv = ply:GetInventory()

			// Create the inventory panel
			local inventory = vgui.Create( "RKCore:ScrollPanel", container )
			inventory:SetPos( 0, 50 )
			inventory:SetSize( container:GetWide() * 0.8 - 5, container:GetTall() - 50 )
			inventory.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
			end

			// Create the inventory Grid
			local grid = vgui.Create( "DGrid", inventory )
			grid:SetPos( 0, 0 )
			grid:SetSize( inventory:GetWide() * 0.8 - 5, inventory:GetTall() )
			grid:SetCols( cols )
			grid:SetColWide( size + 5 )
			grid:SetRowHeight( size + 5 )
			grid.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
			end

			// Create the inventory items
			for i = 1, 64 do
				local item = vgui.Create( "RKCore:InventoryItem", grid )
				item:SetSize( size, size )
				item.Paint = function( self, w, h )
					draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
				end
				item:SetupInventory( i )

				--local imagineimage = vgui.Create( "DImage", item )
				--imagineimage:SetPos()
				--imagineimage:SetSize(size,size)
				--imagineimage:SetImage("vgui/avatar_default", "vgui/avatar_default")

				grid:AddItem( item )

			end

			// Create the item info panel
			local info = vgui.Create( "DPanel", container )
			info:SetPos( container:GetWide() * 0.8 + 5, 0 )
			info:SetSize( container:GetWide() * 0.2 - 5, container:GetTall() - 60 )
			info.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
			end

			// Create the item info title
			local title = vgui.Create( "DLabel", info )
			title:SetPos( 10, 0 )
			title:SetSize( info:GetWide(), 50 )
			title:SetFont( RKFont( 42 ) )
			title:SetText( string.lower( "Item Info" ) )
			title:SetTextColor( Color( 100, 200, 255, 255 ) )

			// Create the item info description
			local description = vgui.Create( "RKCore:RichText", info )
			description:SetPos( 0, 55 )
			description:SetSize( info:GetWide(), info:GetTall() - 55 )
			description:SetText( "" )
			description.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
			end
			description.Refresh = function( self, ... )
				self:SetText( "" )

				self:AddText( Color( 255, 255, 255 ), "Description:\n\n" )

				local col = Color( 200, 200, 200 )
				local txt = { ... }

				if !txt or txt == "" then	
					self:AddText( col, "Select an item to view its details." )
				return end

				for k, v in pairs( get_text_colour_table( txt ) ) do
					if isstring( v ) then
						self:AddText( col, ( k == 1 or k == 2 ) and v or " " .. v )
					else
						col = v
					end
				end
			end

			description:Refresh()
			
			function grid:OnItemSelect( item )
				if !item then
					description:Refresh()
				return end

				local item_base = RK.Inventory:GetItem( item.data.base or item.name ).data

				local txt = ( item_base.description and item_base.description or item.name ) .. " \n\nItem Data:\n"

				txt = txt .. "    " .. "Name: " .. item.name .. "\n"

				for k, v in pairs( item_base ) do
					if k == "description" then continue end
					if k == "model" then continue end
					if k == "nostack" then continue end
					if k == "name" then continue end
					if k == "base" then continue end
					if isfunction( v ) then continue end
					if istable( v ) then continue end

					txt = txt .. "    " ..  string.LUpper( k ) .. ": "
					txt = txt .. tostring( v ) .. "\n"
				end
				description:Refresh( txt )
			end

		end,
	} )
end )