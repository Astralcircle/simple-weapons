AddCSLuaFile()

simple_weapons.Include("Convars")

SWEP.Base = "weapon_base"

SWEP.m_WeaponDeploySpeed = 1

SWEP.DrawWeaponInfoBox = false

SWEP.ViewModelFOV = 54

SWEP.SimpleWeapon = true

SWEP.HoldType = "melee"

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false

SWEP.Primary.ChargeTime = 1
SWEP.Primary.AutoSwing = true

SWEP.Primary.Light = {
	Damage = 1,
	DamageType = DMG_CLUB,

	Range = 75,
	Delay = 0.1,

	Act = ACT_VM_HITCENTER,

	Sound = ""
}

SWEP.Primary.Heavy = {
	Damage = 1,
	DamageType = DMG_CLUB,

	Range = 75,
	Delay = 0.1,

	Act = ACT_VM_HITCENTER,

	Sound = ""
}

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false

SWEP.ChargeOffset = {
	Pos = Vector(),
	Ang = Angle()
}

include("sh_animations.lua")
include("sh_attack.lua")

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", "Lowered")

	self:NetworkVar("Float", "NextIdle")
	self:NetworkVar("Float", "ChargeTime")
end

-- No longer needed now that NetworkVar does this internally
function SWEP:AddNetworkVar(...)
	self:NetworkVar(...)
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self:SendTranslatedWeaponAnim(ACT_VM_DRAW)
	self:SetNextIdle(CurTime() + self:SequenceDuration())

	return true
end

function SWEP:Holster()
	self:SetChargeTime(0)

	return true
end

function SWEP:PrimaryAttack()
	if self.Primary.ChargeTime == 0 then
		self.Primary.Automatic = self.Primary.AutoSwing
		self:LightAttack()

		return
	end

	if self:GetChargeTime() != 0 then
		return
	end

	self:SetChargeTime(CurTime())

	self.Primary.Automatic = false
end

function SWEP:SecondaryAttack()

end

function SWEP:HandleIdle()
	local idle = self:GetNextIdle()

	if idle > 0 and idle <= CurTime() then
		self:SendTranslatedWeaponAnim(ACT_VM_IDLE)

		self:SetNextIdle(0)
	end
end

function SWEP:Think()
	self:HandleIdle()
	self:HandleCharge()
end

function SWEP:OnReloaded()
	self:SetWeaponHoldType(self:GetHoldType())
end

if CLIENT then
	function SWEP:DoDrawCrosshair(x, y)
		return false
	end

	local ease = math.ease.OutBack

	function SWEP:GetViewModelPosition(pos, ang)
		local offset = Vector(VMOffsetX:GetFloat(), VMOffsetY:GetFloat(), VMOffsetZ:GetFloat())

		pos, ang = LocalToWorld(offset, Angle(0, 0, 0), pos, ang)

		local charge = self:GetChargeTime()

		if self.Primary.ChargeTime > 0 and charge != 0 then
			local frac = ease(math.Clamp(math.Remap(CurTime() - charge, 0, self.Primary.ChargeTime * 2, 0, 1), 0, 1))

			local chargePos = LerpVector(frac, vector_origin, self.ChargeOffset.Pos)
			local chargeAng = LerpAngle(frac, angle_zero, self.ChargeOffset.Ang)

			pos, ang = LocalToWorld(chargePos, chargeAng, pos, ang)
		end

		return pos, ang
	end
end

function SWEP:OnRestore()
	self:SetNextIdle(CurTime())
	self:SetChargeTime(0)
end
