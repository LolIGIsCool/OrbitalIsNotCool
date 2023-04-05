local ipairs 		= ipairs
local pairs 		= pairs
local table 		= table
local string 		= string

os.cmd.Params 		= os.cmd.Params or {}

local parser_mt 	= {}
parser_mt.__index 	= parser_mt

-- not being called on pm bug
function os.cmd.Param(name)


	if isnumber(name) == true then
		return
	end
	name = name:lower() or 'no'

	if os.cmd.Params[name] then
		return os.cmd.Params[name]
	else
		local p = {
			Name = name
		}
		setmetatable(p, parser_mt)
		os.cmd.Params[p.Name] = p
		return p
	end
end

function parser_mt:Parse(callback)
	if (SERVER) then
		self.Init = callback
	end
	return self
end

function parser_mt:Complete(callback)
	if (CLIENT) then
		self.AutoComplete = callback
	end
	return self
end

function parser_mt:Menu(action)
	if (CLIENT) then
		self.CreateMenu = action
	end
	return self
end


function os.cmd.Parse(pl, cmd, args)
	args.raw = {}
	cmd = os.cmd.Get(cmd)

	for k, v in ipairs(cmd:GetArgs()) do
		if (args[k] == nil) and (v.Flag ~= 'optional') then
			os.notify_err(pl, os.Term('MissingArg'), v.Key)
			return false
		elseif (args[k] == nil) and (v.Flag == 'optional') then
			break
		end

		if isnumber(v.Param) == true then
			break
		end
	
		local param = os.cmd.Param(v.Param)
		local succ, data = param:Init(pl, cmd:GetName(), args[k], {Key = v.Key, Pos = k, Args = args})
		if (succ == false) then
			os.notify_err(pl, data or os.Term('FatalError'))
			return succ
		else
			args[v.Key] 	= data
			args.raw[v.Key] = args[k]
			args[k] 		= nil -- clean tables plz
		end
	end
	return true
end

local function Concat(tab, endp)
	local str = ''
	for i = 1, endp do
		str = str .. ' ' .. ((i > 1) and os.str.Quotify(tab[i]) or tab[i])
	end
	return str
end

