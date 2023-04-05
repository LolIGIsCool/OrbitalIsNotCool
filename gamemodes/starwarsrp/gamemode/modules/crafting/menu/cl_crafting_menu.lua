local MODULE = MODULE or RK.Modules:Get( "crafting" )

hook.Add( "MainMenu:LoadTabs", "MainMenu:LoadCrafting", function( mainmenu )

	--print( 1 )
	mainmenu:RegisterTab( "Crafting", {
		Order = 2,
		OnCreate = function( container )

			local crafting_list = vgui.Create( "RKCore:CategoryList", container )
			crafting_list:SetPos( 0, 50 )
			crafting_list:SetSize( container:GetWide() * 0.6 - 5, container:GetTall() - 50 )
			crafting_list.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
			end

			local crafting_details = vgui.Create( "DPanel", container )
			crafting_details:SetPos( container:GetWide() * 0.6 + 5, 50 )
			crafting_details:SetSize( container:GetWide() * 0.4 - 5, container:GetTall() - 110 )
			crafting_details.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
			end

			local description = vgui.Create( "RKCore:RichText", crafting_details )
			description:SetPos( 5, 5 )
			description:SetSize( crafting_details:GetWide() - 10, crafting_details:GetTall() - 10 )
			description:SetWrap( true )
			description:SetText( "Select a recipe to view its description." )

			local craft_button = vgui.Create( "RKCore:Button", crafting_details )
			craft_button:SetPos( 5, crafting_details:GetTall() - 35 )
			craft_button:SetSize( crafting_details:GetWide() - 10, 30 )
			craft_button:SetText( "Craft" )

			local selected_recipe = nil

			local function UpdateCraftingList()

				crafting_list:Clear()
				
				local input_data = {}
				local output_data = {}

				for k, v in pairs( MODULE:GetRecipes() ) do
					input_data = v.Recipe.input
					output_data = v.Recipe.output
					---PrintTable(input_data)
					
					---PrintTable(input_data)
					--PrintTable(output_data)
					
					for name, amount in pairs( output_data ) do
						--print("1")
						local item_data = RK.Inventory:GetItem( name )
						if !item_data then continue end
						if v.CanSee and !v.CanSee( LocalPlayer(), item_data ) then continue end
						item_data.data.category = item_data.data.category or "Other"

						if !crafting_list:GetCategory( string.lower( item_data.data.category ) ) then
							local cat = crafting_list:AddCategory( string.lower( item_data.data.category ) )
							cat:SetExpanded( false )
						end

						local item = vgui.Create( "RKCore:Button" )
						item:SetSize( crafting_list:GetWide(), 50 )
						item:SetText( "" )
						item.PostPaint = function( s, w, h )
							// draw the item name
							draw.SimpleTextOutlined( item_data.data.name, RKFont( 28, "Bahnschrift SemiLight Condensed" ), 10, h * 0.5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
						end
						item.DoClick = function( s )
							
							selected_recipe = v

							---PrintTable( v )
							--PrintTable(v.Recipe)
							local input = v.Recipe.input
							local output = v.Recipe.output
							
							--print(input)
							--print(output)
							
							description:SetText( "" )
							description:AddText( Color( 255, 255, 255 ), "Name: " .. k .. "\n\n" )

							description:AddText( Color( 255, 255, 255 ), "Materials Required: \n" )
							
							local can_afford_craft = true
							for k, v in pairs( input ) do
								--PrintTable(input_data)
								local canafford = LocalPlayer():HasInventoryItem( k )
								--print(k,v)
								if canafford then
									canafford = canafford >= v
								end

								if !canafford then
									can_afford_craft = false
								end

								description:AddText( canafford and Color( 0, 200, 100 ) or Color( 200, 50, 50 ), "	" .. k .. " - " .. v .. "\n" )
							end

							description:AddText( Color( 255, 255, 255 ), "Result: \n" )
							for k, v in pairs( output ) do
								--print(k,v)
								description:AddText( Color( 255, 255, 255 ), "	" .. k .. " - " .. v .. "\n" )
							end

							if v.CanCraft then
								craft_button:SetDisabled( !v.CanCraft( LocalPlayer() ) )
							end
							craft_button.DoClick = function( s )
								if !can_afford_craft then return end
								RK.Net:SendNetData( "RK.Crafting:Handler", {
									command = "craft",
									recipe = k,
								}, "Server" )
							end
						end

						item.data = v

						crafting_list:AddCategoryItem( string.lower( item_data.data.category ), item )

					end
					--print("end")
				end

			end

			UpdateCraftingList()

			craft_button.DoClick = function()

				if selected_recipe then

					net.Start( "Crafting:Craft" )
						net.WriteString( selected_recipe.Name )
					net.SendToServer()

				end

			end

		end
	} )
end )