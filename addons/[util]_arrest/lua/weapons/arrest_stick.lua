AddCSLuaFile()

if CLIENT then
	SWEP.Slot = 1
	SWEP.SlotPos = 3
end

DEFINE_BASECLASS("stick_base")

SWEP.Instructions = "Left click to arrest\nRight click to switch batons"
SWEP.IsDarkRPArrestStick = true

SWEP.PrintName = "Arrest Baton"
SWEP.Spawnable = true

SWEP.StickColor = Color(255, 255, 0)

SWEP.Switched = true

function SWEP:Deploy()
	self.Switched = true
	return BaseClass.Deploy(self)
end

function SWEP:PrimaryAttack()
	BaseClass.PrimaryAttack(self)

	if CLIENT then return end

	local Owner = self:GetOwner()

	if not IsValid(Owner) then return end

	Owner:LagCompensation(true)
	local trace = util.QuickTrace(Owner:EyePos(), Owner:GetAimVector() * 90, {Owner})
	Owner:LagCompensation(false)

	local ent = trace.Entity

	local stickRange = self.stickRange * self.stickRange
	if not IsValid(ent) or (Owner:EyePos():DistToSqr(ent:GetPos()) > stickRange) or not ent:IsPlayer() then
		return
	end

	if ent.Arrested then
		bArrest.UnArrest(ent, Owner)
	else
		bArrest.Arrest(ent, Owner)
	end
end


function SWEP:SecondaryAttack()
	BaseClass.PrimaryAttack(self)

	if CLIENT then return end

	local Owner = self:GetOwner()

	if not IsValid(Owner) then return end

	Owner:LagCompensation(true)
	local trace = util.QuickTrace(Owner:EyePos(), Owner:GetAimVector() * 90, {Owner})
	Owner:LagCompensation(false)

	local ent = trace.Entity

	local stickRange = self.stickRange * self.stickRange
	if not IsValid(ent) or (Owner:EyePos():DistToSqr(ent:GetPos()) > stickRange) or not ent:IsPlayer() then
		return
	end

	if ent.Arrested then
		bArrest.UnArrest(ent, Owner)
	end
end
