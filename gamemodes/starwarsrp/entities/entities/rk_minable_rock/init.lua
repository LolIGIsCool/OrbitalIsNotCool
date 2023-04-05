AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

ENT.DropCount = 1

function ENT:Initialize()
	self:SetModel( self.Model )
	self:SetMaterial( "models/shiny" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	self:AddEFlags( EFL_FORCE_CHECK_TRANSMIT )

	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then
		phys:EnableMotion()
		phys:Wake()
	end

	self.DropCount = math.random( 2, 5 )
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end

local tbl = {
	"Metal","Metallurgy","Aeroxite","Agrinium","Alum","Alumabronze","Aluminium","Aluminium","Arcetron","Aurodium","Aurodium","Bandorium","Barabbian","Beryllius",
	"Beskar","Bondite","Brass","Brass","Bronzium","Calcium","Carbonite","Carbonite","Charubah steel","Chromium",
	"Ciridium","Codoan Copper","Codoran","Colat","Copper","Copper","Corellian gold","Cortosis","Corundum","Coruscanthium",
	"Crodium","Cubirian","Desh","Desh","Diatium","Doonium","Doonium","Duralium","Duraplast","Durite",
	"Electrum","Erkinite","Farium","Frasium","Fravisite","Gententhium","Gold","Gold","Guerrerite",
	"Haysian smelt","Hollinium","Inoxium","Iridium (element)","Iron","Kelsh","Kiirium","Laminanium","Laminasteel",
	"Lutetium","Mandalorian iron","Manganese","Midlithe crystal","Mullinine","Mythra","Neuranium","Nickel",
	"Nutorium","Nyix","Nykkalt","Orichalc","Orichalc","Orichalum","Osmiridium","Osmium","Osmium","Peace-sealing","Phosphorus","Platinum","Platinum","Polyfibe",
	"Promethium","Pyronium","Quadanium steel","Quadranium","Quadranium","Rhodium","Rippinnium","Ruusan copper","Sarrassian iron","Sarrassian iron","Scatrium",
	"Serenno silver","Silver","Silver","Slivian iron","Songsteel","Tanium","Terenthium","Tin","Titanium","Titanium",
	"Tricopper","Trimantium","Tungsten","Tungsten","Tunqstoid","Turadium","Ultrachrome","Vanadium","Vanadium",
	"Vandinite","Varium","Vonium","Vonium","Xonolite",
}

function ENT:OnTakeDamage( dmg )
	local attacker = dmg:GetAttacker()

	if !attacker:IsPlayer() then return end
	if attacker:Team() == TEAM_SPECTATOR then return end
	local wep = attacker:GetActiveWeapon()

	if !IsValid( wep ) then return end
	if wep:GetClass() != "weapon_pickaxe" then return end

	local item = table.Random( tbl )
	--print(item)
	attacker:AddInventoryItem( item, 1 )
	attacker:Notify( "You picked up a " .. item .. "." )

	self.DropCount = self.DropCount - 1

	if self.DropCount <= 0 then
		self:Remove()
	end

	return false
end
