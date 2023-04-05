--[[-------------------------------------------------------------------------
First module - Administrative Actions
---------------------------------------------------------------------------]]

local MODULE_ADMIN = GAS.Logging:MODULE()

MODULE_ADMIN.Category = "jBlacklist"
MODULE_ADMIN.Name     = "Admin"
MODULE_ADMIN.Colour   = Color(51, 110, 123)

MODULE_ADMIN:Hook("jBlacklist_LOG_AdminActivity","jBlacklist_LOG_AdminActivity",function(title,msg)

	local configLogType = jBlacklist.Configuration.GetConfigValue( "LOGGING" )

	if configLogType == "Console & Billy's Logs (bLogs)" or configLogType == "Billy's Logs (bLogs)" then
		MODULE_ADMIN:Log(bLogs:Highlight("[" .. title .. "]") .. " " .. msg)
	end

end)

GAS.Logging:AddModule(MODULE_ADMIN)

--[[-------------------------------------------------------------------------
Second module - Other
---------------------------------------------------------------------------]]

local MODULE_OTHER = GAS.Logging:MODULE()

MODULE_OTHER.Category = "jBlacklist"
MODULE_OTHER.Name     = "Other"
MODULE_OTHER.Colour   = Color(51, 110, 123)

MODULE_OTHER:Hook("jBlacklist_LOG_OtherActivity","jBlacklist_LOG_OtherActivity",function(title,msg)

	local configLogType = jBlacklist.Configuration.GetConfigValue( "LOGGING" )

	if configLogType == "Console & Billy's Logs (bLogs)" or configLogType == "Billy's Logs (bLogs)" then
		MODULE_OTHER:Log(bLogs:Highlight("[" .. title .. "]") .. " " .. msg)
	end

end)

GAS.Logging:AddModule(MODULE_OTHER)