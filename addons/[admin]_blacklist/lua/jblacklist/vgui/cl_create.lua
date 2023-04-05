--Creating some vars.
local FrameWidth, FrameHeight = ScrW() * 0.5, ScrH() * 0.5
local HeaderHeight = FrameHeight * 0.15
local BottomHeight = FrameHeight * 0.05
local PanelHeight = FrameHeight - HeaderHeight - BottomHeight
local ControlsOffset = PanelHeight / 6
local ControlsGap = PanelHeight * 0.01
local ControlsWidth = FrameWidth * 0.5

--Creating function to create tab.
function jBlacklist.VGui.Create_CreateTab( parent )

	--Create panel.
	local Panel = vgui.Create( "DPanel", parent )
	Panel:SetSize(FrameWidth,PanelHeight)
	Panel:SetPos(0,HeaderHeight)

	--Creating painit function for Panel.
	Panel.Paint = function( _, w, h )
		--Drawing background.
		surface.SetDrawColor(61,61,61)
		surface.DrawRect(0,0,w,h)

		--Drawing button labels.
		draw.SimpleText(jBlacklist.LoadedLanguage["ISSUE_TYPE"],"jBlacklist_HUD_Small_Bold",FrameWidth / 2,ControlsOffset - ControlsGap,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

		--Drawing button labels.
		draw.SimpleText(jBlacklist.LoadedLanguage["ISSUE_TARGET"],"jBlacklist_HUD_Small_Bold",FrameWidth / 2,ControlsOffset * 2 - ControlsGap,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

		--Drawing button labels.
		draw.SimpleText(jBlacklist.LoadedLanguage["ISSUE_LENGTH"],"jBlacklist_HUD_Small_Bold",FrameWidth / 2,ControlsOffset * 3 - ControlsGap,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

		--Drawing button labels.
		draw.SimpleText(jBlacklist.LoadedLanguage["ISSUE_REASON"],"jBlacklist_HUD_Small_Bold",FrameWidth / 2,ControlsOffset * 4 - ControlsGap,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)
	end

	--[[CREATING STUFF IN OPPOSITE ORDER TO MAKE THE RENDER ORDER CORRECT]]--

	--[[-------------------------------------------------------------------------
	Issue Button
	---------------------------------------------------------------------------]]

	local IssueButton = vgui.Create("DButton",Panel)
	IssueButton:SetSize(FrameWidth * 0.2,PanelHeight * 0.06)
	IssueButton:SetPos(FrameWidth / 2 - IssueButton:GetWide() / 2, ControlsOffset * 5 + ControlsGap)
	IssueButton:SetText(jBlacklist.LoadedLanguage["ISSUE_ISSUE"])
	IssueButton:SetFont("jBlacklist_HUD_Small_Bold")
	IssueButton:SetTextColor(Color(255,255,255))

	--Creating paint function for the button.
	IssueButton.Paint = function( s, w, h )
		draw.RoundedBox(5,0,0,w,h,Color(36,36,36))
		draw.RoundedBox(5,1,1,w - 2,h - 2,s:IsDown() and Color(73, 147, 163) or s:IsHovered() and Color(65, 139, 155) or Color(51, 110, 123))
	end

	--DoClick function at the bottom--

	--[[-------------------------------------------------------------------------
	Creating Silentmode button
	---------------------------------------------------------------------------]]

	local SilentButton = vgui.Create("DButton",Panel)
	SilentButton:SetText(jBlacklist.LoadedLanguage["ISSUE_SILENT"])
	SilentButton:SetFont("jBlacklist_HUD_Small_Bold")
	SilentButton:SetTextColor(Color(255,255,255))
	SilentButton:SetSize(FrameWidth * 0.14,PanelHeight * 0.06)
	SilentButton:SetPos(FrameWidth / 2 - SilentButton:GetWide() / 2, ControlsOffset * 5 - ControlsGap - PanelHeight * 0.06)

	SilentButton.Selected = false

	SilentButton.Paint = function( s, w, h )
		draw.RoundedBox(5,0,0,w,h,Color(36,36,36))
		draw.RoundedBox(5,1,1,w - 2,h - 2,s:IsHovered() and s.Selected == true and Color(65, 139, 155) or s:IsHovered() and Color(120,120,120) or s.Selected == true and Color(51, 110, 123) or Color(100,100,100))
	end

	SilentButton.DoClick = function(  )
		SilentButton.Selected = !SilentButton.Selected
	end

	--[[-------------------------------------------------------------------------
	Creating the reason input.
	---------------------------------------------------------------------------]]

	local ReasonInput = vgui.Create("DTextEntry",Panel)
	ReasonInput:SetSize(ControlsWidth,PanelHeight * 0.05)
	ReasonInput:SetPos(FrameWidth / 2 - ControlsWidth / 2, ControlsOffset * 4 + ControlsGap)
	ReasonInput:SetFont("jBlacklist_HUD_Mini")

	--Creating paint function for the ReasonInput.
	ReasonInput.Paint = function( s, w, h )
		surface.SetDrawColor(Color(36,36,36))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(100,100,100)
		surface.DrawRect(1,1,w - 2,h - 2)
		s:DrawTextEntryText(Color(255,255,255),Color(158, 217, 255),Color(0,0,0))
	end

	--Create AllowInput function for the ReasonInput.
	ReasonInput.AllowInput = function(  )
		return #ReasonInput:GetValue() >= 200
	end

	--[[-------------------------------------------------------------------------
	Time Selector
	---------------------------------------------------------------------------]]

	--Create timeselector.
	local TimeSelector = jBlacklist.VGui.CreateTimeselector( Panel, ControlsWidth, PanelHeight * 0.05, FrameWidth / 2 - ControlsWidth / 2, ControlsOffset * 3 + ControlsGap )

	--Get the limit of how long the user can blacklist someone in minutes.
	local timeLimit = jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "ISSUEMAXLENGTH" )

	--Make sure we got a limit.
	if timeLimit == false then
		timeLimit = 240
	end

	--Convert the time into hours and round it down.
	timeLimit = math.floor(timeLimit / 60)

	--Set the timeselector to the max limit that the user has.
	TimeSelector.NumberEntry:SetText(timeLimit == 0 and 8 or math.min(timeLimit,8))

	--[[-------------------------------------------------------------------------
	Advanced Selector - Target
	---------------------------------------------------------------------------]]

	--Creating selector.
	local TargetSelector = jBlacklist.VGui.CreateSelector( Panel, ControlsWidth, PanelHeight * 0.58, FrameWidth / 2 - ControlsWidth / 2, ControlsOffset * 2 + ControlsGap, PanelHeight * 0.05 )
	TargetSelector.SearchField.HelpText = jBlacklist.LoadedLanguage["ISSUE_CHOOSE_TARGET"]
	TargetSelector.TotalAllowed = 10

	--Creating table to store all items in.
	TargetSelector.Items = {}

	--Adding all players to the selector.
	for k,v in pairs(player.GetAll()) do
		TargetSelector.Items[v:SteamID()] = jBlacklist.VGui.AddSelectorItem( TargetSelector, v:Name() )
	end

	--Creating AddSteamID button.
	local AddSteamIDButton = jBlacklist.VGui.AddSelectorItem( TargetSelector, "< " .. jBlacklist.LoadedLanguage["INPUTSTEAMID"] .. " >" )

	--Overriding DoClick function for AddSteamIDButton.
	AddSteamIDButton.DoClick = function(  )

		TargetSelector.SearchField:SetText("")
		TargetSelector.SearchField.OnChange()

		jBlacklist.StringRequest(jBlacklist.LoadedLanguage["INPUTSTEAMID_QUARY"],"STEAM_0:0:0000000",function( text )

			--Make input uppercase.
			text = string.upper(text)

			--Check so we got a valid SteamID.
			if string.match(text,"^STEAM_%d:%d:%d+$") == nil then jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["INPUTSTEAMID_INCORRECTFORMAT"]) return end

			--Loop through all items in the TargetSelector to check that we don't have similar items.
			for k,v in pairs(TargetSelector.Items) do
				if v:GetText() == "SteamID: " .. text then jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["INPUTSTEAMID_ALREADYADDED"]) return end
			end

			--Create SteamID button.
			TargetSelector.Items[text] = jBlacklist.VGui.AddSelectorItem( TargetSelector, "SteamID: " .. text )

			--Call the onChange function again.
			TargetSelector.SearchField.OnChange()

		end)

	end

	--[[-------------------------------------------------------------------------
	Advanced Selector - Blacklist Type
	---------------------------------------------------------------------------]]

	--Creating selector
	local BlackListSelector = jBlacklist.VGui.CreateSelector( Panel, ControlsWidth, PanelHeight * 0.75, FrameWidth / 2 - ControlsWidth / 2, ControlsOffset + ControlsGap, PanelHeight * 0.05 )
	BlackListSelector.SearchField.HelpText = jBlacklist.LoadedLanguage["ISSUE_CHOOSE_TYPE"]
	BlackListSelector.TotalAllowed = 20

	--Creating table to store all items in.
	BlackListSelector.Items = {}

	for k,v in SortedPairs(jBlacklist.RegistredBlacklists) do
		BlackListSelector.Items[k] = jBlacklist.VGui.AddSelectorItem( BlackListSelector, k )
		BlackListSelector.Items[k].SetHelptext(v.GetDescription())
	end

	--[[-------------------------------------------------------------------------
	IssueButton - DoClick function.
	---------------------------------------------------------------------------]]

	IssueButton.DoClick = function(  )

		--Create table to store all blacklisttypes in.
		local BlacklistTypesTbl = {}

		--Add all selected items to the table.
		for k,v in pairs(BlackListSelector.Items) do
			if v.Selected == true then
				table.insert(BlacklistTypesTbl,k)
			end
		end

		--Create table to store all targetIDs in.
		local TargetIDsTbl = {}

		--Add all selected items to the table.
		for k,v in pairs(TargetSelector.Items) do
			if v.Selected == true then
				table.insert(TargetIDsTbl,k)
			end
		end

		--Check so we have any blacklists selected.
		if #BlacklistTypesTbl == 0 then
			jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["ISSUE_MISSING_TYPES"])
			return
		end

		--Check so we have any targets selected.
		if #TargetIDsTbl == 0 then
			jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_WINDOW, jBlacklist.LoadedLanguage["ISSUE_MISSING_TARGETS"])
			return
		end

		--Calculate length.
		local _, TimeType = TimeSelector.TimeType:GetSelected()
		local BlacklistLength = TimeType == -1 and -1 or TimeType * math.abs(TimeSelector.NumberEntry:GetValue())
		local reason = ReasonInput:GetValue()

		net.Start("jBlacklist_Issue")
			net.WriteTable(BlacklistTypesTbl)
			net.WriteTable(TargetIDsTbl)
			net.WriteInt(BlacklistLength,32)
			net.WriteString(reason == "" and "Reason" or reason)
			net.WriteBool(SilentButton.Selected)
		net.SendToServer()

		parent:AlphaTo(0,0.1,0, function( _, pnl )
			pnl:Remove()
		end)

	end

	--[[-------------------------------------------------------------------------
	Finishing panel
	---------------------------------------------------------------------------]]

	--Return the created panel.
	return Panel

end