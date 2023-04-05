--Creating some vars.
local FrameWidth, FrameHeight = ScrW() * 0.5, ScrH() * 0.5
local HeaderHeight = FrameHeight * 0.15
local BottomHeight = FrameHeight * 0.05
local Panel
local LoadedData = {}
local Loading = false

--Creating function to create tab.
function jBlacklist.VGui.Create_StatsTab( parent )

	--[[-------------------------------------------------------------------------
	Request data.
	---------------------------------------------------------------------------]]

	net.Start("jBlacklist_RequestStats")
	net.SendToServer()

	Loading = true

	--[[-------------------------------------------------------------------------
	Create the panel
	---------------------------------------------------------------------------]]

	--Create panel.
	Panel = vgui.Create( "DPanel", parent )
	Panel:SetSize(FrameWidth,FrameHeight - HeaderHeight - BottomHeight)
	Panel:SetPos(0,HeaderHeight)

	--Create paintover function.
	Panel.PaintOver = function( _, w, h )

		if Loading == false then return end

		jBlacklist.VGui.DrawLoading( Color(61,61,61), w, h )

	end

	--Creating painit function for Panel.
	Panel.Paint = function( _, w, h )
		surface.SetDrawColor(61,61,61)
		surface.DrawRect(0,0,w,h)
	end

	--Creating OnRemove function for Panel.
	Panel.OnRemove = function( )
		Panel = nil
	end

	--[[-------------------------------------------------------------------------
	Create other panels.
	---------------------------------------------------------------------------]]

	local IssuedBlacklistsPanel = vgui.Create("DPanel",Panel)
	IssuedBlacklistsPanel:SetSize(FrameWidth * 0.35,FrameHeight * 0.25)
	IssuedBlacklistsPanel:SetPos(FrameWidth * 0.1, FrameHeight  * 0.1)

	IssuedBlacklistsPanel.Paint = function( _, w, h )
		surface.SetDrawColor(Color(36,36,36))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(80, 80, 80)
		surface.DrawRect(1,1,w - 2,h - 2)

		draw.SimpleText(jBlacklist.LoadedLanguage["STATISTICS_ISSUED"],"jBlacklist_Stats_Small",w * 0.05,h * 0.1,Color(255,255,255))
		draw.SimpleText(LoadedData.Issued or 0,"jBlacklist_Stats_Big",w * 0.05,h * 0.35,Color(255,255,255))
	end

	local RemovedBlacklists = vgui.Create("DPanel",Panel)
	RemovedBlacklists:SetSize(FrameWidth * 0.35,FrameHeight * 0.25)
	RemovedBlacklists:SetPos(FrameWidth * 0.55, FrameHeight  * 0.1)

	RemovedBlacklists.Paint = function( _, w, h )
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(80, 80, 80)
		surface.DrawRect(1,1,w - 2,h - 2)

		draw.SimpleText(jBlacklist.LoadedLanguage["STATISTICS_REMOVED"],"jBlacklist_Stats_Small",w * 0.05,h * 0.1,Color(255,255,255))
		draw.SimpleText(LoadedData.Removed or 0,"jBlacklist_Stats_Big",w * 0.05,h * 0.35,Color(255,255,255))
	end

	local CommonBlacklistPanel = vgui.Create("DPanel",Panel)
	CommonBlacklistPanel:SetSize(FrameWidth * 0.35,FrameHeight * 0.25)
	CommonBlacklistPanel:SetPos(FrameWidth * 0.1, FrameHeight  * 0.45)
	CommonBlacklistPanel.TextPosX = FrameWidth * 0.35 * 0.05
	CommonBlacklistPanel.Reversing = false
	CommonBlacklistPanel.Stay = 0

	CommonBlacklistPanel.Paint = function( s, w, h )
		surface.SetDrawColor(80, 80, 80)
		surface.DrawRect(0,0,w,h)

		draw.SimpleText(jBlacklist.LoadedLanguage["STATISTICS_COMMON"],"jBlacklist_Stats_Small",w * 0.05,h * 0.1,Color(255,255,255))

		surface.SetFont("jBlacklist_Stats_Big")
		surface.SetTextColor(255,255,255)
		surface.SetTextPos(s.TextPosX,h * 0.35)
		surface.DrawText(LoadedData.Common or jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"])

		surface.SetDrawColor(36,36,36)
		surface.DrawOutlinedRect(0,0,w,h)

		local TextWidth = surface.GetTextSize(LoadedData.Common or jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"])

		if TextWidth > w and s.Stay < CurTime() then

			if s.TextPosX > w - TextWidth - FrameWidth * 0.35 * 0.05 and s.Reversing == false then
				s.TextPosX = s.TextPosX - FrameTime() * 90

				if s.TextPosX < w - TextWidth - FrameWidth * 0.35 * 0.05 then
					s.Reversing = true
					s.Stay = CurTime() + 1
				end

			else
				s.TextPosX = s.TextPosX + FrameTime() * 90

				if s.TextPosX > FrameWidth * 0.35 * 0.05 then
					s.Reversing = false
					s.Stay = CurTime() + 1
				end
			end
		end

	end

	local TopBlacklisterPanel = vgui.Create("DPanel",Panel)
	TopBlacklisterPanel:SetSize(FrameWidth * 0.35,FrameHeight * 0.25)
	TopBlacklisterPanel:SetPos(FrameWidth * 0.55, FrameHeight  * 0.45)
	TopBlacklisterPanel.TextPosX = FrameWidth * 0.35 * 0.05
	TopBlacklisterPanel.Reversing = false
	TopBlacklisterPanel.Stay = 0

	TopBlacklisterPanel.Paint = function( s, w, h )
		surface.SetDrawColor(80, 80, 80)
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(80, 80, 80)
		surface.DrawRect(1,1,w - 2,h - 2)

		draw.SimpleText(jBlacklist.LoadedLanguage["STATISTICS_TOP"],"jBlacklist_Stats_Small",w * 0.05,h * 0.1,Color(255,255,255))

		surface.SetFont("jBlacklist_Stats_Big")
		surface.SetTextColor(255,255,255)
		surface.SetTextPos(s.TextPosX,h * 0.35)
		surface.DrawText(LoadedData.Top or jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"])

		surface.SetDrawColor(36,36,36)
		surface.DrawOutlinedRect(0,0,w,h)

		local TextWidth = surface.GetTextSize(LoadedData.Top or jBlacklist.LoadedLanguage["MANAGE_STATISTICS_NONE"])

		if TextWidth > w and s.Stay < CurTime() then

			if s.TextPosX > w - TextWidth - FrameWidth * 0.35 * 0.05 and s.Reversing == false then
				s.TextPosX = s.TextPosX - FrameTime() * 90

				if s.TextPosX < w - TextWidth - FrameWidth * 0.35 * 0.05 then
					s.Reversing = true
					s.Stay = CurTime() + 0.5
				end

			else
				s.TextPosX = s.TextPosX + FrameTime() * 90

				if s.TextPosX > FrameWidth * 0.35 * 0.05 then
					s.Reversing = false
					s.Stay = CurTime() + 0.5
				end
			end
		end

	end

	--Return the created panel.
	return Panel

end

--Add reciver for jBlacklist_SendData.
net.Receive("jBlacklist_SendData",function(  )

	--Read the data from the server.
	local data = net.ReadTable()

	--Request the playerdata.
	jBlacklist.SteamWorks_GetName({data.Top}, function( result )

		--Get the playername.
		data.Top = result[data.Top]

		--Update the data.
		LoadedData = data

		--Stop drawing loadingoverlay.
		Loading = false

	end)

end)

--Create a hook to update data.
hook.Add("jBlacklist_DataChange","jBlacklist_Update_Stats",function(  )
	if Panel then
		net.Start("jBlacklist_RequestStats")
		net.SendToServer()
	end
end)