local LANGUAGE = {}
LANGUAGE.Name = "Russian"
LANGUAGE.Author = "Jompe"
LANGUAGE.Version = "1.1.5"

--[[-------------------------------------------------------------------------
GENERAL
---------------------------------------------------------------------------]]
LANGUAGE["OUTDATED_LANG"] = "Этот язык может быть несовместим с этой версией JBlacklist!"

LANGUAGE["INFO_LOADINGDATA"] = "Загрузка данных с игрока."

LANGUAGE["INFO_NOTAUTHORIZED"] = "Ваш ранг недостаточно высок для использования этого."

--TAGS: %C = Command
LANGUAGE["BLACKLISTED_COMMAND_INFO"] = "Тип %C to show more information."

--TAGS: %A = AdminName, %P = Игрокs separated by comma, %R = Причина, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_ADVERT"] = "%A ограничил (%P) за %R. (%B) (%T)"

--TAGS: %A = AdminName, %R = Причина, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_PERSONAL"] = "Вас ограничил %A за %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Игрок, %I = BlacklistID 
LANGUAGE["REMOVED_ADVERT"] = "%A удалил ограничения для %P . (%I)"

--TAGS: %A = AdminName, %P = Игрок
LANGUAGE["ERASED_ADVERT"] = nil --ENGLISH: %A erased all playerdata from %P.

--TAGS: %B = Name of blacklist
LANGUAGE["BLACKLIST_EXPIRED"] = nil --ENGLISH: Your %B blacklist has expired.

LANGUAGE["LOG_WARNING"] = nil --ENGLISH: This will be logged to prevent abusive actions.

--TAGS: %L = Длительность in minutes.
LANGUAGE["LENGTH_CHANGED"] = nil --ENGLISH: The length of the blacklist was changed to %L minutes due to limited access.

--[[-------------------------------------------------------------------------
VGUI - GENERAL
---------------------------------------------------------------------------]]

LANGUAGE["TITLE_ADMIN"] = "Админ-панель"
LANGUAGE["TITLE_OVERVIEW"] = "Обзор ограничений"
LANGUAGE["TITLE_NOTIFICATION"] = nil --ENGLISH: Notification
LANGUAGE["TITLE_QUERY"] = nil --ENGLISH: Verify
LANGUAGE["TITLE_STRINGREQUEST"] = nil --ENGLISH: Input
LANGUAGE["TITLE_UPDATE"] = nil --ENGLISH: Update

LANGUAGE["CONFIRM"] = nil --ENGLISH: Confirm
LANGUAGE["CANCEL"] = nil --ENGLISH: Cancel

LANGUAGE["OK"] = nil --ENGLISH: OK

LANGUAGE["ISSUEBUTTON"] = "Ограничить"
LANGUAGE["MANAGEBUTTON"] = "Управление"
LANGUAGE["STATSBUTTON"] = "Статистика"

LANGUAGE["INPUTSTEAMID"] = "Введите SteamID"
LANGUAGE["INPUTSTEAMID_TITLE"] = "Добавить SteamID"
LANGUAGE["INPUTSTEAMID_QUARY"] = "Введите SteamID, который желаете добавить."
LANGUAGE["INPUTSTEAMID_INCORRECTFORMAT"] = "Неверный формат SteamID !"
LANGUAGE["INPUTSTEAMID_ALREADYADDED"] = "Этот SteamID уже добавлен."

LANGUAGE["ENTER_SEARCHWORD"] = nil --ENGLISH: Enter search word...

LANGUAGE["MULTISELECTOR_DONE"] = nil --ENGLISH: Done

LANGUAGE["NOACCESS"] = nil --ENGLISH: NO ACCESS

LANGUAGE["LOADING_DATA"] = nil --ENGLISH: Loading Data

LANGUAGE["LOADING_WAIT"] = nil --ENGLISH: Please wait while the required data is being loaded...

--[[-------------------------------------------------------------------------
VGUI - ISSUE TAB
---------------------------------------------------------------------------]]

