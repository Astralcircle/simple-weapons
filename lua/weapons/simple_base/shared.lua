AddCSLuaFile()

simple_weapons.Include("Convars")

SWEP.Base = "weapon_base"

SWEP.m_WeaponDeploySpeed = 1

SWEP.DrawWeaponInfoBox = false

SWEP.ViewModelTargetFOV = 54
SWEP.ViewModelFOV = 54

SWEP.SimpleWeapon = true

SWEP.HoldType = "ar2"
SWEP.CustomHoldType = {}

SWEP.Firemode = -1

SWEP.Primary.Ammo = ""
SWEP.Primary.Cost = 1

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0

SWEP.Primary.PumpAction = false
SWEP.Primary.PumpSound = ""

SWEP.Primary.Damage = 0
SWEP.Primary.Count = 1

SWEP.Primary.Spread = Vector(0, 0, 0)

SWEP.Primary.Range = 1000
SWEP.Primary.Accuracy = 12

SWEP.Primary.Delay = 0.1

SWEP.Primary.BurstDelay = 0
SWEP.Primary.BurstEndDelay = 0

SWEP.Primary.Recoil = {
	MinAng = angle_zero,
	MaxAng = angle_zero,
	Punch = 0,
	Ratio = 0,
}

SWEP.Primary.Reload = {
	Time = 0,
	Amount = math.huge,
	Shotgun = false,
	Sound = ""
}

SWEP.Primary.Sound = ""
SWEP.Primary.TracerName = ""
SWEP.Primary.TracerFrequency = 2

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false

SWEP.ViewOffset = Vector()

SWEP.NPCData = {
	Burst = {3, 5},
	Delay = 0.1,
	Rest = {0.5, 1}
}

if CLIENT then
	include("cl_hud.lua")
else
	AddCSLuaFile("cl_hud.lua")
end

include("sh_ammo.lua")
include("sh_animations.lua")
include("sh_attack.lua")
include("sh_getters.lua")
include("sh_helpers.lua")
include("sh_recoil.lua")
include("sh_reload.lua")
include("sh_sound.lua")
include("sh_view.lua")

if SERVER then
	include("sv_npc.lua")
end

function SWEP:Initialize()
	self:SetFiremode(self.Firemode)

	self.AmmoType = self:GetAmmoType()
end

function SWEP:SetupDataTables()
	self:NetworkVar("Entity", "LastOwner")

	self:NetworkVar("Bool", "NeedPump")
	self:NetworkVar("Bool", "FirstReload")
	self:NetworkVar("Bool", "AbortReload")

	self:NetworkVar("Int", "Firemode")
	self:NetworkVar("Int", "BurstFired")

	self:NetworkVar("Float", "NextIdle")
	self:NetworkVar("Float", "FinishReload")

	self:NetworkVar("Float", "NextFire")
	self:NetworkVar("Float", "NextAltFire")
end

-- No longer needed now that NetworkVar does this internally
function SWEP:AddNetworkVar(...)
	self:NetworkVar(...)
end

function SWEP:OwnerChanged()
	local old = self:GetLastOwner()

	if IsValid(old) and old:IsPlayer() then
		old:SetFOV(0, 0.1, self)
	end

	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsNPC() then
		self:SetHoldType(self.HoldType)
	end

	self:SetLastOwner(ply)
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self:SetNextIdle(CurTime() + self:SequenceDuration())

	return true
end

function SWEP:Holster()
	self:SetFirstReload(false)
	self:SetAbortReload(false)
	self:SetFinishReload(0)

	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsPlayer() then
		ply:SetFOV(0, 0.1, self)
	end

	return true
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()

	if self:GetNextFire() > CurTime() or not self:CanPrimaryFire() then
		return
	end

	self:PrimaryFire()
end

function SWEP:SecondaryAttack()
	self:TryAltFire()
end

function SWEP:HandleIdle()
	local idle = self:GetNextIdle()

	if idle > 0 and idle <= CurTime() then
		self:SendTranslatedWeaponAnim(ACT_VM_IDLE)

		self:SetNextIdle(0)
	end
end

function SWEP:HandlePump()
	if self:GetNeedPump() and not self:IsReloading() and self:GetNextFire() <= CurTime() then
		if not self.Primary.PumpOnEmpty and self:Clip1() == 0 then
			return
		end

		self:SendTranslatedWeaponAnim(ACT_SHOTGUN_PUMP)

		local snd = self.Primary.PumpSound

		if snd != "" and IsFirstTimePredicted() then
			self:EmitSound(snd)
		end

		local duration = self:SequenceDuration()

		self:SetNextFire(CurTime() + duration)
		self:SetNextIdle(CurTime() + duration)

		self:SetNeedPump(false)
	end
end

function SWEP:HandleBurst()
	if self:GetBurstFired() > 0 and CurTime() > self:GetNextFire() + engine.TickInterval() then
		self:SetBurstFired(0)
		self:SetNextFire(CurTime() + self:GetDelay())
	end
end

function SWEP:Think()
	self:HandleReload()
	self:HandleIdle()
	self:HandlePump()
	self:HandleBurst()
	self:HandleViewModel()
end

function SWEP:OnReloaded()
	if self:GetHoldType() != "" then
		self:SetWeaponHoldType(self:GetHoldType())
	end
end

function SWEP:OnRemove()
	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsPlayer() then
		ply:SetFOV(0, 0, self)
	end
end

function SWEP:OnRestore()
	self:SetFirstReload(false)
	self:SetAbortReload(false)

	self:SetBurstFired(0)

	self:SetNextIdle(CurTime())
	self:SetFinishReload(0)

	self:SetNextFire(CurTime())
	self:SetNextAltFire(CurTime())
end
