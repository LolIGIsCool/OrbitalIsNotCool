TCD = TCD or {}
TCD.BOOKING = TCD.BOOKING or {}

include("shared.lua")

local imgui = include("library/cl_imgui.lua")

surface.CreateFont("TCD.Entities.Booking-Station", {
    font = "Roboto",
    size = 20,
    weight = 500,
    antialias = true,
})

surface.CreateFont("TCD.Entities.Booking-Station.two", {
    font = "Roboto",
    size = 22,
    weight = 300,
    antialias = true,
})

function ENT:DrawTranslucent(flags)
    self:DrawModel(flags)

    if (imgui.Entity3D2D(self, Vector(8, -17.5, 34.4), Angle(0, 90, 15), 0.1)) then
        draw.RoundedBox(0, 28, 21, 295, 115, Color(62, 62, 62))

        if (imgui.xTextButton("Open Menu", "!Roboto@20", 120, 60, 95, 30, 2, Color(255,255,255), Color(255,187,0), Color(209,174,78))) then
            self:OpenFrame()
        end

        imgui.End3D2D()
    end

    if (imgui.Entity3D2D(self, Vector(2.1, -12.8, 45.7), Angle(0, 90, 61), 0.05)) then
        draw.RoundedBox(5, 0, 7, 235, 200, Color(14, 59, 157))

        local index = 0
        for k, v in pairs(TCD.BOOKING.Locations) do
            draw.SimpleText(v.name, "TCD.Entities.Booking-Station.two", 25, 20 + index * 20, self.UsedLocations[v.name] and Color(255, 0, 0) or Color(0, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            if (imgui.xTextButton("X", "!Roboto@15", 165, 20 + index * 20 + 3, 15, 15, 2, Color(255, 255, 255), Color(209,174,78), Color(255,187,0))) then
                net.Start("TCD.BOOKING.RemoveLocation")
                    net.WriteString(k)
                net.SendToServer()
            end
            index = index + 1
        end

        imgui.End3D2D()
    end
end

function ENT:NetDataRead()
    self.UsedLocations = util.JSONToTable(net.ReadString())
end

local frame

function ENT:OpenFrame()
    if (frame) then
        frame:Remove()
    end

    frame = vgui.Create("DFrame")
    frame:SetSize(ScrW() * 0.25, ScrH() * 0.3)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(62, 62, 62, 230))
        draw.RoundedBox(0, 0, 0, w, 1, Color(255, 255, 255))
        draw.SimpleText("Booking Station", imgui.xFont("!Roboto@30"), w / 2, 10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    local close = vgui.Create("DButton", frame)
    close:SetSize(40, 30)
    close:SetPos(frame:GetWide() - 50, 10)
    close:SetText("")
    close.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0))
        draw.SimpleText("X", imgui.xFont("!Roboto@40"), w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    close.DoClick = function()
        frame:Remove()
    end

    local comboBox = vgui.Create("DComboBox", frame)
    comboBox:SetSize(frame:GetWide() * 0.5, 30)
    comboBox:SetPos(frame:GetWide() * 0.25, frame:GetTall() * 0.2)
    comboBox:SetValue("Select a hangar")

    for k, v in pairs(TCD.BOOKING.Locations) do
        comboBox:AddChoice(v.name)
    end

    local unitInput = vgui.Create("DTextEntry", frame)
    unitInput:SetSize(frame:GetWide() * 0.5, 30)
    unitInput:SetPos(frame:GetWide() * 0.25, frame:GetTall() * 0.4)
    unitInput:SetPlaceholderText("Enter the unit")
    unitInput:SetDrawLanguageID(false)

    local reasonInput = vgui.Create("DTextEntry", frame)
    reasonInput:SetSize(frame:GetWide() * 0.5, 30)
    reasonInput:SetPos(frame:GetWide() * 0.25, frame:GetTall() * 0.6)
    reasonInput:SetPlaceholderText("Enter the reason")
    reasonInput:SetDrawLanguageID(false)

    local button = vgui.Create("DButton", frame)
    button:SetSize(frame:GetWide() * 0.5, 30)
    button:SetPos(frame:GetWide() * 0.25, frame:GetTall() * 0.8)
    button:SetText("")
    button.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, self:IsHovered() and Color(255, 187, 0) or Color(209, 174, 78))
        draw.SimpleText("Book", imgui.xFont("!Roboto@20"), w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    button.DoClick = function()
        local hangar = comboBox:GetSelected()
        local unit = unitInput:GetValue()
        local reason = reasonInput:GetValue()
		print("asd")
        if (hangar and unit and reason) then
            net.Start("TCD.BOOKING.Book")
                net.WriteString(hangar)
                net.WriteString(unit)
                net.WriteString(reason)
            net.SendToServer()
        end
    end
end