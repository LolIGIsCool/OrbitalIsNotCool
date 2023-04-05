bKeypads_Caller = IsValid(bKeypads_Caller) and bKeypads_Caller or ents.Create("base_point")
local function Input(ent, event, ...)
	if event == "PressIn" then
		ent.bKeypads_PressIn = true
	elseif event == "PressOut" or event == "Press" then
		ent.bKeypads_PressIn = nil
	end
	ent:Input(event, nil, bKeypads_Caller, ...)
end

local doorIsOpenFuncs = {
	func_door = function(self)
		return self:GetSaveTable().m_toggle_state == 0
	end,
	func_door_rotating = function(self)
		return self:GetSaveTable().m_toggle_state == 0
	end,
	prop_door_rotating = function(self)
		return self:GetSaveTable().m_eDoorState ~= 0
	end,
	prop_dynamic = function(self)
		local openSeq = self:LookupSequence("open")
		if openSeq and openSeq ~= -1 then
			return self:GetSaveTable().m_iGoalSequence == openSeq
		end
	end,
}
function bKeypads.MapLinking:IsDoorOpen(ent)
	if not doorIsOpenFuncs[ent:GetClass()] then
		return nil
	else
		return doorIsOpenFuncs[ent:GetClass()](ent)
	end
end

hook.Add("playerKeysSold", "bKeypads.MapLinking.DarkRP.DoorSold", function(ply, ent)
	if bKeypads.MapLinking:IsDoor(ent) then
		local links = bKeypads.MapLinking:GetLinks(ent)
		if links then
			for keypad in pairs(links) do
				bKeypads.MapLinking:Unlink(keypad, ent)
			end
		end
	end
end)

function bKeypads.MapLinking:CleanUp(ent)
	if ent.bKeypads_m_flWait then
		ent:SetSaveValue("m_flWait", ent.bKeypads_m_flWait)
		ent.bKeypads_m_flWait = nil

		if bKeypads.MapLinking:IsDoorOpen(ent) then
			bKeypads.MapLinking:CloseDoor(ent)
		end
	end

	if ent.bKeypads_MapLinking_Locked then
		ent.bKeypads_MapLinking_Locked = nil
		Input(ent, "Unlock")
	end

	if ent.bKeypads_NoForceClosed then
		ent.bKeypads_NoForceClosed = nil
		ent:SetKeyValue("forceclosed", 0)
	end

	if ent.bKeypads_PressIn then
		ent.bKeypads_PressIn = nil
		Input(ent, "PressOut")
	end

	if ent.bKeypads_PressIn_Sandbox then
		ent:Toggle(false)
		ent:NextThink(CurTime())
		ent.bKeypads_PressIn_Sandbox = nil
	end
end

function bKeypads.MapLinking:Link(keypad, ent, access_type, pseudolink, disable, redirect_use, btn_hold, btn_toggle, btn_double_toggle, btn_hide, door_nolockpick, door_toggle, door_lock, ply)
	assert(IsValid(keypad), "Tried to use a NULL keypad!")
	assert(IsValid(ent), "Tried to use a NULL link entity!")
	assert(isbool(access_type), "access_type was not a boolean")
	assert(keypad.bKeypad == true, "Not a keypad")
	assert(bKeypads.MapLinking:IsLinkEntity(ent), "Not a linkable entity")
	
	local isDoor = bKeypads.MapLinking:IsDoor(ent)
	local isButton = not isDoor and bKeypads.MapLinking:IsButton(ent)
	if isDoor then
		ent = bKeypads.MapLinking:GetRootDoor(ent)
	end
	
	bKeypads.MapLinking:Unlink(keypad, ent)

	if pseudolink then
		btn_toggle = false
		btn_double_toggle = false
		btn_hold = false
	elseif btn_hold then
		btn_toggle = false
		btn_double_toggle = false
	elseif btn_toggle then
		btn_hold = false
		btn_double_toggle = false
	elseif btn_double_toggle then
		btn_hold = false
		btn_toggle = false
	end

	local link = ents.Create("bkeypads_map_link")
	link:SetKeypad(keypad)
	link:SetLinkedEnt(ent)
	link:SetAccessType(access_type)

	link:SetGeneralFlags(bit.bor(
		(not IsValid(ply) or bKeypads.Permissions:Check(ply, "linking/disable_map_objects")) and (disable and bKeypads.MapLinking.F_DISABLE_ENT) or 0,
		(not IsValid(ply) or bKeypads.Permissions:Check(ply, "linking/redirect_use")) and (redirect_use and bKeypads.MapLinking.F_REDIRECT_USE) or 0,
		(not IsValid(ply) or bKeypads.Permissions:Check(ply, "linking/pseudolink")) and (pseudolink and bKeypads.MapLinking.F_PSEUDOLINK) or 0
	))

	if isButton then
		link:SetButtonFlags(bit.bor(
			btn_toggle and bKeypads.MapLinking.F_BUTTON_TOGGLE or 0,
			btn_double_toggle and bKeypads.MapLinking.F_BUTTON_DOUBLE_TOGGLE or 0,
			btn_hold and bKeypads.MapLinking.F_BUTTON_HOLD or 0,
			(not IsValid(ply) or bKeypads.Permissions:Check(ply, "linking/hide_map_object")) and (btn_hide and bKeypads.MapLinking.F_BUTTON_HIDE) or 0
		))
	end

	if isDoor then
		link:SetDoorFlags(bit.bor(
			(not IsValid(ply) or bKeypads.Permissions:Check(ply, "linking/darkrp_prevent_lockpick")) and (door_nolockpick and bKeypads.MapLinking.F_DOOR_NOLOCKPICK) or 0,
			door_toggle and bKeypads.MapLinking.F_DOOR_TOGGLE or 0,
			door_lock and bKeypads.MapLinking.F_DOOR_LOCK or 0
		))
	end

	bKeypads.MapLinking:RegisterLink(link, keypad, ent, access_type)

	keypad:RefreshCanKeypadCrack()
	
	if isDoor then
		bKeypads.MapLinking:Off(link)
	end
	if disable or (isDoor and door_lock) then
		bKeypads.MapLinking:Disable(link)
	end
	if keypad:GetBroken() then
		bKeypads.MapLinking:On(link)
	end

	if IsValid(ply) then
		undo.Create(isButton and "bKeypads_Button_Link" or isDoor and "bKeypads_Door_Link" or "bKeypads_Map_Link")
			undo.SetPlayer(ply)
			undo.AddEntity(link)
		undo.Finish()

		if isButton then
			hook.Run("bKeypads.Link.Button", ply, keypad, ent, access_type)
		elseif isDoor then
			hook.Run("bKeypads.Link.Door", ply, keypad, ent, access_type)
		else
			hook.Run("bKeypads.Link.Map", ply, keypad, ent, access_type)
		end
	end
