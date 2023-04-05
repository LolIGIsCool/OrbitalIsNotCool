--LOGGING ENUMS.
JBLACKLIST_LOGGINGENUM_ADMIN = 1
JBLACKLIST_LOGGINGENUM_OTHER = 2


--Create a function used to log activities.
function jBlacklist.Log( type, title, message )

	--Check what hook to call.
	if type == JBLACKLIST_LOGGINGENUM_ADMIN then

		--Call a hook for administrative activity.
		hook.Run("jBlacklist_LOG_AdminActivity", title, message)

	else

		--Call a hook for other activity.
		hook.Run("jBlacklist_LOG_OtherActivity", title, message)

	end

end

--Create a function that will be used by the hooks.
local function hookFunc( title, msg )

	local configLogType = jBlacklist.Configuration.GetConfigValue( "LOGGING" )

	--Check how we should log the information.
	if configLogType == "Console" or configLogType == "Console & Billy's Logs (bLogs)" then

		--print the information to the console.
		jBlacklist.ConNotify("LOG", "[" .. title .. "] : " .. msg)

	end

end

--Add a hooks for logging.
hook.Add("jBlacklist_LOG_AdminActivity","jBlacklist_LogNotification", hookFunc)
hook.Add("jBlacklist_LOG_OtherActivity","jBlacklist_LogNotification", hookFunc)