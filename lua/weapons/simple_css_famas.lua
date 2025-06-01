AddCSLuaFile()

SWEP.Base = "simple_base"

SWEP.PrintName = "FAMAS"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.CSMuzzleFlashes = true

SWEP.Slot = 2

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_rif_famas.mdl")
SWEP.WorldModel = Model("models/weapons/w_rif_famas.mdl")

SWEP.HoldType = "ar2"
SWEP.LowerHoldType = "passive"

SWEP.Firemode = -1

SWEP.Primary = {
	Ammo = "AR2",

	ClipSize = 25,
	DefaultClip = 50,

	Damage = 18,
	Delay = 60 / 666,
	BurstDelay = 60 / 800,
	BurstEndDelay = 0.4,

	Range = 1000,
	Accuracy = 12,

	RangeModifier = 0.96,

	Recoil = {
		MinAng = Angle(1, -0.3, 0),
		MaxAng = Angle(1.2, 0.3, 0),
		Punch = 0.4,
		Ratio = 0.4
	},

	Sound = "Weapon_FAMAS.Single",
	TracerName = "Tracer"
}

function SWEP:AltFire()
	self.Primary.Automatic = false

	self:SetFiremode(self:GetFiremode() == -1 and 3 or -1)

	self:EmitSound("Weapon_SMG1.Special1")
end

SWEP.NPCData = {
	Burst = {3, 3},
	Delay = SWEP.Primary.BurstDelay,
	Rest = {SWEP.Primary.BurstEndDelay, SWEP.Primary.BurstEndDelay * 3}
}

list.Add("NPCUsableWeapons", {class = "simple_css_famas", title = "Simple Weapons: " .. SWEP.PrintName})
