include("shared.lua")

local pos
local ang
local bW
local bH
local mathRound = math.Round
local cornerColor = Color(0,30,255)
local boxColor = Color(10,10,10,100)
local textColor = Color(255,255,255)
local headlineColor = Color(255,255,255)

function ENT:Initialize()
    local min, max = self:GetModelBounds()
    bW = mathRound(max.x - min.x) * 10
    bH = mathRound(max.y - min.y) * 10
end

function ENT:Draw()
    if (self.ShowPanel) then
        self:DrawModel()
    end

    pos = self:GetPos() + self:GetUp() * 2
    ang = self:GetAngles()

    ang:RotateAroundAxis(ang:Up(), 90)

    local curTime = mathRound(CurTime())
    local timeRunning = curTime - self:GetStartTime()

    cam.Start3D2D(pos, ang, 0.1)
        draw.RoundedBox(0, -bW / 2, -bH / 2, bW, bH, boxColor)

        draw.RoundedBox(0, -bW / 2, -bH / 2, 150, 10, cornerColor)
        draw.RoundedBox(0, -bW / 2, -bH / 2, 10, 150, cornerColor)
        draw.RoundedBox(0, bW / 2 - 150, -bH / 2, 150, 10, cornerColor)
        draw.RoundedBox(0, bW / 2 - 10, -bH / 2, 10, 150, cornerColor)
        draw.RoundedBox(0, bW / 2 - 150, bH / 2 - 10, 150, 10, cornerColor)
        draw.RoundedBox(0, bW / 2 - 10, bH / 2 - 150, 10, 150, cornerColor)
        draw.RoundedBox(0, -bW / 2, bH / 2 - 10, 150, 10, cornerColor)
        draw.RoundedBox(0, -bW / 2, bH / 2 - 150, 10, 150, cornerColor)

        draw.SimpleText("Star Destroyer Bookings", "base_booking_panel_top", 0, -bH * 0.45, headlineColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(#self:GetBooker() >= 1 and "Booked by: " .. self:GetBooker() or "Open", "base_booking_panel", 0, -75, textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(#self:GetReason() >= 1 and "Reason: " .. self:GetReason() or "", "base_booking_panel", 0, 0, textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(timeRunning == curTime and "" or "For: " .. timeRunning .. " seconds", "base_booking_panel", 0, 75, textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Message the Imperial Navy to make a Booking", "base_booking_panel_sub", 0, bH * 0.45, headlineColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end