LANGUAGE["ISSUE_TYPE"] = "Тип"
LANGUAGE["ISSUE_TARGET"] = "Игрок"
LANGUAGE["ISSUE_LENGTH"] = "Длительность"
LANGUAGE["ISSUE_REASON"] = "Причина"

LANGUAGE["ISSUE_CHOOSE_TYPE"] = "Choose Blacklist Тип"
LANGUAGE["ISSUE_CHOOSE_TARGET"] = "Выберите игрока"

LANGUAGE["ISSUE_SILENT"] = nil --ENGLISH: Silent
LANGUAGE["ISSUE_ISSUE"] = "Ограничить"

LANGUAGE["ISSUE_MISSING_TYPES"] = nil --ENGLISH: Please select at least one Blacklist Type before issuing blacklist.
LANGUAGE["ISSUE_MISSING_TARGETS"] = nil --ENGLISH: Please select at least one Target before issuing blacklist.

--[[-------------------------------------------------------------------------
VGUI - MANAGE TAB
---------------------------------------------------------------------------]]

LANGUAGE["MANAGE_DETAILSTITLE"] = "Детали"
LANGUAGE["MANAGE_MODIFYTITLE"] = "Редактировать"

LANGUAGE["MANAGE_CHOOSE_PLAYER"] = "Выберите игрока..."

LANGUAGE["MANAGE_ID"] = "ID"
LANGUAGE["MANAGE_USERNAME"] = "Ник"
LANGUAGE["MANAGE_STEAMID"] = "SteamID"
LANGUAGE["MANAGE_TYPE"] = "Тип"
LANGUAGE["MANAGE_REASON"] = "Причина"
LANGUAGE["MANAGE_DESCRIPTION"] = nil --ENGLISH: Description
LANGUAGE["MANAGE_GIVENON"] = "Дата получения"
LANGUAGE["MANAGE_TIMELEFT"] = "Времени осталось"
LANGUAGE["MANAGE_GIVENBY"] = "Ограничил"
LANGUAGE["MANAGE_UPDATED"] = "Последнее изменение"

LANGUAGE["MANAGE_DETAILS"] = "Детали"
LANGUAGE["MANAGE_MODIFY"] = "Редактировать"
LANGUAGE["MANAGE_REMOVE"] = "Удалить"
LANGUAGE["MANAGE_INFO"] = nil --ENGLISH: Information
LANGUAGE["MANAGE_COPYUSERNAME"] = nil --ENGLISH: Copy Username
LANGUAGE["MANAGE_COPYSTEAMID"] = nil --ENGLISH: Copy SteamID
LANGUAGE["MANAGE_COPYSTEAMID64"] = nil --ENGLISH: Copy SteamID64
LANGUAGE["MANAGE_COPYREASON"] = nil --ENGLISH: Copy Reason
LANGUAGE["MANAGE_OPENSTEAMPROFILE"] = nil --ENGLISH: Steam Profile

LANGUAGE["MANAGE_ALL"] = nil --ENGLISH: All
LANGUAGE["MANAGE_GOTOPAGE"] = nil --ENGLISH: What page would you like to go to?
LANGUAGE["MANAGE_ACTIONALL"] = nil --ENGLISH: You cannot perform this action on all players.

LANGUAGE["MANAGE_UPDATEBUTTON"] = "Обновить"

LANGUAGE["MANAGE_DETAILS_QUARY"] = "Вы уверены, что хотите удалить это ограничение?"

LANGUAGE["MANAGE_LOADMORE_BUTTON"] = "Загрузить больше"

LANGUAGE["MANAGE_EXTMGT_ERASEPLYDATA"] = nil --ENGLISH: Erase PlayerData
LANGUAGE["MANAGE_EXTMGT_SELECTPLY"] = nil --ENGLISH: Please select a player first.
LANGUAGE["MANAGE_EXTMGT_CONFIRM_1"] = nil --ENGLISH: Are you sure you want to delete all blacklists from this user?
LANGUAGE["MANAGE_EXTMGT_CONFIRM_2"] = nil --ENGLISH: Confirm that you want to delete all of this player's data.
LANGUAGE["MANAGE_EXTMGT_WRONGANSWER"] = nil --ENGLISH: Please enter the correct answer to erase data.

