AddCSLuaFile()

SWEP.Base = "simple_base"

SWEP.PrintName = "Glock-18"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.CSMuzzleFlashes = true

SWEP.Slot = 1

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_pist_glock18.mdl")
SWEP.WorldModel = Model("models/weapons/w_pist_glock18.mdl")

SWEP.HoldType = "pistol"
SWEP.LowerHoldType = "normal"

SWEP.Firemode = 0

SWEP.Primary = {
	Ammo = "Pistol",

	ClipSize = 20,
	DefaultClip = 60,

	Damage = 16,
	Delay = 60 / 400,
	BurstDelay = 60 / 1200,
	BurstEndDelay = 0.4,

	Range = 750,
	Accuracy = 12,

	RangeModifier = 0.85,

	Recoil = {
		MinAng = Angle(0.9, -0.3, 0),
		MaxAng = Angle(1, 0.3, 0),
		Punch = 0.4,
		Ratio = 0.6
	},

	Sound = "Weapon_Glock.Single",
	TracerName = "Tracer"
}

function SWEP:AltFire()
	self.Primary.Automatic = false

	self:SetFiremode(self:GetFiremode() == 0 and 3 or 0)

	self:EmitSound("Weapon_SMG1.Special1")
end

SWEP.NPCData = {
	Burst = {3, 3},
	Delay = SWEP.Primary.BurstDelay,
	Rest = {SWEP.Primary.BurstEndDelay, SWEP.Primary.BurstEndDelay * 3}
}

list.Add("NPCUsableWeapons", {class = "simple_css_glock", title = "Simple Weapons: " .. SWEP.PrintName})
