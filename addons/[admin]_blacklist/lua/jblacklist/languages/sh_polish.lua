local LANGUAGE = {}
LANGUAGE.Name = "Polish"
LANGUAGE.Author = "Kyo"
LANGUAGE.Version = "2.3.2"

--[[-------------------------------------------------------------------------
GENERAL
---------------------------------------------------------------------------]]
LANGUAGE["OUTDATED_LANG"] = "Ten język może nie być kompatybilny z wersją JBlacklist, którą aktualnie używasz!"

LANGUAGE["INFO_LOADINGDATA"] = "Ładowanie danych gracza."

LANGUAGE["INFO_NOTAUTHORIZED"] = "Nie masz wymaganej rangi, aby to zrobić."

--TAGS: %C = Command
LANGUAGE["BLACKLISTED_COMMAND_INFO"] = "Wpisz %C, aby pokazać więcej informacji."

--TAGS: %A = AdminName, %P = Targets separated by comma, %R = Reason, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_ADVERT"] = "Administrator %A dodał do blacklisty gracza (%P) za %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Target, %R = Reason, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_PERSONAL"] = "Zostałeś dodany na blackliste przez administratora %A za %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Target, %I = BlacklistID
LANGUAGE["REMOVED_ADVERT"] = "Administrator %A usunął gracza %P z blacklisty. (%I)"

--TAGS: %A = AdminName, %P = Target
LANGUAGE["ERASED_ADVERT"] = "Administrator %A wymazał dane gracza %P."

--TAGS: %B = Name of blacklist
LANGUAGE["BLACKLIST_EXPIRED"] = "Blacklista %B straciła ważność."

LANGUAGE["LOG_WARNING"] = "To zostanie zapisane w logach, aby uniknąć nadużyć."

--TAGS: %L = Length in minutes.
LANGUAGE["LENGTH_CHANGED"] = "Czas trwania blacklisty został zmieniony na %L minut, ze względu na ograniczony dostęp."

--[[-------------------------------------------------------------------------
VGUI - GENERAL
---------------------------------------------------------------------------]]

LANGUAGE["TITLE_ADMIN"] = "Panel Administratorski"
LANGUAGE["TITLE_OVERVIEW"] = "Przegląd Blacklisty"
LANGUAGE["TITLE_NOTIFICATION"] = "Powiadomienie"
LANGUAGE["TITLE_QUERY"] = "Potwierdź"
LANGUAGE["TITLE_STRINGREQUEST"] = "Wpisz"
LANGUAGE["TITLE_UPDATE"] = "Zaktualizuj"

LANGUAGE["CONFIRM"] = "Potwierdź"
LANGUAGE["CANCEL"] = "Anuluj"

LANGUAGE["OK"] = "OK"

LANGUAGE["ISSUEBUTTON"] = "Problem"
LANGUAGE["MANAGEBUTTON"] = "Zarządzanie"
LANGUAGE["STATSBUTTON"] = "Statystyki"

LANGUAGE["INPUTSTEAMID"] = "Wpisz SteamID"
LANGUAGE["INPUTSTEAMID_TITLE"] = "Dodaj SteamID"
LANGUAGE["INPUTSTEAMID_QUARY"] = "Wpisz SteamID, które chcesz dodać."
LANGUAGE["INPUTSTEAMID_INCORRECTFORMAT"] = "Niewłaściwy format SteamID!"
LANGUAGE["INPUTSTEAMID_ALREADYADDED"] = "Te SteamID zostało już dodane."

LANGUAGE["ENTER_SEARCHWORD"] = "Wpisz poszukiwane słowo..."

LANGUAGE["MULTISELECTOR_DONE"] = "Zrobione"

LANGUAGE["NOACCESS"] = "BRAK DOSTĘPU"

LANGUAGE["LOADING_DATA"] = "Ładowanie Danych"

LANGUAGE["LOADING_WAIT"] = "Wymagane dane są aktualnie ładowane, proszę chwilę poczekać..."

