os.cmd 			= os.cmd 		or {}
os.cmd.Stored 	= os.cmd.Stored or {}

local cmd_mt 	= {}
cmd_mt.__index 	= cmd_mt

function os.cmd.Create(name, callback)
	local c = {
		Name  		= name:lower():gsub(' ', ''),
		NiceName 	= name,
		Args		= {},
		Flag	 	= 'u',
		Icon 		= 'icon16/group.png',
		Callback	= callback or function() end
	}
	setmetatable(c, cmd_mt)
	os.cmd.Stored[c.Name] = c
	return c
end

function os.cmd.GetTable()
	return os.cmd.Stored
end

function os.cmd.Get(name)
	return os.cmd.Stored[name:lower()]
end

function os.cmd.Exists(name)
	return (os.cmd.Stored[name:lower()] ~= nil)
end

-- Set
function cmd_mt:AddAlias(name)
	os.cmd.Stored[name:lower()] = self
	return self
end

function cmd_mt:RunOnClient(callback)
	self.ClientCallback = callback
	return self
end

function cmd_mt:AddArg(param, key, flag)
	self.Args[#self.Args + 1] = {
		Param 	= param,
		Key 	= key,
		Flag 	= flag,
	}
	return self
end
cmd_mt.AddParam = cmd_mt.AddArg

function cmd_mt:SetFlag(flag)
	self.Flag = flag
	return self
end

function cmd_mt:SetHelp(help)
	self.Help = help
	return self
end

function cmd_mt:SetIcon(icon)
	self.Icon = icon
	return self
end

-- Get
function cmd_mt:GetName()
	return self.Name
end

function cmd_mt:GetNiceName()
	return self.Name
end

function cmd_mt:GetArgs()
	return self.Args
end

function cmd_mt:GetFlag()
	return self.Flag
end

function cmd_mt:GetHelp()
	return self.Help
end

function cmd_mt:GetIcon()
	return self.Icon
end

-- Internal
function cmd_mt:Init(pl, args)
	if (SERVER) then
		if self.ClientCallback then
			net.Start('os.RunCommand')
				net.WriteString(self:GetName())
				net.WriteTable(args)
			net.Send(pl)
		end
		return self.Callback(pl, args)
	else
		return self.ClientCallback(pl)
	end
end

if (CLIENT) then
	net.Receive('os.RunCommand', function()
		local cmd 	= net.ReadString()
		local args 	= net.ReadTable()
		os.cmd.Get(cmd):Init(args)
	end)
end