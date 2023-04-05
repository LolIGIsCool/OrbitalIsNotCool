--[[

	bbbbbbbb                                                                                                          
	b::::::b                   îíìì       lllllll      lllllll                                             ))))))     
	b::::::b                  i::::í      l:::::l      l:::::l                                            )::::::))   
	b::::::b                   ííìî       l:::::l      l:::::l                                             ):::::::)) 
	 b:::::b                              l:::::l      l:::::l                                              )):::::::)
	 b:::::bbbbbbbbb         ììíiìîî       l::::l       l::::l      yyyyyyy           yyyyyyy                 )::::::)
	 b::::::::::::::bb       î:::::ì       l::::l       l::::l       y:::::y         y:::::y       ::::::      ):::::)
	 b::::::::::::::::b       î::::í       l::::l       l::::l        y:::::y       y:::::y        ::::::      ):::::)
	 b:::::bbbbb:::::::b      î::::i       l::::l       l::::l         y:::::y     y:::::y         ::::::      ):::::)
	 b:::::b    b::::::b      î::::í       l::::l       l::::l          y:::::y   y:::::y                      ):::::)
	 b:::::b     b:::::b      î::::í       l::::l       l::::l           y:::::y y:::::y                       ):::::)
	 b:::::b     b:::::b      ì::::í       l::::l       l::::l            y:::::y:::::y                        ):::::)
	 b:::::b     b:::::b      î::::ì       l::::l       l::::l             y:::::::::y             ::::::     )::::::)
	 b:::::bbbbbb::::::b     i::::::ì     l::::::l     l::::::l             y:::::::y              ::::::   )):::::::)
	 b::::::::::::::::b      ì::::::î     l::::::l     l::::::l              y:::::y               ::::::  ):::::::)) 
	 b:::::::::::::::b       î::::::í     l::::::l     l::::::l             y:::::y                       )::::::)    
	 bbbbbbbbbbbbbbbb        îîíiîíìì     llllllll     llllllll            y:::::y                         ))))))     
	                                                                      y:::::y                                     
	                                                                     y:::::y                                      
	                                                                    y:::::y                                       
	                                                                   y:::::y                                        
	                                                                  yyyyyyy                                         
	
	© 2023 William Venner
	https://gmodadminsuite.com/license/private

]]

bKeypads.Persistence = {}  

function bKeypads.Persistence:GetKeypad(keypadName)
	for _, keypad in ipairs(bKeypads_Persistence_SaveKeypads) do
		if keypad:GetKeypadName() == keypadName then
			return keypad
		end
	end
end 

bKeypads.Persistence.Profile = "default"

bKeypads.Persistence.BLOCK_SAVING = false

bKeypads.Persistence.TYPE = {}
bKeypads.Persistence.TYPE.PERSIST_ID        = 0

bKeypads.Persistence.TYPE.KEYPAD            = 1
bKeypads.Persistence.TYPE.FADING_DOOR       = 2

bKeypads.Persistence.TYPE.FADING_DOOR_LINKS = 3 
bKeypads.Persistence.TYPE.KEYPAD_LINKS      = 4
bKeypads.Persistence.TYPE.MAP_LINKS         = 5

-- List of keypads that need saving
bKeypads_Persistence_SaveKeypads = bKeypads_Persistence_SaveKeypads or {}

-- Table of entities that are persistent with the keypad and need deletion on revert
bKeypads_Persistence_SaveEntities = bKeypads_Persistence_SaveEntities or {}

function bKeypads.Persistence:ID(ent, set_id)
	if ent ~= nil then
		if set_id ~= nil then 
			ent.bKeypads_PersistentID = set_id
			ent:SetPersist(true)
		else
			return ent.bKeypads_PersistentID
		end
	else
		local id = bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.PERSIST_ID] + 1  
		bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.PERSIST_ID] = id
		return id
	end
end

function bKeypads.Persistence:IsPersisting(keypad)
	assert(keypad.bKeypad, "Not a keypad")
	return bKeypads.Persistence:ID(keypad) ~= nil
end 

