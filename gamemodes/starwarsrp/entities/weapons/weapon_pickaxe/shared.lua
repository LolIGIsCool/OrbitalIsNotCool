SWEP.PrintName = "Pickaxe"
SWEP.Slot = 0
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.HoldType = "melee"

SWEP.ClipSize = -1
SWEP.DefaultClip = -1
SWEP.Automatic = false
SWEP.Ammo = "none"

SWEP.Spawnable = true

function SWEP:Deploy()
	self:SetHoldType( self.HoldType )
end

function SWEP:PrimaryAttack()
	if !SERVER then return end
	local tr = self.Owner:GetEyeTrace()

	if tr.Hit and tr.HitPos:Distance( self.Owner:GetShootPos() ) <= 80 then
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Owner:ViewPunch( Angle( -10, 0, 0 ) )
		self.Owner:LagCompensation( true )
			
			local ent = tr.Entity
			if IsValid( ent ) then
				local dmginfo = DamageInfo()
				dmginfo:SetDamage( math.random( 10, 20 ) )
				dmginfo:SetDamageType( DMG_CLUB )
				dmginfo:SetAttacker( self.Owner )
				dmginfo:SetInflictor( self.Weapon )
				dmginfo:SetDamageForce( self.Owner:GetAimVector() * 1500 )
				dmginfo:SetDamagePosition( self.Owner:GetPos() )
				ent:TakeDamageInfo( dmginfo )
			end
			self:SetNextPrimaryFire( CurTime() + 2 )
		self.Owner:LagCompensation( false )
	end
	return false
end

function SWEP:SecondaryAttack()
	return false
end