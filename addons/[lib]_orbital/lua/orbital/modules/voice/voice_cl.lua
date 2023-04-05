
PLAYER.GetJobColor = PLAYER.GetJobColor or function(self) return team.GetColor(self:Team()) end -- rp fix

local math 				= math
local table 			= table
local draw 				= draw
local team 				= team
local IsValid 			= IsValid
local CurTime 			= CurTime

local PANEL 			= {}
local PlayerVoicePanels = {}
local material_mic 		= Material 'orbital/icons/istalking'

local color_white 		= Color(255,255,255)
local color_bg 			= Color(10,10,10, 220)
local color_outline 	= Color(20,20,20)
local color_vis_outline	= Color(200,200,200)
local color_vis_bg 		= Color(40,40,40)

function PANEL:Init()
	self.LabelName = ui.Create('DLabel', self)
	self.LabelName:SetFont('ui.17')
	self.LabelName:Dock(FILL)
	self.LabelName:DockMargin(4, 0, 0, 0)
	self.LabelName:SetTextColor(ui.col.White)
	self.LabelName:SetPos(52,29)

	self.Avatar = ui.Create('AvatarImage', self)
	self.Avatar:Dock(LEFT)
	self.Avatar:SetSize(40, 30)
    
	self.Color = color_transparent
	self.LastThink = CurTime()

	self:SetSize(350, 45)
	self:DockPadding(4, 4, 4, 4)
	self:DockMargin(5, 2, 2, 20)
	self:Dock(BOTTOM)
end

function PANEL:Setup(pl)
	self.pl = pl
	self.LabelName:SetText(pl:Nick())
	self.Avatar:SetPlayer(pl)
	
	self.Color = ui.col.OS

	self:InvalidateLayout()
end


function PANEL:Paint(w, h)
	if not IsValid(self.pl) then return end
	
	local pl 		= self.pl
	local volume   	= pl:VoiceVolume()

	self.Color 		 = ui.col.OS
	
	--DrawBlur(self, 6)
	draw.Outline(0, 0, w, h, color_outline)
	draw.Outline(1, 1, w - 2, h - 2, self.Color, 3)

	draw.Box(3, 3, w - 6, h - 6, color_bg)
	
	local s = 32
	surface.SetMaterial(material_mic)
	surface.SetDrawColor(255, 255, 255)
	material_mic:SetString('$alpha', self:GetAlpha()/255) // setalpha doesnt work on animated materials
	surface.DrawTexturedRect(w - 30, 8,s, s)
	
end

function PANEL:Think()
	if IsValid(self.pl) then
		self.LabelName:SetText(self.pl:Name())
	end
	if self.fadeAnim then
		self.fadeAnim:Run()
	end
end

function PANEL:FadeOut(anim, delta, data)
	if anim.Finished then
		self:Remove()
		if IsValid(PlayerVoicePanels[self.pl]) then
			self:Remove()
			PlayerVoicePanels[self.pl]:Remove()
			PlayerVoicePanels[self.pl] = nil
			return 
		end
		return 
	end
	self:SetAlpha(255 - (255 * delta))
end

derma.DefineControl('VoiceNotify', '', PANEL, 'DPanel')

hook.Add('InitPostEntity', 'os.vv.InitPostEntity', function() -- it doesn't play nice if we load before GAMEMODE is a table :(
	function GAMEMODE:PlayerStartVoice(pl)
		if not IsValid(g_VoicePanelList) then return end

		GAMEMODE:PlayerEndVoice(pl)

		if IsValid(PlayerVoicePanels[pl]) then
			if PlayerVoicePanels[pl].fadeAnim then
				PlayerVoicePanels[pl].fadeAnim:Stop()
				PlayerVoicePanels[pl].fadeAnim = nil
			end
			PlayerVoicePanels[pl]:SetAlpha(255)
			return
		end

		if not IsValid(pl) then return end

		local pnl = g_VoicePanelList:Add('VoiceNotify')
		pnl:Setup(pl)
		
		PlayerVoicePanels[pl] = pnl
	end

	function GAMEMODE:PlayerEndVoice(pl)
		if IsValid(PlayerVoicePanels[pl]) then
			if (PlayerVoicePanels[pl].fadeAnim) then return end
			self:Remove()
			PlayerVoicePanels[pl].fadeAnim = Derma_Anim('FadeOut', PlayerVoicePanels[pl], PlayerVoicePanels[pl].FadeOut)
			PlayerVoicePanels[pl].fadeAnim:Start(1)
		end
	end

	timer.Create('VoiceClean', 10, 0, function()
		for k, v in pairs(PlayerVoicePanels) do
			if not IsValid(k) then
				self:Remove()
				GAMEMODE:PlayerEndVoice(k)
			end
		end
	end)

	timer.Simple(0, function()
		if IsValid(g_VoicePanelList) then g_VoicePanelList:Remove() end
		g_VoicePanelList = ui.Create('DPanel')
		g_VoicePanelList:ParentToHUD()
		g_VoicePanelList:SetPos(ScrW() - 325, 100)
		g_VoicePanelList:SetSize(300, ScrH() - 200)
		g_VoicePanelList.Paint = function() end
	end)
end)