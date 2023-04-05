bArrest = bArrest or {}

bArrest.Config = {}
bArrest.Config.Time = 5 * 60 -- seconds
bArrest.Config.MinTime = 5 -- minutes
bArrest.Config.MaxTime = 15 -- minutes

if SERVER then
	AddCSLuaFile("barrest/cl_interface.lua")
	AddCSLuaFile("barrest/cl_networking.lua")

	include("barrest/sv_arrest.lua")
	include("barrest/sv_command.lua")
	include("barrest/sv_saving.lua")
	include("barrest/sv_networking.lua")
	include("barrest/sv_init.lua")
else
	include("barrest/cl_interface.lua")
	include("barrest/cl_networking.lua")
end