function bKeypads.Persistence:Reset()
	bKeypads.Persistence.SavedData = {
		[bKeypads.Persistence.TYPE.PERSIST_ID] = bKeypads.Persistence.SavedData and bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.PERSIST_ID] or 0,

		[bKeypads.Persistence.TYPE.KEYPAD] = {},
		[bKeypads.Persistence.TYPE.FADING_DOOR] = {},

		[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS] = {}, 
		[bKeypads.Persistence.TYPE.KEYPAD_LINKS] = {},
		[bKeypads.Persistence.TYPE.MAP_LINKS] = {},
	}
end

function bKeypads.Persistence:ForceDataIntegrity()
	-- Forget about fading doors with no links
	local saveFadingDoors = {}
	for keypadID, fadingDoorLinks in pairs(bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS]) do 
		for fadingDoorID in pairs(fadingDoorLinks) do
			saveFadingDoors[fadingDoorID] = true
		end
	end
	for fadingDoorID in pairs(bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR]) do
		if not saveFadingDoors[fadingDoorID] then
			bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR][fadingDoorID] = nil 
		end
	end
end

function bKeypads.Persistence:Revert()
	bKeypads.Persistence.BLOCK_SAVING = true

	for _, keypad in ipairs(bKeypads_Persistence_SaveKeypads) do 
		if bKeypads_Persistence_SaveEntities[keypad] then
			for ent in pairs(bKeypads_Persistence_SaveEntities[keypad]) do
				if bKeypads_Persistence_SaveEntities[ent] then
					bKeypads_Persistence_SaveEntities[ent][keypad] = nil
					if table.IsEmpty(bKeypads_Persistence_SaveEntities[ent]) then
						bKeypads_Persistence_SaveEntities[ent] = nil
					else 
						continue
					end
				end
				if IsValid(ent) then
					ent:Remove()
				end
			end 
			bKeypads_Persistence_SaveEntities[keypad] = nil
		end

		if IsValid(keypad) then
			keypad:Remove()
		end
	end

	bKeypads_Persistence_SaveKeypads = {} 

	bKeypads.Persistence.BLOCK_SAVING = false
end
bKeypads.Persistence:Revert()

function bKeypads.Persistence:SaveKeypad(keypad)
	if bKeypads.Persistence.BLOCK_SAVING then return end
	
	assert(IsValid(keypad), "Tried to use a NULL keypad!")

	keypad:SetCreator(NULL) 
	keypad:SetOwner(NULL)
	
	if not bKeypads.Persistence:ID(keypad) then
		bKeypads.Persistence:ID(keypad, bKeypads.Persistence:ID())
		table.insert(bKeypads_Persistence_SaveKeypads, keypad)
	end

	bKeypads.Persistence:CommitKeypad(keypad)
	bKeypads.Persistence:WriteToFile() 
end

function bKeypads.Persistence:ForgetKeypad(keypad)
	assert(IsValid(keypad), "Tried to use a NULL keypad!")
	assert(bKeypads.Persistence:ID(keypad), "Can't forget a non-persistent keypad!")

	local keypadID = bKeypads.Persistence:ID(keypad)
	keypad.bKeypads_PersistentID = nil
	keypad:SetPersist(false)

	-- Remove from save registry
	table.RemoveByValue(bKeypads_Persistence_SaveKeypads, keypad)

	-- Forget about the keypad itself
	bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.KEYPAD][keypadID] = nil 
	
	-- Forget about fading door links‌​‍᠎᠎​‌​‌‌‌‌‌‌‌‌‌​‌‌‌‌‌​‌‍​​‌‌‌‍‌​
	if bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS][keypadID] then
		for fadingDoorID in pairs(bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS][keypadID]) do
			local zombieFadingDoor = true
			for otherKeypadID, linkedFadingDoors in pairs(bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS]) do
				if otherKeypadID == keypadID then continue end
				if linkedFadingDoors[fadingDoorID] then
					zombieFadingDoor = false 
					break
				end
			end
			if zombieFadingDoor then
				bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR][fadingDoorID] = nil
			end 
		end
		bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS][keypadID] = nil
	end

	-- Forget about keypad links
	bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.KEYPAD_LINKS][keypadID] = nil

	-- Forget about map links
	bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.MAP_LINKS][keypadID] = nil

	-- Clean up
	bKeypads.Persistence:ForceDataIntegrity()

	bKeypads.Persistence:WriteToFile() 
