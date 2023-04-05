
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )

end

if ( CLIENT ) then

	SWEP.PrintName			= "E-11 - Stun"

	SWEP.Author				= "TFA, Servius: Edit by Sim"

	SWEP.ViewModelFOV      	= 50

	SWEP.Slot				= 2

	SWEP.SlotPos			= 3

end

SWEP.Base					= "tfa_3dscoped_base"

SWEP.Category = "[Orbital] Blaster Rifles"

SWEP.Spawnable				= true

SWEP.AdminSpawnable			= true

SWEP.HoldType = "ar2"

SWEP.ViewModelFOV = 70

SWEP.ViewModelFlip = false

SWEP.ViewModel = "models/bf2017/c_e11.mdl"

SWEP.WorldModel = "models/bf2017/w_e11.mdl"

SWEP.ShowViewModel = true

SWEP.ShowWorldModel = false

SWEP.UseHands = true

SWEP.Primary.Sound = Sound ("w/e11.wav");

SWEP.Primary.ReloadSound = Sound ("w/rifles.wav");

SWEP.Primary.KickUp			= 2

SWEP.Weight					= 5

SWEP.AutoSwitchTo			= false

SWEP.AutoSwitchFrom			= false

SWEP.Primary.Recoil			= 0.4

SWEP.Primary.Damage			= 50

SWEP.Primary.NumShots		= 1

SWEP.Primary.Spread			= 0.0125

SWEP.Primary.IronAccuracy = .001	-- Ironsight accuracy, should be the same for shotguns

SWEP.Primary.ClipSize		= 30

SWEP.Primary.RPM            = 325

SWEP.Primary.DefaultClip	= 50

SWEP.Primary.Automatic		= true

SWEP.Primary.Ammo			= "ar2"

SWEP.SelectiveFire		= true --Allow selecting your firemode?

SWEP.DisableBurstFire	= false --Only auto/single?

SWEP.OnlyBurstFire		= false --No auto, only burst/single?

SWEP.DefaultFireMode 	= "" --Default to auto or whatev

SWEP.FireModes = {

"Auto",

"3Burst",

"Single"

}

SWEP.FireModeName = nil --Change to a text value to override it

SWEP.Secondary.Automatic	= false

SWEP.Secondary.Ammo			= "none"

SWEP.Secondary.IronFOV = 70