--[[-------------------------------------------------------------------------
VGUI - ISSUE TAB
---------------------------------------------------------------------------]]

LANGUAGE["ISSUE_TYPE"] = "Rodzaj"
LANGUAGE["ISSUE_TARGET"] = "Cel"
LANGUAGE["ISSUE_LENGTH"] = "Długość"
LANGUAGE["ISSUE_REASON"] = "Powód"

LANGUAGE["ISSUE_CHOOSE_TYPE"] = "Wybierz rodzaj Blacklisty"
LANGUAGE["ISSUE_CHOOSE_TARGET"] = "Wybierz cel"

LANGUAGE["ISSUE_SILENT"] = "Silent"
LANGUAGE["ISSUE_ISSUE"] = "Wydanie"

LANGUAGE["ISSUE_MISSING_TYPES"] = "Proszę wybrać przynajmniej jeden rodzaj przed wypuszczeniem blacklisty."
LANGUAGE["ISSUE_MISSING_TARGETS"] = "Proszę wybrać przynajmniej jeden cel przed wypuszczeniem blacklisty."

--[[-------------------------------------------------------------------------
VGUI - MANAGE TAB
---------------------------------------------------------------------------]]

LANGUAGE["MANAGE_DETAILSTITLE"] = "Detale Blacklisty"
LANGUAGE["MANAGE_MODIFYTITLE"] = "Zmodyfikuj Blackliste"

LANGUAGE["MANAGE_CHOOSE_PLAYER"] = "Wybierz gracza..."

LANGUAGE["MANAGE_ID"] = "ID"
LANGUAGE["MANAGE_USERNAME"] = "Nazwa gracza"
LANGUAGE["MANAGE_STEAMID"] = "SteamID"
LANGUAGE["MANAGE_TYPE"] = "Rodzaj"
LANGUAGE["MANAGE_REASON"] = "Powód"
LANGUAGE["MANAGE_DESCRIPTION"] = "Opis"
LANGUAGE["MANAGE_GIVENON"] = "Nadane dla"
LANGUAGE["MANAGE_TIMELEFT"] = "Wygasa za"
LANGUAGE["MANAGE_GIVENBY"] = "Nadane przez"
LANGUAGE["MANAGE_UPDATED"] = "Ostatnia Aktualizacja"

LANGUAGE["MANAGE_DETAILS"] = "Szczegóły"
LANGUAGE["MANAGE_MODIFY"] = "Modyfikuj"
LANGUAGE["MANAGE_REMOVE"] = "Usuń"
LANGUAGE["MANAGE_INFO"] = "Informacja"
LANGUAGE["MANAGE_COPYUSERNAME"] = "Skopiuj nazwę gracza"
LANGUAGE["MANAGE_COPYSTEAMID"] = "Skopiuj SteamID gracza"
LANGUAGE["MANAGE_COPYSTEAMID64"] = "Skopiuj SteamID64 gracza"
LANGUAGE["MANAGE_COPYREASON"] = "Skopiuj powód"
LANGUAGE["MANAGE_OPENSTEAMPROFILE"] = "Profil Steam"

LANGUAGE["MANAGE_ALL"] = "Wszystko"
LANGUAGE["MANAGE_GOTOPAGE"] = "Do której strony chciałbyś trafić?"
LANGUAGE["MANAGE_ACTIONALL"] = "Nie możesz przeprowadzić tej akcji na wszystkich graczach."

LANGUAGE["MANAGE_UPDATEBUTTON"] = "Zaktualizuj Blackliste"

LANGUAGE["MANAGE_DETAILS_QUARY"] = "Czy jesteś pewien że chcesz usunąć tę blacklistę?"

LANGUAGE["MANAGE_LOADMORE_BUTTON"] = "Wczytaj więcej"