end

function bKeypads.MapLinking:Unlink(keypad, ent, ply)
	local link = bKeypads.MapLinking.Links[keypad] and bKeypads.MapLinking.Links[keypad][ent] and (bKeypads.MapLinking.Links[keypad][ent][true] or bKeypads.MapLinking.Links[keypad][ent][false])
	if IsValid(link) then
		if link:GetActive() then
			bKeypads.MapLinking:Off(link)
		end
		bKeypads.MapLinking:Enable(link)
		
		if IsValid(keypad) and IsValid(ent) and IsValid(ply) then
			if bKeypads.MapLinking:IsButton(ent) then
				hook.Run("bKeypads.Unlink.Button", ply, keypad, ent, link:GetAccessType())
			elseif bKeypads.MapLinking:IsDoor(ent) then
				hook.Run("bKeypads.Unlink.Door", ply, keypad, ent, link:GetAccessType())
			else
				hook.Run("bKeypads.Unlink.Map", ply, keypad, ent, link:GetAccessType())
			end
		end
		
		link:Remove()
	end
	if IsValid(ent) then
		bKeypads.MapLinking:CleanUp(ent)
	end
end

function bKeypads.MapLinking:Disable(link)
	local ent = link:GetLinkedEnt()
	if bKeypads.MapLinking:IsDoor(ent) or bKeypads.MapLinking:IsButton(ent) then
		ent.bKeypads_MapLinking_Locked = true
		Input(ent, "Lock")
	end
end

function bKeypads.MapLinking:Enable(link)
	local ent = link:GetLinkedEnt()
	if bKeypads.MapLinking:IsDoor(ent) or bKeypads.MapLinking:IsButton(ent) then
		ent.bKeypads_MapLinking_Locked = false
		Input(ent, "Unlock")
	end
end

bKeypads_OpenAwayFrom = bKeypads_OpenAwayFrom or {
	Pool = {},
	Used = {},
	ID = 0
}
function bKeypads.MapLinking:OpenAwayFrom()
	local controller
	while true do
		controller = next(bKeypads_OpenAwayFrom.Pool)
		if not IsValid(controller) and controller ~= nil then
			bKeypads_OpenAwayFrom.Pool[controller] = nil
			continue
		end
		break
	end

	if controller == nil then
		bKeypads_OpenAwayFrom.ID = bKeypads_OpenAwayFrom.ID + 1

		controller = ents.Create("bkeypads_open_away_from")
		controller:SetName("bkeypads_openawayfrom_" .. bKeypads_OpenAwayFrom.ID)
		controller:Spawn()
	else
		bKeypads_OpenAwayFrom.Pool[controller] = nil
	end

	bKeypads_OpenAwayFrom.Used[controller] = true
	return controller
