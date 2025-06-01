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
	if self.AmmoType == 0 then
		return {Draw = false}
	elseif self.AmmoType == 3 then
		return {
			Draw = true,
			PrimaryClip = self:Clip1()
		}
	end
end
