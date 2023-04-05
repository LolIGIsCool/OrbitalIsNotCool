--Create table to store all languages in.
jBlacklist.LoadedLanguage = {}
jBlacklist.RegistredLanguages = {}

--Function to register new languages.
function jBlacklist.RegisterLang(lang)

	lang.Name = lang.Name or "UNKNOWN"

	jBlacklist.RegistredLanguages[lang.Name] = lang

	--Run the hook jBlacklist_LanguageRegistered.
	hook.Run("jBlacklist_LanguageRegistered", lang)

end

--Function to change language.
function jBlacklist.ChangeLang( langName )

	local engLang = jBlacklist.RegistredLanguages["English"]
	local newLang = jBlacklist.RegistredLanguages[langName]

	for k,v in pairs(engLang) do
		if !newLang[k] then
			newLang[k] = engLang[k]
		end
	end

	jBlacklist.LoadedLanguage = newLang

	if jBlacklist.RegistredLanguages[langName].Version != jBlacklist.Version and SERVER then
		jBlacklist.ConNotify("INFO", jBlacklist.LoadedLanguage["OUTDATED_LANG"] or "This language may not be compatible with this version of jBlacklist!")
	end

	--Run the hook jBlacklist_LanguageChanged.
	hook.Run("jBlacklist_LanguageChanged", langName)

end

--Find all languages installed.
local LANGSInstalled = file.Find("jblacklist/languages/*","LUA")

--Loop through all blacklists.
for i = 1,#LANGSInstalled do

	--Check so the blacklist have the correct name.
	if string.Left(LANGSInstalled[i],3) == "sh_" then

		if SERVER then AddCSLuaFile("jblacklist/languages/" .. LANGSInstalled[i]) end

		--Include the blacklist.
		include("jblacklist/languages/" .. LANGSInstalled[i])

	end

end

--Run the hook jBlacklist_LanguagesFinishedLoading.
hook.Run("jBlacklist_LanguagesFinishedLoading")

if CLIENT then

	local read = file.Read("jblacklist/language.txt","DATA")
	jBlacklist.ChangeLang( jBlacklist.RegistredLanguages[read] and read or "English" )

end