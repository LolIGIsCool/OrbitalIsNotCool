os.ui 			= os.ui or {}

local surface 	= surface
local table 	= table
local math 		= math

surface.CreateFont('os.ui.24', {font = 'roboto', size = 24, weight = 400})
surface.CreateFont('os.ui.22', {font = 'roboto', size = 22, weight = 400})
surface.CreateFont('os.ui.20', {font = 'roboto', size = 20, weight = 400})
surface.CreateFont('os.ui.18', {font = 'roboto', size = 18, weight = 400})
surface.CreateFont('os.ui.17', {font = 'roboto', size = 17, weight = 400})

function os.ui.WordWrap(font, text, width, emotes)
	surface.SetFont(font)
	
	local ret = {}
	
	local strpos = 1
	local bitstart = 1
	local bits = string.Explode('\n', text, false)
	for k, v in ipairs(bits) do
		local w = 0
		local s = ''
		local lastsp = 0
		
		local i = 1
		while (i <= #v) do
			local char = v[i]
			local charW
			
			if (emotes and emotes[strpos]) then 
				charW = 16
			else
				charW = surface.GetTextSize(char)
			end
			
			if (w + charW > width) then
				if (lastsp != 0) then -- split to the last space
					s = s:sub(1, #s-(i-lastsp)+1)
					ret[#ret+1] = s
					
					s = ''
					w = 0
					
					strpos = strpos - (i - lastsp) 
					i = lastsp + 1
					lastsp = 0 -- reset the space
				else -- split right here
					ret[#ret + 1] = s
					w = charW
					s = char
					
					strpos = strpos + 1
					lastsp = 0
					
					i = i + 1
				end
			else
				if (char == ' ') then
					lastsp = i
				end
				
				s = s .. char
				w = w + charW
				strpos = strpos + 1
				
				i = i + 1
			end
		end
		
		if (s != '' or bits[k+1]) then
			ret[#ret + 1] = s
		end
		
		strpos = strpos + 2
		bitstart = strpos
	end
	
	return ret
end

-- stoned is baaaaaad like a sheep :(
-- 	making me write my own utils like some kind of pleb :L
function os.ui.Label(text, parent, opts)
	local p = Label(text, parent)
	p:SetSkin('bAdmin')
	p:SetTextColor(color_white)
	if opts then
		if opts.font then
			p:SetFont(opts.font)
		end
		if opts.color then
			p:SetTextColor(opts.color)
		end
		if opts.wrap then
			p:SetWrap(opts.wrap)
			p:SetAutoStretchVertical(true)
		end
	end
	return p
end

function os.ui.OpenURL(url, title)
	local w, h = ScrW() * .9, ScrH() * .9

	local fr = ui.Create('ui_frame', function(self)
		self:SetSize(w, h)
		self:SetTitle(url)
		self:Center()
		self:MakePopup()
	end)

	ui.Create('HTML', function(self)
		self:SetPos(5, 32)
		self:SetSize(w - 10, h - 37)
		self:OpenURL(url)
	end, fr)

	return fr
end

function os.ui.DermaMenu()
	local m = DermaMenu()
	m:SetSkin('bAdmin')
	return m
end

function os.ui.CheckBox(label, cvar, x, y, parent)
	return ui.Create('os_checkboxlabel', function(self, p)
		self:SetPos(x, y)
		self:SetText(label)
		self:SetConVar(cvar)
		self:SizeToContents()
	end, parent)
end

function os.ScreenScale(size)
	local r = ScrH()/1080
	if (r < 0.8) then 
		r = 0.8
	elseif (r > 2) then 
		r = 2
	end
	return math.Round(r * size)
end