end

local function recursive_empty_table_strip(tbl)
	for i, v in pairs(tbl) do
		if istable(v) then
			recursive_empty_table_strip(v)
			if table.IsEmpty(v) then
				tbl[i] = nil 
			end
		end
	end
end
function bKeypads.Persistence:CommitKeypad(keypad)
	if IsValid(keypad) and bKeypads.Persistence:ID(keypad) and keypad:GetCreationData() then 
		local keypadID = bKeypads.Persistence:ID(keypad)

		-- Saved keypad data structure
		local keypadData = {
			Ent = keypad,
			Pos = keypad:GetPos(),
			Angles = keypad:GetAngles(),
			CreationData = table.Copy(keypad:GetCreationData()),
			AccessMatrix = table.Copy(keypad.AccessMatrix or {}), 
		}

		-- Strip useless data
		keypadData.CreationData.Creator = nil

		keypadData.CreationData.KeypadName = keypadData.CreationData.KeypadName ~= "" and keypadData.CreationData.KeypadName or nil
		
		keypadData.CreationData.GrantedKey = keypadData.CreationData.GrantedKey > 0 and keypadData.CreationData.GrantedKey or nil
		keypadData.CreationData.GrantedDelay = keypadData.CreationData.GrantedDelay > 0 and keypadData.CreationData.GrantedDelay or nil
		keypadData.CreationData.GrantedRepeats = keypadData.CreationData.GrantedRepeats > 0 and keypadData.CreationData.GrantedRepeats or nil
		keypadData.CreationData.GrantedRepeatDelay = keypadData.CreationData.GrantedRepeats and keypadData.CreationData.GrantedRepeatDelay > 0 and keypadData.CreationData.GrantedRepeatDelay or nil--　   　                   　           　  　  　 　      　    　

		keypadData.CreationData.DeniedKey = keypadData.CreationData.DeniedKey > 0 and keypadData.CreationData.DeniedKey or nil
		keypadData.CreationData.DeniedDelay = keypadData.CreationData.DeniedDelay > 0 and keypadData.CreationData.DeniedDelay or nil 
		keypadData.CreationData.DeniedRepeats = keypadData.CreationData.DeniedRepeats > 0 and keypadData.CreationData.DeniedRepeats or nil
		keypadData.CreationData.DeniedRepeatDelay = keypadData.CreationData.DeniedRepeats and keypadData.CreationData.DeniedRepeatDelay > 0 and keypadData.CreationData.DeniedRepeatDelay or nil

		keypadData.CreationData.PIN = keypadData.CreationData.PIN ~= "" and keypadData.CreationData.PIN or nil

		keypadData.CreationData.Uncrackable = keypadData.CreationData.Uncrackable or nil
		keypadData.CreationData.Freeze = keypadData.CreationData.Freeze or nil
		keypadData.CreationData.GrantedNotifications = keypadData.CreationData.GrantedNotifications or nil
		keypadData.CreationData.DeniedNotifications = keypadData.CreationData.DeniedNotifications or nil
		keypadData.CreationData.ChargeUnauthorized = keypadData.CreationData.ChargeUnauthorized or nil 

		-- Can't save Wiremod
		keypadData.CreationData.Wiremod = nil

		-- We have WeldToEntID saved, we can't write the entity to a file
		keypadData.CreationData.WeldEnt = nil
		keypadData.CreationData.WeldToEnt = nil

		-- Strip useless data from access matrix‍᠎‌​​᠎‍᠎‍‍‍‍‍‍‍‍‍᠎‍‍‍‍‍᠎‍‌᠎᠎‍‍‍‌‍᠎
		if keypadData.AccessMatrix[bKeypads.ACCESS_GROUP.PAYMENT] == false then
			keypadData.AccessMatrix[bKeypads.ACCESS_GROUP.PAYMENT] = nil
			keypadData.CreationData.ChargeUnauthorized = nil  
		end
		for _, access_type in ipairs({ bKeypads.ACCESS_TYPE.WHITELIST, bKeypads.ACCESS_TYPE.BLACKLIST }) do
			if keypadData.AccessMatrix[access_type][bKeypads.ACCESS_GROUP.SUPERIOR_KEYCARDS] == false then
				keypadData.AccessMatrix[access_type][bKeypads.ACCESS_GROUP.SUPERIOR_KEYCARDS] = nil
			end
			if keypadData.AccessMatrix[access_type][bKeypads.ACCESS_GROUP.STEAM_FRIENDS] == false then
				keypadData.AccessMatrix[access_type][bKeypads.ACCESS_GROUP.STEAM_FRIENDS] = nil 
			end
		end
		recursive_empty_table_strip(keypadData.AccessMatrix)

		-- Save the keypad
		bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.KEYPAD][keypadID] = keypadData

		-- Save keypad links (as long as those linked keypads are persistent too)
		local linkedKeypads = IsValid(keypad:GetParentKeypad()) and keypad:GetParentKeypad():GetChildKeypads() or nil
		if linkedKeypads then
			for linkedKeypad in pairs(linkedKeypads) do 
				if linkedKeypad == keypad then continue end
				local linkedKeypadID = bKeypads.Persistence:ID(linkedKeypad)
				if linkedKeypadID then
					bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.KEYPAD_LINKS][keypadID] = bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.KEYPAD_LINKS][keypadID] or {}
					bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.KEYPAD_LINKS][keypadID][linkedKeypadID] = true
				end 
			end
		end

		-- Save fading doors and fading door links
		local fadingDoorLinks = bKeypads.FadingDoors:GetLinks(keypad)
		if fadingDoorLinks then
			for fadingDoor, linkData in pairs(fadingDoorLinks) do
				local link = select(2, next(linkData))
				if not IsValid(link) then continue end 

				-- Mark this fading door as persistent - it needs to be removed on revertion
				bKeypads_Persistence_SaveEntities[fadingDoor] = bKeypads_Persistence_SaveEntities[fadingDoor] or {}
				bKeypads_Persistence_SaveEntities[keypad] = bKeypads_Persistence_SaveEntities[keypad] or {}
				bKeypads_Persistence_SaveEntities[fadingDoor][keypad] = true
				bKeypads_Persistence_SaveEntities[keypad][fadingDoor] = true

				fadingDoor:SetCreator(NULL)
				fadingDoor:SetOwner(NULL)

				local fadingDoorID = fadingDoor:GetCreationID() 

				if not bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR][fadingDoorID] then
					local faded = bKeypads.FadingDoors:IsFaded(fadingDoor)
					if faded then fadingDoor:fadeCancel() end

					bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR][fadingDoorID] = duplicator.CopyEntTable(fadingDoor)
					bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR][fadingDoorID].Ent = fadingDoor

					if faded then
						if fadingDoor.fadeReversed then 
							fadingDoor:fadeDeactivate()
						else
							fadingDoor:fadeActivate()
						end
					end
				end 

				bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS][keypadID] = bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS][keypadID] or {}
				bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS][keypadID][fadingDoorID] = link:GetAccessType()
			end
		end

		-- Save map links
		local mapLinks = bKeypads.MapLinking:GetLinks(keypad)
		if mapLinks then
			for ent, linkData in pairs(mapLinks) do 
				local map_id = ent:MapCreationID()
				if map_id == -1 then continue end

				local accessType, link = next(linkData)
				if not IsValid(link) then continue end

				bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.MAP_LINKS][keypadID] = bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.MAP_LINKS][keypadID] or {}
				bKeypads.Persistence.SavedData[bKeypads.Persistence.TYPE.MAP_LINKS][keypadID][map_id] = {
					AccessType = accessType, 
					GeneralFlags = link:GetGeneralFlags() ~= 0 and link:GetGeneralFlags(),
					ButtonFlags = link:GetButtonFlags() ~= 0 and link:GetButtonFlags(),
					DoorFlags = link:GetDoorFlags() ~= 0 and link:GetDoorFlags()
				}
			end
		end 

		return keypadID
	end