--TAGS: %Q = Math Question (Ex. 2 + 2)
LANGUAGE["MANAGE_EXTMGT_QUESTION"] = nil --ENGLISH: Please enter what %Q is below to erase data.

LANGUAGE["MANAGE_STATISTICS_TOTAL"] = nil --ENGLISH: Total Blacklists
LANGUAGE["MANAGE_STATISTICS_COMMON"] = nil --ENGLISH: Частое ограничение

LANGUAGE["MANAGE_UPDATEOCCURRED"] = nil --ENGLISH: A change occurred in this player's blacklists.
LANGUAGE["MANAGE_UPDATELIST"] = nil --ENGLISH: Do you wish to update the list?

--[[-------------------------------------------------------------------------
VGUI - Статистика
---------------------------------------------------------------------------]]

LANGUAGE["STATISTICS_ISSUED"] = "Total Ограничитьd"
LANGUAGE["STATISTICS_REMOVED"] = "Всего удалено"
LANGUAGE["STATISTICS_COMMON"] = nil --ENGLISH: Частое ограничение
LANGUAGE["STATISTICS_TOP"] = "Лучший ограничитель"

LANGUAGE["MANAGE_STATISTICS_NONE"] = nil --ENGLISH: None

--[[-------------------------------------------------------------------------
TIME TYPES
---------------------------------------------------------------------------]]

LANGUAGE["EXPIRED"] = nil --ENGLISH: Expired
LANGUAGE["TIME_SECONDS"] = "Секунды"
LANGUAGE["TIME_MINUTES"] = "Минуты"
LANGUAGE["TIME_HOURS"] = "Часы"
LANGUAGE["TIME_DAYS"] = "Дни"
LANGUAGE["TIME_WEEKS"] = "Недели"
LANGUAGE["TIME_MONTHS"] = "Месяца(-ев)"
LANGUAGE["TIME_YEARS"] = "Лет"
LANGUAGE["TIME_PERMANENT"] = nil --ENGLISH: Never

--TAGS: %Y = Years (Number), %M = Months (Number)
LANGUAGE["FORMATTEDTIME_YM"] = nil --ENGLISH: %Y years and %M months

--TAGS: %M = Months (Number), %D = Days (Number)
LANGUAGE["FORMATTEDTIME_MD"] = nil --ENGLISH: %M months and %D days

--TAGS: %D = Days (Number), %H = Hours (Number)
LANGUAGE["FORMATTEDTIME_DH"] = nil --ENGLISH: %D days and %H hours

--TAGS: %H = Hours (Number), %M = Minutes (Number)
LANGUAGE["FORMATTEDTIME_HM"] = nil --ENGLISH: %H hours and %M minutes

--TAGS: %M = Minutes (Number), %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_MS"] = nil --ENGLISH: %M minutes and %S seconds

--TAGS: %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_S"] = nil --ENGLISH: %S seconds

--[[-------------------------------------------------------------------------
Warning Messages.
---------------------------------------------------------------------------]]
LANGUAGE["WARNING_ADDBL_FAIL"] = "Не удалось добавить ограничение."
LANGUAGE["WARNING_REMOVEBL_FAIL"] = "Не удалось удалить ограничение."
LANGUAGE["WARNING_UPDATEBL_FAIL"] = "Не удалось обновить ограничение."
LANGUAGE["WARNING_READBLTABLE_FAIL"] = "Не удалось получить список ограничений."
LANGUAGE["WARNING_ERASEBLACKLISTS_FAIL"] = nil --ENGLISH: Failed to erase blacklists.
LANGUAGE["WARNING_GETBLPAGE_FAIL"] = nil --ENGLISH: Failed to load page of blacklists.

