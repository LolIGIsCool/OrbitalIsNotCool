TOOL.Category = "Kirby"
TOOL.Name = "Zoning"
TOOL.name = TOOL.Name
TOOL.Command = nil
TOOL.ConfigName = "" --Setting this means that you do not have to create external configuration files to define the layout of the tool config-hud 

function TOOL:LeftClick( trace )
	if CLIENT then return end
	if !util.Delay( 0 ) then return end
	local wep = self:GetOwner():GetActiveWeapon()

	wep:SetNWVector( "ZonePos", trace.HitPos )
return true end
 
function TOOL:RightClick( trace )
	if CLIENT then return end
	if !util.Delay( 0 ) then return end
	local wep = self:GetOwner():GetActiveWeapon()

	wep:SetNWVector( "ZonePos2", trace.HitPos )
return true end

function TOOL:Reload()
	if CLIENT then return end
	if !util.Delay( 1 ) then return end
	local wep = self:GetOwner():GetActiveWeapon()

	wep:SetNWVector( "ZonePos", Vector( 0, 0, 0 ) )
	wep:SetNWVector( "ZonePos2", Vector( 0, 0, 0 ) )
	self:GetOwner():Notify( "Zoning cleared!" )

	local files = file.Find( "swrp/zones/" .. game.GetMap() .. "/*", "DATA" )
	local count = #files

	RK.Zones:SaveZone( { name = count, ["position"] = { wep:GetNWVector( "ZonePos" ), wep:GetNWVector( "ZonePos2" ) } } )

	self:GetOwner():Notify( "Zone Saved! ID: " .. count )
	self:GetOwner():PrintMessage( HUD_PRINTCONSOLE, "Zone Saved! ID: " .. count )
return true end

if CLIENT then
	timer.Simple( 1, function()
		hook.Add("PostDrawTranslucentRenderables", "RK.Zone:PostDrawTranslucentRenderables:Tool", function()
			if !LocalPlayer() or !IsValid( LocalPlayer() ) or !LocalPlayer():Alive() then return end
			if !LocalPlayer():GetActiveWeapon() or !IsValid( LocalPlayer():GetActiveWeapon() ) then return end
			if LocalPlayer():GetActiveWeapon():GetClass() != "gmod_tool" then return end

			local wep = LocalPlayer():GetActiveWeapon()

			if !wep:GetNWVector( "ZonePos" ) then return end
			if !wep:GetNWVector( "ZonePos2" ) then return end

			local pos = wep:GetNWVector( "ZonePos" ) -- position to render box at
			local pos2 = wep:GetNWVector( "ZonePos2" ) -- position to render box at
			local x = ( pos - pos2 )

			render.SetColorMaterial() -- white material for easy coloring

			-- cam.IgnoreZ( true ) -- makes next draw calls ignore depth and draw on top
			render.DrawBox( pos, angle_zero, Vector( 0, 0, 0 ), -x, Color( 255, 255, 255, 75 ) ) -- draws the box 
			-- cam.IgnoreZ( false ) -- disables previous call
		end )
	end )
end 
print( "Zoning tool loaded" )