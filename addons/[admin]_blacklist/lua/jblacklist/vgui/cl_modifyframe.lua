--Creating some vars.
local FrameWidth, FrameHeight = ScrW() * 0.3, ScrH() * 0.2
local HeaderHeight = FrameHeight * 0.15
local PanelSpace = FrameHeight - HeaderHeight
local ControlsOffset = PanelSpace / 4
local ControlsGap = PanelSpace * 0.1
local ControlsWidth = FrameWidth * 0.7
local ClosebuttonSize, ClosebuttonOffset = HeaderHeight * 0.75, HeaderHeight / 2

--Creating a bigger scope for some panels.
local Frame
local ReasonInput
local TimeSelector

--Creating function to open a window that allows you to modify a already existing blacklist.
function jBlacklist.VGui.ModifyBlacklist( SteamID, BlacklistID, BlacklistView )

	--Send a request to the server so we get the blacklist data.
	net.Start("jBlacklist_RequestBlacklistData")
		net.WriteString(SteamID)
		net.WriteUInt(tonumber(BlacklistID),25)
	net.SendToServer()

	--Close current window if one is already open.
	if Frame then Frame:Remove() end

	--Creating new DFrame.
	Frame = vgui.Create("DFrame")
	Frame:SetSize(FrameWidth,FrameHeight)
	Frame:Center()
	Frame:MakePopup()
	Frame:SetTitle("")
	Frame:ShowCloseButton(false)
	Frame:SetDraggable(true)

	--Creating paint function for the Frame.
	Frame.Paint = function( s, w, h )

		if s.Dragging then
			s:SetAlpha(200)
		else
			s:SetAlpha(255)
		end

		--Creating gray background.
		surface.SetDrawColor(61,61,61)
		surface.DrawRect(0,0,w,h)

		--Draw a header.
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,0,w, HeaderHeight)

		--Draw outline.
		surface.SetDrawColor(36,36,36)
		surface.DrawOutlinedRect(0,0,w,h)

		--Draw header text.
		draw.SimpleText("JBlacklist - " .. jBlacklist.LoadedLanguage["MANAGE_MODIFYTITLE"],"jBlacklist_HUD_Small",w / 2,HeaderHeight / 2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		--Drawing button labels.
		draw.SimpleText(jBlacklist.LoadedLanguage["MANAGE_REASON"],"jBlacklist_HUD_Small_Bold",FrameWidth / 2,ControlsOffset + ControlsGap,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

		--Drawing button labels.
		draw.SimpleText(jBlacklist.LoadedLanguage["ISSUE_LENGTH"],"jBlacklist_HUD_Small_Bold",FrameWidth / 2,ControlsOffset * 2 + ControlsGap,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

	end

	--Create OnRemove function for Frame.
	Frame.OnRemove = function( )
		Frame = nil
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
		Frame:Remove()
	end

	--[[-------------------------------------------------------------------------
	Creating the reason input.
	---------------------------------------------------------------------------]]

	ReasonInput = vgui.Create("DTextEntry",Frame)
	ReasonInput:SetSize(ControlsWidth,PanelSpace * 0.12)
	ReasonInput:SetPos(FrameWidth / 2 - ControlsWidth / 2, ControlsOffset + ControlsGap)
	ReasonInput:SetFont("jBlacklist_HUD_Mini")

	--Creating paint function for the ReasonInput.
	ReasonInput.Paint = function( s, w, h )
		surface.SetDrawColor(36,36,36)
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

	TimeSelector = jBlacklist.VGui.CreateTimeselector( Frame, ControlsWidth, PanelSpace * 0.12, FrameWidth / 2 - ControlsWidth / 2, ControlsOffset * 2 + ControlsGap )

	--[[-------------------------------------------------------------------------
	Issue Button
	---------------------------------------------------------------------------]]

	local IssueButton = vgui.Create("DButton",Frame)
	IssueButton:SetSize(FrameWidth * 0.3,PanelSpace * 0.2)
	IssueButton:SetPos(FrameWidth / 2 - IssueButton:GetWide() / 2, ControlsOffset * 3 + ControlsGap)
	IssueButton:SetText(jBlacklist.LoadedLanguage["MANAGE_UPDATEBUTTON"])
	IssueButton:SetFont("jBlacklist_HUD_Small_Bold")
	IssueButton:SetTextColor(Color(255,255,255))

	--Creating paint function for the button.
	IssueButton.Paint = function( s, w, h )

		surface.SetDrawColor(s:IsDown() and Color(73, 147, 163) or s:IsHovered() and Color(65, 139, 155) or Color(51, 110, 123))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(36,36,36,255)
		surface.DrawOutlinedRect(0,0,w,h)

	end

	--Create DoClick function for IssueButton.
	IssueButton.DoClick = function(  )

		local _, TimeType = TimeSelector.TimeType:GetSelected()
		local BlacklistLength = TimeType == -1 and -1 or TimeType * math.abs(TimeSelector.NumberEntry:GetValue())

		local maxTime = jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "ISSUEMAXLENGTH" )

		if maxTime == false then return end

		local FormattedTime = jBlacklist.FormatBlacklistTime( math.Clamp( BlacklistLength,-1, maxTime == 0 and 2147483647 or maxTime * 60) )

		for k,v in pairs(BlacklistView:GetLines()) do

			if !v:IsValid()	then continue end

			if v:GetValue(1) == BlacklistID then
				v:SetColumnText(5,ReasonInput:GetValue())
				v:SetColumnText(7,FormattedTime)
				break
			end
		end

		net.Start("jBlacklist_UpdateBlacklistData")
			net.WriteUInt(BlacklistID,25)
			net.WriteString(SteamID)
			net.WriteString(ReasonInput:GetValue())
			net.WriteInt(BlacklistLength,32)
		net.SendToServer()

		Frame:Remove()
	end

end

--Create a receiver for jBlacklist_SendBlacklistData.
net.Receive("jBlacklist_SendBlacklistData",function(  )

	--Check so the Frame is open.
	if !Frame then return end

	--Update the ReasonInput.
	ReasonInput:SetText(net.ReadString())

	--Read the Blacklist length.
	local Time = net.ReadInt(32)

	local TimeInfo = {
		{31556926, 7},
		{2629743 , 6},
		{604800, 5},
		{86400, 4},
		{3600, 3},
		{60, 2},
		{1, 1}
	}

	if Time == -1 then
		TimeSelector.TimeType:ChooseOptionID(8)
		return
	end

	for i = 1,#TimeInfo do

		if Time >= TimeInfo[i][1] and Time / TimeInfo[i][1] == math.floor(Time / TimeInfo[i][1]) then
			TimeSelector.TimeType:ChooseOptionID(TimeInfo[i][2])
			TimeSelector.NumberEntry:SetText(math.floor(Time / TimeInfo[i][1]))
			return
		end

	end

end)