DeriveGamemode("sandbox")

local ErrorNoHalt = ErrorNoHalt
local include = include
local AddCSLuaFile = AddCSLuaFile

local Color = Color
local MsgC = MsgC

local string = string
local file = file
local table = table

local debug_traceback, pairs, table_Count, print = debug.traceback, pairs, table.Count, print

GM.Name = "StarwarsRP"
GM.Author = "Kirby#2015"

hook = hook or {}
hook["data"] = hook["data"] or {}

function hook.AddOrder( name, order, func )
	if not hook["data"][ name ] then
		hook["data"][ name ] = {}
	end
	if !order then order = #hook["data"][ name ] + 1 end
	hook["data"][ name ][ order ] = func
end

function hook.RunOrder( name, ... )
	if not hook["data"][ name ] then
		return
	end
	for k, v in SortedPairs( hook["data"][ name ] ) do
		v( ... )
	end
end

RK = RK or {}

RK.DeveloperMode = false
local BasePath = "starwarsrp/gamemode"

function RK:Print( msg, col )
	if not msg then return false end
	if not self.DeveloperMode then return end
	col = col and col or CLIENT and Color( 80, 80, 255) or Color( 255, 150, 0, 255 )

	MsgC( col, SERVER and "[RK Server]: " or "[RK Client]: ", Color( 255, 255, 255, 255 ), msg .. "\n" )
	return true
end
RK.print = RK.Print

local function printSpacer()
	print( "" )
end

function RK:Error( msg )
	if not msg then return false end

	ErrorNoHalt( msg .. "\n" )
	if RK.DeveloperMode then print( debug_traceback() ) end
	return true
end

function RK:SetDeveloperMode( bool )
	self.DeveloperMode = bool and bool or false
end

function RK:Initialize()
	self:SetDeveloperMode( true )

	local side = SERVER and "Server" or "Client"
	local locals = {
		[1] = "libs",
		[2] = "register",
	}
	self:LoadFile( "config.lua", "Shared" )

	-- printSpacer()

	for k, v in ipairs( locals, true ) do
		self:Print( "Loading - " .. v .. ":" )
		self:RecusiveInclude( BasePath .. "/" .. v )
		-- self:Print( "Loaded " .. v .. "." )
		-- printSpacer()
	end


	if RK.Modules then RK.Modules:Initialize() end
	self:Print( side .. " has been initialized." )
end

function RK:RecusiveInclude( path, folderOnly )

	local files, directorys = file.Find( path .. "/*", "LUA" )

	if !folderOnly then
		for k, v in pairs( files ) do
			if v:find( ".lua" ) then
				self:LoadFile( path .. "/" .. v )
			end
		end
	end

	if directorys and table_Count( directorys ) > 0 then
		for k, v in pairs( directorys ) do
			RK:RecusiveInclude( path .. "/" .. v )
		end
	end
end

function RK:LoadFile( path, realm )

	local r = realm and realm:lower() or false

	-- self:Print( "Loading: " .. path )
	if ( r and r:lower() == "server" or path:find( "sv_" ) ) then
		if SERVER then return include( path ) end
	elseif ( r and r:lower() == "client" or path:find( "cl_" ) ) then
		if SERVER then AddCSLuaFile( path ) end
		if CLIENT then return include( path ) end
	elseif ( r and r:lower() == "shared" or path:find( "sh_" ) )  then
		if SERVER then AddCSLuaFile( path ) end
		return include( path )
	else
		self:Print( "WARNING: Unable to find file prefix - " .. path )
		self:LoadFile( path, "shared" )
	end

end

function GM:Initialize()
	self.BaseClass.Initialize( self )

end

function Nofify( ply, msg, notify_type, length )

	if !ply then
		if CLIENT then ply = LocalPlayer() end
		if SERVER then return end
	end
	if !msg then msg = "No message given." end
	if !notify_type then notify_type = 3 end
	if !length then length = 5 end

	if SERVER then
		ply:SendLua( "Nofify( LocalPlayer(), \"" .. msg .. "\", " .. notify_type .. ", " .. length .. ")" )
	else
		notification.AddLegacy( msg, notify_type, length )
	end
end

local PLAYER = FindMetaTable( "Player" )

function PLAYER:Notify( msg, notify_type, length )
	Nofify( self, msg, notify_type, length )
end

RK:Initialize()

hook.Run( "PostNetInit" )