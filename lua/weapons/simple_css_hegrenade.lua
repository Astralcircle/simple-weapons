AddCSLuaFile()

if CLIENT then
	language.Add("simple_css_hegrenade_ammo", "HE Grenades")
end

game.AddAmmoType({name = "simple_css_hegrenade", maxcarry = 5})

SWEP.Base = "simple_base_throwing"

SWEP.PrintName = "HE Grenade"
SWEP.Category = "Simple Weapons: Counter-Strike: Source"

SWEP.Slot = 4

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModelFOV = 54

SWEP.ViewModel = Model("models/weapons/cstrike/c_eq_fraggrenade.mdl")
SWEP.WorldModel = Model("models/weapons/w_eq_fraggrenade.mdl")

SWEP.HoldType = "melee"

SWEP.Primary = {
	Ammo = "simple_css_hegrenade",

	ThrowAct = {ACT_VM_PULLBACK_HIGH, ACT_VM_THROW},
	LobAct = {ACT_VM_PULLBACK_LOW, ACT_VM_SECONDARYATTACK},
	RollAct = {ACT_VM_PULLBACK_LOW, ACT_VM_SECONDARYATTACK}
}

if SERVER then
	function SWEP:CreateEntity()
		local ent = ents.Create("simple_ent_css_hegrenade")
		local ply = self:GetOwner()

		ent:SetPos(ply:GetPos())
		ent:SetAngles(ply:EyeAngles())
		ent:SetOwner(ply)
		ent:Spawn()
		ent:Activate()

		ent:SetTimer(1.5)

		return ent
	end
end
