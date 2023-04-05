// Init Module
local MODULE = MODULE or RK.Modules:Get( "hud" )

// Module name
MODULE.name = "HUD"
// Module author
MODULE.author = "No Fucking Clue -glitch"
// Module description
MODULE.description = [[
	HUD.
]]

if SERVER then return end

-- Weapon Switcher --
local categories = {'Build','Roleplay','Misc','Weapons'}
local weaponMap = {
	weapon_physgun = {
		Name = 'Physgun',
		Slot = 1
	},
	weapon_physcannon = {
		Name = 'Gravgun',
		Slot = 1
	},
	gmod_tool = {
		Name = 'Toolgun',
		Slot = 1
	},
	weapon_rpg = {
		Name = 'RPG',
		Slot = 4
	},
	weapon_crossbow = {
		Name = 'Crossbow',
		Slot = 4
	},
	weapon_crowbar = {
		Name = 'Crowbar',
		Slot = 3
	},
	weapon_slam = {
		Name = 'SLAM',
		Slot = 3
	},
	weapon_stunstick = {
		Name = 'Stunstick',
		Slot = 4
	},
	weapon_bugbait = {
		Name = 'Bugbait',
		Slot = 3

	},
	weapon_frag = {
		Name = 'Grenade',
		Slot = 3
	}
}
local function getWeaponCat(wep)
	if (wep.GetSwitcherSlot) then
		wep.Slot = wep:GetSwitcherSlot()
	end
	local map = weaponMap[wep.ClassName or wep:GetClass()]
	return (wep.Slot and math.Clamp(wep.Slot, 1, 4)) or (map and map.Slot) or 2
end
local sorter = function(a, b)
	local aKnife = a.Ent.PrintName == 'Knife' or a.Ent.Base == 'baseknife'
	local bKnife = b.Ent.PrintName == 'Knife' or b.Ent.Base == 'baseknife'
	if (aKnife and !bKnife) then return true end
	return false
end
local wepsCache = {}
local weaponsByCategory = {}
local weaponsByOrder = {}
local weaponsByClass = {}
local selectedWeapon = -1
local lastCache = CurTime()
local function ensureWeapons(force)
	local weps = LocalPlayer():GetWeapons()
	if (lastCache <= CurTime() or force) then
		wepsCache = weps
		table.Empty(weaponsByCategory)
		table.Empty(weaponsByOrder)
		table.Empty(weaponsByClass)
		for k, cat in ipairs(categories) do
			local wepCat = k
			weaponsByCategory[wepCat] = {}
			for _, wep in pairs(weps) do
				if (getWeaponCat(wep) == wepCat) then
					local ind = table.insert(weaponsByCategory[wepCat], {
						Class = wep:GetClass(),
						Name = (weaponMap[wep:GetClass()] and weaponMap[wep:GetClass()].Name) or wep.PrintName or wep:GetClass(),
						Ent = wep
					})
					weaponsByClass[wep:GetClass()] = weaponsByCategory[wepCat][ind]
				end
			end
			table.sort(weaponsByCategory[wepCat], sorter)
		end
		for k, v in ipairs(categories) do
			for _, wep in ipairs(weaponsByCategory[k]) do
				local ind = table.insert(weaponsByOrder, wep)
				wep.ID = ind
			end
		end
	end
	if (selectedWeapon == 0 and IsValid(LocalPlayer():GetActiveWeapon()) and weaponsByClass[LocalPlayer():GetActiveWeapon():GetClass()]) then
		selectedWeapon = weaponsByClass[LocalPlayer():GetActiveWeapon():GetClass()].ID
	end
	lastCache = CurTime() + 0.25
end
local showTime = 0
local fadeTime = 0
local lastWep
local currentWep
local function switchWeapon(wep)
	wep = wep or weaponsByOrder[selectedWeapon]
	showTime = 0
	if not wep then
		return
	end
	lastWep = currentWep
	currentWep = wep
	if not IsValid(LocalPlayer():GetActiveWeapon()) or LocalPlayer():GetActiveWeapon() ~= wep.Ent then
		input.SelectWeapon(wep.Ent)
	else
		return
	end
	surface.PlaySound('buttons/lightswitch2.wav')
	return true
