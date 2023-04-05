local LANGUAGE = {}
LANGUAGE.Name = "Portuguese"
LANGUAGE.Author = "OpeLoad"
LANGUAGE.Version = "1.0.3"

--[[-------------------------------------------------------------------------
GENERAL
---------------------------------------------------------------------------]]
LANGUAGE["OUTDATED_LANG"] = "Este idioma pode não ser compatível com esta versão do JBlacklist!"

LANGUAGE["INFO_LOADINGDATA"] = "Carregando dados do jogador."

LANGUAGE["INFO_NOTAUTHORIZED"] = nil --ENGLISH: You don't have the required rank to do this.

--TAGS: %C = Command
LANGUAGE["BLACKLISTED_COMMAND_INFO"] = "Tipo %C to show more information."

--TAGS: %A = AdminName, %P = Alvos separated by comma, %R = Razão, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_ADVERT"] = "%A Lista negra (%P) para %R. (%B) (%T)"

--TAGS: %A = AdminName, %R = Razão, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_PERSONAL"] = "Você foi colocado na lista negra por by %A for %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Alvo, %I = BlacklistIdentidade 
LANGUAGE["REMOVED_ADVERT"] = "%A Removeu uma lista negra de %P. (%I)"

--TAGS: %A = AdminName, %P = Alvo
LANGUAGE["ERASED_ADVERT"] = nil --ENGLISH: %A erased all playerdata from %P.

--TAGS: %B = Name of blacklist
LANGUAGE["BLACKLIST_EXPIRED"] = nil --ENGLISH: Your %B blacklist has expired.

LANGUAGE["LOG_WARNING"] = nil --ENGLISH: This will be logged to prevent abusive actions.

--TAGS: %L = Comprimento in minutes.
LANGUAGE["LENGTH_CHANGED"] = nil --ENGLISH: The length of the blacklist was changed to %L minutes due to limited access.

--[[-------------------------------------------------------------------------
VGUI - GENERAL
---------------------------------------------------------------------------]]

LANGUAGE["TITLE_ADMIN"] = "Painel de administração"
LANGUAGE["TITLE_OVERVIEW"] = "Visão geral das listas negras"
LANGUAGE["TITLE_NOTIFICATION"] = nil --ENGLISH: Notification
LANGUAGE["TITLE_QUERY"] = nil --ENGLISH: Verify
LANGUAGE["TITLE_STRINGREQUEST"] = nil --ENGLISH: Input
LANGUAGE["TITLE_UPDATE"] = nil --ENGLISH: Update

LANGUAGE["CONFIRM"] = nil --ENGLISH: Confirm
LANGUAGE["CANCEL"] = nil --ENGLISH: Cancel

LANGUAGE["OK"] = nil --ENGLISH: OK

LANGUAGE["ISSUEBUTTON"] = "Questão"
LANGUAGE["MANAGEBUTTON"] = "Gerir"
LANGUAGE["STATSBUTTON"] = "Estatisticas"

LANGUAGE["INPUTSTEAMIdentidade"] = "Digite SteamIdentidade"
LANGUAGE["INPUTSTEAMIdentidade_TITLE"] = "Adicione SteamIdentidade"
LANGUAGE["INPUTSTEAMIdentidade_QUARY"] = "Digite o SteamIdentidade que deseja adicionar."
LANGUAGE["INPUTSTEAMIdentidade_INCORRECTFORMAT"] = "Formato SteamIdentidade incorreto!"
LANGUAGE["INPUTSTEAMIdentidade_ALREADYADDED"] = "Este SteamIdentidade já foi adicionado."

LANGUAGE["ENTER_SEARCHWORD"] = nil --ENGLISH: Enter search word...

LANGUAGE["MULTISELECTOR_DONE"] = nil --ENGLISH: Done

LANGUAGE["NOACCESS"] = nil --ENGLISH: NO ACCESS

LANGUAGE["LOADING_DATA"] = nil --ENGLISH: Loading Data

LANGUAGE["LOADING_WAIT"] = nil --ENGLISH: Please wait while the required data is being loaded...

--[[-------------------------------------------------------------------------
VGUI - ISSUE TAB
---------------------------------------------------------------------------]]

LANGUAGE["ISSUE_TYPE"] = "Tipo"
LANGUAGE["ISSUE_TARGET"] = "Alvo"
LANGUAGE["ISSUE_LENGTH"] = "Comprimento"
LANGUAGE["ISSUE_REASON"] = "Razão"

LANGUAGE["ISSUE_CHOOSE_TYPE"] = "Choose Blacklist Tipo"
LANGUAGE["ISSUE_CHOOSE_TARGET"] = "Escolha o alvo"

LANGUAGE["ISSUE_SILENT"] = nil --ENGLISH: Silent
LANGUAGE["ISSUE_ISSUE"] = "Questão"

