net.Receive("ArrestPositions", function()
	bArrest.Positions = net.ReadTable()
end)

net.Receive("ArrestPlayers", function()
	bArrest.Players = net.ReadTable()
end)

surface.CreateFont("ArrestTitle", {
	font = "Roboto",
	size = 80,
})

surface.CreateFont("ArrestName", {
	font = "Roboto",
	size = 50,
})

surface.CreateFont("ArrestTime", {
	font = "Roboto",
	size = 35,
})


function PromptArrester(str)
	local name 
	for k,v in ipairs(player.GetAll()) do
		if tostring(str) == tostring(v:SteamID64()) then
			name = v:Nick()
		end
	end
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Arrested player" )
	Frame:SetSize( 200,200 )
	Frame:SetPos(ScrW() * 0.9, ScrH()/10)
	--Frame:Center()			
	--Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 231, 76, 60, 150 ) ) -- Draw a red box instead of the frame
		draw.SimpleText("Arrested player: " .. name, "DermaDefault", 20, 30, color_white)
	end
		
	local Button = vgui.Create("DButton", Frame)
	Button:SetText( "Open Menu" )
	Button:SetTextColor( Color(255,255,255) )
	Button:SetPos( 50, 100 )
	Button:SetSize( 100, 30 )
	Button.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) ) -- Draw a blue button
	end
	Button.DoClick = function()
		--print( str )
		Button:GetParent():Close()
		ArrestedPlayer(str, name)
	end
end

function ArrestedPlayer(str, name)
	--print(str)
	--print("prompt")
	
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Arrested player" )
	Frame:SetSize( ScrW()/5,ScrH()/3 )
	Frame:Center()			
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 231, 76, 60, 150 ) ) -- Draw a red box instead of the frame
		draw.RoundedBox( 2, 5, 20, w-10, h-25, color_black )
		--draw.SimpleText("Arrested player: " .. str, "DermaDefault", 20, 30, color_white)
		--draw.SimpleText("Arresting Offcer: " .. LocalPlayer():Nick(), "DermaDefault", 20, 40, color_white)
	end
	
	local ArrestPly = vgui.Create( "DLabel", Frame )
	ArrestPly:SetFont("DermaDefault")
	ArrestPly:SetColor( color_white )
	ArrestPly:SetPos( 20, 30 )
	ArrestPly:SetSize(200,20)
	ArrestPly:SetText( "Arrested Player: " .. name )
	
	local ArrestOff = vgui.Create( "DLabel", Frame )
	ArrestOff:SetFont("DermaDefault")
	ArrestOff:SetColor( color_white )
	ArrestOff:SetPos( 20, 45 )
	ArrestOff:SetSize(200,20)
	ArrestOff:SetText( "Arresting Officer: " .. LocalPlayer():Nick() )
	
	local Label1 = vgui.Create( "DLabel", Frame )
	Label1:SetFont("DermaDefault")
	Label1:SetColor( color_white )
	Label1:SetPos( 20, 65 )
	Label1:SetSize(200,20)
	Label1:SetText( "Offence:" )
	
	local TextEntry = vgui.Create( "DTextEntry", Frame ) 
	TextEntry:SetPos(20,80)
	TextEntry:SetSize(100,20)
	TextEntry:SetPlaceholderText( "Murder" )
	
	
	local Label2 = vgui.Create( "DLabel", Frame )
	Label2:SetFont("DermaDefault")
	Label2:SetColor( color_white )
	Label2:SetPos( 20, 105 )
	Label2:SetSize(200,20)
	Label2:SetText( "Time: (Minutes)" )
	
	local TextEntry2 = vgui.Create( "DTextEntry", Frame ) 
	TextEntry2:SetPos(20,120)
	TextEntry2:SetSize(100,20)
	TextEntry2:SetPlaceholderText( "20" )
	
	local Label3 = vgui.Create( "DLabel", Frame )
	Label3:SetFont("DermaDefault")
	Label3:SetColor( color_white )
	Label3:SetPos( 20, 145 )
	Label3:SetSize(200,20)
	Label3:SetText( "Bail: (Optional)" )
	
	local TextEntry3 = vgui.Create( "DTextEntry", Frame ) 
	TextEntry3:SetPos(20,160)
	TextEntry3:SetSize(100,20)
	TextEntry3:SetPlaceholderText( "5000" )
	
	
	local DButton1 = vgui.Create( "DButton", Frame )
	DButton1:SetText( "Submit" )
	DButton1:SetPos( 20, 200 )
	DButton1:SetSize( 50, 30 )
	DButton1.DoClick = function()
		print(TextEntry:GetValue())
		print(TextEntry2:GetValue())
		print(TextEntry3:GetValue())
		print("AOS Submitted!")
		Frame:Close()
		net.Start("ArrestedPly")
			net.WriteString(TextEntry:GetValue())
			net.WriteString(TextEntry2:GetValue())
			net.WriteString(TextEntry3:GetValue())
		net.SendToServer()
	end
	
	
	
end

---PromptArrester("76561198167414174")

local drawnPositions = {}

-- hook.Add("PostDrawTranslucentRenderables", "DrawArrestInterface", function(depth, skybox)
-- 	if skybox then return end

-- 	if not bArrest.Players or not bArrest.Positions then return end

-- 	for i, player in pairs(bArrest.Players or {}) do
-- 		if player.TimeEnd - CurTime() <= 0 then continue end

-- 		drawnPositions[player.Cell] = drawnPositions[player.Cell] or 0
-- 		local ply = player.Player
-- 		local middle = bArrest.Positions[ player.Cell ].Position
-- 		local time = string.FormattedTime(player.TimeEnd - CurTime(), "%0i:%02i")

-- 		cam.Start3D2D(middle + Vector( 0, 0, 40), Angle(180, 90, 270), 0.1)
-- 			draw.SimpleText("Arrested", "ArrestTitle", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
-- 			draw.SimpleText(time, "ArrestTime", 0, 70, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
-- 		cam.End3D2D()

-- 		cam.Start3D2D(middle + Vector( 0, 0, 40), Angle(180, 270, 270), 0.1)
-- 			draw.SimpleText("Arrested", "ArrestTitle", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
-- 			draw.SimpleText(time, "ArrestTime", 0, 70, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
-- 		cam.End3D2D()

-- 		drawnPositions[player.Cell] = drawnPositions[player.Cell] + 1
-- 	end

-- 	drawnPositions = {}
-- end)

-- hook.Add( "HUDPaint", "drawArrestPaint", function()
-- 	for k, v in pairs( bArrest.Players or {} ) do
-- 		if v.Player != LocalPlayer() then continue end
-- 		if v.TimeEnd - CurTime() <= 0 then continue end

-- 		local time = string.FormattedTime(v.TimeEnd - CurTime(), "%0i:%02i")
-- 		draw.SimpleText("Arrested", "ArrestTitle", ScrW() / 2, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
-- 		draw.SimpleText(time, "ArrestTime", ScrW() / 2, 100, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 	end
-- end )