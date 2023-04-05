local MODULE = MODULE or RK.Modules:Get( "vgui_menus" )


hook.Add( "MainMenu:LoadTabs", "Regiments:LoadTab2", function( mainmenu )
	mainmenu:RegisterTab( "Regiment2", {
		Order = 5,
		OnCreate = function( container )
            --print("bruh sauce")
            local localid
            local function CreateRegimentPage( id )
				local m = container
                local selected_player = nil
                localid = id
				m.ScrollPanelRegiment2 = m:Add( "RKCore:ScrollPanel" )
				m.ScrollPanelRegiment2:SetSize( m:GetWide() * 0.5 - 15, m:GetTall() - 50 )
				m.ScrollPanelRegiment2:SetPos( 10 + m:GetWide() * 0.5, 50 )
                local function ResetPlayers()
                    m.ScrollPanelRegiment2:Clear()
                    for k,v in ipairs(player.GetAll()) do 
                       if v:GetRegiment() != id then break end
                       local b = vgui.Create( "RKCore:Button" )
				    	b:SetSize( m.ScrollPanelRegiment2:GetWide(), 40 )
				    	b:Dock( TOP )
				    	b:DockMargin( 0, 0, 0, 5 )
				    	b:SetText( "" )
				    	b.DoClick = function( s )

                           selected_player = v

                       end

                        b.PostPaint = function( s, w, h )
                            draw.SimpleText( v:Nick(), RKFont( 32, "Bahnschrift SemiLight Condensed" ), 10, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                            draw.SimpleText( v:GetRegimentData()["name"] .. " - " .. v:GetRegimentRankName(), RKFont( 32, "Bahnschrift SemiLight Condensed" ), w - 10, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                        end

                        m.ScrollPanelRegiment2:AddPanel( b )

                    end
                end
                ResetPlayers()

                local promote = vgui.Create( "RKCore:Button", m )
                promote:SetSize( m:GetWide() * 0.2 - 15, 40 )
                promote:SetPos( 10, 50 )
                promote:SetText( "Promote Player" )
                promote.DoClick = function( s )
                    if selected_player != nil then
                        --print("Promote Button " .. selected_player:SteamID64())
                        local v = selected_player
                        if not v:GetRegimentRanks()[v:GetRegimentRank() + 1] then return end
                        RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
                            command = "Promote Player",
                            data = {
                                id = localid,
                               target = v,
                                rank = v:GetRegimentRank() + 1
                            },
                        }, "server" )

                        selected_player = nil
                        ResetPlayers()
                    end
                end
                promote.PostPaint = function( s, w, h )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
                end


                local demote = vgui.Create( "RKCore:Button", m )
                demote:SetSize( m:GetWide() * 0.2 - 15, 40 )
                demote:SetPos( 10, 100 )
                demote:SetText( "Demote Player" )
                demote.DoClick = function( s )
                    if selected_player != nil then
                        local v = selected_player
                        if not v:GetRegimentRanks()[v:GetRegimentRank() - 1] then return end
                        RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
                            command = "Promote Player",
                            data = {
                                id = localid,
                                target = v,
                                rank = v:GetRegimentRank() - 1
                            },
                        }, "server" )
    
                        selected_player = nil
                        ResetPlayers()
                    end
                end
                demote.PostPaint = function( s, w, h )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
                end

                local changeclass = vgui.Create( "RKCore:Button", m )
                changeclass:SetSize( m:GetWide() * 0.2 - 15, 40 )
                changeclass:SetPos( 10, 150 )
                changeclass:SetText( "Change Class" )
                changeclass.DoClick = function( s )
                    local menu = DermaMenu()
                    if selected_player != nil then
                    --print("changeclass Button " .. selected_player)

                    if !(selected_player:GetRegimentClasses() == {}) then
                        --print("idk")
                        local sub2 = menu:AddSubMenu( "SetClass" )
                        sub2:AddOption("Reset Class", function() 
                            RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
                                command = "Reset Class",
                                data = {
                                    id = id,
                                    target = selected_player,
                                    class = "reset"
                                },
                            }, "server" )
                            selected_player = nil
                            ResetPlayers()
                        
                        end)
                        for k,va in pairs(selected_player:GetRegimentClasses()) do
                            sub2:AddOption(va.name, function()
                                RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
                                    command = "Change Class",
                                    data = {
                                        id = id,
                                        target = selected_player,
                                        class = va.name
                                    },
                                }, "server" )
                                selected_player = nil
                                ResetPlayers()
                            end)
                            
                        end
                    end

                    menu:Open()
                    end
                end
                changeclass.PostPaint = function( s, w, h )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
                end


                local kick = vgui.Create( "RKCore:Button", m )
                kick:SetSize( m:GetWide() * 0.2 - 15, 40 )
                kick:SetPos( 10, 200 )
                kick:SetText( "Kick Player" )
                kick.DoClick = function( s )
                    if selected_player != nil then
                        --print("kick Button " .. selected_player)

                        RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
                            command = "Kick Player",
                            data = {
                                id = id,
                                target = selected_player,
                            },
                        }, "server" )

                        selected_player = nil
                        ResetPlayers()
                    end
                end
                kick.PostPaint = function( s, w, h )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
                end

            end
            local function CreateInvitePage(regnum)
                local m = container

                local reg = regnum

				m.ScrollPanelRegiment2 = m:Add( "RKCore:ScrollPanel" )
				m.ScrollPanelRegiment2:SetSize( m:GetWide() * 0.5 - 15, m:GetTall() - 50 )
				m.ScrollPanelRegiment2:SetPos( 10 + m:GetWide() * 0.5, 50 )

                for k,v in ipairs(player.GetAll()) do
                    if v == LocalPlayer() then break end
                    local b = vgui.Create( "RKCore:Button" )
				    b:SetSize( m.ScrollPanelRegiment2:GetWide(), 40 )
				    b:Dock( TOP )
				    b:DockMargin( 0, 0, 0, 5 )
				    b:SetText( "" )
				    b.DoClick = function( s )
                       selected_player = v
                    end

                    b.PostPaint = function( s, w, h )
                        draw.SimpleText( v:Nick(), RKFont( 32, "Bahnschrift SemiLight Condensed" ), 10, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                        draw.SimpleText( v:GetRegimentData()["name"], RKFont( 32, "Bahnschrift SemiLight Condensed" ), w - 10, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                    end

                    m.ScrollPanelRegiment2:AddPanel( b )

                end

                local invite = vgui.Create( "RKCore:Button", m )
                invite:SetSize( m:GetWide() * 0.2 - 15, 40 )
                invite:SetPos( 10, 200 )
                invite:SetText( "Invite or somthing" )
                invite.DoClick = function( s )
                    if selected_player != nil then
                        --print("kick Button " .. selected_player)

                        RK.Net:SendNetData( "RK.Regiments:RequestDataChange", {
                            command = "Invite Player",
                            data = {
                                id = id,
                                target = selected_player,
                            },
                        }, "server" )

                        selected_player = nil
                        ResetPlayers()
                    end
                end
                invite.PostPaint = function( s, w, h )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
                end

                -- man idfk i hate guis and shiii
            end
            local function CreateMainPage()
                local m = container

                local invite = vgui.Create( "RKCore:Button", m )
                invite:SetSize( m:GetWide() * 0.2 - 15, 40 )
                invite:SetPos( 10, 50 )
                invite:SetText( "Invite or somethting" )
                invite.DoClick = function( s )
                    print("Invite selected")
                    container:Clear()
                    CreateInvitePage(LocalPlayer():GetRegiment())
                end
                local manage = vgui.Create( "RKCore:Button", m )
                manage:SetSize( m:GetWide() * 0.2 - 15, 40 )
                manage:SetPos( 10, 150 )
                manage:SetText( "Manage or somethting" )
                manage.DoClick = function( s )
                    print("Manage selected")
                    container:Clear()
                    CreateRegimentPage( LocalPlayer():GetRegiment() )
                end
                --local 

            end
            --CreateRegimentPage("id")
            CreateMainPage()
        end,
	} )
end )