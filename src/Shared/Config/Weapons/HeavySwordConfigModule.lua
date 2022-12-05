-- Bronze Sword Config Module
-- Username
-- September 29, 2022


mult = 3
local HeavySwordWeaponConfig = {}
HeavySwordWeaponConfig.TagName = "HeavySword"
HeavySwordWeaponConfig.DisplayName = "Heavy Sword"
HeavySwordWeaponConfig.HumanoidToKill = ("Humanoid")
	HeavySwordWeaponConfig.WalkSpeed = 8
	HeavySwordWeaponConfig.JumpHeight = 5
	HeavySwordWeaponConfig.MaxDamage = 15 * mult
	HeavySwordWeaponConfig.MinDamage = 10 * mult
	HeavySwordWeaponConfig.AbilityDamage = 10
	HeavySwordWeaponConfig.Cooldown = 1.5
	HeavySwordWeaponConfig.Cost = 200
	HeavySwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	HeavySwordWeaponConfig.ProjectileName = "BigFireball"
	HeavySwordWeaponConfig.AbilityForce = 150
	HeavySwordWeaponConfig.AbilityCooldown = 30
	HeavySwordWeaponConfig.AbilityDebrisTimer = 10
	HeavySwordWeaponConfig.PlayerKnockbackVelocity = 70
	HeavySwordWeaponConfig.ComboResetTimer = 4
	HeavySwordWeaponConfig.HitBoxSize = Vector3.new(15,3,10)
	HeavySwordWeaponConfig.AbilityName = "ForceField"
	HeavySwordWeaponConfig.Description = "Heavy Weight Sword, Ability: Avida's Aura (Gives player invincibility for a short time, allows player to walk on air in certain places)"
	-- Animations & Sounds
	HeavySwordWeaponConfig.SwingAnimations = {
        'rbxassetid://9991378000', --1
		'rbxassetid://9991581812', --2
        'rbxassetid://9991697436', --3
        'rbxassetid://9991581812', --4
        'rbxassetid://9991697436', --5
    }
	HeavySwordWeaponConfig.Textures = { -- Slash
	'rbxassetid://8821193347', --1
	'rbxassetid://8821230983', --2
	'rbxassetid://8821246947', --3
	'rbxassetid://8821254467', --4
	'rbxassetid://8821272181', --5
	'rbxassetid://8821280832', --6
	'rbxassetid://8821300395', --7
	'rbxassetid://8821311218', --8
	'rbxassetid://8896641723', --9
	}
	HeavySwordWeaponConfig.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return HeavySwordWeaponConfig