LANGUAGE["MANAGE_EXTMGT_ERASEPLYDATA"] = "Wyczyść dane gracza"
LANGUAGE["MANAGE_EXTMGT_SELECTPLY"] = "Proszę wybrać gracza."
LANGUAGE["MANAGE_EXTMGT_CONFIRM_1"] = "Czy jesteś pewien że chcesz zdjąć wszelkie blacklisty z tego gracza?"
LANGUAGE["MANAGE_EXTMGT_CONFIRM_2"] = "Potwierdź że chcesz usunąć wszystkie dane tego gracza."
LANGUAGE["MANAGE_EXTMGT_WRONGANSWER"] = "Proszę wpisać prawidłową odpowiedź, aby wyczyścić dane."

--TAGS: %Q = Math Question (Ex. 2 + 2)
LANGUAGE["MANAGE_EXTMGT_QUESTION"] = "Proszę odpowiedzieć na to pytanie %Q, aby wyczyścić dane."

LANGUAGE["MANAGE_STATISTICS_TOTAL"] = "Ogólne Blacklisty"
LANGUAGE["MANAGE_STATISTICS_COMMON"] = "Podstawowa Blacklista"

LANGUAGE["MANAGE_UPDATEOCCURRED"] = "Zmiana pojawiła się w tych blacklistach gracza."
LANGUAGE["MANAGE_UPDATELIST"] = "Czy życzysz sobie zaktualizować tą listę?"

--[[-------------------------------------------------------------------------
VGUI - Statistics
---------------------------------------------------------------------------]]

LANGUAGE["STATISTICS_ISSUED"] = "Ogólnie wydano"
LANGUAGE["STATISTICS_REMOVED"] = "Ogólnie usunięto"
LANGUAGE["STATISTICS_COMMON"] = "Pospolita Blacklista"
LANGUAGE["STATISTICS_TOP"] = "Największa ilość wydanych"

LANGUAGE["MANAGE_STATISTICS_NONE"] = "Nic"

--[[-------------------------------------------------------------------------
TIME TYPES
---------------------------------------------------------------------------]]

LANGUAGE["EXPIRED"] = "Wygasł"
LANGUAGE["TIME_SECONDS"] = "Sekund"
LANGUAGE["TIME_MINUTES"] = "Minut"
LANGUAGE["TIME_HOURS"] = "Godzin"
LANGUAGE["TIME_DAYS"] = "Dni"
LANGUAGE["TIME_WEEKS"] = "Tygodni"
LANGUAGE["TIME_MONTHS"] = "Miesięcy"
LANGUAGE["TIME_YEARS"] = "Lat"
LANGUAGE["TIME_PERMANENT"] = "Nigdy"

--TAGS: %Y = Years (Number), %M = Months (Number)
LANGUAGE["FORMATTEDTIME_YM"] = "%Y lat i %M miesięcy"

--TAGS: %M = Months (Number), %D = Days (Number)
LANGUAGE["FORMATTEDTIME_MD"] = "%M miesięcy i %D dni"

--TAGS: %D = Days (Number), %H = Hours (Number)
LANGUAGE["FORMATTEDTIME_DH"] = "%D dni i %H godzin"

--TAGS: %H = Hours (Number), %M = Minutes (Number)
LANGUAGE["FORMATTEDTIME_HM"] = "%H godzin i %M minut"

--TAGS: %M = Minutes (Number), %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_MS"] = "%M minut i %S sekund"

--TAGS: %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_S"] = "%S sekund"

--[[-------------------------------------------------------------------------
Warning Messages.
---------------------------------------------------------------------------]]
LANGUAGE["WARNING_ADDBL_FAIL"] = "Nie udało się dodać blacklisty."
LANGUAGE["WARNING_REMOVEBL_FAIL"] = "Nie udało się usunąć blacklistę."
LANGUAGE["WARNING_UPDATEBL_FAIL"] = "Nie udało się zaktualizować blacklistę."
LANGUAGE["WARNING_READBLTABLE_FAIL"] = "Nie udało się odczytać tabelę z blacklistami."
LANGUAGE["WARNING_ERASEBLACKLISTS_FAIL"] = "Nie udało się wyczyścić blacklistę."
LANGUAGE["WARNING_GETBLPAGE_FAIL"] = "Nie udało się odczytać stronę z blacklistami."

