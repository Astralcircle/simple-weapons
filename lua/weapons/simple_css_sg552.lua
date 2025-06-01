AddCSLuaFile()

SWEP.Base = "simple_base_scoped"

SWEP.PrintName = "SG 552"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.CSMuzzleFlashes = true

SWEP.Slot = 2

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_rif_sg552.mdl")
SWEP.WorldModel = Model("models/weapons/w_rif_sg552.mdl")

SWEP.HoldType = "ar2"
SWEP.LowerHoldType = "passive"

SWEP.Firemode = -1

SWEP.Primary = {
	Ammo = "AR2",

	ClipSize = 30,
	DefaultClip = 60,

	Damage = 23,

	Range = 1600,
	Accuracy = 12,

	RangeModifier = 0.98,

	Recoil = {
		MinAng = Angle(1, -0.4, 0),
		MaxAng = Angle(1.2, 0.4, 0),
		Punch = 0.4,
		Ratio = 0.4
	},

	Sound = "Weapon_SG552.Single",
	TracerName = "Tracer"
}

SWEP.ScopeZoom = 3
SWEP.ScopeSound = "Default.Zoom"

SWEP.UseScope = false

SWEP.NPCData = {
	Burst = {3, 5},
	Delay = 60 / 429,
	Rest = {60 / 429 * 3, 60 / 429 * 5}
}

list.Add("NPCUsableWeapons", {class = "simple_css_sg552", title = "Simple Weapons: " .. SWEP.PrintName})

function SWEP:GetDelay()
	return self:GetScopeIndex() > 0 and 60 / 429 or 60 / 666
end