function os.cmd.AutoComplete(cmd, str)
	local showNextSet = (str:sub(str:len(), str:len() + 1) == ' ')
	local args = os.str.ExplodeQuotes(str)
	local len = #args
	local ret = {}
	for k, v in pairs(os.cmd.GetTable()) do
		if (SERVER) or LocalPlayer():HasAccess(v:GetFlag()) then
			if (len ~= 0) and string.StartWith(k, args[1]:lower()) then
				ret[#ret + 1] = cmd .. ' ' .. k
			elseif (len == 0) then
				ret[#ret + 1] = cmd .. ' ' .. k
			end
		end
	end
	if args[1] and os.cmd.Exists(args[1]) then
		local cmd_obj = os.cmd.Get(args[1])
		local numArgs = #cmd_obj:GetArgs()

		for k, v in ipairs(cmd_obj:GetArgs()) do
			if (k >= len) and (showNextSet == false) or (k > len) and (showNextSet == true) then
				break
			elseif (numArgs + 1 < len) or (numArgs + 1 <= len) and (showNextSet == true) then
				ret = {'<To many arguments>'}
				break
			end

			local ret1 = cmd .. ' ' .. Concat(args, (showNextSet and len or len - 1))
			ret = {}

			local tbl = os.cmd.Param(v.Param):AutoComplete(args[k + 1], {Key = v.Key, Pos = k, Args = args})

			for key, value in ipairs((#tbl > 0) and tbl or {'<No results>'}) do
				ret[key] = ret1 .. ' ' .. os.str.Quotify(value)
			end
		end
	end
	return (#ret > 0) and ret or {'<No results>'}
end

local RunCommand = (SERVER) and os.cmd.ConCommand or function(p, c, a, str) p:ConCommand('_os ' .. str) end
concommand.Add('os', RunCommand, os.cmd.AutoComplete)
concommand.Add('oadmin', RunCommand, os.cmd.AutoComplete)


--
-- Players
--
local function PlayerAutoComplete(self, arg, opts)
	local ret = {}
	if (arg ~= nil) and os.IsSteamID(arg) then 
		ret = {arg}
	else
		for _, pl in ipairs(player.GetAll()) do
			if (arg ~= nil) and string.find(pl:Name():lower(), arg:lower()) then
				ret[#ret + 1] = pl:Name()
			elseif (arg == nil) then
				ret[#ret + 1] = pl:Name()
			end
		end
	end
	return ret
end

local function PlayerCreateMenu(self, parent, w, h, opts)
	return ui.Create('os_menu_playerlabel', function(self, p)
		self:SetPlayer(parent:GetParent().Player.Player) -- Hmm, don't ask
		self:SetPos(5, h)
		self:SetSize(w - 10, 35)
	end, parent), (h + 35)
end

os.cmd.Param('player_steamid')
	:Parse(function(self, pl, cmd, arg, opts)
		local result = os.FindPlayer(arg)
		if (result ~= nil) and not os.ranks.CanTarget(pl, result) then
			os.notify(result, os.Term('TriedToRunCommand'), pl, cmd)
			return false, os.Term('SameWeight')
		elseif (result == nil) and not os.IsSteamID(arg) then
			return false, 'Player ' ..  arg .. ' not found!'
		elseif os.IsSteamID(arg) and (result == nil) then
			return true, arg
		end
		return true, result
	end)
	:Complete(PlayerAutoComplete)
	:Menu(PlayerCreateMenu)

os.cmd.Param('player_entity')
	:Parse(function(self, pl, cmd, arg, opts)
		local result = os.FindPlayer(arg)
		if (result ~= nil) and not os.ranks.CanTarget(pl, result) then
			os.notify(result, os.Term('TriedToRunCommand'), pl, cmd)
			return false, os.Term('SameWeight')
		elseif (result == nil) then
			return false, 'Player ' ..  arg .. ' not found!'
		end
		return true, result
	end)
	:Complete(PlayerAutoComplete)
	:Menu(PlayerCreateMenu)

os.cmd.Param('player_entity_multi')
	:Parse(function(self, pl, cmd, arg, opts)
		local results = {}
		for i = 1, (#opts.Args - #os.cmd.Get(cmd):GetArgs() + 1) do
			local result = os.FindPlayer(opts.Args[opts.Pos])
			if (result ~= nil) and (not os.ranks.CanTarget(pl, result)) then
				os.notify(result, os.Term('TriedToRunCommand'), pl, cmd)
				return false, os.Term('SameWeight')
			elseif (result == nil) then
				return false, 'Player ' ..  opts.Args[opts.Pos] .. ' not found!'
			else
				table.insert(results, result)
				table.remove(opts.Args, opts.Pos)
			end
		end
		return true, results
	end)
	:Complete(PlayerAutoComplete)
	:Menu(PlayerCreateMenu)



--
-- Time
--
os.NumberUntits = {mi = 60, h = 3600, d = 86400, w = 604800, mo = 2592000}

os.cmd.Param('time')
	:Parse(function(self, pl, cmd, arg, opts)
		arg = arg:lower()
		local s = 0
		for k, t in string.gmatch(arg, '(%d+)(%a+)') do
			if os.NumberUntits[t] then
				s = s + k * os.NumberUntits[t]
			else
				return false, os.Term('InvalidTimeUnit')
			end
		end
		if (s == 0) then
			return false, os.Term('InvalidTimeUnit')
		end
		return true, s
	end)
	:Complete(function(self, arg, opts)
		local ret = {}
		for k, v in pairs(os.NumberUntits) do
			ret[#ret + 1] = '1' .. k
		end
		return ret
	end)
	:Menu(function(self, parent, w, h, opts)
		local lbl = ui.Create('DLabel', function(self)
			self:SetPos(7.5, h + 1)
			self:SetText(os.str.Capital(opts.Key) .. ':')
			self:SizeToContents()
		end, parent)

		local time = ui.Create('os_menu_timeselect', function(self)
			self:SetSize(w - 85, 25)
			self:SetPos(80, h)
		end, parent)
		return time, (h + time:GetTall())
	end)



--
-- String
--
os.cmd.Param('string')
	:Parse(function(self, pl, cmd, arg, opts)
		if (#opts.Args > #os.cmd.GetTable()[cmd].Args) then
			for i = 1, (#opts.Args - #os.cmd.Get(cmd):GetArgs()) do
				arg = arg .. ' ' .. opts.Args[opts.Pos + 1]
				table.remove(opts.Args, opts.Pos + 1)
			end
		end
		return true, arg
	end)
	:Complete(function(self, arg, opts)
		return (arg ~= nil) and {arg} or {'<' .. opts.Key .. '>'}
	end)
	:Menu(function(self, parent, w, h, opts)
		local lbl = ui.Create('DLabel', function(self)
			self:SetPos(7.5, h + 1)
			self:SetText(os.str.Capital(opts.Key) .. ':')
			self:SizeToContents()
		end, parent)

		local entry = ui.Create('DTextEntry', function(self)
			self:SetSize(w - 85, 25)
			self:SetPos(80, h)
		end, parent)
		return entry, (h + entry:GetTall())
	end)

--
-- Ranks
--
os.cmd.Param('rank')
	:Parse(function(self, pl, cmd, arg, opts)
		arg = arg:lower()
		if (not os.ranks.Get(arg)) then
			return false, 'Invalid group!'
		end
		return true, arg
	end)
	:Complete(function(self, arg, opts)
		local ret = {}
		for k, v in pairs(os.ranks.GetTable()) do
			if (arg ~= nil) and string.find(v:GetName():lower(), arg:lower()) then
				ret[#ret + 1] = v:GetName()
			elseif (arg == nil) then
				ret[#ret + 1] = v:GetName()
			end
		end
		return ret
	end)
	:Menu(function(self, parent, w, h, opts)
		local lbl = ui.Create('DLabel', function(self)
			self:SetPos(7.5, h + 1)
			self:SetText(os.str.Capital(opts.Key) .. ':')
			self:SizeToContents()
		end, parent)

		local ranks = ui.Create('DComboBox', function(self)
			self:SetSize(w - 85, 25)
			self:SetPos(80, h)
			for k, v in pairs(os.ranks.GetTable()) do
				if (LocalPlayer():GetImmunity() > v:GetImmunity()) then
					self:AddChoice(os.str.Capital(v:GetName()))
				end
			end
		end, parent)
		return ranks, (h + ranks:GetTall())
	end)