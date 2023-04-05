--[[-------------------------------------------------------------------------
Derma Settings
---------------------------------------------------------------------------]]

--Creating some vars.
local FrameWidth, FrameHeight = ScrW() * 0.5, ScrH() * 0.5
local HeaderHeight = FrameHeight * 0.15
local ClosebuttonSize, ClosebuttonOffset = HeaderHeight * 0.25, HeaderHeight * 0.2
local BottomHeight = FrameHeight * 0.05

local Frame

--[[-------------------------------------------------------------------------
FUNCTIONS
---------------------------------------------------------------------------]]

--Create a function to get a player's name.
function jBlacklist.SteamWorks_GetName( steamIDTbl, callbackFunc )

	--Create a table to return.
	local toReturn = {}

	--Get playernames.
	for i = 1,#steamIDTbl do

		if steamIDTbl[i] == "CONSOLE" or string.match(steamIDTbl[i],"^STEAM_%d:%d:%d+$") == nil and steamIDTbl[i] != "" then

			toReturn[steamIDTbl[i]] = steamIDTbl[i]

			--Check if we are done.
			if i == #steamIDTbl then
				callbackFunc(toReturn)
				return
			end

			continue

		elseif steamIDTbl[i] == "" then

			toReturn[steamIDTbl[i]] = "UNKNOWN"

			--Check if we are done.
			if i == #steamIDTbl then
				callbackFunc(toReturn)
				return
			end

			continue

		end

		--Convert to steamID64.
		local steamID64 = util.SteamIDTo64(steamIDTbl[i])

		--Check so we converted successfully.
		if !steamID64 or steamID64 == "0" then
			toReturn[steamIDTbl[i]] = steamIDTbl[i]
		end

		--Request playerinfo.
		steamworks.RequestPlayerInfo(steamID64)

		timer.Simple(0.25, function(  )

			local name = steamworks.GetPlayerName(steamID64)

			--Add data to table.
			toReturn[steamIDTbl[i]] = name != "[unknown]" and name != "< blank >" and name or "UNKNOWN"

			--Check if we are done.
			if i == #steamIDTbl then
				callbackFunc(toReturn)
			end

		end)

	end


end

--Create a function for coloring scrollbars.
function jBlacklist.VGui.ColorScrollbars( VBar )

	VBar.Paint = function( _, w, h )

		--Set drawcolor for the VBar.
		surface.SetDrawColor(61,61,61)

		--Draw VBar.
		surface.DrawRect(0,0,w,h)

		--Set the drawcolor for the outline.
		surface.SetDrawColor(31,31,31)

		--Draw outline.
		surface.DrawOutlinedRect(0,0,w,h)

	end

	VBar.btnUp.Paint = function( _, w, h )

		--Set the drawcolor for the outline.
		surface.SetDrawColor(31,31,31)

		--Draw outline.
		surface.DrawOutlinedRect(0,0,w,h)

	end

	VBar.btnDown.Paint = function( _, w, h )

		--Set the drawcolor for the outline.
		surface.SetDrawColor(31,31,31)

		--Draw outline.
		surface.DrawOutlinedRect(0,0,w,h)

	end

	VBar.btnGrip.Paint = function( _, w, h )

		--Draw rounded outline.
		draw.RoundedBox(12,w * 0.125,w * 0.125,w * 0.75,h - w * 0.25,Color(31,31,31))

		--Draw grip.
		draw.RoundedBox(12,w * 0.125 + 1,w * 0.125 + 1,w * 0.75 - 2,h - 2 - w * 0.25,Color(71,71,71))

	end

end

--Create material.
local LoadingMaterial = Material("jblacklist_materials/loading.png", "noclamp smooth")