LANGUAGE["WARNING_ADDBL_SUCCESS"] = "Ограничение добавлено успешно."
LANGUAGE["WARNING_REMOVEBL_SUCCESS"] = "Ограничение было успешно удалено."
LANGUAGE["WARNING_UPDATEBL_SUCCESS"] = "Ограничение успешно обновлено."
LANGUAGE["WARNING_READBLTABLE_SUCCESS"] = "Успешно прочитан список ограничений."
LANGUAGE["WARNING_ERASEBLACKLISTS_SUCCESS"] = nil --ENGLISH: Successfully erased blacklists.
LANGUAGE["WARNING_GETBLPAGE_SUCCESS"] = nil --ENGLISH: Successfully read page of blacklists.

LANGUAGE["WARNING_LOADPLAYER_FAIL"] = "Не удалось загрузить данные игрока."
LANGUAGE["WARNING_GETALLBL_NOTHINGTOREAD"] = nil --ENGLISH: There are no blacklists to load on this page.

LANGUAGE["WARNING_ERROR_MISSINGARGS"] = "Отсутствуют аргументы"
LANGUAGE["WARNING_ERROR_WRONGDATATYPE"] = "Неверный формат даты"
LANGUAGE["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] = "Неверный формат SteamID "
LANGUAGE["WARNING_ERROR_BLNOTEXIST"] = "Ограничение не существует"
LANGUAGE["WARNING_ERROR_INCORRECTBLFORMAT"] = "Неверный формат ограничения"
LANGUAGE["WARNING_ERROR_CONFIGNOTEXIST"] = nil --ENGLISH: Config-ID does not exist.
LANGUAGE["WARNING_ERROR_TYPENOTEXIST"] = nil --ENGLISH: Blacklist type does not exist
LANGUAGE["WARNING_ERROR_SQLERROR"] = nil --ENGLISH: MySQL/SQLite Error

--[[-------------------------------------------------------------------------
Blacklist specific translations.
---------------------------------------------------------------------------]]
LANGUAGE["BLACKLIST_GRAVGUN"] = "Из-за ограничения Вы не можете использовать грави-ган"
LANGUAGE["BLACKLIST_TEAM"] = "Вы не можете выбрать эту работу, так как Вы имеете ограничение!"
LANGUAGE["BLACKLIST_OOC"] = "Вы не можете писать в ООС из-за ограничения!"
LANGUAGE["BLACKLIST_PHYSGUN"] = "Из-за ограничения Вы не можете использовать грави-ган"
LANGUAGE["BLACKLIST_PROPS"] = "Вы не можете спавнить пропы/энтити из-за ограничения!"
LANGUAGE["BLACKLIST_TOOLGUN"] = "Вам запрещено использовать Тул-Ган из-за ограничения!"
LANGUAGE["BLACKLIST_WEAPONS"] = "Из-за ограничения Вы не можете пользоваться оружием"
LANGUAGE["BLACKLIST_VEHICLES"] = "Вы не можете использовать технику, так как имеете ограничение!"
LANGUAGE["BLACKLIST_WIREMOD"] = "Из-за ограничения Вы не можете пользоваться WireMod'ом!"
LANGUAGE["BLACKLIST_TOOL"] = nil --ENGLISH: You are not allowed to use this tool due to being blacklisted!
LANGUAGE["BLACKLIST_BUYAMMO"] = nil --ENGLISH: You are not allowed to buy ammo due to being blacklisted!
LANGUAGE["BLACKLIST_BUYENTITY"] = nil --ENGLISH: You are not allowed to buy entities due to being blacklisted!
LANGUAGE["BLACKLIST_BUYPISTOL"] = nil --ENGLISH: You are not allowed to buy pistols due to being blacklisted!
LANGUAGE["BLACKLIST_BUYSHIPMENT"] = nil --ENGLISH: You are not allowed to buy shipments due to being blacklisted!
LANGUAGE["BLACKLIST_CANADVERT"] = nil --ENGLISH: You are not allowed to advert due to being blacklisted!
LANGUAGE["BLACKLIST_Lockpick"] = nil --ENGLISH: You are not allowed to lockpick due to being blacklisted!
LANGUAGE["BLACKLIST_CINEMA_REQUESTVIDEO"] = nil --ENGLISH: You are not allowed to add videos to the queue due to being blacklisted!
LANGUAGE["BLACKLIST_TEXTCHAT"] = nil --ENGLISH: You are not allowed to type non-commands in text chat due to being blacklisted!
LANGUAGE["BLACKLIST_CAMERASWEP"] = nil --ENGLISH: You are not allowed to use the camera SWEP due to being blacklisted!
LANGUAGE["BLACKLIST_VOICECHAT"] = nil --ENGLISH: You are not allowed to talk in voice chat due to being blacklisted!

--%T = Time
LANGUAGE["BLACKLIST_NLR"] = "Из-за того, что на Вас ограничение, нужно подождать %T минут прежде чем воскреснуть!"

--%T = Time
LANGUAGE["BLACKLIST_NLR_RESPAWN"] = nil --ENGLISH: You can respawn in %T.

--[[-------------------------------------------------------------------------
Blacklist Descriptions
---------------------------------------------------------------------------]]

--%T = FORMATTED TIME
LANGUAGE["BLACKLIST_EXPIRESIN"] = nil --ENGLISH: Expires in: %T

LANGUAGE["BLACKLISTDESC_DarkRPBuyAmmo"] = nil --ENGLISH: Restricts the user from purchasing ammunation in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPBuyPistol"] = nil --ENGLISH: Restricts the user from purchasing pistols in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPBuyEntity"] = nil --ENGLISH: Restricts the user from purchasing entities in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPBuyShipment"] = nil --ENGLISH: Restricts the user from purchasing shipments in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPAdvert"] = nil --ENGLISH: Restricts the user from making adverts in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPJobs"] = nil --ENGLISH: Restrcits the user from becoming said job in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPOOC"] = nil --ENGLISH: Restricts the user from using the OOC-chat in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPLockpick"] = nil --ENGLISH: Restricts the user from using the lockpick in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_GravityGun"] = nil --ENGLISH: Restricts the user from using the Gravity Gun.
LANGUAGE["BLACKLISTDESC_PhysGun"] = nil --ENGLISH: Restricts the user from using the Physics Gun.
LANGUAGE["BLACKLISTDESC_ToolGun"] = nil --ENGLISH: Restricts the user from using the Tool Gun.
LANGUAGE["BLACKLISTDESC_NLR"] = nil --ENGLISH: Restricts the user from spawning in certain minutes after dying.
LANGUAGE["BLACKLISTDESC_Props"] = nil --ENGLISH: Restricts the user from spawning props/entities/vehicles.
LANGUAGE["BLACKLISTDESC_Tools"] = nil --ENGLISH: Restricts the user from using said tool.
LANGUAGE["BLACKLISTDESC_Vehicles"] = nil --ENGLISH: Restricts the user from driving vehicles.
LANGUAGE["BLACKLISTDESC_Weapons"] = nil --ENGLISH: Restricts the user from using certain weapons.
LANGUAGE["BLACKLISTDESC_WireMod"] = nil --ENGLISH: Restricts the user from using the Wiremod tools.
LANGUAGE["BLACKLISTDESC_CINEMA_REQUESTVIDEO"] = nil --ENGLISH: Restricts the user from adding new videos to the queue in the cinema gamemode.
LANGUAGE["BLACKLISTDESC_TextChat"] = nil --ENGLISH: --ENGLISH: Restricts the user from typing non-commands in the text chat.
LANGUAGE["BLACKLISTDESC_CAMERASWEP"] = nil --ENGLISH: Restricts the user from using the camera SWEP.
LANGUAGE["BLACKLISTDESC_VOICECHAT"] = nil --ENGLISH: Restricts the user from talking in voice chat.

--[[-------------------------------------------------------------------------
REGISTER THE BLACKLIST.
---------------------------------------------------------------------------]]

--Register the language.
jBlacklist.RegisterLang(LANGUAGE)