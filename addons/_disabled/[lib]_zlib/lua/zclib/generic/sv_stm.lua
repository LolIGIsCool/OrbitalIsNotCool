if CLIENT then return end
zclib = zclib or {}
zclib.STM = zclib.STM or {}

/*

    Save To Map - System
    Saves and loads entities to the map

*/

zclib.STM.List = {}

function zclib.STM.Setup(id,path,getdata,load,remove)
    zclib.STM.List[id] = {
        path = path,
        GetData = getdata,
        Load = load,
        Remove = remove
    }
end

function zclib.STM.Save(id,force)

    local entry = zclib.STM.List[id]
    if entry == nil then return end

    local data = entry.GetData()
    if data == nil then return false end

    // If we force the saving of the data then it doesent matter if its empty
    if force ~= true and table.Count(data) <= 0 then return false end

    file.Write(entry.path, util.TableToJSON(data,true))
    return true
end

function zclib.STM.Load(id)

    zclib.Debug("[STM] Loading " .. id)
    local entry = zclib.STM.List[id]
    if entry == nil then return end

    if file.Exists(entry.path, "DATA") then
        local data = file.Read(entry.path, "DATA")
        if data == nil then return false end

        data = util.JSONToTable(data)
        if data == nil then return false end

        if data and table.Count(data) > 0 then
            entry.Load(data)
        else
            return false
        end
    else
        return false
    end
end

function zclib.STM.GetData(id)
    zclib.Debug("[STM] Loading " .. id)
    local entry = zclib.STM.List[id]
    if entry == nil then return end

    if file.Exists(entry.path, "DATA") then
        local data = file.Read(entry.path, "DATA")
        if data == nil then return false end

        data = util.JSONToTable(data)
        if data == nil then return false end

        if data and table.Count(data) > 0 then
            return data
        else
            return false
        end
    else
        return false
    end
end

function zclib.STM.Remove(id)

    local entry = zclib.STM.List[id]
    if entry == nil then return end

    entry.Remove()

    if file.Exists(entry.path, "DATA") then
        file.Delete(entry.path)
        return true
    else
        return false
    end
end

zclib.Hook.Add("PostCleanupMap", "SaveToMap", function()
    for k,v in pairs(zclib.STM.List) do
        zclib.STM.Load(k)
    end
end)

timer.Simple(3,function()
    for k,v in pairs(zclib.STM.List) do
        zclib.STM.Load(k)
    end
end)


