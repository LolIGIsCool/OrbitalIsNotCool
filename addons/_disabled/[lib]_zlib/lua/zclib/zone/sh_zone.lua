zclib = zclib or {}
zclib.Zone = zclib.Zone or {}

////////////////////////////////////////////////////////////////

zclib.Zone.Entrys = zclib.Zone.Entrys or {}

function zclib.Zone.Setup(entryid,entrydata)
    zclib.Debug("zclib.Zone.Setup " .. entrydata.script .. " " .. entryid)
    zclib.Zone.Entrys[entryid] = entrydata
end

/*
function zclib.Zone.Setup(entryid,script,toolname,path,getdata,load,remove,drawzone,onzoneremoved,snapsize,extraheight)
    zclib.Debug("zclib.Zone.Setup " .. script .. " " .. entryid)
    zclib.Zone.Entrys[entryid] = {

        script = script,

        // The path of the save file
        path = path,

        // Return the var we store the data in
        GetData = getdata,

        // Gets called when the zone data loads
        Load = load,

        // Gets called when the zone data gets removed
        Remove = remove,

        // The name of the toolgun lua file
        ToolName = toolname,

        // Draw the name of the zone in the pewview
        DrawZone = drawzone,


        // Gets called when a zone is about to get removed
        OnZoneRemoved = onzoneremoved,

        // If set then the zones will snap
        SnapSize = snapsize,

        // The default height of the zone
        BaseHeight = 200,

        // Defines how much extra height will be added when drawing the Zone Box
        ExtraHeight = extraheight or 200,
    }
end
*/
function zclib.Zone.GetEntry(entryid)
    return zclib.Zone.Entrys[entryid]
end

function zclib.Zone.GetData(entryid)
    return zclib.Zone.Entrys[entryid].GetData()
end

function zclib.Zone.Set(entryid,data)
    zclib.Debug("zclib.Zone.Set " .. entryid)
    return zclib.Zone.Entrys[entryid].Load(data or {})
end

function zclib.Zone.GetToolName(entryid)
	if not zclib.Zone.Entrys[entryid] then return "nil" end
    return zclib.Zone.Entrys[entryid].ToolName or "nil"
end

function zclib.Zone.GetSnapSize(entryid)
    return zclib.Zone.Entrys[entryid].SnapSize
end

////////////////////////////////////////////////////////////////

// Gets called from the swep to start creating a zone
function zclib.Zone.ToolLeftClick(entryid, swep, ply, trace, extradata)
    zclib.Debug("zclib.Zone.ToolLeftClick " .. entryid)
    if trace.Hit == nil or trace.Hit == false then return end
    if trace.HitPos == nil then return end
    if zclib.Player.IsAdmin(ply) == false then return end

    if SERVER then zclib.Zone.Show(entryid,ply) end

    local vec01 = Vector(0, 0, zclib.Zone.GetHeight(entryid))


    local snapsize = zclib.Zone.GetSnapSize(entryid)
    local n_pos = trace.HitPos
    if snapsize then n_pos = zclib.Zone.Snap(n_pos,snapsize) end

    if swep.ZoneStart == nil then

        swep.ZoneStart = n_pos

        if CLIENT then
            LocalPlayer().zclib_ZoneStart = n_pos
        end
    else
        if SERVER then
            local zoneSize = zclib.Zone.GetSize(entryid,swep.ZoneStart, n_pos)
            zclib.Zone.Add(entryid, ply, swep.ZoneStart - vec01, zoneSize, extradata)
        end

        swep.ZoneStart = nil

        if CLIENT then
            LocalPlayer().zclib_ZoneStart = nil
        end
    end
end

function zclib.Zone.ToolRightClick(entryid, swep, ply, trace)
    zclib.Debug("zclib.Zone.ToolRightClick " .. entryid)
    // Cancel the current zone
    if swep.ZoneStart then
        swep.ZoneStart = nil

        if CLIENT then
            LocalPlayer().zclib_ZoneStart = nil
        end
    else
        // Search for any zone which has trace.HitPos in it and remove it
        if SERVER then
            zclib.Zone.RemoveAt(entryid, ply, trace.HitPos)
        end
    end
end

function zclib.Zone.ToolDeploy(entryid, swep)
    zclib.Debug("zclib.Zone.ToolDeploy " .. entryid)

    swep.ZoneStart = nil

    if CLIENT then
        LocalPlayer().zclib_ZoneStart = nil
    end

    if SERVER then
        if zclib.Player.IsAdmin(swep:GetOwner()) == false then return end
        zclib.Zone.Show(entryid, swep:GetOwner())
    end
end

function zclib.Zone.ToolHolster(entryid, swep)
    zclib.Debug("zclib.Zone.ToolHolster " .. entryid)
    swep.ZoneStart = nil

    if CLIENT then
        LocalPlayer().zclib_ZoneStart = nil
    end

    if SERVER then
        zclib.Zone.Hide(swep:GetOwner())
    end
end

function zclib.Zone.ToolThink(entryid, swep)

    // A quick fix for the toolgun deploy function not working correctly on the first start
    if CLIENT and (swep.LastDraw == nil or (swep.LastDraw + 2) < CurTime()) then
        zclib.Zone.Preview_Start(entryid)
        swep.LastDraw = CurTime()
    end
end

////////////////////////////////////////////////////////////////

function zclib.Zone.Snap(vec,snapsize)
    return Vector(zclib.util.SnapValue(snapsize,vec.x),zclib.util.SnapValue(snapsize,vec.y),vec.z)
end


// Checks if the specified position is inside the specified zone
function zclib.Zone.Check(entryid,zone_id,pos)
    //zclib.Debug("zclib.Zone.Check")
    local zonelist = zclib.Zone.GetData(entryid)
    if zonelist == nil then return false end

    local zone = zonelist[zone_id]
    if zone == nil then return false end

    local box_start = zone.pos
    local box_end = zone.pos + zone.size

    local result = pos:WithinAABox( box_start, box_end )

    if result then
        return true
    else
        return false
    end
end

// Checks if the specified position is inside any of the zones
function zclib.Zone.CheckAll(entryid,pos)
    //zclib.Debug("zclib.Zone.CheckAll")

    local zonelist = zclib.Zone.GetData(entryid)
    if zonelist == nil then return false end

    local result = false
    for k,v in pairs(zonelist) do
        if zclib.Zone.Check(entryid,k,pos) then
            result = k
            break
        end
    end
    return result
end

// Returns true if the provided position is inside a valid zone
function zclib.Zone.Inside(entryid,pos)
    zclib.Debug("zclib.Zone.Inside")
    return zclib.Zone.CheckAll(entryid,pos)
end

function zclib.Zone.GetHeight(entryid)
    local ZoneData = zclib.Zone.GetEntry(entryid)
    if ZoneData == nil then return 200 end
    return ZoneData.BaseHeight or 200
end

function zclib.Zone.GetExtraHeight(entryid)
    local ZoneData = zclib.Zone.GetEntry(entryid)
    if ZoneData == nil then return 200 end
    return ZoneData.ExtraHeight or 200
end

function zclib.Zone.GetSize(entryid,z_start,z_end)
    //zclib.Debug("zclib.Zone.GetSize")
    local zoneSize = z_end - z_start
    zoneSize = Vector(zoneSize.x, zoneSize.y, zclib.Zone.GetHeight(entryid) * 2)
    return zoneSize
end
