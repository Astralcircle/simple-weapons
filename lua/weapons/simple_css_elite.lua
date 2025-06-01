AddCSLuaFile()

DEFINE_BASECLASS("simple_base")

SWEP.Base = "simple_base"

SWEP.PrintName = "Dual Elites"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.CSMuzzleFlashes = true

SWEP.Slot = 1

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelTargetFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_pist_elite.mdl")
SWEP.WorldModel = Model("models/weapons/w_pist_elite.mdl")

SWEP.HoldType = "duel"
SWEP.LowerHoldType = "normal"

SWEP.Firemode = 0

SWEP.Primary = {
	Ammo = "Pistol",

	ClipSize = 30,
	DefaultClip = 60,

	Damage = 18,
	Delay = 60 / 375,

	Range = 700,
	Accuracy = 12,

	RangeModifier = 0.75,

	Recoil = {
		MinAng = Angle(1.4, -0.8, 0),
		MaxAng = Angle(1.8, 0.8, 0),
		Punch = 0.3,
		Ratio = 0.7
	},

	Sound = "Weapon_ELITE.Single",
	TracerName = ""
}

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Bool", "AltGun")
end

function SWEP:TranslateWeaponAnim(act)
	if act == ACT_VM_PRIMARYATTACK and self:GetAltGun() then
		return ACT_VM_SECONDARYATTACK
	end

	return act
end

function SWEP:PrimaryFire()
	BaseClass.PrimaryFire(self)

	self:SetAltGun(not self:GetAltGun())
end

function SWEP:DoImpactEffect(tr, dmgtype)
	if tr.HitSky then
		return
	end

	if not game.SinglePlayer() and IsFirstTimePredicted() then
		return
	end

	if CLIENT then
		local ent = self:HasCameraControl() and self:GetOwner():GetViewModel() or self

		if not IsValid(ent) then
			return
		end

		local attachment = ent:GetAttachment(self:GetAltGun() and 2 or 1)

		if attachment then
			local effect = EffectData()

			effect:SetScale(10000)
			effect:SetOrigin(tr.HitPos)
			effect:SetStart(attachment.Pos)
			effect:SetEntity(ent)

			util.Effect("Tracer", effect)
		end
	end
end
