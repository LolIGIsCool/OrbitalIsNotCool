local LANGUAGE = {}
LANGUAGE.Name = "Swedish"
LANGUAGE.Author = "Jompe"
LANGUAGE.Version = "2.3.2"

--[[-------------------------------------------------------------------------
GENERAL
---------------------------------------------------------------------------]]
LANGUAGE["OUTDATED_LANG"] = "Det här språket kanske inte är kompatibelt med den här versionen av JBlacklist."

LANGUAGE["INFO_LOADINGDATA"] = "Läser in data från spelare."

LANGUAGE["INFO_NOTAUTHORIZED"] = "Du har inte den tillräckliga befogenheter för att göra detta."

--TAGS: %C = Command
LANGUAGE["BLACKLISTED_COMMAND_INFO"] = "Skriv %C för att visa mer information."

--TAGS: %A = AdminName, %P = Måls separated by comma, %R = Anledning, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_ADVERT"] = "%A begränsade (%P) för %R. (%B) (%T)"

--TAGS: %A = AdminName, %R = Anledning, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_PERSONAL"] = "Du har blivit begränsad av %A för %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Mål, %I = BlacklistID 
LANGUAGE["REMOVED_ADVERT"] = "%A tog bort en begränsning från %P. (%I)"

--TAGS: %A = AdminName, %P = Mål
LANGUAGE["ERASED_ADVERT"] = "%A rensade all spelardata från %P."

--TAGS: %B = Name of blacklist
LANGUAGE["BLACKLIST_EXPIRED"] = "Din %B begränsning gick ut."

LANGUAGE["LOG_WARNING"] = "Det här kommer att loggas för att förhindra missbruk."

--TAGS: %L = Längd in minutes.
LANGUAGE["LENGTH_CHANGED"] = "Längden för begränsningen var ändrad till %L minuter pågrund av otillräcklig befogenhet."

--[[-------------------------------------------------------------------------
VGUI - GENERAL
---------------------------------------------------------------------------]]

LANGUAGE["TITLE_ADMIN"] = "Admin Panel"
LANGUAGE["TITLE_OVERVIEW"] = "Begränsningar Överblick"
LANGUAGE["TITLE_NOTIFICATION"] = "Notifikation"
LANGUAGE["TITLE_QUERY"] = "Verifiera"
LANGUAGE["TITLE_STRINGREQUEST"] = "Inmatning"
LANGUAGE["TITLE_UPDATE"] = "Uppdatering"

LANGUAGE["CONFIRM"] = "Bekräfta"
LANGUAGE["CANCEL"] = "Avbryt"

LANGUAGE["OK"] = "OK"

LANGUAGE["ISSUEBUTTON"] = "Utfärda"
LANGUAGE["MANAGEBUTTON"] = "Hantera"
LANGUAGE["STATSBUTTON"] = "Statistik"

LANGUAGE["INPUTSTEAMID"] = "Lägg Till SteamID"
LANGUAGE["INPUTSTEAMID_TITLE"] = "Lägg Till SteamID"
LANGUAGE["INPUTSTEAMID_QUARY"] = "Skriv in det SteamID du vill lägga till."
LANGUAGE["INPUTSTEAMID_INCORRECTFORMAT"] = "Fel SteamID format!"
LANGUAGE["INPUTSTEAMID_ALREADYADDED"] = "Detta SteamID är redan tillagt."

LANGUAGE["ENTER_SEARCHWORD"] = "Ange sökord..."

LANGUAGE["MULTISELECTOR_DONE"] = "Klar"

LANGUAGE["NOACCESS"] = "INGA BEFOGENHETER"

LANGUAGE["LOADING_DATA"] = "Läser in data"

LANGUAGE["LOADING_WAIT"] = "Vänligen vänta medan den nödvändiga informationen läses in..."

--[[-------------------------------------------------------------------------
VGUI - ISSUE TAB
---------------------------------------------------------------------------]]

LANGUAGE["ISSUE_TYPE"] = "Typ"
LANGUAGE["ISSUE_TARGET"] = "Mål"
LANGUAGE["ISSUE_LENGTH"] = "Längd"
LANGUAGE["ISSUE_REASON"] = "Anledning"

LANGUAGE["ISSUE_CHOOSE_TYPE"] = "Choose Blacklist Typ"
LANGUAGE["ISSUE_CHOOSE_TARGET"] = "Välj Mål"

LANGUAGE["ISSUE_SILENT"] = "Tyst"
LANGUAGE["ISSUE_ISSUE"] = "Utfärda"

LANGUAGE["ISSUE_MISSING_TYPES"] = "Vänligen välj minst en Begränsnings-typ innan du utfärdar denna begränsing."
LANGUAGE["ISSUE_MISSING_TARGETS"] = "Vänligen välj minst ett Mål innan du utfärdar denna begränsning."

