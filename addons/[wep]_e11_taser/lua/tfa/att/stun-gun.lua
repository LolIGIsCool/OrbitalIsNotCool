if not ATTACHMENT then
	ATTACHMENT = {}
end

if SERVER then
	util.AddNetworkString("STUN_Effect")

	hook.Add("PlayerSwitchWeapon", "STUN_DisableRagdolledShooter", function(ply)
		if(IsValid(ply) and ply:STUN_IsRagdolled()) then
			ply:StripWeapons()
		end
	end)
end

ATTACHMENT.Name = "Stun"
ATTACHMENT.ShortName = "S"
ATTACHMENT.Icon = "effects/stun-gun.png"
ATTACHMENT.Description = {  
    TFA.AttachmentColors["="], "Stun fire mode", 
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["RPM"] = 60,
		["Sound"] = Sound("weapons/stun-sound.ogg"),
		["NumShots"] = 1,
	},
	["TracerName"] = "effect_sw_stun_laser_blue",
}

local plyMeta = FindMetaTable("Player")

function plyMeta:STUN_IsRagdolled()
	if(self.STUN_Ragdolled == nil) then return false end

	return self.STUN_Ragdolled
end

function plyMeta:STUN_SetInvisible(invisible)
	self:SetNoDraw(invisible)
	self:SetNotSolid(invisible)

	self:DrawViewModel(!invisible)
	self:DrawWorldModel(!invisible)

	if (invisible) then
		self:GodEnable()
	else
		self:GodDisable()
	end
end

function plyMeta:STUN_RagdollEntity(addVelocity)
	self.STUN_Weapons = {}
	self.STUN_Health = self:Health()
	self.STUN_Armor = self:Armor()
	self.STUN_Color = self:GetColor()
	self.STUN_Material = self:GetMaterial()

	self.STUN_Ragdoll = ents.Create("prop_ragdoll")
	self.STUN_Ragdoll.Stunned = true
	self.STUN_Ragdoll.STUN_Owner = self
	self.STUN_Ragdoll:SetPos(self:GetPos())
	self.STUN_Ragdoll:SetModel(self:GetModel())
	self.STUN_Ragdoll:SetAngles(self:GetAngles())
	self.STUN_Ragdoll:SetSkin(self:GetSkin())
	self.STUN_Ragdoll:SetMaterial(self:GetMaterial())
	self.STUN_Ragdoll:Spawn()

	self.STUN_Ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	local velocity = self:GetVelocity()
	addVelocity:Mul(200)
	velocity = velocity + Vector(addVelocity.x, addVelocity.y, 75)

	local physObjects = self.STUN_Ragdoll:GetPhysicsObjectCount() - 1

	for i = 0, physObjects do
		local bone = self.STUN_Ragdoll:GetPhysicsObjectNum(i)

		if IsValid(bone) then
			local position, angle = self:GetBonePosition(self.STUN_Ragdoll:TranslatePhysBoneToBone(i))

			if (position and angle) then
				bone:SetPos(position)
				bone:SetAngles(angle)
			end

			bone:AddVelocity(velocity)
		end
	end

	for k, weapon in pairs(self:GetWeapons()) do
		if IsValid(weapon) then
			table.insert(self.STUN_Weapons, weapon:GetClass())
		end
	end

	self:StripWeapons()
	self:SetMoveType(MOVETYPE_OBSERVER)
	self:Spectate(OBS_MODE_CHASE)
	self:SpectateEntity(self.STUN_Ragdoll)
	self:SetParent(self.STUN_Ragdoll)

	self.STUN_Ragdoll:SetColor(Color(171, 171, 247))
    self.STUN_Ragdoll:SetMaterial("models/debug/debugwhite")

	timer.Simple(0.075, function()
		self.STUN_Ragdoll:SetMaterial(self.STUN_Material)
        self.STUN_Ragdoll:SetColor(self.STUN_Color)
	end)

	if SERVER then
		timer.Simple(0, function()
			net.Start("STUN_Effect")
			net.WriteEntity(self.STUN_Ragdoll)
			net.Broadcast()
		end)
	end

	self.STUN_Ragdolled = true

	timer.Simple(15, function()
		if IsValid(self) and IsValid(self) then
			self:STUN_UnRagdollEntity(self)
		end
	end)

	self:STUN_SetInvisible(true)
end

function plyMeta:STUN_UnRagdollEntity()
	if(self.STUN_Ragdolled) then
		self.STUN_Ragdolled = false
	else 
		return
	end
		
	self:STUN_SetInvisible(false)
    
	local position = self.STUN_Ragdoll:GetPos()

	self.STUN_Ragdoll:Remove()

	self:Spawn()
	timer.Simple(0, function()
		self:SetPos(position + Vector(0, 0, 5))
	end)
	self:UnSpectate()
	self:SetParent(NULL)

	for k, weapon in pairs(self.STUN_Weapons) do
		self:Give(weapon)
	end

	self:SetHealth(self.STUN_Health or 100)
	self:SetArmor(self.STUN_Armor or 0)

	self.STUN_Weapons = nil
end

function ATTACHMENT:ShootBullet(...)
	if not IsFirstTimePredicted() and not game.SinglePlayer() then return end

	local tr = self.Owner:GetEyeTrace()

	if SERVER then
		if tr.Entity and tr.Entity:IsPlayer() and IsValid(tr.Entity) and !tr.Entity:STUN_IsRagdolled() then
			tr.Entity:STUN_RagdollEntity(self.Owner:EyeAngles():Forward())
		end
	end

	local data = EffectData()
	data:SetEntity(self)
	data:SetStart(self.Owner:GetShootPos())
	data:SetOrigin(tr.HitPos)
	util.Effect("effect_sw_stun_laser_blue", data)
end

function ATTACHMENT:Attach(wep)
	wep.ShootBullet = self.ShootBullet
end

function ATTACHMENT:Detach(wep)
	wep.ShootBullet = baseclass.Get(wep.Base).ShootBullet
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
