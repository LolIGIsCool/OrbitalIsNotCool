local MODULE = MODULE or RK.Modules:Get( "crafting" )

MODULE.DebugEnabled = false

MODULE.Recipes = MODULE.Recipes or {}

function MODULE:RegisterCrafting( name, recipe, canSee, canCraft, entRequired )

	if not canSee then canSee = function() return true end end
	if not canCraft then canCraft = function() return true end end
	if !recipe then return false end
	
	self.Recipes[ name ] = {
		Recipe = recipe,
		CanSee = canSee,
		CanCraft = canCraft,
		entRequired = entRequired
	}

	return true
end

function MODULE:GetRecipe( name )
	return self.Recipes[ name ]
end

function MODULE:GetRecipes()
	return self.Recipes
end

concommand.Add( "rk_check_crafting", function()

	if MODULE.DebugEnabled then
		for key, var in pairs( MODULE.Recipes ) do
			for k, v in pairs( var["Recipe"][ "input" ] ) do
				if !RK.Inventory:GetItem( k ) then
					print( "Invalid item in recipe: " .. key, k )
				end
			end
		end
	end

end )

MODULE:RegisterCrafting( "Glitterglass",
	{
		input = {
			[ "Vital suppressor" ] = 1,
		},
		output = {
			[ "Glitterglass" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Selenite",
	{
		input = {
			[ "Gallinore gem" ] = 15,
		},
		output = {
			[ "Selenite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Qashmel",
	{
		input = {
			[ "Neuroprenoline" ] = 19,
		},
		output = {
			[ "Qashmel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Malab",
	{
		input = {
			[ "Songsteel" ] = 1,
		},
		output = {
			[ "Malab" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Life Day Orb",
	{
		input = {
			[ "Bonemer" ] = 3,
		},
		output = {
			[ "Life Day Orb" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crown Jewels of Alderaan",
	{
		input = {
			[ "Protosteel" ] = 16,
		},
		output = {
			[ "Crown Jewels of Alderaan" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rylith crystal",
	{
		input = {
			[ "Love-Wallop pill" ] = 7,
		},
		output = {
			[ "Rylith crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rissle stick",
	{
		input = {
			[ "Plaeklite" ] = 8,
		},
		output = {
			[ "Rissle stick" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Fineweave",
	{
		input = {
			[ "Sorderian weftfabric" ] = 18,
		},
		output = {
			[ "Fineweave" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Steelcloth",
	{
		input = {
			[ "Iridium (element)" ] = 11,
		},
		output = {
			[ "Steelcloth" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Wander-kelp",
	{
		input = {
			[ "Porrh" ] = 12,
		},
		output = {
			[ "Wander-kelp" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Chrysopaz",
	{
		input = {
			[ "Plastcrete" ] = 16,
		},
		output = {
			[ "Chrysopaz" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Quickflash burning gel",
	{
		input = {
			[ "Lockslab" ] = 5,
		},
		output = {
			[ "Quickflash burning gel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Reedug narcotic",
	{
		input = {
			[ "Sun-stone" ] = 11,
		},
		output = {
			[ "Reedug narcotic" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Alderaanian crown jewels",
	{
		input = {
			[ "Tin" ] = 6,
		},
		output = {
			[ "Alderaanian crown jewels" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crism",
	{
		input = {
			[ "Biofiber" ] = 13,
		},
		output = {
			[ "Crism" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Gelatin",
	{
		input = {
			[ "Med-shot" ] = 11,
		},
		output = {
			[ "Gelatin" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Polordion smootdust",
	{
		input = {
			[ "Water" ] = 17,
		},
		output = {
			[ "Polordion smootdust" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Nykkalt",
	{
		input = {
			[ "Lycresh" ] = 2,
		},
		output = {
			[ "Nykkalt" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Bronze",
	{
		input = {
			[ "Hay" ] = 11,
		},
		output = {
			[ "Bronze" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Acertron",
	{
		input = {
			[ "Carapace knitter" ] = 11,
		},
		output = {
			[ "Acertron" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Barabbian",
	{
		input = {
			[ "Gnostra fiber" ] = 20,
		},
		output = {
			[ "Barabbian" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Midlithe crystal",
	{
		input = {
			[ "Plasticrete" ] = 2,
		},
		output = {
			[ "Midlithe crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Alum",
	{
		input = {
			[ "Ore" ] = 14,
		},
		output = {
			[ "Alum" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rock ivory",
	{
		input = {
			[ "Duracrete" ] = 6,
		},
		output = {
			[ "Rock ivory" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Concrete",
	{
		input = {
			[ "Cyanogen silicate" ] = 6,
		},
		output = {
			[ "Concrete" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Alumabronze",
	{
		input = {
			[ "Beskar" ] = 5,
		},
		output = {
			[ "Alumabronze" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Emperor's Favor",
	{
		input = {
			[ "Synfleece" ] = 2,
		},
		output = {
			[ "Emperor's Favor" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Peace-sealing",
	{
		input = {
			[ "Imperial crown jewels" ] = 3,
		},
		output = {
			[ "Peace-sealing" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Dimalium-6",
	{
		input = {
			[ "Molf" ] = 16,
		},
		output = {
			[ "Dimalium-6" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Artesian (crystal)",
	{
		input = {
			[ "Chromite" ] = 5,
		},
		output = {
			[ "Artesian (crystal)" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Graphite",
	{
		input = {
			[ "Doonium" ] = 5,
		},
		output = {
			[ "Graphite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Death stick",
	{
		input = {
			[ "Lucryte" ] = 1,
		},
		output = {
			[ "Death stick" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ferrocongregate",
	{
		input = {
			[ "Zinsian" ] = 1,
		},
		output = {
			[ "Ferrocongregate" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Zwil",
	{
		input = {
			[ "Tava" ] = 13,
		},
		output = {
			[ "Zwil" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Firegem",
	{
		input = {
			[ "Permex" ] = 5,
		},
		output = {
			[ "Firegem" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Knots",
	{
		input = {
			[ "Permaglass" ] = 2,
		},
		output = {
			[ "Knots" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Flat-foil",
	{
		input = {
			[ "DC-15A" ] = 20,
		},
		output = {
			[ "Flat-foil" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ice mushroom",
	{
		input = {
			[ "Miriskin" ] = 3,
		},
		output = {
			[ "Ice mushroom" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Lapis",
	{
		input = {
			[ "Nylasteel" ] = 10,
		},
		output = {
			[ "Lapis" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Kelerium",
	{
		input = {
			[ "Stim stabilizer" ] = 3,
		},
		output = {
			[ "Kelerium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Jorallan opal",
	{
		input = {
			[ "Plastifoam" ] = 1,
		},
		output = {
			[ "Jorallan opal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Laminoid",
	{
		input = {
			[ "9093-T7511" ] = 8,
		},
		output = {
			[ "Laminoid" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ruusan copper",
	{
		input = {
			[ "Phosphorus" ] = 7,
		},
		output = {
			[ "Ruusan copper" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Brass",
	{
		input = {
			[ "Plasti-shield" ] = 16,
		},
		output = {
			[ "Brass" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Kelpcotton",
	{
		input = {
			[ "Sun crystal" ] = 14,
		},
		output = {
			[ "Kelpcotton" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Permacite",
	{
		input = {
			[ "B'omarr regeneration gem" ] = 19,
		},
		output = {
			[ "Permacite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plastifold",
	{
		input = {
			[ "Gemweb" ] = 6,
		},
		output = {
			[ "Plastifold" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Orichalum",
	{
		input = {
			[ "Somaprin-3" ] = 6,
		},
		output = {
			[ "Orichalum" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Alabaster",
	{
		input = {
			[ "Tarelle sel-weave" ] = 3,
		},
		output = {
			[ "Alabaster" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ardanium",
	{
		input = {
			[ "Agrinium" ] = 13,
		},
		output = {
			[ "Ardanium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ammonium-hydrosulfide",
	{
		input = {
			[ "9093-T7511" ] = 6,
		},
		output = {
			[ "Ammonium-hydrosulfide" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plastcrete",
	{
		input = {
			[ "Bronze" ] = 4,
		},
		output = {
			[ "Plastcrete" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Frasium",
	{
		input = {
			[ "Plastithread" ] = 17,
		},
		output = {
			[ "Frasium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ceramasteel",
	{
		input = {
			[ "Firegems" ] = 11,
		},
		output = {
			[ "Ceramasteel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Camarian crystal",
	{
		input = {
			[ "Tranquilizer" ] = 16,
		},
		output = {
			[ "Camarian crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Muratine",
	{
		input = {
			[ "Dedlanite" ] = 8,
		},
		output = {
			[ "Muratine" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rubindum",
	{
		input = {
			[ "Heart of the Universe" ] = 13,
		},
		output = {
			[ "Rubindum" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plastiflex",
	{
		input = {
			[ "Relacite" ] = 8,
		},
		output = {
			[ "Plastiflex" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Hfredium",
	{
		input = {
			[ "Syntex" ] = 20,
		},
		output = {
			[ "Hfredium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Fonwim",
	{
		input = {
			[ "Crude" ] = 15,
		},
		output = {
			[ "Fonwim" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Detoxification hypo",
	{
		input = {
			[ "Life Day Orb" ] = 15,
		},
		output = {
			[ "Detoxification hypo" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Kantak crystal",
	{
		input = {
			[ "Fineweave" ] = 14,
		},
		output = {
			[ "Kantak crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Kunda stone",
	{
		input = {
			[ "Kallistan gem" ] = 6,
		},
		output = {
			[ "Kunda stone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Hydrocarbon",
	{
		input = {
			[ "Stim stabilizer" ] = 6,
		},
		output = {
			[ "Hydrocarbon" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Guerrerite",
	{
		input = {
			[ "Impervium" ] = 5,
		},
		output = {
			[ "Guerrerite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Hay",
	{
		input = {
			[ "Jewel of Zenda" ] = 20,
		},
		output = {
			[ "Hay" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Charal's divinatory poultice",
	{
		input = {
			[ "Plastic" ] = 4,
		},
		output = {
			[ "Charal's divinatory poultice" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Krallian",
	{
		input = {
			[ "Anodyne" ] = 20,
		},
		output = {
			[ "Krallian" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Myoflex",
	{
		input = {
			[ "Silicate" ] = 1,
		},
		output = {
			[ "Myoflex" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Osmium",
	{
		input = {
			[ "Pommwomm" ] = 6,
		},
		output = {
			[ "Osmium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Superstretch durafiber",
	{
		input = {
			[ "Guilea" ] = 11,
		},
		output = {
			[ "Superstretch durafiber" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Metal",
	{
		input = {
			[ "Double-helix prismatic crystal" ] = 10,
		},
		output = {
			[ "Metal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Diaphaneel",
	{
		input = {
			[ "SoroSuub Stimchew" ] = 14,
		},
		output = {
			[ "Diaphaneel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Bando Gora neurotoxin",
	{
		input = {
			[ "Nergon-14" ] = 18,
		},
		output = {
			[ "Bando Gora neurotoxin" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Vorsian crystal",
	{
		input = {
			[ "Duralium" ] = 5,
		},
		output = {
			[ "Vorsian crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ceraglass",
	{
		input = {
			[ "Satin" ] = 11,
		},
		output = {
			[ "Ceraglass" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plastone",
	{
		input = {
			[ "Spitcrete" ] = 12,
		},
		output = {
			[ "Plastone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Lothalite (crystal)",
	{
		input = {
			[ "Zelosi crystal" ] = 13,
		},
		output = {
			[ "Lothalite (crystal)" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ora",
	{
		input = {
			[ "Enkephalin" ] = 14,
		},
		output = {
			[ "Ora" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Obsidian",
	{
		input = {
			[ "Osmiridium" ] = 6,
		},
		output = {
			[ "Obsidian" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sarrassian iron",
	{
		input = {
			[ "Ice moon" ] = 16,
		},
		output = {
			[ "Sarrassian iron" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Dianogan tea",
	{
		input = {
			[ "Vanadinite" ] = 16,
		},
		output = {
			[ "Dianogan tea" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Volduuk crystal",
	{
		input = {
			[ "Plaster" ] = 9,
		},
		output = {
			[ "Volduuk crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Blankets",
	{
		input = {
			[ "Gelatin" ] = 18,
		},
		output = {
			[ "Blankets" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Force crystals",
	{
		input = {
			[ "Kessum" ] = 16,
		},
		output = {
			[ "Force crystals" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Lotiramine",
	{
		input = {
			[ "Happy-Bore Medicated Dewormer" ] = 1,
		},
		output = {
			[ "Lotiramine" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ethmane",
	{
		input = {
			[ "Wind-crystal" ] = 18,
		},
		output = {
			[ "Ethmane" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ionite",
	{
		input = {
			[ "Lava crystal" ] = 7,
		},
		output = {
			[ "Ionite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Antitox booster",
	{
		input = {
			[ "Lothalite (crystal)" ] = 19,
		},
		output = {
			[ "Antitox booster" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Hezar stone",
	{
		input = {
			[ "Elisinandrox" ] = 20,
		},
		output = {
			[ "Hezar stone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Duracrete",
	{
		input = {
			[ "Crism" ] = 5,
		},
		output = {
			[ "Duracrete" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ammonia tablet",
	{
		input = {
			[ "Sleeppack" ] = 10,
		},
		output = {
			[ "Ammonia tablet" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "DiMatolin",
	{
		input = {
			[ "Hormone" ] = 3,
		},
		output = {
			[ "DiMatolin" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Data crystal",
	{
		input = {
			[ "Permaglass" ] = 13,
		},
		output = {
			[ "Data crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Mineral",
	{
		input = {
			[ "Songsteel" ] = 15,
		},
		output = {
			[ "Mineral" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Tarelle sei-weave",
	{
		input = {
			[ "Durite" ] = 11,
		},
		output = {
			[ "Tarelle sei-weave" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Dolomite",
	{
		input = {
			[ "Incense" ] = 12,
		},
		output = {
			[ "Dolomite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Harterran moonstone",
	{
		input = {
			[ "Neuroprenoline" ] = 8,
		},
		output = {
			[ "Harterran moonstone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Gold",
	{
		input = {
			[ "Solarbenite" ] = 17,
		},
		output = {
			[ "Gold" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ciridium",
	{
		input = {
			[ "Relkass sentinel plant" ] = 18,
		},
		output = {
			[ "Ciridium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rybcoarse",
	{
		input = {
			[ "Plexalloy" ] = 8,
		},
		output = {
			[ "Rybcoarse" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Anodyne",
	{
		input = {
			[ "Cerlin" ] = 9,
		},
		output = {
			[ "Anodyne" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ketrian Altronel's alloy",
	{
		input = {
			[ "Ore" ] = 4,
		},
		output = {
			[ "Ketrian Altronel's alloy" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Paraleptin",
	{
		input = {
			[ "Trinium" ] = 20,
		},
		output = {
			[ "Paraleptin" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Stimufrost",
	{
		input = {
			[ "Quella stone" ] = 13,
		},
		output = {
			[ "Stimufrost" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Desh",
	{
		input = {
			[ "Kryotin" ] = 6,
		},
		output = {
			[ "Desh" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plastisheet",
	{
		input = {
			[ "Pholikite" ] = 19,
		},
		output = {
			[ "Plastisheet" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sunblaze",
	{
		input = {
			[ "Tear opal" ] = 13,
		},
		output = {
			[ "Sunblaze" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Qixoni crystal",
	{
		input = {
			[ "Baradium-357" ] = 10,
		},
		output = {
			[ "Qixoni crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Namana",
	{
		input = {
			[ "Synthskin" ] = 19,
		},
		output = {
			[ "Namana" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Honest stone",
	{
		input = {
			[ "Molf" ] = 12,
		},
		output = {
			[ "Honest stone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Lexiaus beast",
	{
		input = {
			[ "Binary liquid" ] = 19,
		},
		output = {
			[ "Lexiaus beast" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Amethyst",
	{
		input = {
			[ "Jedi Mind Juice" ] = 9,
		},
		output = {
			[ "Amethyst" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ore",
	{
		input = {
			[ "Plasticast" ] = 11,
		},
		output = {
			[ "Ore" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crystal core",
	{
		input = {
			[ "Tarpaulin" ] = 15,
		},
		output = {
			[ "Crystal core" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Tynzo crystal",
	{
		input = {
			[ "Plasti-shroud" ] = 19,
		},
		output = {
			[ "Tynzo crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Firefacet",
	{
		input = {
			[ "Orichalum" ] = 20,
		},
		output = {
			[ "Firefacet" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Vandinite",
	{
		input = {
			[ "Roe-Salve" ] = 9,
		},
		output = {
			[ "Vandinite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Quartz crystal",
	{
		input = {
			[ "Dontworry" ] = 10,
		},
		output = {
			[ "Quartz crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Serenno silver",
	{
		input = {
			[ "Rol Stone" ] = 6,
		},
		output = {
			[ "Serenno silver" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ice moon",
	{
		input = {
			[ "Lockslab" ] = 9,
		},
		output = {
			[ "Ice moon" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Metacycline",
	{
		input = {
			[ "Yttrium" ] = 5,
		},
		output = {
			[ "Metacycline" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plasform",
	{
		input = {
			[ "Laminanium" ] = 5,
		},
		output = {
			[ "Plasform" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crodium",
	{
		input = {
			[ "Tursturin" ] = 14,
		},
		output = {
			[ "Crodium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Alderaanian nectar",
	{
		input = {
			[ "Crude" ] = 15,
		},
		output = {
			[ "Alderaanian nectar" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "ArachSilk",
	{
		input = {
			[ "Phil-fiber" ] = 7,
		},
		output = {
			[ "ArachSilk" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rose Mytag crystal",
	{
		input = {
			[ "Blood thinner" ] = 1,
		},
		output = {
			[ "Rose Mytag crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Artusian crystal",
	{
		input = {
			[ "Norbutal (drug)" ] = 20,
		},
		output = {
			[ "Artusian crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Synth-fur",
	{
		input = {
			[ "Alderaanian crown jewels" ] = 18,
		},
		output = {
			[ "Synth-fur" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Callacord",
	{
		input = {
			[ "Cortosis" ] = 12,
		},
		output = {
			[ "Callacord" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Cranoran thread",
	{
		input = {
			[ "Copper" ] = 9,
		},
		output = {
			[ "Cranoran thread" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Allacrete",
	{
		input = {
			[ "Lockslab" ] = 10,
		},
		output = {
			[ "Allacrete" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Berubian",
	{
		input = {
			[ "Gemweb" ] = 15,
		},
		output = {
			[ "Berubian" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Anesthetic",
	{
		input = {
			[ "Erkinite" ] = 16,
		},
		output = {
			[ "Anesthetic" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sulfite",
	{
		input = {
			[ "Quadanium steel" ] = 14,
		},
		output = {
			[ "Sulfite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Permaplast",
	{
		input = {
			[ "Duraplast" ] = 10,
		},
		output = {
			[ "Permaplast" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Synthfur",
	{
		input = {
			[ "Fleekskin" ] = 2,
		},
		output = {
			[ "Synthfur" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plasticene",
	{
		input = {
			[ "T'pala paste" ] = 20,
		},
		output = {
			[ "Plasticene" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Silicate",
	{
		input = {
			[ "Codoran" ] = 16,
		},
		output = {
			[ "Silicate" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Scintathread",
	{
		input = {
			[ "Plastiboard" ] = 6,
		},
		output = {
			[ "Scintathread" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Corundum",
	{
		input = {
			[ "Lutetium" ] = 5,
		},
		output = {
			[ "Corundum" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Burn salve",
	{
		input = {
			[ "Osmiridium" ] = 9,
		},
		output = {
			[ "Burn salve" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sorderian weftfabric",
	{
		input = {
			[ "Life-crystal" ] = 5,
		},
		output = {
			[ "Sorderian weftfabric" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Med-shot",
	{
		input = {
			[ "Flowstone" ] = 1,
		},
		output = {
			[ "Med-shot" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Fibrolite",
	{
		input = {
			[ "Plasform" ] = 15,
		},
		output = {
			[ "Fibrolite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Condensed-matter composite",
	{
		input = {
			[ "Eternity Crystal" ] = 19,
		},
		output = {
			[ "Condensed-matter composite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Flame jewel",
	{
		input = {
			[ "Millaflower" ] = 19,
		},
		output = {
			[ "Flame jewel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Pholikite",
	{
		input = {
			[ "Graphite" ] = 8,
		},
		output = {
			[ "Pholikite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Topaz",
	{
		input = {
			[ "Roonstone" ] = 15,
		},
		output = {
			[ "Topaz" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sein jewel",
	{
		input = {
			[ "Psilocybin" ] = 18,
		},
		output = {
			[ "Sein jewel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crystadurium",
	{
		input = {
			[ "Foamcast" ] = 3,
		},
		output = {
			[ "Crystadurium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Adrenaline",
	{
		input = {
			[ "Genetic coherence sequencer" ] = 14,
		},
		output = {
			[ "Adrenaline" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Phosphorus",
	{
		input = {
			[ "Ammonia tablet" ] = 10,
		},
		output = {
			[ "Phosphorus" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Dathomite",
	{
		input = {
			[ "Drommanarg" ] = 7,
		},
		output = {
			[ "Dathomite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Stim stabilizer",
	{
		input = {
			[ "Hypergem" ] = 6,
		},
		output = {
			[ "Stim stabilizer" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Steelcrete",
	{
		input = {
			[ "Greshollpolyforim" ] = 9,
		},
		output = {
			[ "Steelcrete" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Magsol",
	{
		input = {
			[ "Kantak crystal" ] = 15,
		},
		output = {
			[ "Magsol" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Farium",
	{
		input = {
			[ "Anti-veisalgia drug" ] = 12,
		},
		output = {
			[ "Farium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ossyth",
	{
		input = {
			[ "Shadeshine" ] = 5,
		},
		output = {
			[ "Ossyth" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rare Nova Crystal",
	{
		input = {
			[ "Rubies" ] = 1,
		},
		output = {
			[ "Rare Nova Crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Carnium",
	{
		input = {
			[ "Berubium" ] = 12,
		},
		output = {
			[ "Carnium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Moonstone",
	{
		input = {
			[ "Lost Stars of Nallastia" ] = 6,
		},
		output = {
			[ "Moonstone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Unidentified mineral",
	{
		input = {
			[ "Vendusii Crystal" ] = 6,
		},
		output = {
			[ "Unidentified mineral" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Berubium",
	{
		input = {
			[ "Myoflex" ] = 5,
		},
		output = {
			[ "Berubium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Duraplast",
	{
		input = {
			[ "Carvanium" ] = 19,
		},
		output = {
			[ "Duraplast" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plasticast",
	{
		input = {
			[ "Polyplast" ] = 12,
		},
		output = {
			[ "Plasticast" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Dreamsilk",
	{
		input = {
			[ "Synthecrete" ] = 11,
		},
		output = {
			[ "Dreamsilk" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Spice variants",
	{
		input = {
			[ "Plasto-canvas" ] = 3,
		},
		output = {
			[ "Spice variants" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Stresscrete",
	{
		input = {
			[ "Werrjuice" ] = 14,
		},
		output = {
			[ "Stresscrete" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Miriskin",
	{
		input = {
			[ "Unidentified mineral" ] = 7,
		},
		output = {
			[ "Miriskin" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Lorrdian gemstone",
	{
		input = {
			[ "Dyan-thread" ] = 20,
		},
		output = {
			[ "Lorrdian gemstone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Bene (mineral)",
	{
		input = {
			[ "Vendusii Crystal" ] = 12,
		},
		output = {
			[ "Bene (mineral)" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Synthplast",
	{
		input = {
			[ "Bacta" ] = 8,
		},
		output = {
			[ "Synthplast" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ferrocarbon",
	{
		input = {
			[ "Elixir of Infatuation" ] = 19,
		},
		output = {
			[ "Ferrocarbon" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Unidentified Sith artifact (Jagomir)",
	{
		input = {
			[ "Glitterstim" ] = 9,
		},
		output = {
			[ "Unidentified Sith artifact (Jagomir)" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Baffleweave",
	{
		input = {
			[ "Beolars" ] = 19,
		},
		output = {
			[ "Baffleweave" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Cerillium",
	{
		input = {
			[ "Chromite" ] = 10,
		},
		output = {
			[ "Cerillium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Katrium",
	{
		input = {
			[ "Rudic crystal" ] = 8,
		},
		output = {
			[ "Katrium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crystalline astronomical objects",
	{
		input = {
			[ "Phrik" ] = 20,
		},
		output = {
			[ "Crystalline astronomical objects" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Flesh Raider elixir",
	{
		input = {
			[ "Carvanium" ] = 1,
		},
		output = {
			[ "Flesh Raider elixir" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Amaralite",
	{
		input = {
			[ "Empress Teta's Crown Jewels" ] = 1,
		},
		output = {
			[ "Amaralite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Brismoss-fiber",
	{
		input = {
			[ "Ameron" ] = 4,
		},
		output = {
			[ "Brismoss-fiber" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Anesthetics",
	{
		input = {
			[ "Kista" ] = 9,
		},
		output = {
			[ "Anesthetics" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Clari-crystal",
	{
		input = {
			[ "Duralium" ] = 10,
		},
		output = {
			[ "Clari-crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Fire node",
	{
		input = {
			[ "Clari-crystal" ] = 4,
		},
		output = {
			[ "Fire node" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Memory-plastic",
	{
		input = {
			[ "Sweetblossom" ] = 1,
		},
		output = {
			[ "Memory-plastic" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Beskar",
	{
		input = {
			[ "Stresscrete" ] = 12,
		},
		output = {
			[ "Beskar" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Corusca gem",
	{
		input = {
			[ "Corwindyl paste" ] = 13,
		},
		output = {
			[ "Corusca gem" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ferroceramic",
	{
		input = {
			[ "Graphene" ] = 5,
		},
		output = {
			[ "Ferroceramic" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plasteel",
	{
		input = {
			[ "Detoxification hypo" ] = 7,
		},
		output = {
			[ "Plasteel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Cerlin",
	{
		input = {
			[ "Coarseweave" ] = 2,
		},
		output = {
			[ "Cerlin" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Dendrite",
	{
		input = {
			[ "Millaflower" ] = 11,
		},
		output = {
			[ "Dendrite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Quella stone",
	{
		input = {
			[ "Life Day Orb" ] = 7,
		},
		output = {
			[ "Quella stone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Zwevel",
	{
		input = {
			[ "Baquor" ] = 15,
		},
		output = {
			[ "Zwevel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Tarelle sel-weave",
	{
		input = {
			[ "Jorallan opal" ] = 20,
		},
		output = {
			[ "Tarelle sel-weave" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crystal plants",
	{
		input = {
			[ "Solarbenite" ] = 10,
		},
		output = {
			[ "Crystal plants" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Stress tab",
	{
		input = {
			[ "Berubian" ] = 7,
		},
		output = {
			[ "Stress tab" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sedrellium",
	{
		input = {
			[ "Fibrolite" ] = 18,
		},
		output = {
			[ "Sedrellium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Gemstone",
	{
		input = {
			[ "Permaplex" ] = 10,
		},
		output = {
			[ "Gemstone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rainbow gem",
	{
		input = {
			[ "Life Day Orb" ] = 17,
		},
		output = {
			[ "Rainbow gem" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Isotope-5",
	{
		input = {
			[ "Allacrete" ] = 13,
		},
		output = {
			[ "Isotope-5" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "SoroSuub Stimchew",
	{
		input = {
			[ "Nylonite" ] = 12,
		},
		output = {
			[ "SoroSuub Stimchew" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ranrt crystal",
	{
		input = {
			[ "Bonemer" ] = 19,
		},
		output = {
			[ "Ranrt crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Mangana aqua jewel",
	{
		input = {
			[ "Scatrium" ] = 15,
		},
		output = {
			[ "Mangana aqua jewel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Vintrium",
	{
		input = {
			[ "Colat" ] = 16,
		},
		output = {
			[ "Vintrium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Zinsian",
	{
		input = {
			[ "Vannan Crystal" ] = 19,
		},
		output = {
			[ "Zinsian" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Seoularian crystal",
	{
		input = {
			[ "Myoplexaril" ] = 17,
		},
		output = {
			[ "Seoularian crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Zone of Self-Containment",
	{
		input = {
			[ "Syntex" ] = 14,
		},
		output = {
			[ "Zone of Self-Containment" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Trimantium",
	{
		input = {
			[ "Cellulose" ] = 1,
		},
		output = {
			[ "Trimantium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plastifoam",
	{
		input = {
			[ "Falasian liquid crystal" ] = 3,
		},
		output = {
			[ "Plastifoam" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Serranite",
	{
		input = {
			[ "Insulfiber" ] = 1,
		},
		output = {
			[ "Serranite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Bubse tree",
	{
		input = {
			[ "Lost Stars of Nallastia" ] = 13,
		},
		output = {
			[ "Bubse tree" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Unidentified crystal",
	{
		input = {
			[ "Quantum-crystalline armor" ] = 8,
		},
		output = {
			[ "Unidentified crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Bacta",
	{
		input = {
			[ "Ranrt crystal" ] = 8,
		},
		output = {
			[ "Bacta" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Poly-ceramic",
	{
		input = {
			[ "Heart of Fire" ] = 6,
		},
		output = {
			[ "Poly-ceramic" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Power gem",
	{
		input = {
			[ "Bubse tree" ] = 19,
		},
		output = {
			[ "Power gem" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Kessum",
	{
		input = {
			[ "Black Hole (drug)" ] = 10,
		},
		output = {
			[ "Kessum" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sun crystal",
	{
		input = {
			[ "Steelcloth" ] = 4,
		},
		output = {
			[ "Sun crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Fine oro-weave",
	{
		input = {
			[ "Tanray heart crystal" ] = 13,
		},
		output = {
			[ "Fine oro-weave" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Vertag crystal",
	{
		input = {
			[ "Crism crystal" ] = 11,
		},
		output = {
			[ "Vertag crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Allergy paste",
	{
		input = {
			[ "Hezar stone" ] = 7,
		},
		output = {
			[ "Allergy paste" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Slivian iron",
	{
		input = {
			[ "Spice variants" ] = 12,
		},
		output = {
			[ "Slivian iron" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "T'nal",
	{
		input = {
			[ "Romex" ] = 7,
		},
		output = {
			[ "T'nal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Bota",
	{
		input = {
			[ "Burn salve" ] = 8,
		},
		output = {
			[ "Bota" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Perspex",
	{
		input = {
			[ "Chalcedony" ] = 1,
		},
		output = {
			[ "Perspex" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Cello-plast",
	{
		input = {
			[ "Ceraglass" ] = 2,
		},
		output = {
			[ "Cello-plast" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Nylasteel",
	{
		input = {
			[ "Eye of Deth" ] = 11,
		},
		output = {
			[ "Nylasteel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Vacierite",
	{
		input = {
			[ "Unidentified nutrient" ] = 3,
		},
		output = {
			[ "Vacierite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ulikuo gemstone",
	{
		input = {
			[ "Muratine" ] = 10,
		},
		output = {
			[ "Ulikuo gemstone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Nova crystal",
	{
		input = {
			[ "9095-T8511" ] = 11,
		},
		output = {
			[ "Nova crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Terenthium",
	{
		input = {
			[ "Charal's divinatory poultice" ] = 3,
		},
		output = {
			[ "Terenthium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Anti-veisalgia drug",
	{
		input = {
			[ "Ora" ] = 6,
		},
		output = {
			[ "Anti-veisalgia drug" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Calcium",
	{
		input = {
			[ "Truth drug" ] = 1,
		},
		output = {
			[ "Calcium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Numbspray",
	{
		input = {
			[ "Antishock" ] = 3,
		},
		output = {
			[ "Numbspray" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Fervse",
	{
		input = {
			[ "Scatrium" ] = 13,
		},
		output = {
			[ "Fervse" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Wroshite",
	{
		input = {
			[ "Coruscanthium" ] = 2,
		},
		output = {
			[ "Wroshite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Phond",
	{
		input = {
			[ "Magsol" ] = 1,
		},
		output = {
			[ "Phond" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Drommanarg",
	{
		input = {
			[ "Carbon dioxide" ] = 8,
		},
		output = {
			[ "Drommanarg" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Tarpaulin",
	{
		input = {
			[ "Haka Hai's compound" ] = 4,
		},
		output = {
			[ "Tarpaulin" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Silkweed",
	{
		input = {
			[ "Ammonia tablet" ] = 9,
		},
		output = {
			[ "Silkweed" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ixetallic",
	{
		input = {
			[ "Permaplas" ] = 12,
		},
		output = {
			[ "Ixetallic" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Hollinium",
	{
		input = {
			[ "Nervestick" ] = 19,
		},
		output = {
			[ "Hollinium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Arsensalts",
	{
		input = {
			[ "Gacerite (gemstone)" ] = 18,
		},
		output = {
			[ "Arsensalts" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "VACX",
	{
		input = {
			[ "Myoplexaril" ] = 20,
		},
		output = {
			[ "VACX" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Quad-helix prismatic crystal",
	{
		input = {
			[ "Shard Memorial" ] = 13,
		},
		output = {
			[ "Quad-helix prismatic crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Hydrogen sulfide",
	{
		input = {
			[ "Steelcloth" ] = 18,
		},
		output = {
			[ "Hydrogen sulfide" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Chalcedony",
	{
		input = {
			[ "Stim stabilizer" ] = 8,
		},
		output = {
			[ "Chalcedony" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Elixir of Infatuation",
	{
		input = {
			[ "Midlithe crystal" ] = 8,
		},
		output = {
			[ "Elixir of Infatuation" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Synfur",
	{
		input = {
			[ "Chronamite" ] = 5,
		},
		output = {
			[ "Synfur" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Cormium crystal",
	{
		input = {
			[ "Marcluro-stone" ] = 7,
		},
		output = {
			[ "Cormium crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Carbon monoxide",
	{
		input = {
			[ "Corundum" ] = 2,
		},
		output = {
			[ "Carbon monoxide" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sith crystals",
	{
		input = {
			[ "Marilite" ] = 6,
		},
		output = {
			[ "Sith crystals" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Durafiber",
	{
		input = {
			[ "�meraude" ] = 5,
		},
		output = {
			[ "Durafiber" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Permaplex",
	{
		input = {
			[ "Sulfur tab" ] = 15,
		},
		output = {
			[ "Permaplex" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plexalloy",
	{
		input = {
			[ "Unidentified crystal" ] = 1,
		},
		output = {
			[ "Plexalloy" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plastisynth",
	{
		input = {
			[ "Orichalum" ] = 10,
			[ "Corellian gold" ] = 5,
			[ "Grafiform" ] = 2,
			[ "Unidentified crystal" ] = 1,
		},
		output = {
			[ "Plastisynth" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Kyrprax",
	{
		input = {
			[ "Bando Gora neurotoxin" ] = 19,
		},
		output = {
			[ "Kyrprax" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Latheniol",
	{
		input = {
			[ "Selective memory erasing drug" ] = 9,
		},
		output = {
			[ "Latheniol" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Coal",
	{
		input = {
			[ "Quantum crystal" ] = 3,
		},
		output = {
			[ "Coal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Reflec",
	{
		input = {
			[ "Nervestick" ] = 17,
		},
		output = {
			[ "Reflec" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Grafiform",
	{
		input = {
			[ "Key crystal" ] = 5,
		},
		output = {
			[ "Grafiform" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Corellian gold",
	{
		input = {
			[ "Fiber-alloy" ] = 3,
		},
		output = {
			[ "Corellian gold" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Quadanium steel",
	{
		input = {
			[ "Spice variants" ] = 5,
		},
		output = {
			[ "Quadanium steel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Lycresh",
	{
		input = {
			[ "Quantum crystal" ] = 11,
		},
		output = {
			[ "Lycresh" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Singing Stone",
	{
		input = {
			[ "Myoplexaril" ] = 1,
		},
		output = {
			[ "Singing Stone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Love-Wallop pill",
	{
		input = {
			[ "Hadeira serum" ] = 9,
		},
		output = {
			[ "Love-Wallop pill" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Duralumin",
	{
		input = {
			[ "Stresscrete" ] = 15,
		},
		output = {
			[ "Duralumin" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Bandorium",
	{
		input = {
			[ "D'lis" ] = 9,
		},
		output = {
			[ "Bandorium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "SLV-88",
	{
		input = {
			[ "Manganese brass" ] = 11,
		},
		output = {
			[ "SLV-88" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Glow Stone",
	{
		input = {
			[ "Thorilide" ] = 12,
		},
		output = {
			[ "Glow Stone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "V'ris",
	{
		input = {
			[ "Prismatic crystal" ] = 2,
		},
		output = {
			[ "V'ris" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Behot",
	{
		input = {
			[ "Chrysopaz" ] = 3,
		},
		output = {
			[ "Behot" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Tranquilizer",
	{
		input = {
			[ "Ice-jewel" ] = 2,
		},
		output = {
			[ "Tranquilizer" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ferrocrete",
	{
		input = {
			[ "Nylasteel" ] = 17,
		},
		output = {
			[ "Ferrocrete" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Baquor",
	{
		input = {
			[ "Electrolytic serum" ] = 15,
		},
		output = {
			[ "Baquor" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ecru",
	{
		input = {
			[ "Xonolite" ] = 3,
		},
		output = {
			[ "Ecru" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Syntex",
	{
		input = {
			[ "Tanium" ] = 13,
		},
		output = {
			[ "Syntex" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Roe-Salve",
	{
		input = {
			[ "Plastifold" ] = 19,
		},
		output = {
			[ "Roe-Salve" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Mouth rock",
	{
		input = {
			[ "Phil-fiber" ] = 12,
		},
		output = {
			[ "Mouth rock" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sapphires",
	{
		input = {
			[ "Treeman's herb" ] = 16,
		},
		output = {
			[ "Sapphires" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Socalium crystal",
	{
		input = {
			[ "Gnostra fiber" ] = 7,
		},
		output = {
			[ "Socalium crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ranite",
	{
		input = {
			[ "Glass" ] = 14,
		},
		output = {
			[ "Ranite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Fineweave sherculin-cloth",
	{
		input = {
			[ "Spice" ] = 13,
		},
		output = {
			[ "Fineweave sherculin-cloth" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Anti-radiation inoculation",
	{
		input = {
			[ "Arcetron" ] = 9,
		},
		output = {
			[ "Anti-radiation inoculation" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Suprasteel",
	{
		input = {
			[ "Hyperbaride" ] = 18,
		},
		output = {
			[ "Suprasteel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Kammris",
	{
		input = {
			[ "Cormium crystal" ] = 20,
		},
		output = {
			[ "Kammris" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Salve",
	{
		input = {
			[ "Nanofoil" ] = 5,
		},
		output = {
			[ "Salve" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Mandalorian iron",
	{
		input = {
			[ "Ho'Din herbal tea" ] = 16,
		},
		output = {
			[ "Mandalorian iron" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Flex-bronze",
	{
		input = {
			[ "Sunshield fabric" ] = 8,
		},
		output = {
			[ "Flex-bronze" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Double-helix prismatic crystal",
	{
		input = {
			[ "Qixoni crystal" ] = 18,
		},
		output = {
			[ "Double-helix prismatic crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Meryx",
	{
		input = {
			[ "Karvathian sequined tarp" ] = 13,
		},
		output = {
			[ "Meryx" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crystal",
	{
		input = {
			[ "Ammonium-hydrosulfide" ] = 15,
		},
		output = {
			[ "Crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Dedlanite",
	{
		input = {
			[ "Emperor's Favor" ] = 18,
		},
		output = {
			[ "Dedlanite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plethyl nitrate",
	{
		input = {
			[ "Sormahil fire gem" ] = 2,
		},
		output = {
			[ "Plethyl nitrate" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Velmstone",
	{
		input = {
			[ "Ithorian marble" ] = 4,
		},
		output = {
			[ "Velmstone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Feldspar",
	{
		input = {
			[ "Ferroceramic" ] = 7,
		},
		output = {
			[ "Feldspar" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Force crystal",
	{
		input = {
			[ "Bandorium" ] = 19,
		},
		output = {
			[ "Force crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Werrjuice",
	{
		input = {
			[ "Marilite" ] = 14,
		},
		output = {
			[ "Werrjuice" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Titanium",
	{
		input = {
			[ "Ammonia tablet" ] = 4,
		},
		output = {
			[ "Titanium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Ice-jewel",
	{
		input = {
			[ "Rubies" ] = 12,
		},
		output = {
			[ "Ice-jewel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Doonium",
	{
		input = {
			[ "Drovian zwil" ] = 17,
		},
		output = {
			[ "Doonium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Polycarbonate",
	{
		input = {
			[ "Kwarz crystal" ] = 7,
		},
		output = {
			[ "Polycarbonate" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Solarbenite",
	{
		input = {
			[ "Vibration crystal" ] = 3,
		},
		output = {
			[ "Solarbenite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Empress Teta's Crown Jewels",
	{
		input = {
			[ "Ciridium" ] = 5,
		},
		output = {
			[ "Empress Teta's Crown Jewels" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Vendusii Crystal",
	{
		input = {
			[ "Fleximetal" ] = 11,
		},
		output = {
			[ "Vendusii Crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Mica (mineral)",
	{
		input = {
			[ "Laminanium" ] = 15,
		},
		output = {
			[ "Mica (mineral)" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sassaberry juice",
	{
		input = {
			[ "Plastic" ] = 5,
		},
		output = {
			[ "Sassaberry juice" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Fiberweave",
	{
		input = {
			[ "Plastiboard" ] = 7,
		},
		output = {
			[ "Fiberweave" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Chall-crystal",
	{
		input = {
			[ "Flexicris" ] = 19,
		},
		output = {
			[ "Chall-crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Carbon dioxide",
	{
		input = {
			[ "Graphite" ] = 2,
		},
		output = {
			[ "Carbon dioxide" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "SLV-16",
	{
		input = {
			[ "Gemstone" ] = 3,
		},
		output = {
			[ "SLV-16" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Emradite crystal",
	{
		input = {
			[ "Orichalum" ] = 20,
		},
		output = {
			[ "Emradite crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Kik-dust",
	{
		input = {
			[ "SLV serum series" ] = 20,
		},
		output = {
			[ "Kik-dust" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Inoxium",
	{
		input = {
			[ "Munka" ] = 3,
		},
		output = {
			[ "Inoxium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Glass",
	{
		input = {
			[ "Oplovis linens" ] = 19,
		},
		output = {
			[ "Glass" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Lockslab",
	{
		input = {
			[ "Fiberplast" ] = 11,
		},
		output = {
			[ "Lockslab" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Heart of Fire",
	{
		input = {
			[ "Chromasheath" ] = 7,
		},
		output = {
			[ "Heart of Fire" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Quickwake",
	{
		input = {
			[ "Dendrite" ] = 14,
		},
		output = {
			[ "Quickwake" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Nanofoil",
	{
		input = {
			[ "Crystalline vertex" ] = 15,
		},
		output = {
			[ "Nanofoil" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Duraplate",
	{
		input = {
			[ "Fonwim" ] = 8,
		},
		output = {
			[ "Duraplate" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Cinnabar",
	{
		input = {
			[ "B'omarr regeneration gem" ] = 4,
		},
		output = {
			[ "Cinnabar" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Promethium",
	{
		input = {
			[ "Syncloth" ] = 18,
		},
		output = {
			[ "Promethium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rubies",
	{
		input = {
			[ "Glitterglass" ] = 13,
		},
		output = {
			[ "Rubies" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Falasian liquid crystal",
	{
		input = {
			[ "Silkweed" ] = 9,
		},
		output = {
			[ "Falasian liquid crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Blood thinner",
	{
		input = {
			[ "Munka" ] = 9,
		},
		output = {
			[ "Blood thinner" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Santherian tenho-root",
	{
		input = {
			[ "Reflec" ] = 8,
		},
		output = {
			[ "Santherian tenho-root" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sormahil fire gem",
	{
		input = {
			[ "Silorna Force Crystal" ] = 17,
		},
		output = {
			[ "Sormahil fire gem" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plasto-canvas",
	{
		input = {
			[ "Synfleece" ] = 18,
		},
		output = {
			[ "Plasto-canvas" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Codoan Copper",
	{
		input = {
			[ "Seoularian crystal" ] = 13,
		},
		output = {
			[ "Codoan Copper" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Corwindyl paste",
	{
		input = {
			[ "Hydrocarbon" ] = 14,
		},
		output = {
			[ "Corwindyl paste" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Whirlpool opal",
	{
		input = {
			[ "Kelerium" ] = 4,
		},
		output = {
			[ "Whirlpool opal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Jasse heart",
	{
		input = {
			[ "Ameron" ] = 14,
		},
		output = {
			[ "Jasse heart" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Airseal gel",
	{
		input = {
			[ "Kagle family cold cure" ] = 14,
		},
		output = {
			[ "Airseal gel" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crystalline creatures",
	{
		input = {
			[ "Plastisynth" ] = 10,
		},
		output = {
			[ "Crystalline creatures" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Anothian living crystal",
	{
		input = {
			[ "Corellian Jiang" ] = 19,
		},
		output = {
			[ "Anothian living crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Silica",
	{
		input = {
			[ "Condensed-matter composite" ] = 12,
		},
		output = {
			[ "Silica" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Cerulean gemstone",
	{
		input = {
			[ "Antibiotic" ] = 10,
		},
		output = {
			[ "Cerulean gemstone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Oracle salve",
	{
		input = {
			[ "Plasto-canvas" ] = 15,
		},
		output = {
			[ "Oracle salve" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Cyanogen silicate",
	{
		input = {
			[ "Calcite" ] = 18,
		},
		output = {
			[ "Cyanogen silicate" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Hollinium chloride",
	{
		input = {
			[ "Dilarium oil" ] = 14,
		},
		output = {
			[ "Hollinium chloride" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Hypergem",
	{
		input = {
			[ "Calcium carbonate" ] = 6,
		},
		output = {
			[ "Hypergem" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Susurra-weave",
	{
		input = {
			[ "Ledris" ] = 18,
		},
		output = {
			[ "Susurra-weave" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Smash",
	{
		input = {
			[ "Sinthenol" ] = 18,
		},
		output = {
			[ "Smash" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Genetic coherence sequencer",
	{
		input = {
			[ "Packing foam" ] = 20,
		},
		output = {
			[ "Genetic coherence sequencer" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Hiridiu crystal",
	{
		input = {
			[ "Calcium" ] = 19,
		},
		output = {
			[ "Hiridiu crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Satina",
	{
		input = {
			[ "Plastifoam" ] = 6,
		},
		output = {
			[ "Satina" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Cyanogen",
	{
		input = {
			[ "Sormahil fire gem" ] = 11,
		},
		output = {
			[ "Cyanogen" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Yttrium",
	{
		input = {
			[ "Rhodochrosite" ] = 2,
		},
		output = {
			[ "Yttrium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Nylonite",
	{
		input = {
			[ "Emperor's Favor" ] = 8,
		},
		output = {
			[ "Nylonite" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Coruscanthium",
	{
		input = {
			[ "Tarpaulin" ] = 7,
		},
		output = {
			[ "Coruscanthium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Armorplast",
	{
		input = {
			[ "Orichalum" ] = 16,
		},
		output = {
			[ "Armorplast" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Corellian Jiang",
	{
		input = {
			[ "Roe-Salve" ] = 15,
		},
		output = {
			[ "Corellian Jiang" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Synthweave",
	{
		input = {
			[ "Isotope-5" ] = 13,
		},
		output = {
			[ "Synthweave" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Agrinium",
	{
		input = {
			[ "Boram" ] = 9,
		},
		output = {
			[ "Agrinium" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Tandgor gem",
	{
		input = {
			[ "Selenite" ] = 4,
		},
		output = {
			[ "Tandgor gem" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Electrolytic serum",
	{
		input = {
			[ "Polyfilm" ] = 9,
		},
		output = {
			[ "Electrolytic serum" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Polyfibe",
	{
		input = {
			[ "Tursturin" ] = 3,
		},
		output = {
			[ "Polyfibe" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Elshandruu Pica miracle cure",
	{
		input = {
			[ "Insulfoam" ] = 8,
		},
		output = {
			[ "Elshandruu Pica miracle cure" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Anti-radiation pill",
	{
		input = {
			[ "Rippinnium" ] = 7,
		},
		output = {
			[ "Anti-radiation pill" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Stone",
	{
		input = {
			[ "Eternity Crystal" ] = 10,
		},
		output = {
			[ "Stone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Synthstone",
	{
		input = {
			[ "Ixetallic" ] = 12,
		},
		output = {
			[ "Synthstone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Flimsicard",
	{
		input = {
			[ "Myocaine" ] = 3,
		},
		output = {
			[ "Flimsicard" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Sasho gem",
	{
		input = {
			[ "Warming Crystal" ] = 16,
		},
		output = {
			[ "Sasho gem" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Dalonian crystal",
	{
		input = {
			[ "Kurline" ] = 1,
		},
		output = {
			[ "Dalonian crystal" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Singing stone",
	{
		input = {
			[ "Mouth rock" ] = 1,
		},
		output = {
			[ "Singing stone" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Stimulants",
	{
		input = {
			[ "Dactyl" ] = 11,
		},
		output = {
			[ "Stimulants" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Oplovis linens",
	{
		input = {
			[ "Animated metal sealant" ] = 2,
		},
		output = {
			[ "Oplovis linens" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Heart of the Universe",
	{
		input = {
			[ "Heart of the Universe" ] = 16,
		},
		output = {
			[ "Heart of the Universe" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Plasti-shroud",
	{
		input = {
			[ "Namana liquor" ] = 18,
		},
		output = {
			[ "Plasti-shroud" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Millaflower",
	{
		input = {
			[ "Plesticene" ] = 7,
		},
		output = {
			[ "Millaflower" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Crystalline vertex",
	{
		input = {
			[ "Plasti-shroud" ] = 12,
		},
		output = {
			[ "Crystalline vertex" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Triptophagea",
	{
		input = {
			[ "Coralite" ] = 8,
		},
		output = {
			[ "Triptophagea" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Gimer bush",
	{
		input = {
			[ "Fiberplast" ] = 11,
		},
		output = {
			[ "Gimer bush" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Polybiotic",
	{
		input = {
			[ "Varium" ] = 19,
		},
		output = {
			[ "Polybiotic" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Jiang",
	{
		input = {
			[ "Crism crystal" ] = 10,
		},
		output = {
			[ "Jiang" ] = 1,
		}
	}
)
MODULE:RegisterCrafting( "Rondium",
	{
		input = {
			[ "DC-15B" ] = 15,
		},
		output = {
			[ "Rondium" ] = 1,
		}
	}
)