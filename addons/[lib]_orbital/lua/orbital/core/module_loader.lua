local modules 	 = {}
local gm_modules = {}
local mod_mt 	 = {}
mod_mt.__index 	 = mod_mt

function os.Module(name)
	local m = {
		Name 		 = name,
		Files 		 = {},
		Dependancies = {}
	}
	setmetatable(m, mod_mt)
	modules[#modules + 1] = m
	return m
end

function mod_mt:Author(name)
	self.Creator = name
	return self
end

function mod_mt:SetGM(name)
	self.Gamemode = name:lower()
	return self
end

function mod_mt:CustomCheck(callback)
	self.CustomCheckFunc = callback
	return self
end

function mod_mt:Require(modules)
	if istable(modules) then
		for k, v in ipairs(modules) do
			self.Dependancies[#self.Dependancies + 1] = v
		end
	else
		self.Dependancies[#self.Dependancies + 1] = modules
	end
	return self
end

function mod_mt:Include(files)
	if istable(files) then
		for k, v in ipairs(files) do
			self.Files[#self.Files + 1] = v
		end
	else
		self.Files[#self.Files + 1] = files
	end
	return self
end

function mod_mt:Init()
	if (not self.CustomCheckFunc or self.CustomCheckFunc()) and (not self.Gamemode or (gmod.GetGamemode().Name:lower() == self.Gamemode)) then 
		/*for _, m in ipairs(self.Dependancies) do
			to do, make this work
		end*/ 

		for _, f in ipairs(self.Files) do
			os.include(self.Directory .. f)
		end

		os.print('> Module | ' .. self.Name)
	end
end


local _, dirs = file.Find('orbital/modules/*', 'LUA')
for _, m in ipairs(dirs) do
	os.include_sh('orbital/modules/' .. m .. '/_module.lua')
	modules[#modules].Directory = 'orbital/modules/' .. m .. '/'
end

hook.Add('PostGamemodeLoaded', function() -- it doesn't play nice if we load too soon
	for k, v in ipairs(modules) do
		v:Init()
	end
	hook.Call('osAdminPlguinsLoaded')
end)