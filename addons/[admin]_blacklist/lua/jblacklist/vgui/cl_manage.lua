--Creating some vars.
local FrameWidth, FrameHeight = ScrW() * 0.5, ScrH() * 0.5
local HeaderHeight = FrameHeight * 0.15
local BottomHeight = FrameHeight * 0.05
local PanelHeight = FrameHeight - HeaderHeight - BottomHeight

local Loading = false

--Give some panels a bigger scope.
local BlacklistView
local PlayerChooser

local TotalBlacklists = 0
local CommonBlacklist = jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"]

--Creating function to create tab.
function jBlacklist.VGui.Create_ManageTab( parent )

	Loading = false

	local PageDisplay
	local Cooldown = 0

	local function ChangePage( page )

		if Loading == true or Cooldown > CurTime() then return end
		Cooldown = CurTime() + 1

		--Get the selected player.
		local _, data = PlayerChooser:GetSelected()

		--Check so data is valid.
		if !data then return end

		BlacklistView:Clear()

		Loading = true

		--Request more blacklists.
		net.Start("jBlacklist_RequestUserData")
			net.WriteString(data)
			net.WriteInt(math.Clamp(page,1,BlacklistView.MaxPage),8)
		net.SendToServer()

	end

	--Create panel.
	local Panel = vgui.Create( "DPanel", parent )
	Panel:SetSize(FrameWidth,PanelHeight)
	Panel:SetPos(0,HeaderHeight)

	--Creating paint function for Panel.
	Panel.Paint = function( _, w, h )
		surface.SetDrawColor(61,61,61)
		surface.DrawRect(0,0,w,h)
	end

	--Creating OnRemove function for Panel.
	Panel.OnRemove = function( )
		BlacklistView = nil
		TotalBlacklists = 0
		CommonBlacklist = jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"]
	end

	--[[-------------------------------------------------------------------------
	Create the DListView that will list all blacklists.
	---------------------------------------------------------------------------]]

	--Setup the DlistView.
	BlacklistView = vgui.Create("DListView",Panel)
	BlacklistView:SetSize(FrameWidth * 0.8,PanelHeight * 0.69)
	BlacklistView:SetPos(FrameWidth / 2 - BlacklistView:GetWide() / 2, PanelHeight / 2 - PanelHeight * 0.75 / 2)
	BlacklistView.Page = 1
	BlacklistView.MaxPage = 1

	BlacklistView.PaintOver = function( _, w, h )

		--Check if we are loading data.
		if Loading == true then 

			jBlacklist.VGui.DrawLoading( Color(50,50,50), w, h )

		end

	end

	BlacklistView.Paint = function( s, w, h)
		surface.SetDrawColor(80,80,80)
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(36,36,36)
		surface.DrawOutlinedRect(0,0,w,h)
	end

	--Paint scrollbar.
	jBlacklist.VGui.ColorScrollbars( BlacklistView.VBar )

	BlacklistView.OnRowSelected = function( _, line )
	--Some weird stuff going on.. Arguments seems to be wrong on the wiki and Github.

		--Check if we are loading.
		if Loading == true then BlacklistView:ClearSelection() return end

		--Creating a DMenu.
		local Menu = DermaMenu()

		Menu.Paint = function( _,w,h )
			surface.SetDrawColor(55,55,55)
			surface.DrawRect(0,0,w,h)
		end

		--Get the selectedline panel.
		local LinePanel = BlacklistView:GetLine(line)

		--Adding some options.
		local DetailsOption = Menu:AddOption( jBlacklist.LoadedLanguage["MANAGE_DETAILS"], function(  )

			--Check so the line exists.
			if !LinePanel:IsValid() then return end

			--Calling function to open blacklist details window.
			jBlacklist.VGui.BlacklistDetails( LinePanel:GetValue(3), LinePanel:GetValue(1) )

		end )

		DetailsOption:SetIcon("icon16/information.png")
		DetailsOption:SetTextColor(Color(255,255,255))

		if jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "CANMODIFYBLACKLIST" ) then

			local ModifyOption = Menu:AddOption( jBlacklist.LoadedLanguage["MANAGE_MODIFY"], function(  )

				--Check so the line exists.
				if !LinePanel:IsValid() then return end

				--Sending the information to the blacklist modifier function.
				jBlacklist.VGui.ModifyBlacklist( LinePanel:GetValue(3), LinePanel:GetValue(1), BlacklistView )

			end )

			ModifyOption:SetIcon("icon16/pencil.png")
			ModifyOption:SetTextColor(Color(255,255,255))

		end

		if jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "CANREMOVE" ) then

			local RemoveOption = Menu:AddOption( jBlacklist.LoadedLanguage["MANAGE_REMOVE"], function(  )

				--Check so the line exists.
				if !LinePanel:IsValid() then return end

				local SteamID = LinePanel:GetValue(3)
				local BlacklistID = tonumber(LinePanel:GetValue(1))

				--Create a window to make sure the action was intentional.
				jBlacklist.DermaQuery(jBlacklist.LoadedLanguage["MANAGE_DETAILS_QUARY"],function( )

					net.Start("jBlacklist_RemoveBlacklist")
						net.WriteString(SteamID)
						net.WriteUInt(BlacklistID,25)
					net.SendToServer()

					for k,v in pairs(BlacklistView:GetLines()) do

						if !v:IsValid()	then continue end

						if v:GetValue(1) == BlacklistID then
							BlacklistView:RemoveLine(v:GetID())
							break
						end
					end

				end)

			end )

			RemoveOption:SetIcon("icon16/cross.png")
			RemoveOption:SetTextColor(Color(255,255,255))

		end

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

	local BottomBar = vgui.Create("DPanel",Panel)
	BottomBar:SetSize(BlacklistView:GetWide(),PanelHeight * 0.06)
	BottomBar:SetPos(FrameWidth / 2 - BottomBar:GetWide() / 2, BlacklistViewYPos + BlacklistView:GetTall())

	BottomBar.Paint = function( _, w, h )
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,0,w,h)

		draw.SimpleText(jBlacklist.LoadedLanguage["MANAGE_STATISTICS_TOTAL"] .. ": " .. TotalBlacklists .. " | " .. jBlacklist.LoadedLanguage["MANAGE_STATISTICS_COMMON"] .. ": " .. CommonBlacklist,"jBlacklist_HUD_Small",w * 0.01,h / 2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	end

	--[[-------------------------------------------------------------------------
	Extended management button
	---------------------------------------------------------------------------]]
	local ExtendedManagement = vgui.Create("DImageButton",BottomBar)
	ExtendedManagement:SetSize(BottomBar:GetTall() * 0.65,BottomBar:GetTall() * 0.65)
	ExtendedManagement:SetPos(BottomBar:GetWide() - ExtendedManagement:GetWide() * 1.35, ExtendedManagement:GetTall() * 0.35)
	ExtendedManagement:SetImage("icon16/brick_edit.png")

	ExtendedManagement.DoClick = function(  )

		local _, data = PlayerChooser:GetSelected()

		--Check so data is valid.
		if !data then jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["MANAGE_EXTMGT_SELECTPLY"]) return end
		if data == "" then jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["MANAGE_ACTIONALL"]) return end

		if !jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "ERASEDATA" ) then return end

		local Menu = DermaMenu()

		Menu.Paint = function( _,w,h )
			surface.SetDrawColor(150,55,55)
			surface.DrawRect(0,0,w,h)
		end

		local EraseOption = Menu:AddOption(jBlacklist.LoadedLanguage["MANAGE_EXTMGT_ERASEPLYDATA"], function(  )

			local Numbers = {math.random(2,	15), math.random(2,	15)}

			local Question = string.Replace(jBlacklist.LoadedLanguage["MANAGE_EXTMGT_QUESTION"],"%Q",Numbers[1] .. " + " .. Numbers[2])

			jBlacklist.StringRequest(jBlacklist.LoadedLanguage["MANAGE_EXTMGT_CONFIRM_1"] .. "\n" .. Question,"", function( text )

				--Try to convert to number.
				text = tonumber(text)

				--Check if the user entered the correct answer.
				if text == Numbers[1] + Numbers[2] then

					jBlacklist.DermaQuery(jBlacklist.LoadedLanguage["MANAGE_EXTMGT_CONFIRM_2"] .. "\n" .. jBlacklist.LoadedLanguage["LOG_WARNING"],function( )

						net.Start("jBlacklist_EraseData")
							net.WriteString(data)
						net.SendToServer()

						BlacklistView:Clear()

						TotalBlacklists = 0
						CommonBlacklist = jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"]

					end)

				else
					jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["MANAGE_EXTMGT_WRONGANSWER"])
				end

			end)

		end)

		EraseOption:SetIcon("icon16/bin.png")
		EraseOption:SetTextColor(Color(255,255,255))

		Menu:Open()

	end

	--[[-------------------------------------------------------------------------
	Create playerchooser.
	---------------------------------------------------------------------------]]
	local _, YPos = BlacklistView:GetPos()

	PlayerChooser = vgui.Create("DComboBox",Panel)
	PlayerChooser:SetSize(FrameWidth * 0.8, PanelHeight * 0.05)
	PlayerChooser:SetPos(FrameWidth * 0.1, YPos - PlayerChooser:GetTall() + 1)
	PlayerChooser:SetSortItems(false)
	PlayerChooser:SetText(jBlacklist.LoadedLanguage["MANAGE_CHOOSE_PLAYER"])
	PlayerChooser:SetTextColor(Color(255,255,255))
	PlayerChooser:SetFont("jBlacklist_HUD_Mini")

	--Creating paint function for the PlayerChooser.
	PlayerChooser.Paint = function( _, w, h )
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(80,80,80)
		surface.DrawRect(1,1,w - 2,h - 2)
	end

	--Add item to select all players.
	PlayerChooser:AddChoice(jBlacklist.LoadedLanguage["MANAGE_ALL"],"")

	--Add Items.
	for k,v in pairs(player.GetAll()) do
		PlayerChooser:AddChoice(v:Name(),v:SteamID())
	end

	--Add SteamID input choice.
	PlayerChooser:AddChoice(jBlacklist.LoadedLanguage["INPUTSTEAMID"])

	--Creating paint function for the PlayerChooser.DropButton.
	PlayerChooser.DropButton.Paint = function( _, w, h )
		draw.SimpleText("▼","jBlacklist_HUD_Mini",w * 0.65,h / 2,PlayerChooser:IsHovered() and Color(255,255,255) or Color(200,200,200),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	PlayerChooser.OnSelect = function( _,_, Selected )

		TotalBlacklists = 0
		CommonBlacklist = jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"]

		BlacklistView.Page = 1
		BlacklistView.MaxPage = 1

		BlacklistView:Clear()

		if Selected == jBlacklist.LoadedLanguage["INPUTSTEAMID"] then

			jBlacklist.StringRequest(jBlacklist.LoadedLanguage["INPUTSTEAMID_QUARY"],"STEAM_0:0:0000000", function( text )

				--Make input uppercase.
				text = string.upper(text)

				--Check so we got a valid SteamID.
				if string.match(text,"^STEAM_%d:%d:%d+$") == nil then jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["INPUTSTEAMID_INCORRECTFORMAT"]) return end

				--Loop through all items in the PlayerChooser to check that we don't have similar items.
				for k,v in pairs(PlayerChooser.Choices) do
					if v == "STEAMID: " .. text then
						jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["INPUTSTEAMID_ALREADYADDED"])
						PlayerChooser:SetText(jBlacklist.LoadedLanguage["MANAGE_CHOOSE_PLAYER"])
						return
					end
				end

				--Add SteamID.
				PlayerChooser:AddChoice("STEAMID: " .. text,text,select)

			end, function(  )
				PlayerChooser:SetText(jBlacklist.LoadedLanguage["MANAGE_CHOOSE_PLAYER"])
			end)

		else

			local _, data = PlayerChooser:GetSelected()

			net.Start("jBlacklist_RequestUserData")
				net.WriteString(data)
				net.WriteInt(BlacklistView.Page,8)
			net.SendToServer()

			Loading = true

		end

	end

	--[[-------------------------------------------------------------------------
	Page Navigator
	---------------------------------------------------------------------------]]

	--Create a DTExtEntry to input the page.
	PageDisplay = vgui.Create("DButton",Panel)
	PageDisplay:SetText("")
	PageDisplay:SetSize(FrameWidth * 0.05,FrameHeight * 0.044)
	PageDisplay:SetPos(FrameWidth / 2 - PageDisplay:GetWide() / 2, FrameHeight * 0.725)

	--Creating paint function for the PageDisplay.
	PageDisplay.Paint = function( s, w, h )

		draw.RoundedBox(5,0,0,w,h,Color(36,36,36))
		draw.RoundedBox(5,1,1,w - 2,h - 2,s:IsDown() and Color(110,110,110) or s:IsHovered() and Color(120,120,120) or Color(100,100,100))


		draw.SimpleText(BlacklistView.Page,"jBlacklist_HUD_Small",w / 2,h / 2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	PageDisplay.DoClick = function(  )

		local window = jBlacklist.StringRequest(jBlacklist.LoadedLanguage["MANAGE_GOTOPAGE"], BlacklistView.Page, function( text )
			ChangePage( tonumber(text) )
		end)

		window:GetChildren()[5]:GetChildren()[2]:SetNumeric(true)

	end

	--Create a button to move up one page.
	local PageDown = vgui.Create("DButton",Panel)
	PageDown:SetText("")
	PageDown:SetSize(PageDisplay:GetTall(),PageDisplay:GetTall())
	PageDown:SetPos(FrameWidth * 0.47 - PageDown:GetWide(),FrameHeight * 0.725)

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
	local PageUp = vgui.Create("DButton",Panel)
	PageUp:SetText("")
	PageUp:SetSize(PageDisplay:GetTall(),PageDisplay:GetTall())
	PageUp:SetPos(FrameWidth * 0.53,FrameHeight * 0.725)

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

	--Return the created panel.
	return Panel

end

--Create receiver for jBlacklist_PageAnswer.
net.Receive("jBlacklist_UserDataAnswer",function( )

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

				--Read selected SteamID.
				local _, data = PlayerChooser:GetSelected()

				--Check so we got a SteamID.
				if !data then return end

				--Request the updated data.
				net.Start("jBlacklist_RequestUserData")
					net.WriteString(data)
					net.WriteUInt(BlacklistView.MaxPage,8)
				net.SendToServer()

			end

		end)

		return

	end

	--Create SteamIDtbl with all steamIds.
	local steamIDTbl = {}

	--Add other steamIDs.
	for k,v in pairs(Blacklists) do

		local SteamId = util.SteamIDFrom64(v.STEAMID64)

		SteamId = !SteamId or SteamId == "0" and "" or SteamId

		if !table.HasValue(steamIDTbl, SteamId) then table.insert(steamIDTbl, SteamId) end
		if !table.HasValue(steamIDTbl, v.ADMIN) then table.insert(steamIDTbl, v.ADMIN) end
	end

	local shouldClear = true

	--Get names.
	jBlacklist.SteamWorks_GetName(steamIDTbl, function( result )

		if shouldClear == true then BlacklistView:Clear() shouldClear = false end

		--Loop through all blacklists.
		for k,v in pairs(Blacklists) do

			local STEAMID = util.SteamIDFrom64(v.STEAMID64)

			local FormatedTime

			--Format the time left.
			if v.TIME > os.time() or v.TIME == -1 then
				FormatedTime = jBlacklist.FormatBlacklistTime( math.max(v.TIME - os.time(),-1) )
			else
				FormatedTime = jBlacklist.LoadedLanguage["EXPIRED"]
			end

			--Load the blacklist.
			local line = BlacklistView:AddLine(tonumber(k), result[STEAMID], STEAMID, v.TYPE, v.REASON, os.date( "%d/%m/%Y" , v.DATE ), FormatedTime , result[v.ADMIN] )

			--Color the columns.
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
hook.Add("jBlacklist_DataChange","jBlacklist_Update_BlacklistView",function( targetTbl )

	timer.Simple(0.55,function(  )

		--Update the panel if we had it open.
		if BlacklistView then

			--Read selected SteamID.
			local _, data = PlayerChooser:GetSelected()

			--Check so we got a SteamID.
			if !data then return end

			--Check if we need to update the blacklistview.
			if data != "" and !table.HasValue(targetTbl,data) then return end

			--Request the updated data.
			net.Start("jBlacklist_RequestUserData")
				net.WriteString(data)
				net.WriteUInt(BlacklistView.Page,8)
			net.SendToServer()

		end

	end)

end)

--Create a hook to check if the server want's us to cancel the loading animation.
hook.Add("jBlacklist_StopLoading","JBlacklist_StopLoading_ManageTab",function( )
	Loading = false
end)