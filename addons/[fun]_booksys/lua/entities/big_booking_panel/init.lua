TCD = TCD or {}
TCD.BOOKING = TCD.BOOKING or {}

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/hunter/plates/plate3x3.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetRenderMode(RENDERMODE_NORMAL)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self.CurrentBookings = TCD.BOOKING.CurrentBookings
    self:NetDataUpdate()
end

function ENT:UpdateScreen()
    self.CurrentBookings = TCD.BOOKING.CurrentBookings
    self:NetDataUpdate()
end

function ENT:NetDataWrite()
    net.WriteString(util.TableToJSON(self.CurrentBookings))
end
