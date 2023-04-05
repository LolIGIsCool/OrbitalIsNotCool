os.Terms 		= os.Terms 		or {}
os.TermsMap 	= os.TermsMap 	or {}
os.TermsStore 	= os.TermsStore or {}

local c = 0
hook.Add('BadminPlguinsLoaded', 'os.terms.BadminPlguinsLoaded', function()
	for k, v in SortedPairsByMemberValue(os.TermsStore, 'Name', false) do
		os.TermsMap[v.Name] = c 
		os.Terms[c] = v.Message
		c = c + 1
	end
end)

local color_red 	= Color(255,0,0)
local color_white 	= Color(235,235,235)
local color_console = Color(150, 0, 255)
local color_green 	= Color(175,255,175)  -- unused, now orange
local color_grey 	= Color(190,190,190)

function os.AddTerm(name, message)
	local k = os.TermsMap[name] or (#os.TermsStore + 1)
	os.TermsStore[k] = {
		Name = name,
		Message = message,
	}
end

function os.Term(name)
	return os.TermsMap[name]
end

local function writeargs(...)
	for k, v in ipairs({...}) do
		local t = type(v)
		if (t == 'Player') then
			net.WriteUInt(0,2)
			net.WritePlayer(v)
		elseif (t == 'Entity') then
			net.WriteUInt(1,2)
		else
			net.WriteUInt(2,2)
			net.WriteString(tostring(v))
		end
	end
end

local function readargs(msg)
	local tab = {}
	local k = 1
	local isfirst = (string.sub(msg, 1, 1) == '#') -- do the hack, do the hack
	local hasargs = (string.find(msg, '#') ~= nil)
	for v in string.gmatch(msg, '([^#]+)') do
		if (not isfirst) then
			tab[k] = v
			k = k + 1
		end
		if hasargs then
			local t = net.ReadUInt(2)
			if (t == 0) then 
				local v = net.ReadPlayer()
				if IsValid(v) then
					tab[k] = team.GetColor(v:Team())
					tab[k + 1] = v:Name()
					tab[k + 2] = color_grey
					tab[k + 3] = '(' .. v:SteamID() .. ')'
					tab[k + 4] = color_white
					k = k + 5
				else
					tab[k] = color_console
					tab[k + 1] = 'Unknown'
					tab[k + 2] = color_white
					k = k + 3
				end
			elseif (t == 1) then
				tab[k] = color_console
				tab[k + 1] = '(Console)'
				tab[k + 2] = color_white
				k = k + 3
			else
				tab[k] = color_console
				tab[k + 1] = net.ReadString()
				tab[k + 2] = color_white
				k = k + 3
			end
		end
			if (isfirst) then
				tab[k] = v
				k = k + 1
			end
		end

	if (not IsColor(tab[1])) then
		table.insert(tab, 1, color_white)
	end

	return tab
end

function os.WriteTerm(id, ...)
	net.WriteUInt(id, 8)
	writeargs(...)
end

function os.ReadTerm()
	return readargs(os.Terms[net.ReadUInt(8)])
end

function os.WriteMsg(msg, ...)
	net.WriteString(msg)
	writeargs(...)
end

function os.ReadMsg()
	return readargs(net.ReadString())
end