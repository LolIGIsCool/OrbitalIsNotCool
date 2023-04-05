local BlacklistView

--Creating some vars.
local FrameWidth, FrameHeight = ScrW() * 0.5, ScrH() * 0.5
local HeaderHeight = FrameHeight * 0.075
local ClosebuttonSize, ClosebuttonOffset = HeaderHeight / 2, HeaderHeight / 2
local BottomHeight = FrameHeight * 0.05

local Frame

local TotalBlacklists = 0
local CommonBlacklist = jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"]

local Loading = false

--Creating a function to open the admin menu.
function jBlacklist.VGui.OpenOverview(  )

	if Frame then Frame:Remove() end

	local PageDisplay
	local Cooldown = 0

	local function ChangePage( page )

		if Loading == true or Cooldown > CurTime() then return end
		Cooldown = CurTime() + 1

		BlacklistView:Clear()

		Loading = true

		--Request more blacklists.
		net.Start("jBlacklist_RequestPersonalBlacklists")
			net.WriteInt(math.Clamp(page,1,BlacklistView.MaxPage),8)
		net.SendToServer()

	end

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
		draw.SimpleText("JBlacklist - " .. jBlacklist.LoadedLanguage["TITLE_OVERVIEW"],"jBlacklist_HUD_Small",w / 2,HeaderHeight / 2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		--Draw gray actions area.
		surface.SetDrawColor(61,61,61)
		surface.DrawRect(0,HeaderHeight,w,h - HeaderHeight)

		--Draw bottom.
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,h - BottomHeight,w,BottomHeight)

		surface.SetDrawColor(28,28,28)
		surface.DrawRect(0,h - BottomHeight,w,1)

		draw.SimpleText(jBlacklist.Version .. " | " .. jBlacklist.Owner,"jBlacklist_HUD_Small",w * 0.01,h - BottomHeight / 2,Color(255,255,255),TEXT_ALIGN_LEFT,	TEXT_ALIGN_CENTER)

	end

	--Creating OnRemove function for Panel.
	Frame.OnRemove = function( )
		BlacklistView = nil
		TotalBlacklists = 0
		CommonBlacklist = jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"]
	end

	--[[-------------------------------------------------------------------------
	CloseButton
	---------------------------------------------------------------------------]]

	--Creating button.
	local CloseButton = vgui.Create("DButton",Frame)
	CloseButton:SetSize(ClosebuttonSize,ClosebuttonSize)
	CloseButton:SetPos(FrameWidth - ClosebuttonOffset - ClosebuttonSize / 2, ClosebuttonOffset - ClosebuttonSize / 2)
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
	Overview panel
	---------------------------------------------------------------------------]]

	--Setup the DlistView.
	BlacklistView = vgui.Create("DListView",Frame)
	BlacklistView:SetSize(FrameWidth * 0.8,FrameHeight * 0.65)
	BlacklistView:SetPos(FrameWidth / 2 - BlacklistView:GetWide() / 2, FrameHeight / 2 - FrameHeight * 0.7 / 2)
	BlacklistView.Page = 1
	BlacklistView.MaxPage = 1

	--Paint scrollbar.
	jBlacklist.VGui.ColorScrollbars( BlacklistView.VBar )

	BlacklistView.PaintOver = function( _, w, h )

		if Loading == false then return end

		jBlacklist.VGui.DrawLoading(Color(50,50,50), w, h)

	end

	BlacklistView.Paint = function( s, w, h)
		surface.SetDrawColor(80,80,80)
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(36,36,36)
		surface.DrawOutlinedRect(0,0,w,h)
	end

	BlacklistView.OnRowSelected = function( _, line )

		--Check if we are loading.
		if Loading == true then BlacklistView:ClearSelection() return end

		--Creating a DMenu.
		local Menu = DermaMenu()

		--Get the selectedline panel.
		local LinePanel = BlacklistView:GetLine(line)

		Menu.Paint = function( _, w, h )
			surface.SetDrawColor(55,55,55)
			surface.DrawRect(0,0,w,h)
		end

		--Adding some options.
		local DetailsOption = Menu:AddOption( jBlacklist.LoadedLanguage["MANAGE_DETAILS"], function(  )

			--Check so the line exists.
			if !LinePanel:IsValid() then return end

			--Calling function to open blacklist details window.
			jBlacklist.VGui.BlacklistDetails( LocalPlayer():SteamID(), LinePanel:GetValue(1) )

		end )

		DetailsOption:SetIcon("icon16/information.png")
		DetailsOption:SetTextColor(Color(255,255,255))

		--Add a spacer.
		Menu:AddSpacer()

		--Add a submenu called Information.
		local InformationsSubMenu, InformationsSubMenuOption = Menu:AddSubMenu( jBlacklist.LoadedLanguage["MANAGE_INFO"] )

		InformationsSubMenu.Paint = function( _,w,h )
			surface.SetDrawColor(55,55,55)
			surface.DrawRect(0,0,w,h)
		end

		InformationsSubMenuOption:SetIcon("icon16/page_paste.png")
		InformationsSubMenuOption:SetTextColor(Color(255,255,255))

		local ActionButtons = {
			{jBlacklist.LoadedLanguage["MANAGE_COPYUSERNAME"], "page_copy.png", function(  ) SetClipboardText( LinePanel:GetValue(2) ) end},
			{jBlacklist.LoadedLanguage["MANAGE_COPYSTEAMID"], "page_copy.png", function(  ) SetClipboardText( LinePanel:GetValue(3) ) end},
			{jBlacklist.LoadedLanguage["MANAGE_COPYSTEAMID64"], "page_copy.png", function(  ) SetClipboardText( util.SteamIDTo64(LinePanel:GetValue(3)) ) end},
			{jBlacklist.LoadedLanguage["MANAGE_COPYREASON"], "page_copy.png", function(  ) SetClipboardText( LinePanel:GetValue(5) ) end},
			{jBlacklist.LoadedLanguage["MANAGE_OPENSTEAMPROFILE"], "world_go.png", function(  ) gui.OpenURL("http://steamcommunity.com/profiles/" .. util.SteamIDTo64(LinePanel:GetValue(3))) end},
		}

		for k,v in pairs(ActionButtons) do
			
			local Button = InformationsSubMenu:AddOption( v[1], function(  )

				--Check so the line exists.
				if !LinePanel:IsValid() then return end

				--Call the function for the button.
				v[3]()

			end )

			Button:SetIcon("icon16/" .. v[2])
			Button:SetTextColor(Color(255,255,255))

		end

		--Open the menu.
		Menu:Open()

		--Clearing selection for a cleaner VGui and as the selection isn't needed.
		BlacklistView:ClearSelection()

	end

	--Add columns and set their width.
	BlacklistView:AddColumn(jBlacklist.LoadedLanguage["MANAGE_ID"])
	BlacklistView:AddColumn(jBlacklist.LoadedLanguage["MANAGE_USERNAME"])
	BlacklistView:AddColumn(jBlacklist.LoadedLanguage["MANAGE_STEAMID"])
	BlacklistView:AddColumn(jBlacklist.LoadedLanguage["MANAGE_TYPE"])
	BlacklistView:AddColumn(jBlacklist.LoadedLanguage["MANAGE_REASON"])
	BlacklistView:AddColumn(jBlacklist.LoadedLanguage["MANAGE_GIVENON"])
	BlacklistView:AddColumn(jBlacklist.LoadedLanguage["MANAGE_TIMELEFT"])
	BlacklistView:AddColumn(jBlacklist.LoadedLanguage["MANAGE_GIVENBY"])

	for i = 1,#BlacklistView.Columns do

		BlacklistView.Columns[i].Header.Paint = function( _, w, h )
			surface.SetDrawColor(35,35,35)
			surface.DrawRect(0,0,w,h)
		end

		BlacklistView.Columns[i].Header:SetTextColor(Color(255,255,255))

	end

	--[[-------------------------------------------------------------------------
	Create blacklistview bottom bar.
	---------------------------------------------------------------------------]]
	local _, BlacklistViewYPos = BlacklistView:GetPos()

	local BottomBar = vgui.Create("DPanel",Frame)
	BottomBar:SetSize(BlacklistView:GetWide(),FrameHeight * 0.05)
	BottomBar:SetPos(FrameWidth / 2 - BottomBar:GetWide() / 2, BlacklistViewYPos + BlacklistView:GetTall())

	BottomBar.Paint = function( _, w, h )
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,0,w,h)

		draw.SimpleText(jBlacklist.LoadedLanguage["MANAGE_STATISTICS_TOTAL"] .. ": " .. TotalBlacklists .. " | " .. jBlacklist.LoadedLanguage["MANAGE_STATISTICS_COMMON"] .. ": " .. CommonBlacklist,"jBlacklist_HUD_Small",w * 0.01,h / 2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
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

		timer.Simple(0,function (  )
			jBlacklist.VGui.OpenOverview(  )
		end)

	end

	--[[-------------------------------------------------------------------------
	Page Navigator
	---------------------------------------------------------------------------]]

	--Create a DTExtEntry to input the page.
	PageDisplay = vgui.Create("DButton",Frame)
	PageDisplay:SetText("")
	PageDisplay:SetSize(FrameWidth * 0.05,FrameHeight * 0.044)
	PageDisplay:SetPos(FrameWidth / 2 - PageDisplay:GetWide() / 2, FrameHeight * 0.88)

	--Creating paint function for the PageDisplay.
	PageDisplay.Paint = function( s, w, h )

		draw.RoundedBox(5,0,0,w,h,Color(36,36,36))
		draw.RoundedBox(5,1,1,w - 2,h - 2,s:IsDown() and Color(110,110,110) or s:IsHovered() and Color(120,120,120) or Color(100,100,100))


		draw.SimpleText(BlacklistView.Page,"jBlacklist_HUD_Small",w / 2,h / 2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	PageDisplay.DoClick = function(  )

		local window = jBlacklist.StringRequest( jBlacklist.LoadedLanguage["MANAGE_GOTOPAGE"], BlacklistView.Page, function( text )
			ChangePage( tonumber(text) )
		end)

		window:GetChildren()[5]:GetChildren()[2]:SetNumeric(true)

	end

	--Create a button to move up one page.
	local PageDown = vgui.Create("DButton",Frame)
	PageDown:SetText("")
	PageDown:SetSize(PageDisplay:GetTall(),PageDisplay:GetTall())
	PageDown:SetPos(FrameWidth * 0.47 - PageDown:GetWide(),FrameHeight * 0.88)

	--Creating paint function for PageDown.
	PageDown.Paint = function( s, w, h )

		draw.RoundedBox(6,0,0,w,h,Color(36,36,36))
		draw.RoundedBox(6,1,1,w - 2,h - 2,s:IsDown() and Color(110,110,110) or s:IsHovered() and Color(120,120,120) or Color(100,100,100))


		draw.SimpleText("<<","jBlacklist_HUD_Mini",w / 2,h / 2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	PageDown.DoClick = function(  )

		if BlacklistView.Page > 1 then
			ChangePage(BlacklistView.Page - 1)
		end

	end

	--Create a button to move up one page.
	local PageUp = vgui.Create("DButton",Frame)
	PageUp:SetText("")
	PageUp:SetSize(PageDisplay:GetTall(),PageDisplay:GetTall())
	PageUp:SetPos(FrameWidth * 0.53,FrameHeight * 0.88)

	--Creating paint function for PageUp.
	PageUp.Paint = function( s, w, h )

		draw.RoundedBox(6,0,0,w,h,Color(36,36,36))
		draw.RoundedBox(6,1,1,w - 2,h - 2,s:IsDown() and Color(110,110,110) or s:IsHovered() and Color(120,120,120) or Color(100,100,100))


		draw.SimpleText(">>","jBlacklist_HUD_Mini",w / 2,h / 2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	PageUp.DoClick = function(  )

		if BlacklistView.Page < BlacklistView.MaxPage then
			ChangePage(BlacklistView.Page + 1)
		end

	end

	--Request blacklists.
	net.Start("jBlacklist_RequestPersonalBlacklists")
		net.WriteUInt(BlacklistView.Page,8)
	net.SendToServer()

	Loading = true

end

--Create receiver for jBlacklist_PageAnswer.
net.Receive("jBlacklist_SendPersonalBlacklists",function( )

	--Check so the panel is open.
	if !BlacklistView then return end

	--Read the blacklists.
	local Blacklists = net.ReadTable()
	BlacklistView.Page = net.ReadInt(8)

	--Read stats.
	TotalBlacklists = net.ReadUInt(15)
	CommonBlacklist = net.ReadString()

	BlacklistView.MaxPage = math.ceil(TotalBlacklists / 20)

	--Check if there are any blacklists at all.
	if TotalBlacklists == 0 then

		--Set the commonblacklist to none.
		CommonBlacklist = jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"]

		--Clear the page.
		BlacklistView:Clear()

		--Set loading to false.
		Loading = false

		return

	--Check if we have entered a empty page.
	elseif table.Count(Blacklists) == 0 and TotalBlacklists > 0 then

		--Request new page again.
		timer.Simple(0.55,function(  )

			--Update the panel if we had it open.
			if BlacklistView then

				--Request the updated data.
				net.Start("jBlacklist_RequestPersonalBlacklists")
					net.WriteUInt(BlacklistView.MaxPage,8)
				net.SendToServer()

			end

		end)

		return

	end

	--Create SteamIDtbl with all steamIds.
	local steamIDTbl = {}

	--Add steamIDs.
	for k,v in pairs(Blacklists) do
		if !table.HasValue(steamIDTbl, v.ADMIN) then table.insert(steamIDTbl, v.ADMIN) end
	end

	local shouldClear = true

	--Get names.
	jBlacklist.SteamWorks_GetName(steamIDTbl, function( result )

		if shouldClear == true then BlacklistView:Clear() shouldClear = false end

		for k,v in pairs(Blacklists) do

			--Format the time left.
			if v.TIME > os.time() or v.TIME == -1 then
				FormatedTime = jBlacklist.FormatBlacklistTime( math.max(v.TIME - os.time(),-1) )
			else
				FormatedTime = jBlacklist.LoadedLanguage["EXPIRED"]
			end

			--Load the blacklist.
			local line = BlacklistView:AddLine(tonumber(k), LocalPlayer():Name(), LocalPlayer():SteamID(), v.TYPE, v.REASON, os.date( "%d/%m/%Y" , v.DATE ), FormatedTime , result[v.ADMIN] )

			--Color columns.
			for _,col in pairs(line.Columns) do
				col:SetColor(Color(255,255,255))
			end

		end

		--Sort all lines.
		BlacklistView:SortByColumn(1, true)

		Loading = false

	end)

end)

--Create a hook to update data.
hook.Add("jBlacklist_DataChange","jBlacklist_Update_BlacklistOverview",function( targetTbl )

	timer.Simple(0.55,function(  )

		--Update the panel if we had it open.
		if BlacklistView then

			--Check if we need to update the blacklistview.
			if !table.HasValue(targetTbl,LocalPlayer():SteamID()) then return end

			--Request the updated data.
			net.Start("jBlacklist_RequestPersonalBlacklists")
				net.WriteUInt(BlacklistView.Page,8)
			net.SendToServer()

		end

	end)

end)

--Create a hook to check if the server want's us to cancel the loading animation.
hook.Add("jBlacklist_StopLoading","JBlacklist_StopLoading_Overview",function( )
	Loading = false
end)

--Create concommand to open the adminmenu.
concommand.Add("jblacklist_openoverview",jBlacklist.VGui.OpenOverview)