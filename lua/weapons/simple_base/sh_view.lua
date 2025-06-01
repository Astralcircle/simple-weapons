AddCSLuaFile()

DEFINE_BASECLASS("weapon_base")

function SWEP:TranslateFOV(fov)
	if not IsValid(self:GetOwner()) then
		return fov
	end

	local desired = self:GetOwnerDefaultFOV()

	self.ViewModelFOV = self.ViewModelTargetFOV + (desired - fov) * 0.6

	return fov
end

local SwayScale, BobScale = GetConVar("simple_weapons_swayscale"), GetConVar("simple_weapons_bobscale")

function SWEP:HandleViewModel()
	if CLIENT then
		self.SwayScale = SwayScale:GetFloat()
		self.BobScale = BobScale:GetFloat()
	end
end

if CLIENT then
	function SWEP:CalcView(ply, pos, ang, fov)
		if not self:HasCameraControl() then
			return
		end

		return pos, ang - ply:GetViewPunchAngles() * self.Primary.Recoil.Ratio, fov
	end
	
	local VMOffsetX, VMOffsetY, VMOffsetZ  = GetConVar("simple_weapons_vm_offset_x"), GetConVar("simple_weapons_vm_offset_y"), GetConVar("simple_weapons_vm_offset_z")

	function SWEP:GetViewModelPosition(pos, ang)
		local offset = self.ViewOffset + Vector(VMOffsetX:GetFloat(), VMOffsetY:GetFloat(), VMOffsetZ:GetFloat())

		pos, ang = LocalToWorld(offset, Angle(0, 0, 0), pos, ang)

		local ply = self:GetOwner()

		if IsValid(ply) then
			local const = math.pi / 360
			local fov, vmfov = ply:GetFOV(), self.ViewModelFOV
			local ratio = math.tan(math.min(fov, vmfov) * const) / math.tan(math.max(fov, vmfov) * const)

			ang = ang + ply:GetViewPunchAngles() * ratio * self.Primary.Recoil.Ratio
		end

		return pos, ang
	end

	function SWEP:AdjustMouseSensitivity()
		if not self:HasCameraControl() then
			return 1
		end

		local desired = self:GetOwnerDefaultFOV()
		local fov = self:GetFOV()

		return fov / desired
	end

	function SWEP:DrawWorldModelTranslucent(flags)
		self:DrawWorldModel(flags)
	end
end