LANGUAGE["WARNING_ADDBL_SUCCESS"] = "Pomyślnie dodano blacklistę."
LANGUAGE["WARNING_REMOVEBL_SUCCESS"] = "Pomyślnie usunięto blacklistę."
LANGUAGE["WARNING_UPDATEBL_SUCCESS"] = "Pomyślnie zaktualizowano blacklistę."
LANGUAGE["WARNING_READBLTABLE_SUCCESS"] = "Pomyślnie odczytano tabelę z blacklistami."
LANGUAGE["WARNING_ERASEBLACKLISTS_SUCCESS"] = "Pomyślnie wyczyszczono blacklistę."
LANGUAGE["WARNING_GETBLPAGE_SUCCESS"] = "Pomyślnie odczytano stronę z blacklistami."

LANGUAGE["WARNING_LOADPLAYER_FAIL"] = "Nie udało się wczytać gracza."
LANGUAGE["WARNING_GETALLBL_NOTHINGTOREAD"] = "Nie ma żadnej blacklisty, które można wczytać na tej stronie."

LANGUAGE["WARNING_ERROR_MISSINGARGS"] = "Brakują argumenty"
LANGUAGE["WARNING_ERROR_WRONGDATATYPE"] = "Zły rodzaj danych"
LANGUAGE["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] = "Niewłaściwy format SteamID"
LANGUAGE["WARNING_ERROR_BLNOTEXIST"] = "Ta Blacklista nie istnieje"
LANGUAGE["WARNING_ERROR_INCORRECTBLFORMAT"] = "Niewłaściwy format Blacklisty."
LANGUAGE["WARNING_ERROR_CONFIGNOTEXIST"] = "Config-ID nie istnieje."
LANGUAGE["WARNING_ERROR_TYPENOTEXIST"] = "Taki rodzaj Blacklisty nie istnieje."
LANGUAGE["WARNING_ERROR_SQLERROR"] = "Błąd MySQL/SQLite"

--[[-------------------------------------------------------------------------
Blacklist specific translations.
---------------------------------------------------------------------------]]
LANGUAGE["BLACKLIST_GRAVGUN"] = "Nie możesz korzystać z Gravity Gun'a, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_TEAM"] = "Nie możesz zmienić się na tę pracę, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_OOC"] = "Nie możesz korzystać z czatu OOC, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_PHYSGUN"] = "Nie możesz korzystać z Physic Gun'a, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_PROPS"] = "Nie możesz stawiać żadnych obiektów, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_TOOLGUN"] = "Nie możesz korzystać z Tool Gun'a, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_WEAPONS"] = "Nie możesz korzystać z broni, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_VEHICLES"] = "Nie możesz kierować pojazdem, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_WIREMOD"] = "Nie możesz korzystać z WireMod'a, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_TOOL"] = "Nie możesz korzystać z tego narzędzia, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_BUYAMMO"] = "Nie możesz zakupić amunicji, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_BUYENTITY"] = "Nie możesz zakupić przedmioty(entities), ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_BUYPISTOL"] = "Nie możesz zakupić broni, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_BUYSHIPMENT"] = "Nie możesz zakupić zapasów(shipments), ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_CANADVERT"] = "Nie możesz korzystać z komendy /advert, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_LOCKPICK"] = "Nie możesz korzystać z lockpick'a, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_CINEMA_REQUESTVIDEO"] = "Nie możesz dodawać filmów do kolejki, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_TEXTCHAT"] = "Nie możesz korzystać z czatu poza komendami, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_CAMERASWEP"] = "Nie możesz korzystać z kamery, ponieważ znajdujesz się na blackliście!"
LANGUAGE["BLACKLIST_VOICECHAT"] = "Nie możesz korzystać z czatu głosowego, ponieważ znajdujesz się na blackliście!"

