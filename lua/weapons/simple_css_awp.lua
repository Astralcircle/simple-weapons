AddCSLuaFile()

DEFINE_BASECLASS("simple_base_scoped")

SWEP.Base = "simple_base_scoped"

SWEP.PrintName = "AWP"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.CSMuzzleFlashes = true

SWEP.Slot = 3

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_snip_awp.mdl")
SWEP.WorldModel = Model("models/weapons/w_snip_awp.mdl")

SWEP.HoldType = "ar2"
SWEP.LowerHoldType = "passive"

SWEP.Firemode = 0

SWEP.Primary = {
	Ammo = "XBowBolt",

	ClipSize = 10,
	DefaultClip = 10,

	Damage = 85,
	Delay = 1.5,

	Range = 4000,
	Accuracy = 12,

	UnscopedRange = 80,
	UnscopedAccuracy = 12,

	RangeModifier = 0.99,

	Recoil = {
		MinAng = Angle(2, -0.8, 0),
		MaxAng = Angle(3, 0.8, 0),
		Punch = 0.6,
		Ratio = 0.2
	},

	Sound = "Weapon_AWP.Single",
	TracerName = "Tracer"
}

SWEP.ScopeZoom = {2.25, 9}
SWEP.ScopeSound = "Default.Zoom"

SWEP.NPCData = {
	Burst = {1, 1},
	Delay = SWEP.Primary.Delay,
	Rest = {2, 4}
}

list.Add("NPCUsableWeapons", {class = "simple_css_awp", title = "Simple Weapons: " .. SWEP.PrintName})

-- Dynamic Weapon Reverb support
SWEP.dwr_customAmmoType = "ar2"

if SERVER then
	function SWEP:GetNPCBulletSpread(prof)
		return BaseClass.GetNPCBulletSpread(self, prof) * 0.5
	end
end
