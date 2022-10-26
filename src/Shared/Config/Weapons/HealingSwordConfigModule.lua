-- Healing Sword Config Module
-- Username
-- October 25, 2022



local HealingSwordConfigModule = {}
HealingSwordConfigModule.TagName = "HealingSword"
HealingSwordConfigModule.DisplayName = "Healing Sword"
HealingSwordConfigModule.HumanoidToKill = ("Humanoid")
	HealingSwordConfigModule.WalkSpeed = 18
	HealingSwordConfigModule.JumpHeight = 10
	HealingSwordConfigModule.MaxDamage = 25
	HealingSwordConfigModule.MinDamage = 20
	HealingSwordConfigModule.AbilityDamage = 0
	HealingSwordConfigModule.HealAmount = 20
	HealingSwordConfigModule.Cooldown = 0.7
	HealingSwordConfigModule.Cost = 0
	HealingSwordConfigModule.ProjectileCooldown = 1
	HealingSwordConfigModule.ProjectileAnimation = "rbxassetid://10149103707"
	HealingSwordConfigModule.AbilityForce = 100
	HealingSwordConfigModule.AbilityCooldown = 20
	HealingSwordConfigModule.AbilityDebrisTimer = 2
	HealingSwordConfigModule.PlayerKnockbackVelocity = 10
	HealingSwordConfigModule.ComboResetTimer = 1.5
	HealingSwordConfigModule.HitBoxSize = Vector3.new(10,3,7)
	HealingSwordConfigModule.AbilityName = "Heal"
	HealingSwordConfigModule.Description = "Light Weight Sword, Ability: Heal by "..tostring(HealingSwordConfigModule.HealAmount).." Health, Cooldown: "..tostring(HealingSwordConfigModule.AbilityCooldown)

	-- Animations & Sounds
	HealingSwordConfigModule.SwingAnimations = {
		'rbxassetid://9991581812', --1
        'rbxassetid://9991378000', --2
        'rbxassetid://9991581812', --3
        'rbxassetid://9820421213', --4
        'rbxassetid://9991697436', --5
    }
	HealingSwordConfigModule.Textures = { -- Slash
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
	HealingSwordConfigModule.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return HealingSwordConfigModule