end
hook.Add("Tick", "bKeypads.MapLinking.OpenAwayFrom.Pool", function()
	for controller in pairs(bKeypads_OpenAwayFrom.Used) do
		bKeypads_OpenAwayFrom.Pool[controller] = true
		bKeypads_OpenAwayFrom.Used[controller] = nil
	end
end)

function bKeypads.MapLinking:OpenDoor(door, link, ply)
	if door.bKeypads_NoForceClosed then
		door.bKeypads_NoForceClosed = nil
		door:SetKeyValue("forceclosed", 0)
	end

	local awayFrom = (IsValid(ply) and ply) or (IsValid(link:GetKeypad()) and link:GetKeypad()) or game.GetWorld()
	if door:GetClass() == "prop_door_rotating" and IsValid(awayFrom) then
		local controller = bKeypads.MapLinking:OpenAwayFrom()
		controller:SetPos(awayFrom:WorldSpaceCenter())
		Input(door, "OpenAwayFrom", controller:GetName())
	else
		if door:GetClass() == "func_door" then
			local m_flWait = door:GetInternalVariable("m_flWait")
			if m_flWait ~= nil then
				door.bKeypads_m_flWait = m_flWait
				door:SetSaveValue("m_flWait", -1)
			end
		end
		local seq = door:LookupSequence("open")
		if seq ~= nil and seq ~= -1 then
			local isOpen = bKeypads.MapLinking:IsDoorOpen(door)
			if isOpen == nil then
				Input(door, "Open")
			elseif not isOpen then
				Input(door, "setanimation", "open", "0")
			end
		else
			Input(door, "Open")
		end
	end
end

function bKeypads.MapLinking:CloseDoor(door)
	if not tobool(door:GetKeyValues().forceclosed) then
		door.bKeypads_NoForceClosed = true
	end
	door:SetKeyValue("forceclosed", 1)

	if door.bKeypads_m_flWait then
		door:SetSaveValue("m_flWait", door.bKeypads_m_flWait)
		door.bKeypads_m_flWait = nil
	end

	local seq = door:LookupSequence("close")
	if seq ~= nil and seq ~= -1 then
		local isOpen = bKeypads.MapLinking:IsDoorOpen(door)
		if isOpen == nil then
			Input(door, "Close")
		elseif isOpen then
			Input(door, "setanimation", "close", "0")
		end
	else
		Input(door, "Close")
	end
end

if IsValid(bKeypads_OpenAwayFrom_Controller) then
	bKeypads_OpenAwayFrom_Controller:Remove()
end
function bKeypads.MapLinking:On(link, ply)
	if link:HasGeneralFlag(bKeypads.MapLinking.F_PSEUDOLINK) then return end

	if not link:GetAccessType() and IsValid(link:GetKeypad()) and link:GetKeypad():GetBroken() then
		return
	end

	local ent = link:GetLinkedEnt()
	if not IsValid(ent) then link:SetActive(true) return end

	local isDoor, isButton = bKeypads.MapLinking:IsDoor(ent), bKeypads.MapLinking:IsButton(ent)
	if isDoor or isButton then
		local shouldDisable = link:HasGeneralFlag(bKeypads.MapLinking.F_DISABLE_ENT) or ent:GetInternalVariable("m_bLocked") == true
		if not shouldDisable and isDoor then
			shouldDisable = link:HasDoorFlag(bKeypads.MapLinking.F_DOOR_LOCK)
		end
		bKeypads.MapLinking:Enable(link)
		if isDoor then
			if not link:GetKeypad():GetBroken() and link:HasDoorFlag(bKeypads.MapLinking.F_DOOR_TOGGLE) then
				local isOpen = bKeypads.MapLinking:IsDoorOpen(ent)
				if isOpen then
					bKeypads.MapLinking:CloseDoor(ent, link)
				else
					bKeypads.MapLinking:OpenDoor(ent, link, ply)
				end
			else
				bKeypads.MapLinking:OpenDoor(ent, link, ply)
			end
		elseif isButton then
			if bKeypads.MapLinking:IsSandboxButton(ent) then
				if ent:GetIsToggle() or link:HasButtonFlag(bKeypads.MapLinking.F_BUTTON_TOGGLE) or link:HasButtonFlag(bKeypads.MapLinking.F_BUTTON_DOUBLE_TOGGLE) then
					ent:Toggle(not ent:GetOn())
				else
					ent:Toggle(true)
					ent:NextThink(math.huge)
					ent.bKeypads_PressIn_Sandbox = true
				end
			else
				if link:HasButtonFlag(bKeypads.MapLinking.F_BUTTON_TOGGLE) or link:HasButtonFlag(bKeypads.MapLinking.F_BUTTON_DOUBLE_TOGGLE) then
					Input(ent, "Press")
				elseif link:HasButtonFlag(bKeypads.MapLinking.F_BUTTON_HOLD) then
					Input(ent, "PressIn")
				else
					Input(ent, "PressIn")
					Input(ent, "PressOut")
				end
			end
		end
		if shouldDisable then bKeypads.MapLinking:Disable(link) end
	end

	link:SetActive(true)
