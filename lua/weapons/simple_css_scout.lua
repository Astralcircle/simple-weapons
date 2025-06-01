AddCSLuaFile()

DEFINE_BASECLASS("simple_base_scoped")

SWEP.Base = "simple_base_scoped"

SWEP.PrintName = "Steyr Scout"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.CSMuzzleFlashes = true

SWEP.Slot = 3

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_snip_scout.mdl")
SWEP.WorldModel = Model("models/weapons/w_snip_scout.mdl")

SWEP.HoldType = "ar2"
SWEP.LowerHoldType = "passive"

SWEP.Firemode = 0

SWEP.Primary = {
	Ammo = "XBowBolt",

	ClipSize = 10,
	DefaultClip = 10,

	Damage = 55,
	Delay = 1.25,

	Range = 4000,
	Accuracy = 12,

	UnscopedRange = 80,
	UnscopedAccuracy = 12,

	RangeModifier = 0.98,

	Recoil = {
		MinAng = Angle(2, -0.8, 0),
		MaxAng = Angle(3, 0.8, 0),
		Punch = 0.4,
		Ratio = 0.2
	},

	Sound = "Weapon_Scout.Single",
	TracerName = "Tracer"
}

SWEP.ScopeZoom = {2.25, 9}
SWEP.ScopeSound = "Default.Zoom"

SWEP.NPCData = {
	Burst = {1, 1},
	Delay = 1.4,
	Rest = {1, 3}
}

list.Add("NPCUsableWeapons", {class = "simple_css_scout", title = "Simple Weapons: " .. SWEP.PrintName})

if SERVER then
	function SWEP:GetNPCBulletSpread(prof)
		return BaseClass.GetNPCBulletSpread(self, prof) * 0.5
	end
end
