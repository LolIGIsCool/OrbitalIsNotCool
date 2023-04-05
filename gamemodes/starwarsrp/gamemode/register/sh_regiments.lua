RK = RK or {}

-- Create new MetaTable via register module
RK.Regiment = RK.Register:New( {} )
-- On register function, Called after a new entry
function RK.Regiment:OnRegister( data )
	
	local enum = string.gsub( data.name:upper(), " ", "_" )

	_G[ "REGIMENT_" .. enum ] = data.team_num

	timer.Simple( 0.2, function() self:GetFlags( data.team_num ) end )

	return data
end

--
function RK.Regiment:GetFlags( regiment )
	local reg = self:GetByMember( "team_num", regiment )

	if !reg then return {} end
	if !reg.flags then return {} end
	if reg._sortedflags then return reg._sortedflags end

	local flags = {}
	for k, v in pairs( string.Explode( ";", reg.flags ) ) do
		flags[ v ] = true
	end

	reg._sortedflags = flags
	return reg._sortedflags
end

function RK.Regiment:GetByID( regiment )
	return self:GetByMember( "team_num", regiment )
end

-- Add a new entry to the Regiment table with the name "Stormtrooper Corp".
RK.Regiment:Add( "Recruit", {    
    team_num = 1, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/player/tiki/white.mdl", -- The regiment model
    skin = 0, -- The regiment skin

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 50, -- Init runspeed
    walkspeed = 20, -- Init walkspeed
    prefix = "",

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = {
		[ "gm_construct" ] = Vector( 43, -3012, -5520 ), -- Spawn position for the regiment
	},
    ranks = {
        [1] = { name = "Recruit", skin = 0 }
    },

    weapons = {
        "rw_sw_trd_e11_noscope",
        --"climb_swep2"
        "weapon_empty_hands"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
    
RK.Regiment:Add( "6th Infantry", {
    team_num = 2, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/nada/RogueOneTK.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "6th",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( 371, -2435, -5504 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Private" , cl = 1},
        [2] = { name = "Private First Class" , cl = 1},
        [3] = { name = "Lance Corporal" , cl = 1},
		[4] = { name = "Junior Corporal" , cl = 1},
        [5] = { name = "Corporal" , cl = 1},
        [6] = { name = "Senior Corporal" , cl = 1},
        [7] = { name = "Sergeant" , cl = 2},
        [8] = { name = "Staff Sergeant" , cl = 2},
        [9] = { name = "Master Sergeant" , cl = 2},
        [10] = { name = "Sergeant Major" , cl = 2},
        [11] = { name = "Junior Warrant Officer" , cl = 3},
        [12] = { name = "Warrant Officer" , cl = 2},
        [13] = { name = "Chief Warrant Officer" , cl = 3},
        [14] = { name = "Second Lieutenant" , cl = 3},
        [15] = { name = "Lieutenant" , cl = 3},
        [16] = { name = "Captain" , cl = 3},
        [17] = { name = "Major" , cl = 4},
        [18] = { name = "Lieutenant Colonel" , cl = 4},
        [19] = { name = "Colonel" , cl = 4}
    },

    weapons = {
        "rw_sw_e11",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} ) 
   
RK.Regiment:Add( "Shock Trooper", {
    team_num = 3, -- Unique

    colour = Color(255, 0, 0), -- The regiment colour
    model = "models/nada/RogueOneShock.mdl", -- The regiment model
    skin = 0, -- The regiment skin

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed
    prefix = "SK",

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -818, -2745, -5376 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Private" , cl = 1},
        [2] = { name = "Private First Class" , cl = 1},
        [3] = { name = "Lance Corporal" , cl = 1},
		[4] = { name = "Junior Corporal" , cl = 1},
        [5] = { name = "Corporal" , cl = 1},
        [6] = { name = "Senior Corporal" , cl = 1},
        [7] = { name = "Sergeant" , cl = 2},
        [8] = { name = "Staff Sergeant" , cl = 2},
        [9] = { name = "Master Sergeant" , cl = 2},
        [10] = { name = "Sergeant Major" , cl = 2},
        [11] = { name = "Junior Warrant Officer" , cl = 3},
        [12] = { name = "Warrant Officer" , cl = 2},
        [13] = { name = "Chief Warrant Officer" , cl = 3},
        [14] = { name = "Second Lieutenant" , cl = 3},
        [15] = { name = "Lieutenant" , cl = 3},
        [16] = { name = "Captain" , cl = 3},
        [17] = { name = "Major" , cl = 4},
        [18] = { name = "Lieutenant Colonel" , cl = 4},
        [19] = { name = "Colonel" , cl = 4}
    },

    weapons = {
        "rw_sw_e11",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )

RK.Regiment:Add( "501st Trooper", {
    team_num = 4, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/nada/RogueOneTKMedic.mdl", -- The regiment model
    skin = 0, -- The regiment skin

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed
    prefix = "501st",

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -2150, -3227, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Private" , cl = 1},
        [2] = { name = "Private First Class" , cl = 1},
        [3] = { name = "Lance Corporal" , cl = 1},
		[4] = { name = "Junior Corporal" , cl = 1},
        [5] = { name = "Corporal" , cl = 1},
        [6] = { name = "Senior Corporal" , cl = 1},
        [7] = { name = "Sergeant" , cl = 2},
        [8] = { name = "Staff Sergeant" , cl = 2},
        [9] = { name = "Master Sergeant" , cl = 2},
        [10] = { name = "Sergeant Major" , cl = 2},
        [11] = { name = "Junior Warrant Officer" , cl = 3},
        [12] = { name = "Warrant Officer" , cl = 2},
        [13] = { name = "Chief Warrant Officer" , cl = 3},
        [14] = { name = "Second Lieutenant" , cl = 3},
        [15] = { name = "Lieutenant" , cl = 3},
        [16] = { name = "Captain" , cl = 3},
        [17] = { name = "Major" , cl = 4},
        [18] = { name = "Lieutenant Colonel" , cl = 4},
        [19] = { name = "Colonel" , cl = 4}
    },
	
	classes = {
	["IC"] = {name = "IC", model = "models/nada/shoretrooper.mdl", weapons = {}, health = 100, armour = 100, flags = "r1;weapon", },
	["Purge"] = {name = "Purge", model = "models/nada/shoretrooper.mdl", weapons = {}, health = 100, armour = 100, flags = "r1;weapon", },
	},

    weapons = {
        "rw_sw_e11",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard",
        "weapon_bactanade",
        "weapon_bactainjector"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
    
RK.Regiment:Add( "212th Trooper", {
    team_num = 5, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/nada/RogueOneNova.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "212th",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -9397, 522, 96 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Private" , cl = 1},
        [2] = { name = "Private First Class" , cl = 1},
        [3] = { name = "Lance Corporal" , cl = 1},
		[4] = { name = "Junior Corporal" , cl = 1},
        [5] = { name = "Corporal" , cl = 1},
        [6] = { name = "Senior Corporal" , cl = 1},
        [7] = { name = "Sergeant" , cl = 2},
        [8] = { name = "Staff Sergeant" , cl = 2},
        [9] = { name = "Master Sergeant" , cl = 2},
        [10] = { name = "Sergeant Major" , cl = 2},
        [11] = { name = "Junior Warrant Officer" , cl = 3},
        [12] = { name = "Warrant Officer" , cl = 2},
        [13] = { name = "Chief Warrant Officer" , cl = 3},
        [14] = { name = "Second Lieutenant" , cl = 3},
        [15] = { name = "Lieutenant" , cl = 3},
        [16] = { name = "Captain" , cl = 3},
        [17] = { name = "Major" , cl = 4},
        [18] = { name = "Lieutenant Colonel" , cl = 4},
        [19] = { name = "Colonel" , cl = 4}
    },

	classes = {
	["AIR"] = {name = "AIR", model = "models/nada/shoretrooper.mdl", weapons = {}, health = 100, armour = 100, flags = "r1;weapon", },
    ["JUG"] = {name = "JUG", model = "models/nada/shoretrooper.mdl", weapons = {}, health = 100, armour = 100, flags = "r1;weapon", },
	},

    weapons = {
        "rw_sw_e11",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
    
RK.Regiment:Add( "81st Trooper", {
    team_num = 6, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/halves/arcconcept/arcblank.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "81st",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -1831, -449, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Private" , cl = 1},
        [2] = { name = "Private First Class" , cl = 1},
        [3] = { name = "Lance Corporal" , cl = 1},
		[4] = { name = "Junior Corporal" , cl = 1},
        [5] = { name = "Corporal" , cl = 1},
        [6] = { name = "Senior Corporal" , cl = 1},
        [7] = { name = "Sergeant" , cl = 2},
        [8] = { name = "Staff Sergeant" , cl = 2},
        [9] = { name = "Master Sergeant" , cl = 2},
        [10] = { name = "Sergeant Major" , cl = 2},
        [11] = { name = "Junior Warrant Officer" , cl = 3},
        [12] = { name = "Warrant Officer" , cl = 2},
        [13] = { name = "Chief Warrant Officer" , cl = 3},
        [14] = { name = "Second Lieutenant" , cl = 3},
        [15] = { name = "Lieutenant" , cl = 3},
        [16] = { name = "Captain" , cl = 3},
        [17] = { name = "Major" , cl = 4},
        [18] = { name = "Lieutenant Colonel" , cl = 4},
        [19] = { name = "Colonel" , cl = 4}
    },

	classes = {
	["MED"] = {name = "MED", model = "models/nada/shoretrooper.mdl", weapons = {}, health = 100, armour = 100, flags = "r1;weapon", },
	["ART"] = {name = "ART", model = "models/nada/shoretrooper.mdl", weapons = {}, health = 100, armour = 100, flags = "r1;weapon", },
	},

    weapons = {
        "rw_sw_e11",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
    
RK.Regiment:Add( "Imperial High Command", {
    team_num = 7, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/nada/pms/male/army.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "IHC",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon;Booking;DefconAccess", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -9110, 1682, 96 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Brigadier", cl = 5, branch = "Army" },
        [2] = { name = "Commodore", cl = 5, branch = "Navy" },
        [3] = { name = "Assistant Bureau Chief", cl = 5, branch = "Security" },
        [4] = { name = "Major General", cl = 5, branch = "Army" },
        [5] = { name = "Rear Admiral", cl = 5, branch = "Navy" },
        [6] = { name = "Buraeu Chief", cl = 5, branch = "Security" },
        [7] = { name = "Lieutenant General", cl = 5, branch = "Army" },
        [8] = { name = "Vice Admiral", cl = 5, branch = "Navy" },
        [9] = { name = "Deputy Director", cl = 5, branch = "Security" },
        [10] = { name = "General", cl = 5, branch = "Army" },
        [11] = { name = "Admiral", cl = 5, branch = "Navy" },
        [12] = { name = "Director", cl = 5, branch = "Security" },
        [13] = { name = "Grand General", cl = 6, branch = "Army" },
        [14] = { name = "Grand Admiral", cl = 6, branch = "Navy" },
        [15] = { name = "ISO Directorate", cl = 6, branch = "Security" },
        
        
        
        --[[[2] = { name = "Major General" },
        [3] = { name = "Lieutenant General" },
        [4] = { name = "General" },
        [5] = { name = "Grand General", skin = 0, model = "models/nada/pms/male/warlord.mdl" }]]--
    },

    weapons = {
        "rw_sw_e11",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
  
RK.Regiment:Add( "Imperial Navy", {
    team_num = 8, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/nada/pms/male/Naval_Officer.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "Navy",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon;Booking;DefconAccess", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -9336, -663, 416 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Cadet" , cl = 1},
        [2] = { name = "Crewman" , cl = 1},
        [3] = { name = "Able Crewman" , cl = 1},
		[4] = { name = "Senior Crewman" , cl = 1},
        [5] = { name = "Master Crewman" , cl = 1},
        [6] = { name = "Leading Crewman" , cl = 1},
        [7] = { name = "Petty Officer" , cl = 2},
        [8] = { name = "Chief Petty Officer" , cl = 2},
        [9] = { name = "Senior Chief Petty Officer" , cl = 2},
        [10] = { name = "Master Chief Petty Officer" , cl = 2},
        [11] = { name = "Junior Midshipman" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl"},
        [12] = { name = "Midshipman" , cl = 2, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [13] = { name = "Ensign" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [14] = { name = "Junior Lieutenant" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [15] = { name = "Lieutenant" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [16] = { name = "Lieutenant Commander" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [17] = { name = "Commander" , cl = 4, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [18] = { name = "Captain" , cl = 4, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [19] = { name = "Line Captain" , cl = 4, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
    },
	
	--[[ranks = {
        [1] = { name = "Junior Crewman" },
        [2] = { name = "Crewman" },
        [3] = { name = "Able Crewman" },
        [4] = { name = "Senior Crewman" },
        [5] = { name = "Leading Crewman" },
        [6] = { name = "Petty Officer" },
        [7] = { name = "Chief Petty Officer" },
        [8] = { name = "Senior Chief Petty Officer" },
        [9] = { name = "Master Chief Petty Officer" },
        [10] = { name = "Junior Midshipman", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [11] = { name = "Midshipman", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [12] = { name = "Senior Midshipman", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [13] = { name = "Ensign", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [14] = { name = "Junior Lieutenant", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [15] = { name = "Lieutenant", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [16] = { name = "Lieutenant Commander", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [17] = { name = "Commander", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [18] = { name = "Captain", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [19] = { name = "Commodore", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [20] = { name = "Rear Admiral", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [21] = { name = "Vice Admiral", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [22] = { name = "Admiral", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [23] = { name = "High Admiral", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [24] = { name = "Grand Admiral", skin = 0, model = "models/nada/Thrawn.mdl" }
    },]]--

    weapons = {
        "rw_sw_e11",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
    
RK.Regiment:Add( "Imperial Pilots", {
    team_num = 9, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/nada/tie_pilot.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "Pilot",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( 3957, -309, -5680 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Flight Cadet" , cl = 1},
        [2] = { name = "Flight Specalist" , cl = 1},
        [3] = { name = "Flight Lance Corporal" , cl = 1},
		[4] = { name = "Junior Flight Corporal" , cl = 1},
        [5] = { name = "Flight Corporal" , cl = 1},
        [6] = { name = "Senior Flight Corporal" , cl = 1},
        [7] = { name = "Flight Sergeant" , cl = 2},
        [8] = { name = "Flight Chief" , cl = 2},
        [9] = { name = "Senior Flight Chief" , cl = 2},
        [10] = { name = "Master Flight Chief" , cl = 2},
        [11] = { name = "Junior Flight Officer" , cl = 3},
        [12] = { name = "Flight Officer" , cl = 2},
        [13] = { name = "Ensign" , cl = 3},
        [14] = { name = "Junior Lieutenant" , cl = 3},
        [15] = { name = "Lieutenant" , cl = 3},
        [16] = { name = "Lieutenant Commander" , cl = 3},
        [17] = { name = "Commander" , cl = 4},
        [18] = { name = "Captain" , cl = 4},
        [19] = { name = "Line Captain" , cl = 4}
    },

    weapons = {
        "rw_sw_rk3",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
    
	
RK.Regiment:Add( "Imperial Auxillery Corps", {
    team_num = 10, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/nada/pms/male/Naval_Officer.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "Navy",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon;Booking;DefconAccess", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -9336, -663, 416 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Cadet" , cl = 1},
        [2] = { name = "Crewman" , cl = 1},
        [3] = { name = "Able Crewman" , cl = 1},
		[4] = { name = "Senior Crewman" , cl = 1},
        [5] = { name = "Master Crewman" , cl = 1},
        [6] = { name = "Leading Crewman" , cl = 1},
        [7] = { name = "Petty Officer" , cl = 2},
        [8] = { name = "Chief Petty Officer" , cl = 2},
        [9] = { name = "Senior Chief Petty Officer" , cl = 2},
        [10] = { name = "Master Chief Petty Officer" , cl = 2},
        [11] = { name = "Junior Midshipman" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl"},
        [12] = { name = "Midshipman" , cl = 2, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [13] = { name = "Ensign" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [14] = { name = "Junior Lieutenant" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [15] = { name = "Lieutenant" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [16] = { name = "Lieutenant Commander" , cl = 3, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [17] = { name = "Commander" , cl = 4, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [18] = { name = "Captain" , cl = 4, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [19] = { name = "Line Captain" , cl = 4, skin = 0, model = "models/nada/pms/male/admiral.mdl" },
    },
	
	--[[ranks = {
        [1] = { name = "Junior Crewman" },
        [2] = { name = "Crewman" },
        [3] = { name = "Able Crewman" },
        [4] = { name = "Senior Crewman" },
        [5] = { name = "Leading Crewman" },
        [6] = { name = "Petty Officer" },
        [7] = { name = "Chief Petty Officer" },
        [8] = { name = "Senior Chief Petty Officer" },
        [9] = { name = "Master Chief Petty Officer" },
        [10] = { name = "Junior Midshipman", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [11] = { name = "Midshipman", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [12] = { name = "Senior Midshipman", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [13] = { name = "Ensign", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [14] = { name = "Junior Lieutenant", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [15] = { name = "Lieutenant", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [16] = { name = "Lieutenant Commander", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [17] = { name = "Commander", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [18] = { name = "Captain", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [19] = { name = "Commodore", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [20] = { name = "Rear Admiral", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [21] = { name = "Vice Admiral", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [22] = { name = "Admiral", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [23] = { name = "High Admiral", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [24] = { name = "Grand Admiral", skin = 0, model = "models/nada/Thrawn.mdl" }
    },]]--

    weapons = {
        "rw_sw_e11",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
	
	
	
--[[[RK.Regiment:Add( "Government", {
    team_num = 12, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/nada/pms/male/OperationsMajor.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -8822, 380, 416 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Administrative Assistant", skin = 0 },
        [2] = { name = "Under Clerk", skin = 0 },
        [3] = { name = "Clerk", skin = 0 },
        [4] = { name = "Senior Clerk", skin = 0 },
        [5] = { name = "Principal Clerk", skin = 0 },
        [6] = { name = "Prefect", skin = 0 },
        [7] = { name = "Legate", skin = 0 },
        [8] = { name = "Inspector", skin = 0 },
        [9] = { name = "Chief Inspector", skin = 0 },
        [10] = { name = "Staff Adjutant", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [11] = { name = "Deputy Administrator", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [12] = { name = "Administrator", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [13] = { name = "Sector Adjutant", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [14] = { name = "Superintendent", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [15] = { name = "Chief Superintendent", skin = 0, model = "models/nada/pms/male/admiral.mdl" },
        [16] = { name = "Sector Magistrate", skin = 0, model = "models/nada/pms/male/Clerk.mdl" },
        [17] = { name = "Deputy Chief of Staff", skin = 0, model = "models/nada/pms/male/Clerk.mdl" },
        [18] = { name = "Chief of Staff", skin = 0, model = "models/nada/pms/male/Clerk.mdl" },
        [19] = { name = "Vice Minister", skin = 0, model = "models/nada/pms/male/moff.mdl" },
        [20] = { name = "Adjutant General", skin = 0, model = "models/nada/pms/male/moff.mdl" },
        [21] = { name = "Lieutenant Governor", skin = 0, model = "models/nada/pms/male/moff.mdl" },
        [22] = { name = "Governor", skin = 0, model = "models/nada/pms/male/moff.mdl" },
        [23] = { name = "Governor General", skin = 0, model = "models/nada/pms/male/isb.mdl" },
        [24] = { name = "Grand Moff", skin = 0, model = "models/nada/WilhuffTarkin.mdl" }
                
    },

    weapons = {
        "rw_sw_dt29",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )]]--
    
RK.Regiment:Add( "Imperial Security Bureau", {
    team_num = 11, -- Unique

    colour = Color(100, 99, 78), -- The regiment colour
    model = "models/nada/pms/male/agent.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "ISB",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon;DefconAccess;Booking", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( 479, -4470, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Probitionary Operative", cl = 1 },
        [2] = { name = "Operative", cl = 2 },
        [3] = { name = "Senior Operative", cl = 2  },
        [4] = { name = "Master Operative", cl = 2  },
        [5] = { name = "Junior Agent", cl = 2  },
        [6] = { name = "Agent", cl = 2 , skin = 0, model = "models/nada/pms/male/Operative.mdl" },
        [7] = { name = "Senior Agent", cl = 2 , skin = 0, model = "models/nada/pms/male/Operative.mdl" },
        [8] = { name = "Lead Agent", cl = 3 , skin = 0, model = "models/nada/pms/male/Operative.mdl" },
        [9] = { name = "Junior Lieutenant", cl = 3 , skin = 0, model = "models/nada/pms/male/Operative.mdl" },
        [10] = { name = "Lieutenant", cl = 3 , skin = 0, model = "models/nada/pms/male/Operative.mdl" },
        [11] = { name = "Captain", cl = 3 , skin = 0, model = "models/nada/pms/male/isb.mdl" },
        [12] = { name = "Major", cl = 4 , skin = 0, model = "models/nada/pms/male/isb.mdl" },
        [13] = { name = "Assistant Colonel", cl = 4 , skin = 0, model = "models/nada/pms/male/isb.mdl" },
        [14] = { name = "Colonel", cl = 4 , skin = 0, model = "models/nada/pms/male/isb.mdl" },
        [15] = { name = "Assistant Chief", cl = 4 , skin = 0, model = "models/nada/pms/male/isb.mdl" },
        [16] = { name = "Chief", cl = 4 , skin = 0, model = "models/nada/pms/male/isb.mdl" },
        [17] = { name = "Bureau Chief", cl = 4 , skin = 0, model = "models/nada/pms/male/isb.mdl" },
        [18] = { name = "Deputy Director", cl = 4 , skin = 0, model = "models/nada/pms/male/isb.mdl" },
        [19] = { name = "Director", cl = 4 , skin = 0, model = "models/nada/OrsonKrennic.mdl" },
        [20] = { name = "Chairman", cl = 5 , skin = 0, model = "models/nada/pms/male/isb.mdl" }
    },

    weapons = {
        "rw_sw_e11",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )

RK.Regiment:Add( "Death Trooper", {
    team_num = 12, -- Unique

    colour = Color(10, 10, 10), -- The regiment colour
    model = "models/nada/deathtrooper.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "DT",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( 342, -2209, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Private" , cl = 1},
        [2] = { name = "Private First Class" , cl = 1},
        [3] = { name = "Lance Corporal" , cl = 1},
		[4] = { name = "Junior Corporal" , cl = 1},
        [5] = { name = "Corporal" , cl = 1},
        [6] = { name = "Senior Corporal" , cl = 1},
        [7] = { name = "Sergeant" , cl = 2},
        [8] = { name = "Staff Sergeant" , cl = 2},
        [9] = { name = "Master Sergeant" , cl = 2},
        [10] = { name = "Sergeant Major" , cl = 2},
        [11] = { name = "Junior Warrant Officer" , cl = 3},
        [12] = { name = "Warrant Officer" , cl = 2},
        [13] = { name = "Chief Warrant Officer" , cl = 3},
        [14] = { name = "Second Lieutenant" , cl = 3},
        [15] = { name = "Lieutenant" , cl = 3},
        [16] = { name = "Captain" , cl = 3},
        [17] = { name = "Major" , cl = 4},
        [18] = { name = "Lieutenant Colonel" , cl = 4},
        [19] = { name = "Colonel" , cl = 4}
    },
	-- {name = "EOD", weapons = {}, model = "", health = 100, armour = 100, flags = "r1;weapon", },
	classes = {
	["EOD"] = {name = "EOD", model = "models/nada/rogueonenova.mdl", weapons = {}, health = 100, armour = 100, flags = "r1;weapon", },
	},
	
    weapons = {
        "rw_sw_e11d",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
    
--[[[RK.Regiment:Add( "Purge Trooper", {
    team_num = 12, -- Unique
    prefix = "PT", -- Prefix for chat.

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/nada/PurgeTrooperElectoStaff.mdl", -- The regiment model
    skin = 0, -- The regiment skin

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -5931, -3173, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Private" },
        [2] = { name = "Corporal" },
        [3] = { name = "Sergeant" },
        [4] = { name = "Master Sergeant" },
        [5] = { name = "Sergeant Major" },
        [6] = { name = "Chief Warrant Officer" },
        [7] = { name = "Lieutenant" },
        [8] = { name = "Captain" },
        [9] = { name = "Major" },
        [10] = { name = "Colonel" },
        [11] = { name = "Brigadier", skin = 0, model = "models/nada/PurgeTrooperCommander.mdl" }
    },

    weapons = {
        "imperialarts_staff_electrostaff",
        "imperialarts_bludgeon_electrohammer",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )]]--
    
RK.Regiment:Add( "Emperor", {
    team_num = 13, -- Unique

    colour = Color(12, 12, 12), -- The regiment colour
    model = "models/player/emperor_palpatine.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -5931, -3173, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Emperor" }
    },

    weapons = {
        "weapon_lightsaber",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
	
	
RK.Regiment:Add( "Inquisitor", {
    team_num = 14, -- Unique

    colour = Color(119, 20, 20), -- The regiment colour
    model = "models/player/xozz/hydra/inquisitor/inquisitormale_02.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "Inquisitor",

    health = 500, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -5931, -3173, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Initiate" },
		[2] = { name = "Acolyte" },
        [3] = { name = "Inquisitor" },
        [4] = { name = "High Inquisitor" },
        [5] = { name = "Grand Inquisitor", skin = 0, model = "models/epangelmatikes/grand_inquisitor.mdl" }
    },

    weapons = {
        "weapon_lightsaber",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
    
--[[RK.Regiment:Add( "Royal Guard", {
    team_num = 15, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/epangelmatikes/RoyalGuard/Royal_Guard.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "RG",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -5931, -3173, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Initiate" },
        [2] = { name = "Guardsman" },
        [3] = { name = "Sentinel" },
        [4] = { name = "Commander" }
    },

    weapons = {
        "imperialarts_staff_royalpike",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )
    
RK.Regiment:Add( "Shadow Guard", {
    team_num = 16, -- Unique

    colour = Color(255, 255, 255), -- The regiment colour
    model = "models/epangelmatikes/RoyalGuard/Shawod_Guard.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "SG",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -5931, -3173, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Initiate", skin = 0, model = "models/epangelmatikes/RoyalGuard/Shawod_Guard.mdl" },
        [2] = { name = "Guardsman", skin = 0, model = "models/epangelmatikes/RoyalGuard/Shawod_Guard.mdl" },
        [3] = { name = "Sentinel", skin = 0, model = "models/epangelmatikes/RoyalGuard/Shawod_Guard.mdl" },
        [4] = { name = "Commander", skin = 0, model = "models/epangelmatikes/RoyalGuard/Shawod_Guard.mdl" }
    },

    weapons = {
        "weapon_lightsaber",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )]]--
    
RK.Regiment:Add( "Darth", {
    team_num = 15, -- Unique

    colour = Color(107, 10, 10), -- The regiment colour
    model = "models/konnie/starwars/darthvader.mdl", -- The regiment model
    skin = 0, -- The regiment skin
    prefix = "",

    health = 100, -- Init health
    armour = 50, -- Init armour
    runspeed = 20, -- Init runspeed
    walkspeed = 20, -- Init walkspeed

    jumppower = 200, -- Init jump power

    flags = "r1;weapon", -- Flags for the regiment, ie. "a" or "weapon"
    spawn_position = Vector( -5931, -3173, -4800 ), -- Spawn position for the regiment
    ranks = {
        [1] = { name = "Darth", skin = 0, model = "models/konnie/starwars/darthvader.mdl" }
    },

    weapons = {
        "weapon_lightsaber",
        --"climb_swep2"
        "weapon_empty_hands",
        "bkeycard"
    } -- weapons table that contains the weapons that the regiment spawns with.
} )

hook.Run( "RK:PostRegimentLoad" )