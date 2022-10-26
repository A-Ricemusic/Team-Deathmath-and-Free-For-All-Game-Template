-- Ability Controller
-- Username
-- October 25, 2022



local AbilityController = {}


function AbilityController:Start()
    local AbilityService = self.Services.AbilityService
    function AbilityController.Ability(WeaponConfig)
        if WeaponConfig.AbilityName == 'Projectile' then
            AbilityService:Projectile(WeaponConfig)
        end

        if WeaponConfig.AbilityName == 'FastRun' then
            AbilityService:FastRun(WeaponConfig)
        end

        if WeaponConfig.AbilityName == 'Heal' then
            AbilityService:Heal(WeaponConfig)
        end

        if WeaponConfig.AbilityName == 'ForceField' then
            AbilityService:ForceField(WeaponConfig)
        end
	end
end


function AbilityController:Init()

end


return AbilityController