TCD = TCD or {}
TCD.BOOKING = TCD.BOOKING or {}

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel(self.IsBigScreen and "models/hunter/plates/plate3x3.mdl" or "models/hunter/plates/plate2x2.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetRenderMode(RENDERMODE_NORMAL)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    local location
    for k, v in pairs(TCD.BOOKING.Locations) do
        if v.entity == self:GetClass() then
            location = k
            break
        end
    end
    if not location then
        print("[BOOKING]: Booking location not found for entity " .. self:GetClass())
        self:Remove()
        return
    end
    for k, v in pairs(TCD.BOOKING.CurrentBookings) do
        if (k == location) then
            self:UpdateBooking(v)
            break
        end
    end
end

function ENT:UpdateBooking(bookingTable)
    self:SetBooker(bookingTable.unit)
    self:SetReason(bookingTable.reason)
    self:SetStartTime(math.Round(bookingTable.time))
end

function ENT:ClearBooking()
    self:SetBooker("")
    self:SetReason("")
    self:SetStartTime(0)
end