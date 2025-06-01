AddCSLuaFile()

simple_weapons.Include("Convars")

function SWEP:GetAmmoType()
	if self.Primary.Ammo == "" and self.Primary.ClipSize == -1 then
		return 0
	elseif self.Primary.Ammo == "" then
		return 3
	elseif self.Primary.ClipSize == -1 then
		return 2
	else
		return 1
	end
end

function SWEP:ConsumeAmmo()
	if self.AmmoType == 0 then
		return
	end

	local primary = self.Primary
	local cost = primary.Cost
	local ply = self:GetOwner()

	if self.AmmoType == 2 then
		cost = math.min(cost, ply:GetAmmoCount(primary.Ammo))

		ply:RemoveAmmo(cost, primary.Ammo)
	else
		self:TakePrimaryAmmo(math.min(cost, self:Clip1()))
	end
end

function SWEP:GetAmmo()
	if self.AmmoType == 1 or self.AmmoType == 3 then
		return self:Clip1()
	elseif self.AmmoType == 2 then
		return self:GetOwner():GetAmmoCount(self.Primary.Ammo)
	end

	return 1
end
