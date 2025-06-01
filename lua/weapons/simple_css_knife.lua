AddCSLuaFile()

DEFINE_BASECLASS("simple_base_melee")

SWEP.Base = "simple_base_melee"

SWEP.PrintName = "Knife"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.Slot = 0

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_knife_t.mdl")
SWEP.WorldModel = Model("models/weapons/w_knife_t.mdl")

SWEP.HoldType = "knife"
SWEP.LowerHoldType = "normal"

SWEP.Primary = {
	ChargeTime = 0.4,

	Light = {
		Damage = 24,
		DamageType = DMG_SLASH,

		Range = 75,
		Delay = 0.4,

		Act = ACT_VM_PRIMARYATTACK,

		Sound = {"Weapon_Crowbar.Melee_Hit", "Weapon_Crowbar.Single"}
	},

	Heavy = {
		Damage = 55,
		DamageType = DMG_SLASH,

		Range = 65,
		Delay = 1,

		Act = {ACT_VM_SECONDARYATTACK, ACT_VM_MISSCENTER},

		Sound = {"Weapon_Crowbar.Melee_Hit", "Weapon_Crowbar.Single"}
	}
}

SWEP.ChargeOffset = {
	Pos = Vector(0, 7.5, -2),
	Ang = Angle(5, -30, 0)
}

function SWEP:Deploy()
	BaseClass.Deploy(self)

	self:EmitSound("Weapon_Knife.Deploy")

	return true
end

function SWEP:PlayAttackSound(heavy, hit, trace)
	local snd = "Weapon_Knife.Slash"

	if hit then
		snd = "Weapon_Knife.HitWall"

		if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			snd = heavy and "Weapon_Knife.Stab" or "Weapon_Knife.Hit"
		end
	end

	self:EmitSound(snd)
end

function SWEP:GetDamage(heavy, trace)
	local damage, damageType = BaseClass.GetDamage(self, heavy, trace)
	local isLiving = trace.Entity:IsPlayer() or trace.Entity:IsNPC()

	if heavy and isLiving then
		local pos = trace.Entity:GetPos() - trace.StartPos

		pos.z = 0
		pos:Normalize()

		if pos:Dot(trace.Entity:GetForward()) > 0.70721 then
			damage = damage * 2
		end
	end

	if isLiving then
		damageType = DMG_CLUB -- Required for blood splat decals instead of knife cuts
	end

	return damage, damageType
end

function SWEP:TranslateWeaponAnim(act)
	if act == ACT_VM_IDLE then
		return ACT_VM_FIDGET
	end

	return act
end