end
local color_white 		= ui.col.White
local color_flatblack 	= ui.col.FlatBlack
local color_background 	= ui.col.Background
local color_highlight 	= Color(255,255,255, 40)
local color_os	        = ui.col.OS
local color_red 	    = ui.col.Red
function GM:DrawWepSwitch()
	local st = SysTime()
	local w, h = 185, 35
	local x, y = (ScrW() - #categories * (w + 3)) * 0.5, 34 + math.sin(Lerp((st - fadeTime) / 0.5, 0, 1) * math.pi / 2) * 10
	if (showTime + 0.25 <= st) then return end
	ensureWeapons()
	if (showTime <= st) then
		surface.SetAlphaMultiplier(Lerp((st - showTime) / 0.2, 1, 0))
	else
		surface.SetAlphaMultiplier(Lerp((st - fadeTime) / 0.2, 0, 1))
	end
	for k, cat in ipairs(categories) do
		local x, y = x + ((k - 1) * (w + 3)), y
		local wepCat = k
		draw.RoundedBox(0, x, y, w, h, color_flatblack)
		draw.SimpleText(wepCat, 'ui.15', x + 3, y + 3, color_os, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText(cat, 'ui.20', x + (w * 0.5), y + (h * 0.5), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		for i, wep in ipairs(weaponsByCategory[wepCat]) do
			local y = y + (i * (h + 3))
			draw.RoundedBox(0, x, y, w, h, color_background)
			if (wep.ID == selectedWeapon) then
				draw.RoundedBox(0, x, y, w, h, color_highlight)
			end
			local name = string.Wrap('ui.18', wep.Name, w)
			if (#name > 1) then
				local wepW, wepH = 0, 0
				for wepK, wepName in ipairs(name) do
					wepW, wepH = draw.SimpleText(wepName, 'ui.18', x + 5, y + wepH, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				end
			else
				draw.SimpleText(wep.Name, 'ui.18', x + 5, y + 3, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
			if (not IsValid(wep.Ent)) then continue end
			local clip1, maxClip1 = wep.Ent:Clip1(), wep.Ent:GetMaxClip1()
			local isUnlimited = (maxClip1 < 1) and (clip1 < 1) or (not wep.Ent.DrawAmmo)
			draw.SimpleText(isUnlimited and '' or (clip1 .. '/' .. maxClip1) , 'ui.15', (x + w) - 5, (y + h) - 3, ((not isUnlimited) and (clip1 == 0)) and color_red or color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
		end
	end
end
local lastSnd = 0
hook('PlayerBindPress', 'rp.wepswitch.PlayerBindPress', function(pl, bind, pressed)
	if (!pressed) then return end
	if (!LocalPlayer():Alive()) then return end
	if (!IsValid(LocalPlayer():GetActiveWeapon())) then return end
	if (table.Count(LocalPlayer():GetWeapons()) <= 1) then return end
	local wep = pl:GetActiveWeapon()
	if IsValid(wep) and wep.SWBWeapon and wep.dt and (wep.dt.State == SWB_AIMING) and wep.AdjustableZoom then
		return
	end
	if hook.Call('SuppressWeaponSwitcher', nil, pl, bind, pressed) then return end
	if ((bind == 'invprev') or (bind == 'lastinv') or (bind == 'invnext') or (string.sub(bind, 1, 4) == 'slot')) and (not pl:KeyDown(IN_ATTACK)) then
		if (bind == 'lastinv') and lastWep and IsValid(lastWep.Ent) then
			switchWeapon(lastWep)
			selectedWeapon = currentWep.ID
		elseif (string.sub(bind, 1, 3) == 'inv') then
			if (showTime < SysTime()) then
				ensureWeapons(true)
				selectedWeapon = 0
			else
				local scroll = (bind == 'invprev') and -1 or 1
				selectedWeapon = selectedWeapon + scroll

				if (!weaponsByOrder[selectedWeapon]) then
					selectedWeapon = (scroll == 1 and 1) or #weaponsByOrder
				end
			end
		else -- using number keys
			if (showTime < SysTime()) then
				ensureWeapons(true)
				fadeTime = SysTime()
			end
			local slot = tonumber(string.sub(bind, -1))
			if (!categories[slot]) then return end
			if (weaponsByCategory[slot][1]) then
				local found = false
				for k, v in ipairs(weaponsByCategory[slot]) do
					if (v.ID == selectedWeapon) then
						found = true
						if (weaponsByCategory[slot][k + 1]) then
							selectedWeapon = v.ID + 1
						else
							selectedWeapon = weaponsByCategory[slot][1].ID
						end
						break
					end
				end
				if (!found) then
					selectedWeapon = weaponsByCategory[slot][1].ID
				end
			end
		end
		ensureWeapons(true)
		showTime = SysTime() + 2
		if (lastSnd < SysTime() - 0.05) then
			surface.PlaySound('garrysmod/ui_hover.wav')--buttons/blip1.wav')
			lastSnd = SysTime()
		end
	elseif (showTime > SysTime() and bind == '+attack') then
		showTime = 0
		if (IsValid(LocalPlayer():GetActiveWeapon()) and weaponsByOrder[selectedWeapon] and weaponsByClass[LocalPlayer():GetActiveWeapon():GetClass()] and selectedWeapon != weaponsByClass[LocalPlayer():GetActiveWeapon():GetClass()].ID) then
			switchWeapon()
		end
		return true
	elseif (bind == 'phys_swap') then
		showTime = 0
	end
end)

local function openWeaponOrderPreview()	
	local omit = {
		'weapon_base',
		'basecombatweapon',
		'weapon_rp_base',
		'swb_base',
		'weapon_ziptie_carrying',
		'baseknife',
		'weapon_struggle',
		'weapon_ziptied',
		'weapon_flechettegun'
	}

	ui.Create('ui_frame', function(self)
		local w, h = 185, 35
		local x, y = (ScrW() - #categories * (w + 3)) * 0.5, 35
		self:SetPos(x, y)
		self:SetSize(#categories * (w + 3) + 3, ScrH() - y * 2)
		self:SetTitle('Weapon Order Customization')
		self:SetDraggable(false)

		local weaponCategories = {}
		for k, v in ipairs(categories) do
			weaponCategories[k] = {
				Name = v,
				Weapons = {}
			}
		end

		local weps = weapons.GetList()
		for k, v in ipairs(weps) do
			if (table.HasValue(omit, v.ClassName)) then continue end
			v.Ent = weapons.GetStored(v.ClassName)
			v.Ent.ClassName = v.ClassName
			table.insert(weaponCategories[getWeaponCat(v.Ent)].Weapons, v)
		end

		for k, v in pairs(weaponMap) do
			local i = table.insert(weps, {
				ClassName = k,
				Ent = {
					ClassName = k,
					PrintName = v.Name
				}
			})
			table.insert(weaponCategories[getWeaponCat(weps[i].Ent)].Weapons, weps[i])
		end

		for k, v in ipairs(weaponCategories) do
			table.sort(v.Weapons, sorter)
			ui.Create('ui_scrollpanel', function(scr)
				local x, y = (k - 1) * (w + 3) + 3, 33
				scr:SetPos(x, y)
				scr:SetSize(w, self:GetTall() - y - 5)
				scr:AddItem(ui.Create('Panel', function(pnl)
					pnl:SetSize(w, h)
					pnl.Paint = function(s, w, h)
						draw.RoundedBox(0, 0, 0, w, h, color_flatblack)
						draw.SimpleText(k, 'ui.15', 3, 3, color_os, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
						draw.SimpleText(v.Name, 'ui.20', (w * 0.5), (h * 0.5), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end))

				for i, l in ipairs(v.Weapons) do
					scr:AddItem(ui.Create('Panel', function(pnl)
						pnl:SetSize(w, h)
						pnl.Paint = function(s, w, h)
							draw.RoundedBox(0, 0, 0, w, h, color_background)
							local name = (weaponMap[l.ClassName] and weaponMap[l.ClassName].Name) or l.PrintName or l.ClassName
							draw.SimpleText(name, 'ui.18', 5, 3, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
						end
					end))
				end
			end, self)
		end
		self:MakePopup()
	end)
end

concommand.Add('openWeaponOrderPreview', openWeaponOrderPreview)

/*------------------------------------
	Optimization
--------------------------------------*/
  
RunConsoleCommand("gmod_mcore_test","1")
RunConsoleCommand("mat_queue_mode", "-1")
RunConsoleCommand("cl_threaded_bone_setup","1")
RunConsoleCommand("cl_threaded_client_leaf_system","1")
RunConsoleCommand("r_threaded_particles","1")
RunConsoleCommand("r_threaded_renderables","1")
RunConsoleCommand("r_queued_ropes" , "1")
RunConsoleCommand("studio_queue_mode", "1")

/*------------------------------------
	-- Variables
--------------------------------------*/


local pos_y = 0
local preview_w_offset = -89

local x = ScrW()
local y = ScrH()

local additional_bar_x = 235 + preview_w_offset
local additional_bar_y = y - 40 + pos_y
local additional_bar_h = 9
local additional_bar_font = "tahoma_hud_13b"
local text_x_alignment = TEXT_ALIGN_CENTER

local MaxHealth, MaxArmour = 0, 0
local barlength = 215

local talkingplayers = {}
hook('PlayerStartVoice', 'rp.hud.PlayerStartVoice', function(pl)
	talkingplayers[pl] = true
end)

hook('PlayerEndVoice', 'rp.hud.PlayerEndVoice', function(pl)
	talkingplayers[pl] = nil
end)

timer.Simple(1, function()
	Material('voice/icntlk_pl'):SetFloat('$alpha', 0) -- hacky voice bubble fix
end)

local function mat(texture)
	return Material(texture, 'smooth')
end

local material_mic 		= mat 'orbital/icons/istalking'
local material_typing 	= mat 'orbital/icons/istyping'

local colour = {
	["pure_white"] = Color(255, 255, 255),
	["white"] = Color(220, 220, 220),
	["grey"] = Color(155, 155, 155),
	["darkest"] = Color(34, 34, 34),
	["dark"] = Color(13, 15, 46),
	["light"] = Color(101, 111, 123),
	["bar"] = Color(62, 88, 99),
	["health"] = Color(233, 233, 233), --226, 45, 45
	["experience"] = Color(46, 204, 113),
	["armour"] = Color(32, 110, 253),
	["entity_health"] = Color(255, 255, 255),
	["entity_job"] = Color(220, 220, 220),
	["entity_organisation"] = Color(200, 200, 200),
	["entity_level"] = Color(230, 230, 230)
}

/*------------------------------------
	Functions, Fonts and Materials
--------------------------------------*/

local nodraw = {
	CHudHealth 		= true,
	CHudCrosshair 	= false,
	CHudBattery 	= true,
	CHudSuitPower	= true,
	CHudAmmo 		= true,
	CHudSecondaryAmmo = true,
	CHudWeaponSelection = true,
	VoiceBox            = true
}
function GM:HUDShouldDraw(name)
	if nodraw[name] or ((name == 'CHudDamageIndicator') and (not LocalPlayer():Alive())) then
		return false
	end

	local wep = IsValid(LocalPlayer()) and LocalPlayer():GetActiveWeapon()
	if (IsValid(wep) and wep:GetClass() == 'gmod_camera') then return (name == 'CHudGMod') end
	return true
end

local function GetPercentage(value, max_value, max_width)
	if (!max_width) then max_width = 100 end
	local result = math.Clamp((value / max_value) * (max_width), 0, (max_width))
	return math.floor(result)
end

local simpleMathVecOffset = Vector(0, 0, -0)
local pang = Angle(0,90,90)
local disableBannerOverhead = false

function GM:DrawPlayerInfo(pl, simpleMath)

	local pos
	if (simpleMath) then
		pos = pl:EyePos() + simpleMathVecOffset
	else
		local bone = pl:LookupBone('ValveBiped.Bip01_Head1')
		if (not bone) then return end

		pos, _ = pl:GetBonePosition(bone)
	end

	if (not pos) then return end

	infoy = 0
	if pl.InfoOffset then
		pos.z = pos.z + pl.InfoOffset + 8.5
	else
		pos.z = pos.z + 13.5
	end

	pang.y = (LocalPlayer():EyeAngles().y - 90)


	cam_Start3D2D(pos, pang, 0.050)
	local x, y, w, h, y2

	if talkingplayers[pl] then
		surface_SetMaterial(material_mic)
		surface_SetDrawColor(color_white.r, color_white.g, color_white.b)
		surface_DrawTexturedRect(-64, y2 - 52, 128, 128)
	elseif pl:IsTyping() then
		surface_SetMaterial(material_typing)
		surface_SetDrawColor(color_white.r, color_white.g, color_white.b)
		surface_DrawTexturedRect(-60, y2 - -0, 128, 128)
	end

	cam_End3D2D()

end




if !CLIENT then return end 

surface.CreateFont( "CarbonHudFont26", { font = "Bahnschrift", size = 24, weight = 0, outline = true } )
surface.CreateFont( "ArcaneHudFont", { font = "Roboto Bold", size = 25, weight = 600 } )
surface.CreateFont( "ArcaneHudFontSmall", { font = "Roboto Bold", size = 23, weight = 600 } )
surface.CreateFont("AmmoPrim", {font = "Roboto Bold", size = 45})
surface.CreateFont("AmmoSec", {font = "Roboto Bold", size = ScreenScale(6)})
surface.CreateFont("WeaponName", {font = "Roboto Bold", size = 25})

local salaryicon = Material("materials/orbital/hud/cash.png","unlitgeneric")



local function img(x, y, w, h, mat, color)
	if color then
		surface.SetDrawColor(color.r ,color.g ,color.b)
	else
		surface.SetDrawColor(r or 200,g or 251,b or 255) ---  THIS COLOR ICONS 
	end
	surface.SetMaterial(mat)
	surface.DrawTexturedRect(x, y, w, h)
end


local function DrawRect( x, y, w, h, col )
    surface.SetDrawColor( col )
    surface.DrawRect( x, y, w, h )
end

local function DrawText( msg, fnt, x, y, c, align )
    draw.SimpleText( msg, fnt, x, y, c, align and align or TEXT_ALIGN_CENTER )
end



local function CreateImageIcon( icon, x, y, col, val )
  surface.SetDrawColor( col )
  surface.SetMaterial( icon )
  local w, h = 20, 20
  if val then
	  surface.SetDrawColor( Color( 255, 255, 255 ) )
  end
  surface.DrawTexturedRect( x, y, w, h )
end

function IfNotDead()

   	-- Check if Player isn't dead 
    if !LocalPlayer():Alive() then return end
    
    -- Check if Player doesn't have a weapon out
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end 
    
    local current_weapon = LocalPlayer():GetActiveWeapon()
    local mag_left = LocalPlayer():GetActiveWeapon():Clip1() 
    local mag_extra = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) 
    local secondary_ammo = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType())
end 



timer.Create( 'HandleLaws', 0.5, 0, function()
   	if input.IsKeyDown( KEY_F2 ) then
       	if show_laws then show_laws = false else show_laws = true end
   	end
end )


local blur = Material( "pp/blurscreen" )
local function DrawBlurRect(x, y, w, h)
	local X, Y = 0,0
		
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(blur)
	
		for i = 1, 5 do
			blur:SetFloat("$blur", (i / 4) * (4))
			blur:Recompute()
	
			render.UpdateScreenEffectTexture()
	
			render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
			render.SetScissorRect(0, 0, 0, 0, false)
		end
	   
	local lightness = 125
	   
   draw.RoundedBox(0,x,y,w,h,Color(0,0,0,lightness))
   surface.SetDrawColor(0,0,0)
   //surface.DrawOutlinedRect(x,y,w,h)
	   
end

local function NormalRect(x, y, w, h, colour, highlight)
	surface.SetDrawColor(colour)
	surface.DrawRect(x, y, w, h)
		
	if (highlight) then
	   surface.SetDrawColor(Color(colour.r * 1.2, colour.g * 1.2, colour.b * 1.2, colour.a))
	   surface.DrawRect(x, y, w, 1)
	   surface.DrawRect(x + w - 1, y, 1, h)
	end
end
	 
local function HealthArmourBar(x, y, w, h, health, armour)
	local health = math.floor(health)
	local armour = math.floor(armour)
	NormalRect(x, y, w-1, h, colour.darkest, false)
	NormalRect(x, y, health, h, colour.health, false)
		
	if (armour > 0) and LocalPlayer():Alive() then
	   NormalRect(x + health, y, armour, h, colour.armour, false)
	end

end

--//---------------------------------------

--Main HUD

---------------------------------------\\--



function CreateHUD()

	IfNotDead()
	local self = LocalPlayer()

	local bX, bY, bW, bH = ScrW() / 2 - 175, ScrH() - 120  , 350 , 95 -- Main Box
	DrawBlurRect( bX, bY, bW, bH +3, back )
	surface.SetDrawColor(255,255,255)
	surface.DrawOutlinedRect(  bX, bY, bW, bH -3, 1)
	surface.DrawOutlinedRect(  bX, bY, bW, bH +3, 1)
	surface.DrawOutlinedRect(  bX+(bW/6), bY+(bH/2.5)+3, bW/1.5, bH/1.75 -3, 1)
	surface.DrawRect(bX, bY+(bH/2.5)+3, bW, 1)
	surface.DrawRect(bX+(bW/3), bY, 1, bH/2.25)
	
	// DrawRect( bX, bH - 6, ScrW(), 4, through) -- Bar HUD


	local offset = 0

	local hX, hY, hW, hH = 9, ScrH() - 35, 190, 21

	local divide = 5
	local offset = 2

  --//---------------------------------------

  --Name Display 

  ---------------------------------------\\--

	local function DrawName()
		local width, height = surface.GetTextSize( 0 )
		local BoxLength = width + 50


		name = LocalPlayer():Nick()
		--name = string.upper(name)
		if string.len(name) > 16 then 
			--name = string.Left(name, 20)
			--name = string.upper(name)
			draw.SimpleText( name, "ArcaneHudFontSmall", bX+125 , bY+9, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)
		else
			draw.SimpleText( name, "ArcaneHudFontSmall", bX+125 , bY+9, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)
		end

		

	end
	DrawName()

 --//---------------------------------------

  --Health Display 

  ---------------------------------------\\--
  
	local function DrawVitals()
		
  		local health = LocalPlayer():Health()
		local armor = LocalPlayer():Armor()
		

		if health <= 0 then 
			health = "0"
		end

		if armor <= 0 then 
			armor = '0'
		end


		if LocalPlayer():Health() > MaxHealth then MaxHealth = LocalPlayer():Health() end
		if LocalPlayer():Armor() > MaxArmour and MaxArmour <= 250 then MaxArmour = LocalPlayer():Armor() end
		
		if (!LocalPlayer():Alive()) then 
		   Health = 0
		   Armour = 0
		   MaxHealth = 0 
		   MaxArmour = 0 
		end
	 
		Health = LocalPlayer():Health() 
		Armour = LocalPlayer():Armor()
		
		local health_percentage = GetPercentage(Health or 0, MaxHealth + MaxArmour, barlength)
		local armour_percentage = GetPercentage(Armour or 0, MaxHealth + MaxArmour, barlength)
		
		local additional_bar_x = barlength + preview_w_offset
		local additional_bar_y = y - 40 + pos_y
		local additional_bar_h = 9
		local additional_bar_font = "tahoma_hud_13b"
		local text_x_alignment = TEXT_ALIGN_CENTER
		local spacingdif = barlength / 5
		
		 additional_bar_y = y - 35 + pos_y
		 additional_bar_font = "opensans_hud_19b" 
		
		
		if (LocalPlayer():Health() > 0) then 
			HealthArmourBar(bX+66 , bY+55, 215, 14 + additional_bar_h, health_percentage, armour_percentage) 
			surface.SetDrawColor(colour.darkest)
			for i = 0,3 do
				surface.DrawRect((bX+65)+ spacingdif*(i+1), bY+55, 1, 14 + additional_bar_h)	
			end
		end  

		if (LocalPlayer():Armor() > 0) then 
		   additional_bar_x = 117 + preview_w_offset
		   text_x_alignment = TEXT_ALIGN_LEFT 
		end

		draw.SimpleText(health, "ArcaneHudFont", bX+30 , bY+55, Color(255,255,255), TEXT_ALIGN_CENTER ) 
	
		
		draw.SimpleText(armor, "ArcaneHudFont", bX+(bW)-30 , bY+55, Color(255,255,255), TEXT_ALIGN_CENTER )
	
	end 
	DrawVitals()

  --//---------------------------------------

  --Money

  ---------------------------------------\\--

  local cash = ( self:GetMoney() ) 
  local cashamount = tostring(cash)
  local cashwidth, cashheight = surface.GetTextSize( cashamount )

  img( bX+95 , bY+10, 16, 16, salaryicon, Color(255,255,255))


	DrawText( cashamount, "ArcaneHudFontSmall", bX+93 , bY+8, Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT)


  --//---------------------------------------

  --Ammo Display 

  ---------------------------------------\\--

 local function weapondisplay()
	draw.SimpleText( string.upper(weaponname) ,"WeaponName", ScrW() - 45 ,ScrH() - 116, Color(255,255,255), TEXT_ALIGN_RIGHT) 
  end 


  if(LocalPlayer():GetActiveWeapon() == NULL or LocalPlayer():GetActiveWeapon() == "Camera") then return end

  local current_weapon = LocalPlayer():GetActiveWeapon()
  local mag_left = LocalPlayer():GetActiveWeapon():Clip1() 
  local mag_extra = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) 
  local secondary_ammo = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType())
  


  function AmmoDisplay()
	
	local curWeapon = LocalPlayer():GetActiveWeapon():GetClass()
	if !IsValid(LocalPlayer():GetActiveWeapon()) then return end

	local weapon = LocalPlayer():GetActiveWeapon()
	local MaxAmmo = { }
	local ammo = (math.max((LocalPlayer():GetActiveWeapon():Clip1()), 0)) .. " / " .. mag_extra
	local clip = tonumber(weapon:Clip1()) or -1
	local allAmmo = LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType() or "")

	if curWeapon == "weapon_physcannon" then 
		weaponout = false
		return end

	if clip >= 0 || (MaxAmmo[weapon] or -1) >= 0 then
			
		DrawBlurRect(x - 235, y -80, 200, 60 )
		surface.SetDrawColor(colour.pure_white)
		surface.DrawOutlinedRect(x - 235, y -80, 200, 60,1)

		DrawBlurRect(x - 235, y - 118, 200, 30 )
		surface.SetDrawColor(colour.pure_white)
		surface.DrawOutlinedRect(x - 235, y - 118, 200, 30,1)

		DrawRect( ScrW() - 135, ScrH() - 80, 2, 60, color_white)

		draw.SimpleText(""..mag_left,"AmmoPrim", ScrW() - 185 ,ScrH() - 72, Color(255,255,255), TEXT_ALIGN_CENTER) 
		draw.SimpleText(""..mag_extra,"AmmoPrim", ScrW() - 85 ,ScrH() - 72, Color(255,255,255), TEXT_ALIGN_CENTER)
		weaponout = true

	else 
		weaponout = false
	end 

  end

    AmmoDisplay()

	if weaponout == true then
		weaponname = current_weapon:GetPrintName()
  		if string.len(weaponname) > 15 then weaponname = string.Left(weaponname, 15) .. "..." 
			weapondisplay()
  		else
			weapondisplay()
		end

	else 
		weaponname = current_weapon:GetPrintName()

		
		if string.len(weaponname) > 15 then weaponname = string.Left(weaponname, 15) .. "..." 
			DrawBlurRect(ScrW() - 235, ScrH() - 50, 200, 30 )
			surface.SetDrawColor(colour.pure_white)
			surface.DrawOutlinedRect(ScrW() - 235, ScrH() - 50, 200, 30,1)
			draw.SimpleText( string.upper(weaponname) ,"WeaponName", ScrW() - 45 ,ScrH() - 48, Color(255,255,255), TEXT_ALIGN_RIGHT)
		else 
			DrawBlurRect(ScrW() - 235, ScrH() - 50, 200, 30 )
			surface.SetDrawColor(colour.pure_white)
			surface.DrawOutlinedRect(ScrW() - 235, ScrH() - 50, 200, 30,1)
			draw.SimpleText( string.upper(weaponname) ,"WeaponName", ScrW() - 45 ,ScrH() - 48, Color(255,255,255), TEXT_ALIGN_RIGHT)  
			
		end 
	end 
end


local modify = {
	['$pp_colour_addr'] = 0.07,
	['$pp_colour_addg'] = 0.07,
	['$pp_colour_addb'] = 0.07,
	['$pp_colour_brightness'] = 0.0,
	['$pp_colour_contrast' ] = 1.05,
	['$pp_colour_colour'] = 1.5,
	['$pp_colour_mulr'] = 0,
	['$pp_colour_mulg'] = 0,
	['$pp_colour_mulb'] = 0
 }

hook.Add( "RenderScreenspaceEffects", "color_modify_example", function()

	DrawColorModify( modify )

end )

hook.Add( 'HUDPaint', 'HUD_DRAW_HUD', function()
  CreateHUD()
end )

function GM:HUDPaint()
	self:DrawWepSwitch()	
end