end

function bKeypads.Persistence:Commit()
	for _, keypad in ipairs(bKeypads_Persistence_SaveKeypads) do
		bKeypads.Persistence:CommitKeypad(keypad)
	end 
end

function bKeypads.Persistence:WriteToFile()
	if bKeypads.Persistence.Corrupted then
		MsgC("\n")
		bKeypads:print("Refusing to overwrite corrupted persistence file!", bKeypads.PRINT_TYPE_BAD, "PERSISTENCE")
		bKeypads:print("Please open a support ticket and include the persistence file and the error(s) below with the ticket.\n", bKeypads.PRINT_TYPE_BAD, "PERSISTENCE")
		bKeypads:print("If you want to use persistence again, you'll have to delete the persistence file.", bKeypads.PRINT_TYPE_BAD, "PERSISTENCE")
		bKeypads:print("The persistence file can be found in:", bKeypads.PRINT_TYPE_BAD, "PERSISTENCE")
		bKeypads:print("garrysmod/data/bkeypads/persistence/" .. game.GetMap() .. "/profiles/" .. bKeypads.Persistence.Profile .. ".json", bKeypads.PRINT_TYPE_SPECIAL, "PERSISTENCE")
		return
	end
	
	file.CreateDir("bkeypads/persistence/" .. game.GetMap() .. "/profiles")
	file.Write("bkeypads/persistence/" .. game.GetMap() .. "/profiles/" .. bKeypads.Persistence.Profile .. ".json", util.Compress(util.TableToJSON(bKeypads.Persistence.SavedData)))