--[[-------------------------------------------------------------------------
VGUI - MANAGE TAB
---------------------------------------------------------------------------]]

LANGUAGE["MANAGE_DETAILSTITLE"] = "Begränsnings Detaljer"
LANGUAGE["MANAGE_MODIFYTITLE"] = "Ändra Begränsning"

LANGUAGE["MANAGE_CHOOSE_PLAYER"] = "Välj en spelare..."

LANGUAGE["MANAGE_ID"] = "ID"
LANGUAGE["MANAGE_USERNAME"] = "Användarnamn"
LANGUAGE["MANAGE_STEAMID"] = "SteamID"
LANGUAGE["MANAGE_TYPE"] = "Typ"
LANGUAGE["MANAGE_REASON"] = "Anledning"
LANGUAGE["MANAGE_DESCRIPTION"] = "Beskrivning"
LANGUAGE["MANAGE_GIVENON"] = "Utfärdad"
LANGUAGE["MANAGE_TIMELEFT"] = "Upphör"
LANGUAGE["MANAGE_GIVENBY"] = "Utfärdad Av"
LANGUAGE["MANAGE_UPDATED"] = "Senast Ändrad"

LANGUAGE["MANAGE_DETAILS"] = "Detaljer"
LANGUAGE["MANAGE_MODIFY"] = "Ändra"
LANGUAGE["MANAGE_REMOVE"] = "Ta bort"
LANGUAGE["MANAGE_COPYUSERNAME"] = "Kopiera Användarnamn"
LANGUAGE["MANAGE_INFO"] = "Information"
LANGUAGE["MANAGE_COPYSTEAMID"] = "Kopirea SteamID"
LANGUAGE["MANAGE_COPYSTEAMID64"] = "Kopiera SteamID64"
LANGUAGE["MANAGE_COPYREASON"] = "Kopiera Anledning"
LANGUAGE["MANAGE_OPENSTEAMPROFILE"] = "Steam Profil"

LANGUAGE["MANAGE_ALL"] = "Alla"
LANGUAGE["MANAGE_GOTOPAGE"] = "Vilken sida skulle du vilja gå till?"
LANGUAGE["MANAGE_ACTIONALL"] = "Du kan inte utföra denna åtgärd på alla spelare."

LANGUAGE["MANAGE_UPDATEBUTTON"] = "Ändra Begränsning"

LANGUAGE["MANAGE_DETAILS_QUARY"] = "Är du säker på att du vill ta bort denna begränsning?"

LANGUAGE["MANAGE_LOADMORE_BUTTON"] = "Läs in fler"

LANGUAGE["MANAGE_EXTMGT_ERASEPLYDATA"] = "Radera spelardata"
LANGUAGE["MANAGE_EXTMGT_SELECTPLY"] = "Var god välj en spelare först."
LANGUAGE["MANAGE_EXTMGT_CONFIRM_1"] = "Är du säker på att du vill ta bort alla begränsningar från denna spelare?"
LANGUAGE["MANAGE_EXTMGT_CONFIRM_2"] = "Bekräfta att du vill radera denna spelares begränsningar."
LANGUAGE["MANAGE_EXTMGT_WRONGANSWER"] = "Var god ange rätt svar för att rensa spelardata."

--TAGS: %Q = Math Question (Ex. 2 + 2)
LANGUAGE["MANAGE_EXTMGT_QUESTION"] = "Var god svara på vad %Q är för att radera spelarens begränsningar."

LANGUAGE["MANAGE_STATISTICS_TOTAL"] = "Antal Begränsningar"
LANGUAGE["MANAGE_STATISTICS_COMMON"] = "Vanligaste Begränsning"

LANGUAGE["MANAGE_UPDATEOCCURRED"] = "En ändring gjordes i den här spelarens begränsningar."
LANGUAGE["MANAGE_UPDATELIST"] = "Vill du uppdatera listan?"

--[[-------------------------------------------------------------------------
VGUI - Statistik
---------------------------------------------------------------------------]]

LANGUAGE["STATISTICS_ISSUED"] = "Totalt Utfärdade"
LANGUAGE["STATISTICS_REMOVED"] = "Totalt Borttagna"
LANGUAGE["STATISTICS_COMMON"] = "Vanligaste Begränsning"
LANGUAGE["STATISTICS_TOP"] = "Mest Utfärdade"

LANGUAGE["MANAGE_STATISTICS_NONE"] = "Ingen"

--[[-------------------------------------------------------------------------
TIME TYPES
---------------------------------------------------------------------------]]

