AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Defon Machine"
ENT.Author = "Kirby#2015"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "Defon"

DEFCON = DEFCON or {}
DEFCON.LEVEL = DEFCON.LEVEL or 5

DEFCON.TEXT = {
	[ 1 ] = "DEFCON I. Shit...",
	[ 2 ] = "DEFCON II. Heavy ordinants are authorized.",
	[ 3 ] = "DEFCON III. The situation is serious. Force is authorised.",
	[ 4 ] = "DEFCON IV. Be on alert, Report to your commanders",
	[ 5 ] = "DEFCON V. All system nominal",
}

DEFCON.DEFCONCOLOURS = {
	[1] = Color( 255, 50, 50 ),
	[2] = Color( 255, 150, 50 ),
	[3] = Color( 255, 250, 50 ),
	[4] = Color( 50, 150, 150 ),
	[5] = Color( 0, 200, 200 ),
}

DEFCON.ROMAN = {
	[1] = "I",
	[2] = "II",
	[3] = "III",
	[4] = "IV",
	[5] = "V",
}

if SERVER then
	util.AddNetworkString( "defcon" )
	function ENT:Initialize()
		self:SetModel("models/props_combine/combine_interface001.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType( SIMPLE_USE )
		local phys = self:GetPhysicsObject()
		if IsValid( phys ) then phys:Wake() end

		-- ban dupe
		self.nodupe = true
		
	end

	function ENT:Use( ply )
		if ply:IsPlayer() then
			ply:ConCommand("defcon")
		end
	end

	net.Receive( "defcon", function( len, ply )
		local defcon = net.ReadInt( 4 )

		if !ply:HasFlag( "DefconAccess" ) then return end

		local new = math.Clamp( DEFCON.LEVEL + defcon, 1, 5 )

		if new == DEFCON.LEVEL then return end

		hook.Run( "PlayerChangedDefcon", ply, DEFCON.LEVEL, new )

		DEFCON.LEVEL = new
		for k, v in pairs( player.GetAll() ) do
			v:SetNWInt( "Defcon", DEFCON.LEVEL )
			v:SendNetMessage( "SendChatMessage", { DEFCON.DEFCONCOLOURS[ DEFCON.LEVEL ], "[DEFCON] ", Color( 225, 225, 225 ), DEFCON.TEXT[ DEFCON.LEVEL ] } )
		end
	end )

	hook.Add( "PlayerSpawn", "Defcon:PlayerSpawn", function( ply ) ply:SetNWInt( "Defcon", DEFCON.LEVEL ) end )
end

if CLIENT then
	function ENT:Draw()
		self.Entity:DrawModel()
	end

	concommand.Add( "defcon", function( ply, cmd, args )
		if !ply:HasFlag( "DefconAccess" ) then return end
		
		local trace = ply:GetEyeTrace()
		local ent = trace.Entity

		if IsValid( ent ) and ent:GetClass() == "sh_decon_machine" then

			local frame = vgui.Create( "DPanel" )
			frame.Paint = function( s, w, h )
				s:DrawBlur( 8 )
			end
			frame:SetSize( ScrW(), ScrH() )
			frame:SetPos( 0, 0 )
			frame:SetVisible( true )
			frame:MakePopup()

			local raise_defcon = vgui.Create( "RKCore:Button", frame )
			raise_defcon:SetText( "Raise Defcon" )
			raise_defcon:SetSize( ScrW() * 0.5, 80 )
			raise_defcon:SetPos( ScrW() * 0.25, ScrH() * 0.5 - 40 )
			raise_defcon.DoClick = function()
				net.Start( "defcon" )
					net.WriteInt( -1, 4 )
				net.SendToServer()
				frame:Remove()
			end

			local lower_defcon = vgui.Create( "RKCore:Button", frame )
			lower_defcon:SetText( "Lower Defcon" )
			lower_defcon:SetSize( ScrW() * 0.5, 80 )
			lower_defcon:SetPos( ScrW() * 0.25, ScrH() * 0.5 + 40 )
			lower_defcon.DoClick = function()
				net.Start( "defcon" )
					net.WriteInt( 1, 4 )
				net.SendToServer()
				frame:Remove()
			end

			local back = vgui.Create( "RKCore:Button", frame )
			back:SetText( "Cancel" )
			back:SetSize( ScrW(), 80 )
			back:SetPos( 0, ScrH() - 80 )
			back.DoClick = function()
				frame:Remove()
			end
		end
	end )

end