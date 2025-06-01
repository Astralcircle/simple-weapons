AddCSLuaFile()

SWEP.Base = "simple_base"

SWEP.PrintName = "Galil"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.CSMuzzleFlashes = true

SWEP.Slot = 2

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_rif_galil.mdl")
SWEP.WorldModel = Model("models/weapons/w_rif_galil.mdl")

SWEP.HoldType = "ar2"
SWEP.LowerHoldType = "passive"

SWEP.Firemode = -1

SWEP.Primary = {
	Ammo = "AR2",

	ClipSize = 35,
	DefaultClip = 90,

	Damage = 18,
	Delay = 60 / 666,

	Range = 1000,
	Accuracy = 12,

	RangeModifier = 0.98,

	Recoil = {
		MinAng = Angle(1, -0.3, 0),
		MaxAng = Angle(1.2, 0.3, 0),
		Punch = 0.5,
		Ratio = 0.4
	},

	Sound = "Weapon_Galil.Single",
	TracerName = "Tracer"
}

SWEP.NPCData = {
	Burst = {3, 5},
	Delay = SWEP.Primary.Delay,
	Rest = {SWEP.Primary.Delay * 2, SWEP.Primary.Delay * 3}
}

list.Add("NPCUsableWeapons", {class = "simple_css_galil", title = "Simple Weapons: " .. SWEP.PrintName})