--%T = Time
LANGUAGE["BLACKLIST_NLR"] = "Musisz odczekać %T minut, aby móc się odrodzić, ponieważ znajdujesz się na blackliście."

--%T = Time
LANGUAGE["BLACKLIST_NLR_RESPAWN"] = "Możesz się pojawić dopiero za %T."

--[[-------------------------------------------------------------------------
Blacklist Descriptions
---------------------------------------------------------------------------]]

--%T = FORMATTED TIME
LANGUAGE["BLACKLIST_EXPIRESIN"] = "Wygasa za: %T"

LANGUAGE["BLACKLISTDESC_DarkRPBuyAmmo"] = "Pozbaw gracza możliwości zakupu amunicji w trybie DarkRP."
LANGUAGE["BLACKLISTDESC_DarkRPBuyPistol"] = "Pozbaw gracza możliwości zakupu broni w trybie DarkRP."
LANGUAGE["BLACKLISTDESC_DarkRPBuyEntity"] = "Pozbaw gracza możliwości zakupu przedmiotów(entities) w trybie DarkRP."
LANGUAGE["BLACKLISTDESC_DarkRPBuyShipment"] = "Pozbaw gracza możliwości zakupu zapasów(shipments) w trybie DarkRP."
LANGUAGE["BLACKLISTDESC_DarkRPAdvert"] = "Pozbaw gracza korzystania z komendy /advert na trybie DarkRP."
LANGUAGE["BLACKLISTDESC_DarkRPJobs"] = "Pozbaw gracza możliwości zmiany na ustaloną pracę w trybie DarkRP."
LANGUAGE["BLACKLISTDESC_DarkRPOOC"] = "Pozbaw gracza możliwości korzystania z czatu OOC w trybie DarkRP."
LANGUAGE["BLACKLISTDESC_DarkRPLockpick"] = "Pozbaw gracza możliwości korzystania z lockpick'a na trybie DarkRP."
LANGUAGE["BLACKLISTDESC_GravityGun"] = "Pozbaw gracza możliwości korzystania z Gravity Gun'a."
LANGUAGE["BLACKLISTDESC_PhysGun"] = "Pozbaw gracza możliwości korzystania z Physic Gun'a."
LANGUAGE["BLACKLISTDESC_ToolGun"] = "Pozbaw gracza możliwości korzystania z Tool Gun'a."
LANGUAGE["BLACKLISTDESC_NLR"] = "Pozbaw gracza możliwości natychmiastowego odrodzenia się po zginięciu."
LANGUAGE["BLACKLISTDESC_Props"] = "Pozbaw gracza możliwości stawiania wszelkich obiektów."
LANGUAGE["BLACKLISTDESC_Tools"] = "Pozbaw gracza możliwości użycia wybranego narzędzia."
LANGUAGE["BLACKLISTDESC_Vehicles"] = "Pozbaw gracza możliwości kierowania pojazdem."
LANGUAGE["BLACKLISTDESC_Weapons"] = "Pozbaw gracza możliwości użycia ustalonych broni."
LANGUAGE["BLACKLISTDESC_WireMod"] = "Pozbaw gracza możliwości użycia narzędzia Wiremod."
LANGUAGE["BLACKLISTDESC_CINEMA_REQUESTVIDEO"] = "Pozbaw gracza możliwości dodawania filmów do kolejki w trybie Cinema."
LANGUAGE["BLACKLISTDESC_TextChat"] = "Pozbaw gracza możliwości pisania na czacie, z wyjątkiem komend."
LANGUAGE["BLACKLISTDESC_CAMERASWEP"] = "Pozbaw gracza możliwości użycia kamery(SWEP)."
LANGUAGE["BLACKLISTDESC_VOICECHAT"] = "Pozbaw gracza możliwości korzystania z mikrofonu."

--[[-------------------------------------------------------------------------
REGISTER THE BLACKLIST.
---------------------------------------------------------------------------]]

--Register the language.
jBlacklist.RegisterLang(LANGUAGE)