end
hook.Add("ShutDown", "bKeypads.Persistence.ShutDown", function()
	if bKeypads.Config.Persistence.SaveOnShutDown then  
		bKeypads.Persistence:Reset()
		bKeypads.Persistence:Commit()
		bKeypads.Persistence:WriteToFile()
	end
end)

function bKeypads.Persistence:ReadFile()
	if not file.Exists("bkeypads/persistence/" .. game.GetMap() .. "/profiles/" .. bKeypads.Persistence.Profile .. ".json", "DATA") then return end

	local data = file.Read("bkeypads/persistence/" .. game.GetMap() .. "/profiles/" .. bKeypads.Persistence.Profile .. ".json", "DATA")

	if not data then 
		error("Persistence file read error\n")
		return
	end

	data = util.Decompress(data)

	if not data or #data == 0 then
		error("Persistence file decompression error\n")
		return
	end 

	data = util.JSONToTable(data)
	
	if not data then
		error("Persistence file JSON error\n")
		return
	end

	return data
end

function bKeypads.Persistence:Load()  
	bKeypads.Persistence:Revert()
	bKeypads.Persistence:Reset()
	if bKeypads.Persistence.Profile ~= "none" then
		local data = bKeypads.Persistence:ReadFile()
		if data then
			bKeypads.Persistence.SavedData = data

			bKeypads.Persistence.BLOCK_SAVING = true

			-- Spawn keypads
			local keypads = {} 
			for keypadID, keypadData in pairs(data[bKeypads.Persistence.TYPE.KEYPAD]) do
				local AccessMatrix = table.Merge(bKeypads.KeypadData:AccessMatrix(), keypadData.AccessMatrix)
				local CreationData = table.Merge(bKeypads.KeypadData:CreationData(), keypadData.CreationData)

				local keypad = bKeypads:CreateKeypad(keypadData.Pos, keypadData.Angles, keypadData.CreationData)
				keypad:SetCreationData(CreationData)
				keypad:SetAccessMatrix(AccessMatrix) 
				bKeypads.Persistence:ID(keypad, keypadID)

				table.insert(bKeypads_Persistence_SaveKeypads, keypad)

				keypads[keypadID] = keypad
			end

			-- Spawn fading doors
			local fadingDoors = {}
			for fadingDoorID, fadingDoorData in pairs(data[bKeypads.Persistence.TYPE.FADING_DOOR]) do
				local pastedEnts = duplicator.Paste(NULL, { fadingDoorData }, {})  
				
				if IsValid(pastedEnts[1]) then
					fadingDoors[fadingDoorID] = pastedEnts[1]
				end
			end

			-- Link keypads to fading doors
			for keypadID, links in pairs(data[bKeypads.Persistence.TYPE.FADING_DOOR_LINKS]) do
				local keypad = keypads[keypadID]
				if not IsValid(keypad) then continue end 

				for fadingDoorID, access_granted in pairs(links) do
					local fadingDoor = fadingDoors[fadingDoorID]
					if not IsValid(fadingDoor) then continue end

					bKeypads.FadingDoors:Link(keypad, fadingDoor, access_granted)

					bKeypads_Persistence_SaveEntities[keypad] = bKeypads_Persistence_SaveEntities[keypad] or {}
					bKeypads_Persistence_SaveEntities[keypad][fadingDoor] = true
					bKeypads_Persistence_SaveEntities[fadingDoor] = bKeypads_Persistence_SaveEntities[fadingDoor] or {}  
					bKeypads_Persistence_SaveEntities[fadingDoor][keypad] = true
				end
			end

			-- Link keypads to map entities
			for keypadID, links in pairs(data[bKeypads.Persistence.TYPE.MAP_LINKS]) do
				local keypad = keypads[keypadID]
				if not IsValid(keypad) then continue end 

				for mapID, link in pairs(links) do
					local ent = ents.GetMapCreatedEntity(mapID)
					if not IsValid(ent) then continue end

					local pseudolink = link.GeneralFlags and bit.band(link.GeneralFlags, bKeypads.MapLinking.F_PSEUDOLINK) ~= 0
					local disable = link.GeneralFlags and bit.band(link.GeneralFlags, bKeypads.MapLinking.F_DISABLE_ENT) ~= 0
					local redirect_use = link.GeneralFlags and bit.band(link.GeneralFlags, bKeypads.MapLinking.F_REDIRECT_USE) ~= 0
					local btn_hold = link.ButtonFlags and bit.band(link.ButtonFlags, bKeypads.MapLinking.F_BUTTON_HOLD) ~= 0 
					local btn_toggle = link.ButtonFlags and bit.band(link.ButtonFlags, bKeypads.MapLinking.F_BUTTON_TOGGLE) ~= 0
					local btn_double_toggle = link.ButtonFlags and bit.band(link.ButtonFlags, bKeypads.MapLinking.F_BUTTON_DOUBLE_TOGGLE) ~= 0
					local btn_hide = link.ButtonFlags and bit.band(link.ButtonFlags, bKeypads.MapLinking.F_BUTTON_HIDE) ~= 0
					local door_nolockpick = link.DoorFlags and bit.band(link.DoorFlags, bKeypads.MapLinking.F_DOOR_NOLOCKPICK) ~= 0
					local door_toggle = link.DoorFlags and bit.band(link.DoorFlags, bKeypads.MapLinking.F_DOOR_TOGGLE) ~= 0

					bKeypads.MapLinking:Link(keypad, ent, link.AccessType, pseudolink, disable, redirect_use, btn_hold, btn_toggle, btn_double_toggle, btn_hide, door_nolockpick, door_toggle)
				end 
			end

			-- Link keypads to each other
			for sourceKeypadID, links in pairs(data[bKeypads.Persistence.TYPE.KEYPAD_LINKS]) do
				local sourceKeypad = keypads[sourceKeypadID]
				if not IsValid(sourceKeypad) then continue end

				for linkedKeypadID in pairs(links) do
					local linkedKeypad = keypads[linkedKeypadID]
					if not IsValid(linkedKeypad) or linkedKeypadID == sourceKeypadID then continue end 

					bKeypads.KeypadLinking:Link(sourceKeypad, linkedKeypad, false)
				end
			end

			bKeypads.Persistence.BLOCK_SAVING = false
		end
	end 

	hook.Run("bKeypads.Persistence.LoadedProfile", bKeypads.Persistence.Profile)