LANGUAGE["EXPIRED"] = "Utgått"
LANGUAGE["TIME_SECONDS"] = "Sekunder"
LANGUAGE["TIME_MINUTES"] = "Minuter"
LANGUAGE["TIME_HOURS"] = "Timmar"
LANGUAGE["TIME_DAYS"] = "Dagar"
LANGUAGE["TIME_WEEKS"] = "Veckor"
LANGUAGE["TIME_MONTHS"] = "Månader"
LANGUAGE["TIME_YEARS"] = "År"
LANGUAGE["TIME_PERMANENT"] = "Aldrig"

--TAGS: %Y = Years (Number), %M = Months (Number)
LANGUAGE["FORMATTEDTIME_YM"] = "%Y år och %M månader"

--TAGS: %M = Months (Number), %D = Days (Number)
LANGUAGE["FORMATTEDTIME_MD"] = "%M månader och %D dagar"

--TAGS: %D = Days (Number), %H = Hours (Number)
LANGUAGE["FORMATTEDTIME_DH"] = "%D dagar och %H timmar"

--TAGS: %H = Hours (Number), %M = Minutes (Number)
LANGUAGE["FORMATTEDTIME_HM"] = "%H timmar och %M minuter"

--TAGS: %M = Minutes (Number), %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_MS"] = "%M minuter och %S sekunder"

--TAGS: %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_S"] = "%S sekunder"

--[[-------------------------------------------------------------------------
Warning Messages.
---------------------------------------------------------------------------]]
LANGUAGE["WARNING_ADDBL_FAIL"] = "Misslyckades med att lägga till begränsning."
LANGUAGE["WARNING_REMOVEBL_FAIL"] = "Misslyckades med att ta bort begränsning."
LANGUAGE["WARNING_UPDATEBL_FAIL"] = "Misslyckades med att ändra begränsning."
LANGUAGE["WARNING_READBLTABLE_FAIL"] = "Misslyckades med att läsa begränsnings table."
LANGUAGE["WARNING_ERASEBLACKLISTS_FAIL"] = "Misslyckades med att rensa begränsningar."
LANGUAGE["WARNING_GETBLPAGE_FAIL"] = "Misslyckades med att läsa sida av begränsningar."

LANGUAGE["WARNING_ADDBL_SUCCESS"] = "Lyckades med att lägga till begränsning."
LANGUAGE["WARNING_REMOVEBL_SUCCESS"] = "Lyckades med att ta bort begränsning."
LANGUAGE["WARNING_UPDATEBL_SUCCESS"] = "Lyckades med att ändra begränsning."
LANGUAGE["WARNING_READBLTABLE_SUCCESS"] = "Lyckades med att läsa begränsnings table."
LANGUAGE["WARNING_ERASEBLACKLISTS_SUCCESS"] = "Lyckades med att rensa begränsningar."
LANGUAGE["WARNING_GETBLPAGE_SUCCESS"] = "Lyckades med att läsa sida av begränsningar."

LANGUAGE["WARNING_LOADPLAYER_FAIL"] = "Misslyckades med att läsa in spelare."
LANGUAGE["WARNING_GETALLBL_NOTHINGTOREAD"] = "Det finns inga begränsningar att läsa in på denna sida."

LANGUAGE["WARNING_ERROR_MISSINGARGS"] = "Argument saknas"
LANGUAGE["WARNING_ERROR_WRONGDATATYPE"] = "Fel datatyp"
LANGUAGE["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] = "Fel SteamID format"
LANGUAGE["WARNING_ERROR_BLNOTEXIST"] = "Begränsning finns inte"
LANGUAGE["WARNING_ERROR_INCORRECTBLFORMAT"] = "Fel begränsnings format"
LANGUAGE["WARNING_ERROR_CONFIGNOTEXIST"] = "Konfigurations-ID finns inte"
LANGUAGE["WARNING_ERROR_TYPENOTEXIST"] = "Begränsnings-typ existerar inte"
LANGUAGE["WARNING_ERROR_SQLERROR"] = "MySQL/SQLite Fel"

--[[-------------------------------------------------------------------------
Blacklist specific translations.
---------------------------------------------------------------------------]]
LANGUAGE["BLACKLIST_GRAVGUN"] = "Du är inte tillåten att använda Gravity Gun pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_TEAM"] = "Du är inte tillåten att bli detta jobb pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_OOC"] = "Du är inte tillåten att använda OOC chat pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_PHYSGUN"] = "Du är inte tillåten att använda Physics Gun pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_PROPS"] = "Du är inte tillåten att ta fram föremål eller enheter pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_TOOLGUN"] = "Du är inte tillåten att använda Tool Gun pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_WEAPONS"] = "Du är inte tillåten att använda vapen pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_VEHICLES"] = "Du är inte tillåten att köra fordon pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_WIREMOD"] = "Du är inte tillåten att använda Wiremod pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_TOOL"] = "Du är inte tillåten att använda detta verktyg pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_BUYAMMO"] = "Du är inte tillåten att köpa ammunition pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_BUYENTITY"] = "Du är inte tillåten att köpa enheter pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_BUYPISTOL"] = "Du är inte tillåten att köpa pistoler pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_BUYSHIPMENT"] = "Du är inte tillåten att köpa lådor pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_CANADVERT"] = "Du är inte tillåten att annonsera pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_Lockpick"] = "Du är inte tillåten att dyrka lås pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_CINEMA_REQUESTVIDEO"] = "Du är inte tillåten att lägga till videoklipp i kön pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_TEXTCHAT"] = "Du är inte tillåten att skriva icke kommandon i chatten pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_CAMERASWEP"] = "Du är inte tillåten att använda kamera pågrund av att du är begränsad."
LANGUAGE["BLACKLIST_VOICECHAT"] = "Du är inte tillåten att prata i röst chatten pågrund av att du är begränsad."

