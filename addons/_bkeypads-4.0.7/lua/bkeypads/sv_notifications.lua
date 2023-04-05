util.AddNetworkString("bKeypads.Notification")

function bKeypads.Notifications:Send(receiver, type, keypad, ply)
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

-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.ACCESS_GRANTED, TRACE_ENT(), player.GetByID(2))
-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.ACCESS_DENIED, TRACE_ENT(), player.GetByID(2))
-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.PAYMENT_TAKEN, TRACE_ENT())
-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.PAYMENT_RECEIVED, TRACE_ENT(), player.GetByID(2))
-- lua_run bKeypads.Notifications:Send(ME(), bKeypads.Notifications.PAYMENT_CANT_AFFORD, TRACE_ENT())