local disablefeed = true

hook.Add("DrawDeathNotice", "DisableKills", function()
	if disablefeed then
		return 0,0
	end
end)