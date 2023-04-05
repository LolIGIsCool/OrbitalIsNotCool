--Creating some vars.
local FrameWidth, FrameHeight = ScrW() * 0.38, ScrH() * 0.28
local HeaderHeight = ScrH() * 0.2 * 0.15
local FieldHeight = (FrameHeight - HeaderHeight - FrameHeight * 0.05) / 9
local ClosebuttonSize, ClosebuttonOffset = HeaderHeight * 0.75, HeaderHeight / 2

--Creating a bigger scope for some panels.
local Frame
local LoadedBlacklist

--Creating function to open a window that allows you to modify a already existing blacklist.
function jBlacklist.VGui.BlacklistDetails( SteamID, BlacklistID )

	--Reset LoadedBlacklist on load.
	LoadedBlacklist = nil

	--Send a request to the server so we get the blacklist data.
	net.Start("jBlacklist_RequestBlacklistDetails")
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
		draw.SimpleText("JBlacklist - " .. jBlacklist.LoadedLanguage["MANAGE_DETAILSTITLE"],"jBlacklist_HUD_Small",w / 2,HeaderHeight / 2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	Frame.PaintOver = function( _, w, h )

		--Check if we have received the details yet.
		if !LoadedBlacklist then

			--Tell the user we are waiting for data.
			jBlacklist.VGui.DrawLoading( Color(61,61,61), w, h )
			--Stop here if no details have arrived yet.
			return

		end

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
	Fields
	---------------------------------------------------------------------------]]

	local FieldsInfo = {
		{Title = jBlacklist.LoadedLanguage["MANAGE_ID"], GetText = function(  ) return BlacklistID end},
		{Title = jBlacklist.LoadedLanguage["MANAGE_USERNAME"], GetText = function(  ) return LoadedBlacklist.USER end},
		{Title = jBlacklist.LoadedLanguage["MANAGE_TYPE"], GetText = function(  ) return LoadedBlacklist.TYPE end},
		{Title = jBlacklist.LoadedLanguage["MANAGE_DESCRIPTION"], GetText = function(  ) return jBlacklist.RegistredBlacklists[LoadedBlacklist.TYPE].GetDescription() end},
		{Title = jBlacklist.LoadedLanguage["MANAGE_REASON"], GetText = function(  ) return LoadedBlacklist.REASON end},
		{Title = jBlacklist.LoadedLanguage["MANAGE_GIVENON"], GetText = function(  ) return os.date( "%d/%m/%Y - %H:%M:%S" , LoadedBlacklist.DATE ) end},
		{Title = jBlacklist.LoadedLanguage["MANAGE_TIMELEFT"], GetText = function(  ) return LoadedBlacklist.FormatedTime  end},
		{Title = jBlacklist.LoadedLanguage["MANAGE_UPDATED"], GetText = function(  ) return os.date( "%d/%m/%Y - %H:%M:%S", LoadedBlacklist.LASTUPDATE) end},
		{Title = jBlacklist.LoadedLanguage["MANAGE_GIVENBY"], GetText = function(  ) return LoadedBlacklist.ADMIN_NAME .. " (" .. LoadedBlacklist.ADMIN .. ")" end},
	}

	local Index = 0

	for k,v in pairs(FieldsInfo) do

		FieldsInfo[k].DPanel_Main = vgui.Create("DPanel",Frame)
		FieldsInfo[k].DPanel_Main:SetSize(Frame:GetWide() * 0.2,FieldHeight)
		FieldsInfo[k].DPanel_Main:SetPos(0,HeaderHeight + FrameHeight * 0.05 / 2 + FieldHeight * Index)

		FieldsInfo[k].DPanel_Main.Paint = function( _, w, h )

			draw.SimpleText(v.Title .. ":","jBlacklist_HUD_Small_Bold",w  / 2,h / 2,Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

		FieldsInfo[k].DPanel_Info = vgui.Create("DPanel",Frame)
		FieldsInfo[k].DPanel_Info:SetSize(Frame:GetWide() * 0.8,FieldHeight)
		FieldsInfo[k].DPanel_Info:SetPos(Frame:GetWide() * 0.2,HeaderHeight + FrameHeight * 0.05 / 2 + FieldHeight * Index)
		FieldsInfo[k].DPanel_Info.TextPosX = 0
		FieldsInfo[k].DPanel_Info.Reversing = false
		FieldsInfo[k].DPanel_Info.Stay = 0

		FieldsInfo[k].DPanel_Info.Paint = function( s, w, h )

			if !LoadedBlacklist then return end

			local Text = FieldsInfo[k].GetText()

			surface.SetFont("jBlacklist_HUD_Small_Bold")

			local TextWidth, TextHeight = surface.GetTextSize(Text)

			surface.SetTextColor(255,255,255)
			surface.SetTextPos(s.TextPosX,h / 2 - TextHeight / 2)
			surface.DrawText(Text)

			if TextWidth > w and s.Stay < CurTime() then

				if s.TextPosX > w - TextWidth - FieldsInfo[k].DPanel_Info:GetWide() * 0.025 and s.Reversing == false then
					s.TextPosX = s.TextPosX - FrameTime() * 90

					if s.TextPosX < w - TextWidth - FieldsInfo[k].DPanel_Info:GetWide() * 0.025 then
						s.Reversing = true
						s.Stay = CurTime() + 0.5
					end

				else
					s.TextPosX = s.TextPosX + FrameTime() * 90

					if s.TextPosX > 0 then
						s.Reversing = false
						s.Stay = CurTime() + 0.5
					end
				end
			end

		end

		Index = Index + 1

	end

	timer.Simple(10,function(  )
		if !LoadedBlacklist then
			Frame:Remove()
		end
	end)

end

--Create a receiver for jBlacklist_SendBlacklistDetails.
net.Receive("jBlacklist_SendBlacklistDetails",function(  )

	--Check so the Frame is open.
	if !Frame then return end

	--Read the blacklist sent.
	local data = net.ReadTable()

	jBlacklist.SteamWorks_GetName({data.STEAMID, data.ADMIN}, function( result )

		data.USER = result[data.STEAMID]
		data.ADMIN_NAME = result[data.ADMIN]

		--Format the time.
		if data.TIME > os.time() or data.TIME == -1 then
			data.FormatedTime = jBlacklist.FormatBlacklistTime(math.max(data.TIME - os.time(), -1)) .. (data.TIME != -1 and " | " .. os.date( "%d/%m/%Y - %H:%M:%S", data.TIME) or "")
		else
			data.FormatedTime = jBlacklist.LoadedLanguage["EXPIRED"]
		end

		LoadedBlacklist = data

	end)

end)

hook.Add("jBlacklist_StopLoading","jBlacklist_BlacklistDetails_StoppedLoading",	function(  )
	if !LoadedBlacklist and Frame then
		Frame:Remove()
	end
end)