local MODULE = MODULE or RK.Modules:Get( "vgui_menus" )

hook.Add( "MainMenu:LoadTabs", "Regiments:LoadTab", function( mainmenu )
	mainmenu:RegisterTab( "Regiment", {
		Order = 4,
		OnCreate = function( container )
			local function CreateRegimentPage( id )
				local m = container

				m.ScrollPanelRegiment = m:Add( "RKCore:ScrollPanel" )
				m.ScrollPanelRegiment:SetSize( m:GetWide() * 0.5 - 15, m:GetTall() - 50 )
				m.ScrollPanelRegiment:SetPos( 5, 50 )

				m.ScrollPanelInvite = m:Add( "RKCore:ScrollPanel" )
				m.ScrollPanelInvite:SetSize( m:GetWide() * 0.5 - 15, m:GetTall() - 50 )
				m.ScrollPanelInvite:SetPos( 10 + m:GetWide() * 0.5, 50 )

				for k, v in pairs( player.GetAll() ) do

					if v:GetRegiment() == id then
						local b = vgui.Create( "RKCore:Button" )
						b:SetSize( m.ScrollPanelRegiment:GetWide(), 40 )
						b:Dock( TOP )
						b:DockMargin( 0, 0, 0, 5 )
						b:SetText( "" )
						b.DoClick = function( s )

							if !LocalPlayer():IsAdmin() then
								if LocalPlayer():GetRegiment() != v:GetRegiment() then
									return false
								end
						
								if !LocalPlayer():HasAuthority() then
									return false
								end
						
								if v:IsCommander() then
									return false
								end
						
								if v:HasAuthority() and !LocalPlayer():IsCommander() then
									return false
								end
							end

							local menu = DermaMenu()
							local sub3 = menu:AddOption("Kick Player", function()
								RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
									command = "Kick Player",
									data = {
										id = id,
										target = v,
									},
								}, "server" )
							end)
							local sub = menu:AddSubMenu( "Change Rank" )
							
							for i, rank in SortedPairs( v:GetRegimentData().ranks ) do
								sub:AddOption( rank.name, function()
									--print( i, rank.name)
									RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
										command = "Promote Player",
										data = {
											id = id,
											target = v,
											rank = i
										},
									}, "server" )
								end )
							end
							--PrintTable(v:GetRegimentClasses())
							if !(v:GetRegimentClasses() == {}) then
								--print("idk")
								local sub2 = menu:AddSubMenu( "SetClass" )
								sub2:AddOption("Reset Class", function() 
									RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
										command = "Reset Class",
										data = {
											id = id,
											target = v,
											class = "reset"
										},
									}, "server" )
								
								end)
								for k,va in pairs(v:GetRegimentClasses()) do
									sub2:AddOption(va.name, function()
										RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
											command = "Change Class",
											data = {
												id = id,
												target = v,
												class = va.name
											},
										}, "server" )
										
									end)
									
								end
							end
							menu:Open()
						end
						b.PostPaint = function( s, w, h )
							draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
							draw.SimpleText( v:Nick(), RKFont( 32, "Bahnschrift SemiLight Condensed" ), 10, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
							draw.SimpleText( v:GetRegimentRankName(), RKFont( 32, "Bahnschrift SemiLight Condensed" ), w - 10, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
						end

						m.ScrollPanelRegiment:AddPanel( b )
					else
						local b = vgui.Create( "RKCore:Button" )
						b:SetSize( m.ScrollPanelRegiment:GetWide(), 40 )
						b:Dock( TOP )
						b:DockMargin( 0, 0, 0, 5 )
						b:SetText( "" )
						b.DoClick = function( s )
							local menu = DermaMenu()

							menu:AddOption( "Invite", function()
								RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
									command = "Invite Player",
									data = {
										id = id,
										target = v,
									},
								}, "server" )
							end )

							if LocalPlayer():IsAdmin() then
								menu:AddOption( "Force Regiment", function()
									RK.Net:SendNetData( "RK.Admin:RequestDataChange", { ["command"] = "Set Regiment", [ "data" ] = { id = id, target = v } }, "server" )
								end )
							end

							menu:Open()
						end
						b.PostPaint = function( s, w, h )
							draw.SimpleText( v:Nick(), RKFont( 32, "Bahnschrift SemiLight Condensed" ), 10, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
							draw.SimpleText( v:GetRegimentData()["name"] .. " - " .. v:GetRegimentRankName(), RKFont( 32, "Bahnschrift SemiLight Condensed" ), w - 10, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
						end
						m.ScrollPanelInvite:AddPanel( b )
					end
				end
			end

			local function CreateMainRegimentPage()
				local m = container
				local ply = LocalPlayer()

				local p_a, p_b = -1, -1
				local size = ( m:GetWide() / 6 ) - 10

				m.ScrollPanel = m:Add( "RKCore:ScrollPanel" )
				m.ScrollPanel:SetSize( m:GetWide(), m:GetTall() - 50 )
				m.ScrollPanel:SetPos( 0, 50 )

				for i = -1, 16 do
					local reg = RK.Regiment:GetByID( i + 2 )

					if i % 6 == 5 then p_b = p_b + 1; p_a = -1 end
					p_a = p_a + 1

					local b = vgui.Create( "DPanel" )
					b:SetSize( size, size )
					b:SetPos( p_a * (size + 5), p_b * (size + 5) )
					b.Paint = function( s, w, h )
						-- Background
						draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
					end
					b.PaintOver = function( s, w, h )
						if reg then
							draw.SimpleText( reg.name, RKFont( 24, "Bahnschrift SemiLight Condensed" ), w * 0.5, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
						end
					end
					b.ID = i + 2

					if reg then

						local model = vgui.Create( "DModelPanel", b )
						model:SetPos( 0, b:GetTall() * 0.1 )
						model:SetSize( b:GetWide(), b:GetTall() * 0.9 )
						model:SetModel( reg.model )
						model:SetSkin( reg.skin )
						model:SetAnimated( false )
						function model:LayoutEntity( Entity ) return end
						if model.Entity and IsValid( model.Entity ) then
							local bone = model.Entity:LookupBone( "ValveBiped.Bip01_Head1" )
							if bone then
								local eyepos = model.Entity:GetBonePosition( bone )

								eyepos:Add( Vector( 0, 0, 2 ) )	-- Move up slightly

								model:SetLookAt( eyepos )

								model:SetCamPos( eyepos - Vector( -15, 0, 0 ) )	-- Move cam in front of eyes

								model.Entity:SetEyeTarget( eyepos - Vector( -12, 0, 0 ) )
							end
						end

						local overlay_button = vgui.Create( "DButton", b )
						overlay_button:SetSize( b:GetWide(), b:GetTall() )
						overlay_button:SetPos( 0, 0 )
						overlay_button:SetText( "" )
						overlay_button.DoClick = function()
							container:Clear()

							CreateRegimentPage( b.ID )
						end
						overlay_button.Paint = function( s, w, h )
						end

					end

					m.ScrollPanel:AddPanel( b )
				end
			end

			CreateMainRegimentPage()
		end,
	} )
end )
