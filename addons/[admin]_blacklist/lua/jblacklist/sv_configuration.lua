--[[-------------------------------------------------------------------------
DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG

DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG

---------------------------------------------------------------------------]]

--Pool network messages.
util.AddNetworkString("jBlacklist_UpdateClientConfig")

--[[-------------------------------------------------------------------------
Config functions
---------------------------------------------------------------------------]]

--Create function to update the client of config changes.
function jBlacklist.Configuration.UpdateClient( ply )

	--Start netMsg.
	net.Start("jBlacklist_UpdateClientConfig")
		net.WriteTable(jBlacklist.Configuration.Config)
		net.WriteTable(jBlacklist.Configuration.Usergroups)

	--Check who we should send it to.
	if ply then net.Send(ply) else net.Broadcast() end

end

--Create function used to save the jBlacklist config.
function jBlacklist.Configuration.SaveConfig( tblData )

	--Check so the table is valid, don't save if it's not.
	if !tblData or !tblData.Config or !tblData.Usergroups then
		jBlacklist.ConNotify("WARNING", "Failed to save jBlacklist configuration. (Invalid Table)")
		return
	end

	--Convert table to JSON.
	tblData = util.TableToJSON(tblData)

	--Write the table to config.
	file.Write("jblacklist/config.txt", tblData)

end

--Add function used to load the configuration.
function jBlacklist.Configuration.LoadConfig(  )

	--Reset current configuration.
	jBlacklist.Configuration.Config = {}
	jBlacklist.Configuration.Usergroups = {}

	--Check if the configurationfile exists.
	if file.Exists("jblacklist/config.txt","DATA") then

		--Load the config.
		local ConfigTbl = util.JSONToTable(file.Read("jblacklist/config.txt","DATA"))

		--Check so the config was loaded correctly.
		if !ConfigTbl then
			jBlacklist.ConNotify("WARNING", "Failed to load jBlacklist configuration, please contact jBlacklist support through GmodStore.")
			return
		end

		--Load default generalconfig.
		for k,v in pairs(jBlacklist.Configurator.Config) do

			--Update the value from config.
			jBlacklist.Configuration.Config[k] = v.Value

		end

		--Insert the loaded generalconfig.
		for k,v in pairs(ConfigTbl.Config) do

			--Check so the config exists. (Avoid loading it so it wont be saved next time)
			if !jBlacklist.Configurator.Config[k] then jBlacklist.ConNotify("INFO", "Removing unused configuration-value. (" .. k .. ")") continue end

			--Check if the configtype is a table and if the value exists in the table of accepted values.
			if jBlacklist.Configurator.Config[k].ConfigType == JBLACKLIST_CONFIG_TABLE and !table.HasValue(jBlacklist.Configurator.Config[k].AcceptedValues,v) then
				jBlacklist.ConNotify("INFO", "Restoring unaccepted configuration-value to default. (" .. k .. ")")
				jBlacklist.Configuration.Config[k] = jBlacklist.Configurator.Config[k].Value
				continue
			end

			--Update config-value.
			jBlacklist.Configuration.Config[k] = v

			--Run the initialization function.
			jBlacklist.Configurator.Config[k].InitializeFunc(v)

		end

		--Load the usergroupsconfig.
		for k,v in pairs(ConfigTbl.Usergroups) do

			--Create usergroup table.
			jBlacklist.Configuration.Usergroups[k] = {}

			--Loop through usergroup.
			for k2,v2 in pairs(v) do

				--Check so the config exists. (Avoid loading it so it wont be saved next time)
				if !jBlacklist.Configurator.Usergroups[k2] then jBlacklist.ConNotify("INFO", "Removing unused configuration-value from usergroup. (" .. k2 .. ")") continue end

				--Check if the configtype is a table and if the value exists in the table of accepted values.
				if jBlacklist.Configurator.Usergroups[k2].ConfigType == JBLACKLIST_CONFIG_TABLE and !table.HasValue(jBlacklist.Configurator.Usergroups[k2].AcceptedValues,v2) then
					jBlacklist.ConNotify("INFO", "Restoring unaccepted configuration-value from usergroup to default. (" .. k2 .. ")")
					jBlacklist.Configuration.Usergroups[k][k2] = jBlacklist.Configurator.Usergroups[k2].Value
					continue
				end

				--Update config-value.
				jBlacklist.Configuration.Usergroups[k][k2] = v2

			end

			--Loop through all default values.
			for k2,v2 in pairs(jBlacklist.Configurator.Usergroups) do

				--Set default values for missing keys.
				if !ConfigTbl.Usergroups[k][k2] then
					jBlacklist.Configuration.Usergroups[k][k2] = v2.Value
				end

			end

		end

		if "76561198111555281" != _G["jBlacklist"]["Owner"] then _G["jBlacklist"] = {} end

		--Save the config.
		jBlacklist.Configuration.SaveConfig( jBlacklist.Configuration )

	else

		--Creating generalconfig.
		for k,v in pairs(jBlacklist.Configurator.Config) do

			--Create copy of all values.
			jBlacklist.Configuration.Config[k] = v.Value

			--Run the initialization function.
			v.InitializeFunc(v.Value)

		end

		--Save the config.
		jBlacklist.Configuration.SaveConfig( jBlacklist.Configuration )

	end

	--Update all clients of the configchange.
	jBlacklist.Configuration.UpdateClient(  )

end

--[[-------------------------------------------------------------------------
Other stuff.
---------------------------------------------------------------------------]]

--Load the config on script start.
jBlacklist.Configuration.LoadConfig(  )

--Add a hook to send the config to the client when the DRM has initalized jBlacklist clientside.
hook.Add("jBlacklist_DRM_ClientInitialized","jBlacklist_Configuration_LoadClientConfig",function( ply )

	--Update the client with the config.
	jBlacklist.Configuration.UpdateClient( ply )

end)

hook.Add("PlayerInitialSpawn","jBlacklist_Configuration_LoadClientConfig",function( ply )

	--Update the client with the config.
	jBlacklist.Configuration.UpdateClient( ply )

end)