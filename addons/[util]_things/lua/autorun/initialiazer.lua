ACU = ACU or {}
ACU.vars = ACU.vars or {}
ACU.vars.callbackInitialize = ACU.vars.callbackInitialize or false

if SERVER then
    MsgC(Color(90, 230, 0), "[ACU] Launching utility...\n")

    util.AddNetworkString("ACUSettingsChanger")

    function GetSettings()
        if file.Exists("acu/settings.dat", "DATA") then
            return util.JSONToTable(util.Decompress(file.Read("acu/settings.dat", "DATA")))
        end

        return {
            enabled = 1,
            notification = 0,
            timer = 180
        }
    end

    function SaveSettings()
        local data = {
            enabled = GetConVar("acu_enabled"):GetInt(),
            notification = GetConVar("acu_shownotification"):GetInt(),
            timer = GetConVar("acu_timer"):GetInt()
        }

        if not file.Exists("acu", "DATA") then
            file.CreateDir("acu")
        end

        file.Write("acu/settings.dat", util.Compress(util.TableToJSON(data)))
    end

    local settings = GetSettings()

    if not ConVarExists("acu_enabled") then
        CreateConVar("acu_enabled", settings.enabled, { FCVAR_GAMEDLL, FCVAR_REPLICATED, FCVAR_NOTIFY })

        if settings.enabled == 0 then
            MsgC(Color(255, 50, 50), "[ACU] Utility is not enabled, run console command acu_enabled 1 or change enable parameter in Q-menu -> Utilities.\n")
        end
    end

    if not ConVarExists("acu_shownotification") then
        CreateConVar("acu_shownotification", settings.notification, { FCVAR_GAMEDLL, FCVAR_REPLICATED })
    end

    if not ConVarExists("acu_timer") then
        CreateConVar("acu_timer", settings.timer, { FCVAR_GAMEDLL, FCVAR_REPLICATED })
    end

    function CreateTimer()
        if timer.Exists("ACUCleanupTimer") then
            timer.Remove("ACUCleanupTimer")
        end

        if GetConVar("acu_enabled"):GetInt() == 0 then return end

        timer.Create("ACUCleanupTimer", GetConVar("acu_timer"):GetInt(), 0, function()
            --MsgC(Color(90, 230, 0), "[ACU] Successfully cleaning decals.\n")
            -- Running command on all client
            BroadcastLua("RunConsoleCommand('r_cleardecals')")
            BroadcastLua([[MsgC(Color(90, 230, 0), "[ACU] Successfully cleaning decals.\n")]])

            if(GetConVar("acu_shownotification"):GetBool()) then
                BroadcastLua([[notification.AddLegacy("All decals on map was removed!", NOTIFY_GENERIC, 5)]])
            end
        end)
    end

    CreateTimer()

    MsgC(Color(90, 230, 0), "[ACU] Successfully launched.\n")
    
    net.Receive("ACUSettingsChanger", function(len, ply)
        local settingsType = net.ReadString()
        local settingsValue = net.ReadInt(12)

        if not game.SinglePlayer() and not ply:IsSuperAdmin() then
            return ply:SendLua([[notification.AddLegacy("Access denied! Superadmin rights required.", NOTIFY_GENERIC, ]].. NOTIFY_ERROR ..[[)]])
        end

        if settingsType == "enable" then
            local enable = math.Clamp(settingsValue, 0, 1)

            GetConVar("acu_enabled"):SetInt(enable)
        elseif settingsType == "notification" then
            local enable = math.Clamp(settingsValue, 0, 1)

            GetConVar("acu_shownotification"):SetInt(enable)
        elseif settingsType == "timer" then
            local value = math.Clamp(settingsValue, 30, 1800)
			
            GetConVar("acu_timer"):SetInt(value)
        end
    end)

    if not ACU.vars.callbackInitialize then
        ACU.vars.callbackInitialize = true

        cvars.AddChangeCallback("acu_enabled", function(convar, oValue, nValue)
            MsgC(Color(90, 230, 0), "[ACU] Status of utility changed to ".. nValue .."\n")

            local value = tonumber(nValue)

            if value == 1 then
                CreateTimer()
            end

            SaveSettings()
        end)

        cvars.AddChangeCallback("acu_shownotification", function(convar, oValue, nValue)
            MsgC(Color(90, 230, 0), "[ACU] Notification parameter value changed to ".. nValue .."\n")

            CreateTimer()

            SaveSettings()
        end)

        cvars.AddChangeCallback("acu_timer", function(convar, oValue, nValue)
            MsgC(Color(90, 230, 0), "[ACU] Timer parameter value changed to ".. nValue .."\n")

            CreateTimer()

            SaveSettings()
        end)
    end
end

if CLIENT then
    CreateClientConVar("acu_enabled", 1, false, false, nil, 0, 1)
    CreateClientConVar("acu_shownotification", "0", false, false, nil, 0, 1)
    CreateClientConVar("acu_timer", 180, false, false, nil, 0, 1800)

    hook.Add("PopulateToolMenu", "ACUSetupSettings", function()
        spawnmenu.AddToolMenuOption("Utilities", "Auto Clear Utility", "acu", "Settings", "", "", function(panel)
            panel:SetName("Cleanup settings")
            panel:Help("This page containing some settings, which can help you manage ACU.")
            local enableCheckbox = panel:CheckBox("Enable ACU", "acu_enabled")

            function enableCheckbox:Think()
                self:SetEnabled(LocalPlayer():IsSuperAdmin() or game.SinglePlayer())
            end

            local notificationCheckbox = panel:CheckBox("Enable notification", "acu_shownotification")

            function notificationCheckbox:Think()
                self:SetEnabled(LocalPlayer():IsSuperAdmin() or game.SinglePlayer())
            end

            panel:ControlHelp("FINALLY! Now you can control it, disabled by default.")

            local timerSlider = panel:NumSlider("Cleaning timer", "acu_timer", 30, 1800)
            timerSlider:SetDecimals(0)

            function timerSlider:Think()
                self:SetEnabled(LocalPlayer():IsSuperAdmin() or game.SinglePlayer())
            end

            panel:ControlHelp("Select your preferred cleaning interval, in seconds.\nRecomended: 180 seconds (3 minutes)")
        end)
    end)

    cvars.AddChangeCallback("acu_enabled", function(cmd, oValue, nValue)
        if LocalPlayer():IsSuperAdmin() then
            net.Start("ACUSettingsChanger")
            net.WriteString("enable")
            net.WriteInt(tonumber(nValue), 12)
            net.SendToServer()
        end
    end)

    cvars.AddChangeCallback("acu_shownotification", function(cmd, oValue, nValue)
        if LocalPlayer():IsSuperAdmin() then
            net.Start("ACUSettingsChanger")
            net.WriteString("notification")
            net.WriteInt(tonumber(nValue), 12)
            net.SendToServer()
        end
    end)

    cvars.AddChangeCallback("acu_timer", function(cmd, oValue, nValue)
        if LocalPlayer():IsSuperAdmin() then
            net.Start("ACUSettingsChanger")
            net.WriteString("timer")
            net.WriteInt(tonumber(nValue), 12)
            net.SendToServer()
        end
    end)
end