LANGUAGE["ISSUE_MISSING_TYPES"] = nil --ENGLISH: Please select at least one Blacklist Type before issuing blacklist.
LANGUAGE["ISSUE_MISSING_TARGETS"] = nil --ENGLISH: Please select at least one Target before issuing blacklist.

--[[-------------------------------------------------------------------------
VGUI - MANAGE TAB
---------------------------------------------------------------------------]]

LANGUAGE["MANAGE_DETAILSTITLE"] = "Detalhes da lista negra"
LANGUAGE["MANAGE_MODIFYTITLE"] = "Modificar lista negra"

LANGUAGE["MANAGE_CHOOSE_PLAYER"] = "Escolha um jogador ..."

LANGUAGE["MANAGE_Identidade"] = "Identidade"
LANGUAGE["MANAGE_USERNAME"] = "Nome de usuário"
LANGUAGE["MANAGE_STEAMIdentidade"] = "SteamIdentidade"
LANGUAGE["MANAGE_TYPE"] = "Tipo"
LANGUAGE["MANAGE_REASON"] = "Razão"
LANGUAGE["MANAGE_DESCRIPTION"] = nil --ENGLISH: Description
LANGUAGE["MANAGE_GIVENON"] = "Dado sobre"
LANGUAGE["MANAGE_TIMELEFT"] = "Tempo restante"
LANGUAGE["MANAGE_GIVENBY"] = "Dado por"
LANGUAGE["MANAGE_UPDATED"] = "Última atualização"

LANGUAGE["MANAGE_DETAILS"] = "Detalhes"
LANGUAGE["MANAGE_MODIFY"] = "Modificar"
LANGUAGE["MANAGE_REMOVE"] = "Remove"
LANGUAGE["MANAGE_INFO"] = nil --ENGLISH: Information
LANGUAGE["MANAGE_COPYUSERNAME"] = nil --ENGLISH: Copy Username
LANGUAGE["MANAGE_COPYSTEAMID"] = nil --ENGLISH: Copy SteamID
LANGUAGE["MANAGE_COPYSTEAMID64"] = nil --ENGLISH: Copy SteamID64
LANGUAGE["MANAGE_COPYREASON"] = nil --ENGLISH: Copy Reason
LANGUAGE["MANAGE_OPENSTEAMPROFILE"] = nil --ENGLISH: Steam Profile

LANGUAGE["MANAGE_ALL"] = nil --ENGLISH: All
LANGUAGE["MANAGE_GOTOPAGE"] = nil --ENGLISH: What page would you like to go to?
LANGUAGE["MANAGE_ACTIONALL"] = nil --ENGLISH: You cannot perform this action on all players.

LANGUAGE["MANAGE_UPDATEBUTTON"] = "Atualizar lista negra"

LANGUAGE["MANAGE_DETAILS_QUARY"] = "Tem certeza de que deseja excluir esta lista negra?"

LANGUAGE["MANAGE_LOADMORE_BUTTON"] = nil --ENGLISH: Load More

LANGUAGE["MANAGE_EXTMGT_ERASEPLYDATA"] = nil --ENGLISH: Erase PlayerData
LANGUAGE["MANAGE_EXTMGT_SELECTPLY"] = nil --ENGLISH: Please select a player first.
LANGUAGE["MANAGE_EXTMGT_CONFIRM_1"] = nil --ENGLISH: Are you sure you want to delete all blacklists from this user?
LANGUAGE["MANAGE_EXTMGT_CONFIRM_2"] = nil --ENGLISH: Confirm that you want to delete all of this player's data.
LANGUAGE["MANAGE_EXTMGT_WRONGANSWER"] = nil --ENGLISH: Please enter the correct answer to erase data.

--TAGS: %Q = Math Question (Ex. 2 + 2)
LANGUAGE["MANAGE_EXTMGT_QUESTION"] = nil --ENGLISH: Please enter what %Q is below to erase data.

LANGUAGE["MANAGE_STATISTICS_TOTAL"] = nil --ENGLISH: Total Blacklists
LANGUAGE["MANAGE_STATISTICS_COMMON"] = nil --ENGLISH: Lista negra comum

LANGUAGE["MANAGE_UPDATEOCCURRED"] = nil --ENGLISH: A change occurred in this player's blacklists.
LANGUAGE["MANAGE_UPDATELIST"] = nil --ENGLISH: Do you wish to update the list?

--[[-------------------------------------------------------------------------
VGUI - Estatisticas
---------------------------------------------------------------------------]]

LANGUAGE["STATISTICS_ISSUED"] = "Total Questãod"
LANGUAGE["STATISTICS_REMOVED"] = "Total removido"
LANGUAGE["STATISTICS_COMMON"] = nil --ENGLISH: Lista negra comum
LANGUAGE["STATISTICS_TOP"] = "Top Blacklister"

LANGUAGE["MANAGE_STATISTICS_NONE"] = nil --ENGLISH: None

