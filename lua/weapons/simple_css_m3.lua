AddCSLuaFile()

SWEP.Base = "simple_base"

SWEP.PrintName = "M3 Super 90"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.CSMuzzleFlashes = true

SWEP.Slot = 3

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_shot_m3super90.mdl")
SWEP.WorldModel = Model("models/weapons/w_shot_m3super90.mdl")

SWEP.HoldType = "shotgun"
SWEP.LowerHoldType = "passive"

SWEP.Firemode = 0

SWEP.Primary = {
	Ammo = "Buckshot",

	ClipSize = 8,
	DefaultClip = 32,

	Damage = 18,
	Count = 6,

	Delay = 60 / 68,

	Range = 400,
	Accuracy = 24,

	RangeModifier = 0.7,

	Recoil = {
		MinAng = Angle(2, -0.7, 0),
		MaxAng = Angle(3, 0.7, 0),
		Punch = 0.5,
		Ratio = 0
	},

	Reload = {
		Amount = 1,
		Shotgun = true
	},

	Sound = "Weapon_M3.Single",
	TracerName = "Tracer"
}

SWEP.NPCData = {
	Burst = {1, 1},
	Delay = SWEP.Primary.Delay,
	Rest = {SWEP.Primary.Delay, SWEP.Primary.Delay * 2}
}

list.Add("NPCUsableWeapons", {class = "simple_css_m3", title = "Simple Weapons: " .. SWEP.PrintName})
