local glowingModels = {}

local halosActive = false
local function drawHalos()
    if(table.IsEmpty(glowingModels)) then
        halosActive = false
        hook.Remove("PreDrawHalos", "STUN_Halos")
        return
    end

    halo.Add(glowingModels, Color(79, 39, 223), 5, 5, 2)
end

net.Receive("STUN_Effect", function()
    local ent = net.ReadEntity()
    table.insert(glowingModels, ent)

    if(!IsValid(ent)) then print("TFA_STUN_ATT ERROR: stun_glow.lua net message sent invalid entity (entity should be player ragdoll)") return end

    // slight optimization
    if !halosActive then
        hook.Add("PreDrawHalos", "STUN_Halos", drawHalos)
        halosActive = true
    end

    timer.Simple(0.025, function()
        if(IsValid(ent)) then
            table.RemoveByValue(glowingModels, ent)
        end
    end)
end)