AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/lordtrilobite/starwars/isd/imp_console_medium02.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetRenderMode(RENDERMODE_NORMAL)

    self:SetSubMaterial(1, "models/rendertarget")

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    for k, v in pairs(TCD.BOOKING.CurrentBookings) do
        self:SetUsed(v.location, true)
    end
end

function ENT:SetUsed(location, use)
    self.UsedLocations[location] = use
    self:NetDataUpdate()
end

function ENT:NetDataWrite()
    net.WriteString(util.TableToJSON(self.UsedLocations))
end