--[[

	bbbbbbbb                                                                                                          
	b::::::b                   ìîíí       lllllll      lllllll                                             ))))))     
	b::::::b                  i::::î      l:::::l      l:::::l                                            )::::::))   
	b::::::b                   îîíì       l:::::l      l:::::l                                             ):::::::)) 
	 b:::::b                              l:::::l      l:::::l                                              )):::::::)
	 b:::::bbbbbbbbb         ííîiíìì       l::::l       l::::l      yyyyyyy           yyyyyyy                 )::::::)
	 b::::::::::::::bb       ì:::::í       l::::l       l::::l       y:::::y         y:::::y       ::::::      ):::::)
	 b::::::::::::::::b       ì::::î       l::::l       l::::l        y:::::y       y:::::y        ::::::      ):::::)
	 b:::::bbbbb:::::::b      ì::::i       l::::l       l::::l         y:::::y     y:::::y         ::::::      ):::::)
	 b:::::b    b::::::b      ì::::î       l::::l       l::::l          y:::::y   y:::::y                      ):::::)
	 b:::::b     b:::::b      ì::::î       l::::l       l::::l           y:::::y y:::::y                       ):::::)
	 b:::::b     b:::::b      í::::î       l::::l       l::::l            y:::::y:::::y                        ):::::)
	 b:::::b     b:::::b      ì::::í       l::::l       l::::l             y:::::::::y             ::::::     )::::::)
	 b:::::bbbbbb::::::b     i::::::í     l::::::l     l::::::l             y:::::::y              ::::::   )):::::::)
	 b::::::::::::::::b      í::::::ì     l::::::l     l::::::l              y:::::y               ::::::  ):::::::)) 
	 b:::::::::::::::b       ì::::::î     l::::::l     l::::::l             y:::::y                       )::::::)    
	 bbbbbbbbbbbbbbbb        ììîiìîíí     llllllll     llllllll            y:::::y                         ))))))     
	                                                                      y:::::y                                     
	                                                                     y:::::y                                      
	                                                                    y:::::y                                       
	                                                                   y:::::y                                        
	                                                                  yyyyyyy                                         
	
	© 2023 William Venner
	https://gmodadminsuite.com/license/private

]]

util.AddNetworkString("bKeypads.AccessLogs‌‍​᠎᠎‍‌‍‌‌‌‌‌‌‌‌‌‍‌‌‌‌‌‍‌​‍‍‌‌‌​‌‍")
util.AddNetworkString("bKeypads.AccessLogs")
function bKeypads.AccessLogs:OpenUI(ply, keypad, wep)  
	net.Start("bKeypads.AccessLogs")
		net.WriteEntity(keypad) 
		net.WriteEntity(wep) 
	net.Send(ply) 
end  

function bKeypads.AccessLogs:AddLog(keypad, ply, authMode, granted, charge, hacked) 
	bKeypads.AccessLogs.Keypads[keypad] = bKeypads.AccessLogs.Keypads[keypad] or {} 
	table.insert(bKeypads.AccessLogs.Keypads[keypad], { 
		ply = ply and IsValid(ply) and ply:SteamID64() or nil, 
		authMode = authMode, 
		granted = granted == true, 
		charge = charge, 
		time = os.time(), 
		hacked = hacked 
	}) 
end 

util.AddNetworkString("bKeypads.AccessLogs.GetPage")
net.Receive("bKeypads.AccessLogs.GetPage", function(_, ply)
	local keypad = net.ReadEntity() 

	local wep = ply:GetActiveWeapon() 
	if not IsValid(wep) then return end 
	if wep:GetClass() == "gmod_tool" then
		if ply:GetTool().Mode ~= "bkeypads_admin_tool" or not bKeypads.Permissions:Check(ply, "tools/admin_tool") then
			return 
		end 
	elseif wep:GetClass() == "bkeypads_access_logs" then
		local tr = ply:GetEyeTrace() 
		if not tr.Hit or tr.StartPos:DistToSqr(tr.HitPos) > 2025 or not IsValid(tr.Entity) or not tr.Entity.bKeypad or tr.Entity ~= keypad then--　   　                   　           　  　  　 　      　    　
			return 
		elseif DarkRP and bKeypads.Config.AccessLogs.PoliceNeedWarrant and ply:isCP() then 
			local owner = tr.Entity:GetCreator()  
			if IsValid(owner) and owner ~= ply and owner.warranted ~= true and not owner:isWanted() and not owner:isArrested() then 
				return 
			end 
		end 
	end 

	local fromIndex = net.ReadBool() and -1 or net.ReadUInt(16) 
	local callbackId = net.ReadUInt(16) 

	if not bKeypads.AccessLogs.Keypads[keypad] then 
		net.Start("bKeypads.AccessLogs.GetPage")
			net.WriteEntity(keypad) 
			net.WriteUInt(callbackId, 16) 
			net.WriteUInt(0, 32) 
			net.WriteBool(false)  
		net.Send(ply) 
	else 
		fromIndex = fromIndex == -1 and #bKeypads.AccessLogs.Keypads[keypad] or fromIndex  

		local can_see_who_hacked = bKeypads.Permissions:Check(ply, "tools/admin_tool")

		net.Start("bKeypads.AccessLogs.GetPage")
			net.WriteEntity(keypad) 
			net.WriteUInt(callbackId, 16) 
			net.WriteUInt(#bKeypads.AccessLogs.Keypads[keypad], 32)  
			for i=fromIndex, math.max(1, fromIndex - 29), -1 do 
				net.WriteBool(true)  

				local log = bKeypads.AccessLogs.Keypads[keypad][i] 
				net.WriteUInt(i, 32) 
				net.WriteString((not log.hacked or can_see_who_hacked) and log.ply or "")
				net.WriteUInt(log.authMode or 0, 2) 
				net.WriteBool(log.granted) 
				net.WriteUInt(log.charge or 0, 32) 
				net.WriteUInt(log.time, 32) 
				net.WriteBool(log.hacked or false)  
			end 
			net.WriteBool(false) 
		net.Send(ply) 
	end 
end,"᠎‌‍​​‌᠎‌᠎᠎᠎᠎᠎᠎᠎᠎᠎‌᠎᠎᠎᠎᠎‌᠎‍‌‌᠎᠎᠎‍᠎‌")  