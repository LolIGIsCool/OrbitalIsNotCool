// Init Module
local MODULE = MODULE or RK.Modules:Get( "Medals" )

// Module name
MODULE.name = "Medals"
// Module author
MODULE.author = "Bunnings"
// Module description
MODULE.description = [[
	Medals, WIP - Kassius has asked me to make this because why not. - Bunnings
]]

-- Save / load data for the medals, just use GetVar / SetVar like everything else. Will be a table of medals.

-- Find what is being displayed
-- Find out how its being displayed
-- May need to network it to players??? man who tf knows this shit

--[[

All players - OFFLINE SUPPORT NEEDED!!!!
Drop down menu of medal, - which one is being selected
Select whos applying - default to current steamID
Comment - Why it was given

]]--


-- offline support gonna be a bitch because fuck you kirby and your goofy ahh util.TableToJSON ahh db ahh 

-- query ( SELECT * from DB )
-- JSONToTable 
-- get the medals and add to a table
--- on new medal update current table as apose to rerunning bc INTENSIVE QUERY!!!
-- Maybe convert to another DB table? therefore less strain and just use DataObject.id for key? then yeah? man why am i doing this at 1:46AM