--%T = Time
LANGUAGE["BLACKLIST_NLR"] = "Du måste vänta %T minuter innan du återuppstår pågrund av att du är begränsad!"

--%T = Time
LANGUAGE["BLACKLIST_NLR_RESPAWN"] = "Du kan återuppstå om %T."

--[[-------------------------------------------------------------------------
Blacklist Descriptions
---------------------------------------------------------------------------]]

--%T = FORMATTED TIME
LANGUAGE["BLACKLIST_EXPIRESIN"] = "Går ut om: %T"

LANGUAGE["BLACKLISTDESC_DarkRPBuyAmmo"] = "Begränsar spelaren från att köpa ammunition i DarkRP spelläget."
LANGUAGE["BLACKLISTDESC_DarkRPBuyPistol"] = "Begränsar spelaren från att köpa pistoler i DarkRP spelläget."
LANGUAGE["BLACKLISTDESC_DarkRPBuyEntity"] = "Begränsar spelaren från att köpa enheter i DarkRP spelläget."
LANGUAGE["BLACKLISTDESC_DarkRPBuyShipment"] = "Begränsar spelaren från att köpa fraktlådor i DarkRP spelläget."
LANGUAGE["BLACKLISTDESC_DarkRPAdvert"] = "Begränsar spelaren från att göra annonseringar i DarkRP spelläget."
LANGUAGE["BLACKLISTDESC_DarkRPJobs"] = "Begränsar spelaren från att bli följande jobb i DarkRP spelläget."
LANGUAGE["BLACKLISTDESC_DarkRPOOC"] = "Begränsar spelaren från att använda OOC-chatten i DarkRP spelläget."
LANGUAGE["BLACKLISTDESC_DarkRPLockpick"] = "Begränsar spelaren från att dyrka lås i DarkRP spelläget."
LANGUAGE["BLACKLISTDESC_GravityGun"] = "Begränsar spelaren från att använda sig av en Gravity Gun."
LANGUAGE["BLACKLISTDESC_PhysGun"] = "Begränsar spelaren från att använda sig av en Physics Gun."
LANGUAGE["BLACKLISTDESC_ToolGun"] = "Begränsar spelaren från att använda sig av en Tool Gun."
LANGUAGE["BLACKLISTDESC_NLR"] = "Begränsar spelaren från att återuppstå några minuter efter dödsfall."
LANGUAGE["BLACKLISTDESC_Props"] = "Begränsar spelaren från att ta fram föremål/enheter/fordon."
LANGUAGE["BLACKLISTDESC_Tools"] = "Begränsar spelaren från att använda följande verktyg."
LANGUAGE["BLACKLISTDESC_Vehicles"] = "Begränsar spelaren från att köra fordon."
LANGUAGE["BLACKLISTDESC_Weapons"] = "Begränsar spelaren från att använda vissa vapen."
LANGUAGE["BLACKLISTDESC_WireMod"] = "Begränsar spelaren från att använda Wiremod-verktygen."
LANGUAGE["BLACKLISTDESC_CINEMA_REQUESTVIDEO"] = "Begränsar spelaren från att lägga till videoklipp i kön på Cinema spelläget."
LANGUAGE["BLACKLISTDESC_CAMERASWEP"] = "Begränsar spelaren från att använda sig av en kamera."
LANGUAGE["BLACKLISTDESC_VOICECHAT"] = "Begränsar spelaren från att prata i röst chatten."

--[[-------------------------------------------------------------------------
REGISTER THE BLACKLIST.
---------------------------------------------------------------------------]]

--Register the language.
jBlacklist.RegisterLang(LANGUAGE)