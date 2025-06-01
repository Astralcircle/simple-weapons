AddCSLuaFile()

SWEP.Base = "simple_base"

SWEP.PrintName = "TMP"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.Slot = 2

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_smg_tmp.mdl")
SWEP.WorldModel = Model("models/weapons/w_smg_tmp.mdl")

SWEP.HoldType = "smg"
SWEP.LowerHoldType = "passive"

SWEP.Firemode = -1

SWEP.Primary = {
	Ammo = "SMG1",

	ClipSize = 30,
	DefaultClip = 60,

	Damage = 8,
	Delay = 60 / 857,

	Range = 600,
	Accuracy = 12,

	RangeModifier = 0.87,

	Recoil = {
		MinAng = Angle(0.5, -0.3, 0),
		MaxAng = Angle(0.7, 0.3, 0),
		Punch = 0.6,
		Ratio = 0.6
	},

	Sound = "Weapon_TMP.Single",
	TracerName = ""
}

SWEP.NPCData = {
	Burst = {3, 9},
	Delay = SWEP.Primary.Delay,
	Rest = {SWEP.Primary.Delay * 3, SWEP.Primary.Delay * 5}
}

list.Add("NPCUsableWeapons", {class = "simple_css_tmp", title = "Simple Weapons: " .. SWEP.PrintName})

-- Dynamic Weapon Reverb support
SWEP.dwr_customIsSuppressed = true

function SWEP:FireAnimationEvent(_, _, event)
	if event == 5001 or event == 5003 then
		return true
	end
end