end

function bKeypads.Persistence:SafeLoad()
	xpcall(bKeypads.Persistence.Load, function(err)
		bKeypads.Persistence.Corrupted = true
		bKeypads.Persistence:WriteToFile()
		ErrorNoHalt("\n" .. err .. "\n")
		debug.Trace()
	end, bKeypads) 
end

hook.Add("PostCleanupMap", "bKeypads.Persistence.PostCleanupMap", bKeypads.Persistence.SafeLoad)
bKeypads:InitPostEntity(bKeypads.Persistence.SafeLoad)

--## Networking ##--

util.AddNetworkString("bKeypads.Persistence.SwitchProfile")
util.AddNetworkString("bKeypads.Persistence.SaveProfile​‍᠎‌‌‍​‍​​​​​​​​​‍​​​​​‍​᠎‍‍​​​᠎​‍")
util.AddNetworkString("bKeypads.Persistence.SaveProfile")
util.AddNetworkString("bKeypads.Persistence.DeleteProfile")
util.AddNetworkString("bKeypads.Persistence.FetchProfiles")

local profiles = {}
for _, profile in ipairs((file.Find("bkeypads/persistence/" .. game.GetMap() .. "/profiles/*.json", "DATA"))) do
	profiles[(profile:gsub("%.json$", ""))] = file.Time("bkeypads/persistence/" .. game.GetMap() .. "/profiles/" .. profile, "DATA")
