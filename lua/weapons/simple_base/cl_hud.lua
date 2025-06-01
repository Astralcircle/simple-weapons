simple_weapons.Include("Convars")
simple_weapons.Include("Enums")

function SWEP:DoDrawCrosshair(x, y)
	if self.OverrideCrosshairDraw then
		return self:OverrideCrosshairDraw(x, y)
	end

	if not self:ShouldHideCrosshair() then
		return self:DrawCrosshair(x, y)
	end

	return true
end

function SWEP:ShouldHideCrosshair()
	return self:IsReloading()
end

function SWEP:DrawCrosshair(x, y)
	return false
end

function SWEP:CustomAmmoDisplay()
	if self.AmmoType == AMMO_NONE then
		return {Draw = false}
	elseif self.AmmoType == AMMO_INTERNAL then
		return {
			Draw = true,
			PrimaryClip = self:Clip1()
		}
	end
end