--Create function to draw a loadingoverlay.
function jBlacklist.VGui.DrawLoading( backgroundColor, w, h )

	surface.SetDrawColor(backgroundColor)
	surface.DrawRect(0,0,w,h)

	surface.SetDrawColor(36,36,36)
	surface.DrawOutlinedRect(0,0,w,h)

	surface.SetDrawColor(255,255,255)

	surface.SetMaterial(LoadingMaterial)

	surface.DrawTexturedRectRotated(w / 2,h * 0.3,h * 0.4,h * 0.4,(CurTime() * -240) % 360)

	draw.SimpleText(jBlacklist.LoadedLanguage["LOADING_DATA"],"jBlacklist_HUD_Big",w / 2,h * 0.6,Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	draw.SimpleText(jBlacklist.LoadedLanguage["LOADING_WAIT"],"jBlacklist_HUD_Small",w / 2,h * 0.75,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

end

--Creating a function to open the admin menu.
function jBlacklist.VGui.OpenMenu(  )

	--Check if the user got the required rank.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "ACCESSADMINMENU" ) then
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, jBlacklist.LoadedLanguage["INFO_NOTAUTHORIZED"])
		return
	end

	--Check if menu is already open.
	if Frame then Frame:Remove() end

	--[[-------------------------------------------------------------------------
	DFrame - Basic
	---------------------------------------------------------------------------]]

	--Create DFrame.
	Frame = vgui.Create("DFrame")
	Frame:SetSize(FrameWidth, FrameHeight)
	Frame:Center()
	Frame:MakePopup()
	Frame:SetTitle("")
	Frame:ShowCloseButton(false)
	Frame:SetDraggable(true)

	--Creating Paint function.
	Frame.Paint = function( s, w, h )

		if s.Dragging then
			s:SetAlpha(200)
		else
			s:SetAlpha(255)
		end

		--Creating gray header.
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,0,w,HeaderHeight)

		--Draw header text.
		draw.SimpleText("JBlacklist - " .. jBlacklist.LoadedLanguage["TITLE_ADMIN"],"jBlacklist_HUD_Small_Bold",w / 2,HeaderHeight * 0.2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		--Draw gray actions area.
		surface.SetDrawColor(61,61,61)
		surface.DrawRect(0,HeaderHeight,w,h - HeaderHeight)

		--Draw bottom.
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,h - BottomHeight,w,BottomHeight)

		surface.SetDrawColor(28,28,28)
		surface.DrawRect(0,h - BottomHeight,w,1)

		draw.SimpleText(jBlacklist.Version .. " | " .. jBlacklist.Owner,"jBlacklist_HUD_Small",w * 0.01,h - BottomHeight / 2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

	end

	--[[-------------------------------------------------------------------------
	CloseButton
	---------------------------------------------------------------------------]]

	--Creating button.
	local CloseButton = vgui.Create("DButton",Frame)
	CloseButton:SetSize(ClosebuttonSize,ClosebuttonSize)
	CloseButton:SetPos(FrameWidth - ClosebuttonOffset * 1.5, ClosebuttonOffset - ClosebuttonSize / 2)
	CloseButton:SetText("")

	--Creating paint function for button.
	CloseButton.Paint = function( _, w, h )
		draw.SimpleText("✖","jBlacklist_HUD_Small_Bold",w / 2,h / 2,CloseButton:IsDown() and Color(150,150,150) or CloseButton:IsHovered() and Color(200,200,200) or Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	--Creating DoClick function for button.
	CloseButton.DoClick = function(  )

		Frame:AlphaTo(0,0.1,0, function( _, pnl )
			pnl:Remove()
		end)

	end

	--[[-------------------------------------------------------------------------
	Creating Panels.
	---------------------------------------------------------------------------]]

	--Create the panels
	local CreatePanel = jBlacklist.VGui.Create_CreateTab( Frame )
	local ManagePanel = jBlacklist.VGui.Create_ManageTab( Frame )
	local StatsPanel = jBlacklist.VGui.Create_StatsTab( Frame )

	--Make some of them invisible.
	ManagePanel:SetVisible(false)
	StatsPanel:SetVisible(false)

	--Check if the user have access to the issuemenu.
	if !jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "CANISSUE" ) then
		CreatePanel:SetVisible(false)
		ManagePanel:SetVisible(true)
	end

	--[[-------------------------------------------------------------------------
	Adding navigation buttons.
	---------------------------------------------------------------------------]]

	local ButtonWidth, ButtonHeight = FrameWidth / 3, HeaderHeight * 0.5
	local ButtonYPos = HeaderHeight - ButtonHeight

	--Creating CreateButton.
	local CreateButton = vgui.Create("DButton",Frame)
	CreateButton:SetSize(ButtonWidth,ButtonHeight)
	CreateButton:SetPos(0,ButtonYPos + 1)
	CreateButton:SetText("")

	CreateButton.Paint = function( btn, w, h )

		if btn:IsHovered() then

			--Set Draw Color
			surface.SetDrawColor(btn:IsDown() and Color(56,56,56) or Color(46,46,46))

			--Draw Button Background
			surface.DrawRect(0,0,w,h)

		end

		--Create local textvariable.
		local text = jBlacklist.LoadedLanguage["ISSUEBUTTON"]

		--Check if the user got access to issue.
		if !jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "CANISSUE" ) then text = text .. " [" .. jBlacklist.LoadedLanguage["NOACCESS"] .. "]" end

		--Draw button text.
		draw.SimpleText(text,"jBlacklist_HUD_Small_Bold",w / 2,h * 0.8 / 2,Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		--Draw underline
		surface.SetDrawColor(198,53,80)
		surface.DrawRect(0,h * 0.9,w,h * 0.1)
	end

	--Creating DoClick function for the Create_Button button.
	CreateButton.DoClick = function( )
		if !jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "CANISSUE" ) then return end
		CreatePanel:SetVisible(true)
		ManagePanel:SetVisible(false)
		StatsPanel:SetVisible(false)
	end

	--Creating ManageButton.
	local ManageButton = vgui.Create("DButton",Frame)
	ManageButton:SetSize(ButtonWidth,ButtonHeight)
	ManageButton:SetPos(ButtonWidth,ButtonYPos + 1)
	ManageButton:SetText("")

	ManageButton.Paint = function( btn, w, h )

		if btn:IsHovered() then

			--Set Draw Color
			surface.SetDrawColor(btn:IsDown() and Color(56,56,56) or Color(46,46,46))

			--Draw Button Background
			surface.DrawRect(0,0,w,h)

		end

		--Draw button text.
		draw.SimpleText(jBlacklist.LoadedLanguage["MANAGEBUTTON"],"jBlacklist_HUD_Small_Bold",w / 2,h * 0.8 / 2,Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		--Draw underline
		surface.SetDrawColor(0,110,205)
		surface.DrawRect(0,h * 0.9,w,h * 0.1)
	end

	--Creating DoClick function for the ManageButton button.
	ManageButton.DoClick = function( )
		CreatePanel:SetVisible(false)
		ManagePanel:SetVisible(true)
		StatsPanel:SetVisible(false)
	end

	--Creating StatsButton.
	local StatsButton = vgui.Create("DButton",Frame)
	StatsButton:SetSize(ButtonWidth,ButtonHeight)
	StatsButton:SetPos(ButtonWidth * 2,ButtonYPos + 1)
	StatsButton:SetText("")

	StatsButton.Paint = function( btn, w, h )

		if btn:IsHovered() then

			--Set Draw Color
			surface.SetDrawColor(btn:IsDown() and Color(56,56,56) or Color(46,46,46))

			--Draw Button Background
			surface.DrawRect(0,0,w,h)

		end

		--Draw button text.
		draw.SimpleText(jBlacklist.LoadedLanguage["STATSBUTTON"],"jBlacklist_HUD_Small_Bold",w / 2,h * 0.8 / 2,Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		--Draw underline
		surface.SetDrawColor(2,195,154)
		surface.DrawRect(0,h * 0.9,w,h * 0.1)
	end

	--Creating DoClick function for the StatsButton button.
	StatsButton.DoClick = function( )
		CreatePanel:SetVisible(false)
		ManagePanel:SetVisible(false)
		StatsPanel:SetVisible(true)
	end

	--Create language selector.
	local LanguageSelector = vgui.Create("DComboBox",Frame)
	LanguageSelector:SetSize(FrameWidth * 0.1,BottomHeight)
	LanguageSelector:SetPos(FrameWidth * 0.9,FrameHeight - BottomHeight)
	LanguageSelector:SetText(jBlacklist.LoadedLanguage.Name)
	LanguageSelector:SetFont("jBlacklist_HUD_Mini")

	LanguageSelector:SetTextColor(Color(255,255,255))

	--Creating paint function for the Selector.TimeType.
	LanguageSelector.Paint = function( _, w, h )
		surface.SetDrawColor(25,25,25)
		surface.DrawRect(0,0,w,h)
	end

	--Creating paint function for the Selector.TimeType.DropButton.
	LanguageSelector.DropButton.Paint = function( _, w, h )
		draw.SimpleText("▼","jBlacklist_HUD_Mini",w * 0.65,h / 2,LanguageSelector:IsHovered() and Color(255,255,255) or Color(200,200,200),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	for k,v in pairs(jBlacklist.RegistredLanguages) do
		LanguageSelector:AddChoice(k)
	end

	LanguageSelector.OnSelect = function( _,_,Lang )

		jBlacklist.ChangeLang( Lang )
		Frame:Remove()

		if !file.Exists("jblacklist","DATA") then
			file.CreateDir("jblacklist")
		end

		file.Write("jblacklist/language.txt",Lang)

		if jBlacklist.RegistredLanguages[Lang].Version != jBlacklist.Version then
			jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["OUTDATED_LANG"] or "This language may not be compatible with this version of jBlacklist!")
		end

		--Need to do this to prevent a bug with the BlacklistView being nil.
		timer.Simple(0,function(  )
			jBlacklist.VGui.OpenMenu(  )
		end)

	end

end

--Create a reciver for jBlacklist_DataChange
net.Receive("jBlacklist_DataChange",function(  )

	local Targets = net.ReadTable()

	hook.Run("jBlacklist_DataChange", Targets)

end)

--Create receiver for jBlacklist_StopLoading.
net.Receive("jBlacklist_StopLoading",function( )
	hook.Run("jBlacklist_StopLoading")
end)

--Create concommand to open the adminmenu.
concommand.Add("jblacklist_openadmin",jBlacklist.VGui.OpenMenu)