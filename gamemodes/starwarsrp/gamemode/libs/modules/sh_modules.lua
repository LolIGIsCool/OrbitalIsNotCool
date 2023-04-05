RK = RK or {}
RK.Modules = RK.Modules or {}
RK.Modules.list = RK.Modules.list or {}
RK.Modules.unloaded = RK.Modules.unloaded or {} 
HOOKS_CACHE = {}

function RK.Modules:Load( uid, path, var )
	if hook.Run( "ModuleShouldLoad", uid, var ) == false then return false end

	local var = var or "MODULE"

	local MODULE = {
		[ "uid" ] 			= uid,
		[ "folder" ] 		= path,
		[ "name" ] 			= "Unknown",
		[ "description" ] 	= "Description not available",
		[ "author" ] 		= "Anonymous",
		[ "loading" ] 		= true
	}

	timer.Simple( 3, function() if MODULE.loading then RK:Print( "WARNING: " .. uid .. " is struggling to load." ) end end )

	_G[var] = MODULE

	local singleFile = path:find( ".lua" )
	if singleFile then RK:LoadFile( path ) else RK:LoadFile( path .. "/sh_" .. var:lower() .. ".lua", "shared" ) end

	if !singleFile then
		RK:RecusiveInclude( path, true )
	end

	function MODULE:SetData( value, ignoreMap )
		RK.Data:Set( uid, value, ignoreMap )
	end

	function MODULE:GetData( default, ignoreMap, refresh )
		return RK.Data:Get( uid, default, ignoreMap, refresh ) or {}
	end

	MODULE.name = MODULE.name or "Unknown"
	MODULE.description = MODULE.description or "No description available."

	for k, v in pairs(MODULE) do
		if (isfunction(v)) then
			HOOKS_CACHE[k] = HOOKS_CACHE[k] or {}
			HOOKS_CACHE[k][MODULE] = v
		end
	end

	MODULE.loading = false
	hook.Run( "ModuleLoaded", uid, MODULE )

	self.list[uid] = MODULE
	_G[var] = nil

	if (MODULE.OnLoaded) then
		MODULE:OnLoaded()
	end
end

function RK.Modules:GetHook(moduleName, hookName)
	local h = HOOKS_CACHE[ hookName ]

	if ( h ) then
		local p = self.list[ moduleName ]

		if ( p ) then
			return h[ p ]
		end
	end

	return
end

function RK.Modules:Get(identifier)
	return identifier and ( self.list[identifier] and self.list[identifier] or false ) or self.list
end

function RK.Modules:Initialize()
	self.unloaded = RK.Data and RK.Data:Get("unloaded", {}, true) or {}

	local files, folders = file.Find("starwarsrp/gamemode/modules/*", "LUA")

	for k, v in pairs( folders ) do
		if !self.unloaded[ v ] and !v:find( ".lua" ) then
			self:Load( v, "starwarsrp/gamemode/modules/" .. v )
		end
	end
	for k, v in pairs( files ) do
		if !self.unloaded[ v ] and v:find( ".lua" ) then
			self:Load( v, "starwarsrp/gamemode/modules/" .. v )
		end
	end
	
end

do
	-- luacheck: globals hook
	hook.RKCall = hook.RKCall or hook.Call

	function hook.Call(name, gm, ...)
		local cache = HOOKS_CACHE[name]

		if (cache) then
			for k, v in pairs(cache) do
				local a, b, c, d, e, f = v(k, ...)

				if (a != nil) then
					return a, b, c, d, e, f
				end
			end
		end

		return hook.RKCall(name, gm, ...)
	end
end