SWEP.ViewModelBoneMods = {
	["v_e11_reference001"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-3, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["e11"] = { type = "Model", model = "models/kuro/sw_battlefront/weapons/bf1/e11.mdl", bone = "v_e11_reference001", rel = "", pos = Vector(-1, 6, -3), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["scope"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_e11_reference001", rel = "e11", pos = Vector(-6.85, -0.035, 7.325), angle = Angle(0, 180, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["e11"] = { type = "Model", model = "models/kuro/sw_battlefront/weapons/bf1/e11.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 0.4, 1), angle = Angle(192, 180, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.IronSightsPos = Vector(-2.9, -8, 3)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(5.226, -2, 0)
SWEP.RunSightsAng = Vector(-18, 36, -13.5)
SWEP.InspectPos = Vector(8, -4.8, -3)
SWEP.InspectAng = Vector(11.199, 38, 0)

SWEP.BlowbackVector = Vector(0,-3,0.025)

SWEP.Blowback_Only_Iron  = false

SWEP.DoProceduralReload = true

SWEP.ProceduralReloadTime = 2.5

----Swft Base Code

SWEP.TracerCount = 1

SWEP.MuzzleFlashEffect = ""

SWEP.TracerName = "effect_sw_laser_red"

SWEP.Secondary.IronFOV = 70

SWEP.Primary.KickUp = 0.2

SWEP.Primary.KickDown = 0.1

SWEP.Primary.KickHorizontal = 0.1

SWEP.Primary.KickRight = 0.1

SWEP.DisableChambering = true

SWEP.ImpactDecal = "FadingScorch"

SWEP.ImpactEffect = "effect_sw_impact" --Impact Effect

SWEP.RunSightsPos = Vector(2.127, 0, 1.355)

SWEP.RunSightsAng = Vector(-15.775, 10.023, -5.664)

SWEP.BlowbackEnabled = true

SWEP.BlowbackVector = Vector(0,-3,0.1)

SWEP.Blowback_Shell_Enabled = false

SWEP.Blowback_Shell_Effect = ""

SWEP.ThirdPersonReloadDisable=false

SWEP.Primary.DamageType = DMG_SHOCK

SWEP.DamageType = DMG_SHOCK

SWEP.Attachments = {
	[2] = { offset = { 0, 0 }, atts = { "stun-gun"}, order = 2 },


}

--[[3dScopedBase stuff

SWEP.RTMaterialOverride = 0

SWEP.RTScopeAttachment = -1

SWEP.Scoped_3D = true

SWEP.ScopeReticule = "scope/gdcw_vibrantred_nobar"

SWEP.Secondary.ScopeZoom = 8

SWEP.ScopeReticule_Scale = {2.5,2.5}

SWEP.Secondary.UseACOG			= false	 --Overlay option

SWEP.Secondary.UseMilDot			= false			 --Overlay option

SWEP.Secondary.UseSVD			= false		 --Overlay option

SWEP.Secondary.UseParabolic		= false		 --Overlay option

SWEP.Secondary.UseElcan			= false	 --Overlay option

SWEP.Secondary.UseGreenDuplex		= false		 --Overlay option

if surface then

	SWEP.Secondary.ScopeTable = nil --[[

		{

			scopetex = surface.GetTextureID("scope/gdcw_closedsight"),

			reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),

			dottex = surface.GetTextureID("scope/gdcw_acogcross")

		}

	--

--end--]]

SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "#sw/visor/sw_ret_redux_red" 
SWEP.Secondary.ScopeZoom 			= 7.5
SWEP.ScopeReticule_Scale 			= {1,1}

if surface then
	SWEP.Secondary.ScopeTable = {
		["ScopeMaterial"] =  Material("#sw/visor/sw_ret_redux_red.png", "smooth"),
		["ScopeBorder"] = color_black,
		["ScopeCrosshair"] = { ["r"] = 0, ["g"]  = 0, ["b"] = 0, ["a"] = 0, ["s"] = 1 }
	}
end

DEFINE_BASECLASS( SWEP.Base )

--[[

SWEP.ViewModelBoneMods = {

	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0.925, 0, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.555, 0.185), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0.925, -0.186, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0.555, -0.556, -0.186), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.186, -0.186), angle = Angle(0, 0, 0) },

	["v_weapon.awm_parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(1.799, 0.5, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0.925, 0, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(3.888, -0.926, 0.555), angle = Angle(0, 0, 0) }

}

SWEP.WElements = {

	["element_name"] = { type = "Model", model = "models/servius/starwars/ashura/dc15s.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.8, 1, 1.399), angle = Angle(-167, 178, 0), size = Vector(0.644, 0.644, 0.644), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

SWEP.VElements = {

	["element_name"] = { type = "Model", model = "models/servius/starwars/ashura/dc15s.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(0, 3.5, -6), angle = Angle(-90, 90, 0), size = Vector(0.82, 0.82, 0.82), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

SWEP.IronSightsPos = Vector(-7.401, -2.814, 2.519)

SWEP.IronSightsAng = Vector(0, 0, 0)



SWEP.HoldType = "ar2"

SWEP.ViewModelFOV = 70

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_snip_awp.mdl"

SWEP.WorldModel = "models/weapons/w_dc15sa.mdl"

SWEP.ShowViewModel = true

SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {

	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0.925, 0, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.555, 0.185), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0.925, -0.186, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0.555, -0.556, -0.186), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.186, -0.186), angle = Angle(0, 0, 0) },

	["v_weapon.awm_parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(1.799, 0.5, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0.925, 0, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(3.888, -0.926, 0.555), angle = Angle(0, 0, 0) }

}

--]]