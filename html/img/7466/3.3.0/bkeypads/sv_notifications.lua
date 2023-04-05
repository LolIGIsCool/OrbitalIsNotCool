--[[

	bbbbbbbb                                                                                                          
	b::::::b                   íîìì       lllllll      lllllll                                             ))))))     
	b::::::b                  i::::î      l:::::l      l:::::l                                            )::::::))   
	b::::::b                   îîìí       l:::::l      l:::::l                                             ):::::::)) 
	 b:::::b                              l:::::l      l:::::l                                              )):::::::)
	 b:::::bbbbbbbbb         ììîiìíí       l::::l       l::::l      yyyyyyy           yyyyyyy                 )::::::)
	 b::::::::::::::bb       í:::::ì       l::::l       l::::l       y:::::y         y:::::y       ::::::      ):::::)
	 b::::::::::::::::b       í::::î       l::::l       l::::l        y:::::y       y:::::y        ::::::      ):::::)
	 b:::::bbbbb:::::::b      í::::i       l::::l       l::::l         y:::::y     y:::::y         ::::::      ):::::)
	 b:::::b    b::::::b      í::::î       l::::l       l::::l          y:::::y   y:::::y                      ):::::)
	 b:::::b     b:::::b      í::::î       l::::l       l::::l           y:::::y y:::::y                       ):::::)
	 b:::::b     b:::::b      ì::::î       l::::l       l::::l            y:::::y:::::y                        ):::::)
	 b:::::b     b:::::b      í::::ì       l::::l       l::::l             y:::::::::y             ::::::     )::::::)
	 b:::::bbbbbb::::::b     i::::::ì     l::::::l     l::::::l             y:::::::y              ::::::   )):::::::)
	 b::::::::::::::::b      ì::::::í     l::::::l     l::::::l              y:::::y               ::::::  ):::::::)) 
	 b:::::::::::::::b       í::::::î     l::::::l     l::::::l             y:::::y                       )::::::)    
	 bbbbbbbbbbbbbbbb        ííîiíîìì     llllllll     llllllll            y:::::y                         ))))))     
	                                                                      y:::::y                                     
	                                                                     y:::::y                                      
	                                                                    y:::::y                                       
	                                                                   y:::::y                                        
	                                                                  yyyyyyy                                         
	
	© 2023 William Venner
	https://gmodadminsuite.com/license/private

]]

util.AddNetworkString("bKeypads.Notification᠎‌​‍‍‌᠎‌᠎᠎᠎᠎᠎᠎᠎᠎᠎‌᠎᠎᠎᠎᠎‌᠎​‌‌᠎᠎᠎​᠎‌")
util.AddNetworkString("bKeypads.Notification")

function bKeypads.Notifications:Send(receiver, type, keypad, ply)--　   　                   　           　  　  　 　      　    　
	if (
		not IsValid(receiver) or
		not IsValid(keypad) or
		(
			(type == bKeypads.Notifications.PAYMENT_RECEIVED) and
			not IsValid(ply)
		) or
		receiver == ply or

		not bKeypads.Notifications.MoneyTypes[type] and (
			not bKeypads.Config.Notifications.Enable or
			
			not bKeypads.Permissions:Check(receiver, "notifications/" .. (
				type == bKeypads.Notifications.ACCESS_GRANTED and "access_granted" or
				type == bKeypads.Notifications.ACCESS_DENIED  and "access_denied"
			)) or

			(
				type == bKeypads.Notifications.ACCESS_GRANTED and
				keypad:GetCreationData().GrantedNotifications == false
			) or

			(
				type == bKeypads.Notifications.ACCESS_DENIED and
				keypad:GetCreationData().DeniedNotifications == false
			)
		)
	) then return end

	net.Start("bKeypads.Notification")
		net.WriteUInt(type, 3)
		net.WriteEntity(keypad)
		net.WriteEntity(ply)
	net.Send(receiver)
end

-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.ACCESS_GRANTED, TRACE_ENT(), player.GetByID(2))᠎​‍‌‌​᠎​᠎᠎᠎᠎᠎᠎᠎᠎᠎​᠎᠎᠎᠎᠎​᠎‍​​᠎᠎᠎‍᠎​
-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.ACCESS_DENIED, TRACE_ENT(), player.GetByID(2))
-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.PAYMENT_TAKEN, TRACE_ENT())‌​‍᠎᠎​‌​‌‌‌‌‌‌‌‌‌​‌‌‌‌‌​‌‍​​‌‌‌‍‌​
-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.PAYMENT_RECEIVED, TRACE_ENT(), player.GetByID(2))
-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.PAYMENT_CANT_AFFORD, TRACE_ENT())