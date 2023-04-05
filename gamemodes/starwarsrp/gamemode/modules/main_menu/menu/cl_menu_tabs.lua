local MODULE = MODULE or RK.Modules:Get( "main_menu" )

hook.Add( "MainMenu:LoadTabs", "MainMenu:LoadStandardTabs", function( mainmenu )

	-- Order 1 - Inventory
	-- mainmenu:RegisterTab( "Character", {
	-- 	Order = 2,
	-- 	OnCreate = function( container )
		
	-- 	end,
	-- } )
	-- mainmenu:RegisterTab( "Quests", {
	-- 	Order = 3,
	-- 	OnCreate = function( container )
		
	-- 	end,
	-- } )
	-- mainmenu:RegisterTab( "Stats", {
	-- 	Order = 99,
	-- 	OnCreate = function( container )
		
	-- 	end,
	-- } )
	mainmenu:RegisterTab( "Options", {
		Order = 100,
		OnCreate = function( container )
			RK.Config:RequestAllConfig( LocalPlayer() )

			local m = container

			local ply = LocalPlayer()

			m.Container = m:Add( "RKCore:CategoryList" )
			m.Container:SetSize( m:GetWide(), m:GetTall() )

			m.Config = m.Config or {}

			local function refresh( cfg )
				m.Config = cfg

				m.Container:Clear()
				for k, v in SortedPairsByMemberValue( m.Config ) do
					if !m.Container:GetCategory( v.realm ) then m.Container:AddCategory( v.realm ) end

					if !v.var then continue end
					if istable( v.var ) then
						v.force_tbl = true
						v.var = util.TableToJSON( v.var )
					end
					if isfunction( v.var ) then continue end
					if IsColor( v.var ) then
						v.var = v.var:HTMLColor()
					end

					local b = vgui.Create( "DPanel" )
					m.Container:AddCategoryItem( v.realm, b )
					b:SetTall( 100 )
					b.Paint = function( s, w, h )
						-- Background
						draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )

						-- var
						local var = v.var
						local default = v.default
						local name = k

						surface.SetTextColor( 255, 255, 255, 255 )
						surface.SetFont( RKFont( 25, "Bahnschrift SemiLight Condensed" ) )
					
						surface.SetTextPos( 10, 10 )
						surface.DrawText( string.lower( name ) )

						surface.SetTextPos( 50, 40 )
						surface.DrawText( string.lower( var ) )

					end
	
				end
			end
			hook.Add( "ReceivedConfig", "RK.Menu:ReceivedConfig", function( data )
				refresh( data )
			end )
		end,
	} )
end )