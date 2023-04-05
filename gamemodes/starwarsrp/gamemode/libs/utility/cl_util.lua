RK = RK or {}
RK.Img = RK.Img or {}
RK.Img.Images = RK.Img.Images or {}

local Panel = FindMetaTable( "Panel" )

local draw = _G.draw

local blur = Material("pp/blurscreen")
local gradientSquare = Material( "vgui/gradient-u", "noclamp smooth" )

function draw.Blur(x, y, w, h, amount, color)

	local X, Y = 0,0
	local W, H = ScrW(), ScrH()
	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( blur )
	if color then
		draw.RoundedBox( 0, x, y, w, h, color )
	end
	for i = 1, 5 do
		blur:SetFloat("$blur", ( i / 3 ) * ( amount or 6 ) )
		blur:Recompute()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect(0, 0, W, H)
			render.UpdateScreenEffectTexture()
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end

function Panel:DrawBlur( amount )
	local x, y = self:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat( "$blur", ( i / 3 ) * ( amount or 6 ) )
		blur:Recompute()
		surface.DrawTexturedRect(x * -1,y * -1, scrW, scrH)
		render.UpdateScreenEffectTexture()
	end
end

function RK.Img:GetMaterial( url )
	if !url then return end
	local crc = util.CRC( url ) .. ".png"
	if self.Images[crc] and TypeID( self.Images[crc] ) == TYPE_MATERIAL then return self.Images[crc] end

	if file.Exists("rk_lib/" .. crc, "DATA") then
		self.Images[crc] = Material("data/rk_lib/" .. crc, "smooth noclamp")
		return self.Images[crc]
	else
		return self:PreCacheMaterial(url, crc)
	end
end

function RK.Img:PreCacheMaterial( url, crc )
	if not crc then
		crc = util.CRC(url) .. ".png"
	end

	if not file.Exists("rk_lib", "DATA") then
		file.CreateDir("rk_lib")
	end

	self.PreCacheStarted = self.PreCacheStarted or {}

	if not self.PreCacheStarted[crc] then
		self.PreCacheStarted[crc] = true

		http.Fetch(url, function(body, size, headers, code)
			if true or body:find( "^.PNG" ) then
				file.Write("rk_lib/" .. crc, body)
				self.Images[crc] = Material( "data/rk_lib/" .. crc, "smooth noclamp" )

				return self.Images[crc]
			else
				print( "Error: Unable to find PNG on - " .. url )
			end
		end, function()
			print( "Error: Failed to get image on - " .. url )
		end)
	end

	return self.NoMaterial
end

local PANEL = {}
local OVERRIDES = {}

local function OverridePanel( name, f )
	PANEL = vgui_GetControlTable(name)

	if (not istable(PANEL)) then
		return
	end

	OVERRIDES = OVERRIDES or {}
	f()

	for k, _ in pairs(PANEL) do
		local overrideName = "RK" .. k

		if (PANEL[overrideName] and not OVERRIDES[k]) then
			print("unhooking override ", overrideName)

			PANEL[k] = PANEL[overrideName]
			PANEL[overrideName] = nil
		end
	end
end