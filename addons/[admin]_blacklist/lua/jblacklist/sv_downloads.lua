--Cache the CONTENT_DOWNLOAD configuration-value.
local downloadType = jBlacklist.Configuration.GetConfigValue( "CONTENT_DOWNLOAD" )

--Check how we want to download it.
if downloadType == "Workshop (Default)" then

	--Tell the clients to download the jBlacklist Content addon.
	resource.AddWorkshop("1291381502")

elseif downloadType == "File Download" then

	--Tell the client to download all files.
	resource.AddFile("materials/jblacklist_materials/loading.png")

end