TCD = TCD or {}
TCD.BOOKING = TCD.BOOKING or {}
TCD.BOOKING.CurrentBookings = TCD.BOOKING.CurrentBookings or {}

AddCSLuaFile("library/cl_imgui.lua")

util.AddNetworkString("TCD.BOOKING.Book")
util.AddNetworkString("TCD.BOOKING.RemoveLocation")

function TCD.BOOKING.AddBooking(booking)
    local location = booking.location
    local unit = booking.unit
    local reason = booking.reason

    if (not location or not unit or not reason or not TCD.BOOKING.Locations[location] or TCD.BOOKING.CurrentBookings[location]) then
        return false
    end

    local bookingTable = {
        location = location,
        unit = unit,
        reason = reason,
        time = CurTime(),
    }
    for k, v in ipairs(ents.FindByClass(TCD.BOOKING.Locations[location].entity)) do
        v:UpdateBooking(bookingTable)
    end
    TCD.BOOKING.CurrentBookings[location] = bookingTable
    for k, v in ipairs(ents.FindByClass("big_booking_panel")) do
        v:UpdateScreen()
    end
    for k, v in ipairs(ents.FindByClass("booking_station")) do
        v:SetUsed(location, true)
    end
end

net.Receive("TCD.BOOKING.Book", function(len, ply)
    if not ply:HasFlag("Booking") then return end

    local hangar = net.ReadString()
    local unit = net.ReadString()
    local reason = net.ReadString()

    if (not hangar or not unit or not reason or not TCD.BOOKING.Locations[hangar]) then
        ply:ChatPrint("[BOOKING]: Invalid booking")
        return
    end

    if (TCD.BOOKING.CurrentBookings[hangar]) then
        ply:ChatPrint("[BOOKING]: Hangar is already booked")
        return
    end

    TCD.BOOKING.AddBooking({
        location = hangar,
        unit = unit,
        reason = reason,
    })
    ply:ChatPrint("[BOOKING]: Hangar booked")

    for k, v in ipairs(player.GetAll()) do
        if (v == ply) then continue end
        v:ChatPrint("[BOOKING]: Unit " .. unit .. " has booked " .. hangar .. " for " .. reason)
    end
end)

function TCD.BOOKING.RemoveBooking(location)
    if (not location or not TCD.BOOKING.Locations[location] or not TCD.BOOKING.CurrentBookings[location]) then
        return false
    end

    for k, v in ipairs(ents.FindByClass(TCD.BOOKING.Locations[location].entity)) do
        v:ClearBooking()
    end
    TCD.BOOKING.CurrentBookings[location] = nil
    for k, v in ipairs(ents.FindByClass("big_booking_panel")) do
        v:UpdateScreen()
    end
    for k, v in ipairs(ents.FindByClass("booking_station")) do
        v:SetUsed(location, false)
    end
end

net.Receive("TCD.BOOKING.RemoveLocation", function(len, ply)
    if not ply:HasFlag("Booking") then return end

    local location = net.ReadString()

    if (not location or not TCD.BOOKING.Locations[location]) then
        ply:ChatPrint("[BOOKING]: Invalid location")
        return
    end

    if (not TCD.BOOKING.CurrentBookings[location]) then
        ply:ChatPrint("[BOOKING]: Location is not booked")
        return
    end

    TCD.BOOKING.RemoveBooking(location)
    ply:ChatPrint("[BOOKING]: Location unbooked")

    for k, v in ipairs(player.GetAll()) do
        if (v == ply) then continue end
        v:ChatPrint("[BOOKING]: " .. location .. " has been cleared")
    end
end)

function TCD.BOOKING.GetBooking(location)
    if (not location or not TCD.BOOKING.Locations[location]) then
        return false
    end

    return TCD.BOOKING.CurrentBookings[location]
end