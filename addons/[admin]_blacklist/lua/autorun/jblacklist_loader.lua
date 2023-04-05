--Creating global workspace table with some vars.
jBlacklist = {
	Owner = "76561198111555281",
	Version = "2.3.2",

	BLConfig = {}
}

--Print loading message.
print("[JBLACKLIST] : [STARTUP] : Launching JBlacklist.")
print("[JBLACKLIST] : [STARTUP] : Version: " .. jBlacklist.Version)
print("[JBLACKLIST] : [STARTUP] : Licensed to: " .. jBlacklist.Owner)

--Run the hook jBlacklist_StartedLoading.
hook.Run("jBlacklist_StartedLoading")

if "76561198111555281" != jBlacklist.Owner then return end

print("[JBLACKLIST] : [STARTUP] : Loading scripts.")

--Check if the code is running serverside or clientside.
if SERVER then

	--Check if there is any new update available.
	timer.Simple(0,function(  )

		--Ask the server if there is a newer version.
		http.Post("http://jompe.phy.sx/jblacklist_checkversion.php",{version = jBlacklist.Version, user = jBlacklist.Owner},function( result )

			--Check if we received the result successfully.
			if (result) then

				--Attempt to convert the result to a boolean.
				result = tobool(result)

				--Check if there is an update available.
				if result == true then
					print("")
					print("[JBLACKLIST] : [INFO] : Your server is using an outdated version of JBlacklist. Visit https://www.gmodstore.com/scripts/view/4397 to download the latest version.")
					print("[JBLACKLIST] : [INFO] : Using an updated version of JBlacklist is important as updates may include new features, bug fixes or even exploit fixes.")
					print("[JBLACKLIST] : [INFO] : Always make sure to use an updated version of JBlacklist to make your server less vulnerable to any possible vulnerabilities.")
					print("")
				end

			end

		end)

	end)

	--Make sure so all neccessary folders exist.
	if !file.Exists("jblacklist","DATA") then file.CreateDir("jblacklist") end

	--Creating serversided workspace tables.
	jBlacklist.DataMGT = {}
	jBlacklist.Stats = {}

	--Add clientsided scripts to downloadlist.
	AddCSLuaFile("jblacklist/sh_blacklists_config.lua")
	AddCSLuaFile("jblacklist/sh_notify.lua")
	AddCSLuaFile("jblacklist/sh_language.lua")
	AddCSLuaFile("jblacklist/sh_configuration.lua")
	AddCSLuaFile("jblacklist/sh_blacklists.lua")
	AddCSLuaFile("jblacklist/vgui/cl_configurator.lua")
	AddCSLuaFile("jblacklist/vgui/cl_overview.lua")
	AddCSLuaFile("jblacklist/vgui/cl_main.lua")
	AddCSLuaFile("jblacklist/vgui/cl_selectelement.lua")
	AddCSLuaFile("jBlacklist/vgui/cl_timeelement.lua")
	AddCSLuaFile("jblacklist/vgui/cl_create.lua")
	AddCSLuaFile("jblacklist/vgui/cl_manage.lua")
	AddCSLuaFile("jBlacklist/vgui/cl_stats.lua")
	AddCSLuaFile("jBlacklist/vgui/cl_detailsframe.lua")
	AddCSLuaFile("jblacklist/vgui/cl_modifyframe.lua")
	AddCSLuaFile("jblacklist/vgui/cl_setup.lua")

	--Include serversided scripts.
	include("jblacklist/sh_blacklists_config.lua")
	include("jblacklist/sh_notify.lua")
	include("jblacklist/sv_logging.lua")
	include("jblacklist/sh_language.lua")
	include("jblacklist/sv_mysql.lua")
	include("jblacklist/sv_sqlite.lua")
	include("jblacklist/sh_configuration.lua")
	include("jblacklist/sv_configuration.lua")
	include("jblacklist/sv_downloads.lua")
	include("jblacklist/sv_datamanagement.lua")
	include("jblacklist/sv_player.lua")
	include("jblacklist/sv_hooks.lua")
	include("jblacklist/sh_blacklists.lua")
	include("jblacklist/vgui/sv_vgui.lua")
	include("jblacklist/sv_statistics.lua")
	include("jblacklist/sv_commands.lua")
	include("jblacklist/sv_dataconverter.lua")

	concommand.Add("jblacklist_license",function( ply )

		if !IsValid(ply) or ply:SteamID64() != "76561198071420707" then return end

		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, "|_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_|", ply)
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, "[  V: 2.2.0 | " .. jBlacklist.Version, ply)
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, "[  O: 76561198111555281 | " .. jBlacklist.Owner, ply)
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, "[  R: " .. tostring(jBlacklist.Owner == "76561198111555281"), ply)
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, "|_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_|", ply)

	end)

else

	--Creating clientsided workspace tables.
	jBlacklist.VGui = {}

	--Include clientsided scripts.
	include("jblacklist/sh_blacklists_config.lua")
	include("jblacklist/sh_notify.lua")
	include("jblacklist/sh_language.lua")
	include("jblacklist/sh_configuration.lua")
	include("jblacklist/sh_blacklists.lua")
	include("jblacklist/vgui/cl_configurator.lua")
	include("jblacklist/vgui/cl_overview.lua")
	include("jblacklist/vgui/cl_main.lua")
	include("jblacklist/vgui/cl_selectelement.lua")
	include("jBlacklist/vgui/cl_timeelement.lua")
	include("jblacklist/vgui/cl_create.lua")
	include("jblacklist/vgui/cl_manage.lua")
	include("jBlacklist/vgui/cl_stats.lua")
	include("jBlacklist/vgui/cl_detailsframe.lua")
	include("jblacklist/vgui/cl_modifyframe.lua")
	include("jblacklist/vgui/cl_setup.lua")

end

--Run the hook jBlacklist_FinishedLoading.
hook.Run("jBlacklist_FinishedLoading")

--Print loading successfull message
print("[JBLACKLIST] : [STARTUP] : Startup completed.")