--[[-------------------------------------------------------------------------
TIME TYPES
---------------------------------------------------------------------------]]

LANGUAGE["EXPIRED"] = nil --ENGLISH: Expired
LANGUAGE["TIME_SECONDS"] = "Segundos"
LANGUAGE["TIME_MINUTES"] = "Minutos"
LANGUAGE["TIME_HOURS"] = "Horas"
LANGUAGE["TIME_DAYS"] = "Dias"
LANGUAGE["TIME_WEEKS"] = "Semanas"
LANGUAGE["TIME_MONTHS"] = "Meses"
LANGUAGE["TIME_YEARS"] = "Anos"
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
LANGUAGE["WARNING_ADDBL_FAIL"] = "Falha ao adicionar lista negra."
LANGUAGE["WARNING_REMOVEBL_FAIL"] = "Falha ao remover a lista negra."
LANGUAGE["WARNING_UPDATEBL_FAIL"] = "Falha na atualização da lista negra."
LANGUAGE["WARNING_READBLTABLE_FAIL"] = "Falha ao ler a tabela da lista negra."
LANGUAGE["WARNING_ERASEBLACKLISTS_FAIL"] = nil --ENGLISH: Failed to erase blacklists.
LANGUAGE["WARNING_GETBLPAGE_FAIL"] = nil --ENGLISH: Failed to load page of blacklists.

LANGUAGE["WARNING_ADDBL_SUCCESS"] = "Lista negra adicionada com sucesso."
LANGUAGE["WARNING_REMOVEBL_SUCCESS"] = "Lista negra removida com sucesso."
LANGUAGE["WARNING_UPDATEBL_SUCCESS"] = "Lista negra atualizada com êxito."
LANGUAGE["WARNING_READBLTABLE_SUCCESS"] = "Leia com sucesso a tabela da lista negra."
LANGUAGE["WARNING_ERASEBLACKLISTS_SUCCESS"] = nil --ENGLISH: Successfully erased blacklists.
LANGUAGE["WARNING_GETBLPAGE_SUCCESS"] = nil --ENGLISH: Successfully read page of blacklists.

LANGUAGE["WARNING_LOADPLAYER_FAIL"] = "Falha ao carregar o player."
LANGUAGE["WARNING_GETALLBL_NOTHINGTOREAD"] = nil --ENGLISH: There are no blacklists to load on this page.

LANGUAGE["WARNING_ERROR_MISSINGARGS"] = "Argumentos faltantes"
LANGUAGE["WARNING_ERROR_WRONGDATATYPE"] = "Tipo de dados errado"
LANGUAGE["WARNING_ERROR_INCORRECTSTEAMIdentidadeFORMAT"] = "Formato SteamIdentidade incorreto"
LANGUAGE["WARNING_ERROR_BLNOTEXIST"] = "Lista negra não existe"
LANGUAGE["WARNING_ERROR_INCORRECTBLFORMAT"] = "Formato de lista negra incorreto"
LANGUAGE["WARNING_ERROR_CONFIGNOTEXIST"] = nil --ENGLISH: Config-Identidade does not exist.
LANGUAGE["WARNING_ERROR_TYPENOTEXIST"] = nil --ENGLISH: Blacklist type does not exist
LANGUAGE["WARNING_ERROR_SQLERROR"] = nil --ENGLISH: MySQL/SQLite Error

--[[-------------------------------------------------------------------------
Blacklist specific translations.
---------------------------------------------------------------------------]]
LANGUAGE["BLACKLIST_GRAVGUN"] = "Você não está autorizado a usar a Gravity Gun devido a ser colocado na lista negra!"
LANGUAGE["BLACKLIST_TEAM"] = "Você não tem permissão para se tornar este trabalho devido à lista negra!"
LANGUAGE["BLACKLIST_OOC"] = "Você não está autorizado a usar o bate-papo OOC devido a ser colocado na lista negra!"
LANGUAGE["BLACKLIST_PHYSGUN"] = "Você não está autorizado a usar a Física Gun devido a ser na lista negra!"
LANGUAGE["BLACKLIST_PROPS"] = "Você não tem permissão para gerar adereços ou entidades devido à sua lista negra!"
LANGUAGE["BLACKLIST_TOOLGUN"] = "Você não está autorizado a usar o Tool Gun devido a ser colocado na lista negra!"
LANGUAGE["BLACKLIST_WEAPONS"] = "Você não é permitido usar as armas devido a ser colocado na lista negra!"
LANGUAGE["BLACKLIST_VEHICLES"] = "Você não tem permissão para conduzir veículos devido à lista negra!"
LANGUAGE["BLACKLIST_WIREMOD"] = nil --ENGLISH: You are not allowed to use Wiremod due to being blacklisted!
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
LANGUAGE["BLACKLIST_NLR"] = "Você precisa aguardar %T minutos antes de ser reprovado devido à lista negra!"

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