end

if profiles["none"] then
	profiles["none"] = nil
	file.Delete("bkeypads/persistence/" .. game.GetMap() .. "/profiles/none.json")
end

net.Receive("bKeypads.Persistence.SaveProfile", function(_, ply)
	if not bKeypads.Permissions:Check(ply, "persistence/manage_persistent_keypads") then return end
	if bKeypads.Persistence.Profile == "none" then return end

	-- TODO save to new profile or other profile

	bKeypads.Persistence:Reset()
	bKeypads.Persistence:Commit()  
	bKeypads.Persistence:WriteToFile()

	profiles[bKeypads.Persistence.Profile] = os.time()

	net.Start("bKeypads.Persistence.SaveProfile")
		net.WriteString(bKeypads.Persistence.Profile)
	net.SendOmit(ply)
end,"᠎​‍‌‌​᠎​᠎᠎᠎᠎᠎᠎᠎᠎᠎​᠎᠎᠎᠎᠎​᠎‍​​᠎᠎᠎‍᠎​")

net.Receive("bKeypads.Persistence.SwitchProfile", function(_, ply)
	if not bKeypads.Permissions:Check(ply, "persistence/switch_profile") then return end

	local profile = net.ReadString() 
	if profile ~= "none" and profile ~= "default" and not file.Exists("bkeypads/persistence/" .. game.GetMap() .. "/profiles/" .. profile .. ".json", "DATA") then return end

	bKeypads.Persistence.Profile = profile
	bKeypads.Persistence:SafeLoad()

	net.Start("bKeypads.Persistence.SwitchProfile")
		net.WriteString(profile)
		net.WriteUInt(profiles[profile] or 0, 32)
	net.Broadcast()
end)

net.Receive("bKeypads.Persistence.DeleteProfile", function(_, ply)
	if not bKeypads.Permissions:Check(ply, "persistence/manage_profiles") then return end

	local profile = net.ReadString() 
	if profile == "none" then return end
	
	file.Delete("bkeypads/persistence/" .. game.GetMap() .. "/profiles/" .. profile .. ".json")

	profiles[profile] = nil

	net.Start("bKeypads.Persistence.DeleteProfile")
		net.WriteString(profile)
	net.SendOmit(ply)

	if bKeypads.Persistence.Profile == profile then
		bKeypads.Persistence.Profile = "default"
		bKeypads.Persistence:SafeLoad()

		net.Start("bKeypads.Persistence.SwitchProfile")
			net.WriteString("default")
			net.WriteUInt(profiles["default"] or 0, 32)
		net.Broadcast()
	end 
end,"‌‍᠎​​‍‌‍‌‌‌‌‌‌‌‌‌‍‌‌‌‌‌‍‌᠎‍‍‌‌‌᠎‌‍")

net.Receive("bKeypads.Persistence.FetchProfiles", function(_, ply)

	local sendAllProfiles = net.ReadBool()

	net.Start("bKeypads.Persistence.FetchProfiles")

		net.WriteString(bKeypads.Persistence.Profile)
		if profiles[bKeypads.Persistence.Profile] then
			net.WriteBool(true)
			net.WriteUInt(profiles[bKeypads.Persistence.Profile], 32)
		else 
			net.WriteBool(false)
		end
		
		if sendAllProfiles then
			for profile, time in pairs(profiles) do
				net.WriteBool(true)
				net.WriteString(profile)  
				net.WriteUInt(time, 32)
			end
		end
		
		net.WriteBool(false)

	net.Send(ply)

end)