ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Base Booking Panel"
ENT.Author = "Luiggi33"
ENT.Category = "Booking - Entities"
ENT.Spawnable = false

ENT.IsBigScreen = true
ENT.ShowPanel = false

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "Booker")
    self:NetworkVar("String", 1, "Reason")
    self:NetworkVar("Int", 0, "StartTime")
end