end

function bKeypads.MapLinking:Off(link)
	if link:HasGeneralFlag(bKeypads.MapLinking.F_PSEUDOLINK) then return end

	if link:GetAccessType() and not link:GetActive() and IsValid(link:GetKeypad()) and link:GetKeypad():GetBroken() then
		return bKeypads.MapLinking:On(link)
	end
	link:SetActive(false)

	local ent = link:GetLinkedEnt()
	if not IsValid(ent) then return end

	local isDoor, isButton = bKeypads.MapLinking:IsDoor(ent), bKeypads.MapLinking:IsButton(ent)
	if isDoor or isButton then
		local shouldDisable = link:HasGeneralFlag(bKeypads.MapLinking.F_DISABLE_ENT) or ent:GetInternalVariable("m_bLocked") == true
		if not shouldDisable and isDoor then
			shouldDisable = link:HasDoorFlag(bKeypads.MapLinking.F_DOOR_LOCK)
		end
		bKeypads.MapLinking:Enable(link)
		if isDoor then
			if not link:HasDoorFlag(bKeypads.MapLinking.F_DOOR_TOGGLE) then
				bKeypads.MapLinking:CloseDoor(ent, link)
			end
		elseif isButton then
			if bKeypads.MapLinking:IsSandboxButton(ent) then
				if link:HasButtonFlag(bKeypads.MapLinking.F_BUTTON_DOUBLE_TOGGLE) or (ent:GetIsToggle() and link:HasButtonFlag(bKeypads.MapLinking.F_BUTTON_HOLD)) then
					ent:Toggle(not ent:GetOn())
				elseif not ent:GetIsToggle() then
					ent:Toggle(false)
					ent:NextThink(CurTime())
					ent.bKeypads_PressIn_Sandbox = nil
				end
			else
				if link:HasButtonFlag(bKeypads.MapLinking.F_BUTTON_DOUBLE_TOGGLE) then
					Input(ent, "Press")
				elseif link:HasButtonFlag(bKeypads.MapLinking.F_BUTTON_HOLD) then
					Input(ent, "PressOut")
				end
			end
		end
		if shouldDisable then bKeypads.MapLinking:Disable(link) end
	end
end

local function NetworkLinkServerEnt(ent)
	if bKeypads.MapLinking:IsDoor(ent) then
		ent:SetNWBool("bKeypads.IsDoor", true)

		-- dumb hack for some weird behaviour I found
		if ent.m_tblToolsAllowed and not ent.m_tblToolsAllowed_bKeypads_Patched then
			ent.m_tblToolsAllowed_bKeypads_Patched = true
			table.insert(ent.m_tblToolsAllowed, "bkeypads_linker")
		end
	elseif bKeypads.MapLinking:IsMapButton(ent) then
		ent:SetNWBool("bKeypads.IsButton", true)
	end
end
bKeypads:InitPostEntity(function()
	for _, ent in ipairs(ents.GetAll()) do
		NetworkLinkServerEnt(ent)
	end
end)
hook.Add("OnEntityCreated", "bKeypads.NetworkLinkNewServerEnt", NetworkLinkServerEnt)

for _, ent in ipairs(ents.GetAll()) do
	NetworkLinkServerEnt(ent)
end

hook.Add("AcceptInput", "bKeypads.MapLinking.AcceptInput", function(ent, event, activator, caller, val)
	--print(ent, event, activator, caller, val)
	if caller == bKeypads_Caller then return end
	if not bKeypads.MapLinking:IsLinkEntity(ent) then return end

	local links = bKeypads.MapLinking:GetLinks(ent)
	if not links then return end

	local suppressEvent = false
	for keypad, linkData in pairs(links) do
		if not IsValid(keypad) then continue end

		local link = select(2, next(linkData))
		if not IsValid(link) then continue end

		if link:HasGeneralFlag(bKeypads.MapLinking.F_DISABLE_ENT) or link:GetKeypad():GetBroken() or link:GetActive() then
			suppressEvent = true
			break
		end
	end

	if suppressEvent then
		local event = event:lower()
		if event == "use" or event == "unlock" or event == "lock" then
			return true
		elseif bKeypads.MapLinking:IsDoor(ent) then
			if event == "open" or event == "close" or event == "setanimation" then
				return true
			end
		elseif bKeypads.MapLinking:IsButton(ent) then
			if event == "press" or event == "pressin" or event == "pressout" then
				return true
			end
		end
	end
end)

-- TODO make all these functions use tables for programmatic usage

hook.Run("bKeypads.MapLinking.Ready")