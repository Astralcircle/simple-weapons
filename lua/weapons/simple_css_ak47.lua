AddCSLuaFile()

SWEP.Base = "simple_base"

SWEP.PrintName = "AK-47"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.CSMuzzleFlashes = true

SWEP.Slot = 2

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_rif_ak47.mdl")
SWEP.WorldModel = Model("models/weapons/w_rif_ak47.mdl")

SWEP.HoldType = "ar2"
SWEP.LowerHoldType = "passive"

SWEP.Firemode = -1

SWEP.Primary = {
	Ammo = "AR2",

	ClipSize = 30,
	DefaultClip = 60,

	Damage = 24,
	Delay = 60 / 600,

	Range = 1000,
	Accuracy = 12,

	RangeModifier = 0.98,

	Recoil = {
		MinAng = Angle(1.1, -0.5, 0),
		MaxAng = Angle(1.3, 0.5, 0),
		Punch = 0.4,
		Ratio = 0.6
	},

	Sound = "Weapon_AK47.Single",
	TracerName = "Tracer"
}

SWEP.NPCData = {
	Burst = {2, 3},
	Delay = SWEP.Primary.Delay,
	Rest = {SWEP.Primary.Delay * 3, SWEP.Primary.Delay * 5}
}

list.Add("NPCUsableWeapons", {class = "simple_css_ak47", title = "Simple Weapons: " .. SWEP.PrintName})
