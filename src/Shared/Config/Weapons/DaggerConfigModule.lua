-- Dagger Config Module
-- Username
-- October 25, 2022




local DaggerConfigModule = {}
DaggerConfigModule.TagName = "Dagger"
DaggerConfigModule.DisplayName = "Dagger"
DaggerConfigModule.HumanoidToKill = ("Humanoid")
	DaggerConfigModule.WalkSpeed = 25
	DaggerConfigModule.JumpHeight = 15
	DaggerConfigModule.MaxDamage = 15
	DaggerConfigModule.MinDamage = 10
	DaggerConfigModule.AbilityDamage = 15
	DaggerConfigModule.Cooldown = 0.3
	DaggerConfigModule.Cost = 0
	DaggerConfigModule.ProjectileAnimation = "rbxassetid://10149103707"
	DaggerConfigModule.ProjectileName = "ThrowingKnife"
	DaggerConfigModule.AbilityForce = 100
	DaggerConfigModule.AbilityCooldown = 0.5
	DaggerConfigModule.AbilityDebrisTimer = 5
	DaggerConfigModule.PlayerKnockbackVelocity = 5
	DaggerConfigModule.ComboResetTimer = 1.5
	DaggerConfigModule.HitBoxSize = Vector3.new(5,3,5)
	DaggerConfigModule.AbilityName = "Projectile"
	DaggerConfigModule.Description = "Dagger, great at ranged. Ability: throwing knife with BaseDamage"..tostring(DaggerConfigModule.AbilityDamage)..", Cooldown: "..tostring(DaggerConfigModule.AbilityCooldown)
	-- Animations & Sounds
	DaggerConfigModule.SwingAnimations = {
        'rbxassetid://9991697436', --1
		'rbxassetid://9991581812', --2
        'rbxassetid://9991697436', --3
        'rbxassetid://9991378000', --4
        'rbxassetid://9991581812', --5
    }
	DaggerConfigModule.Textures = { -- Slash
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
	DaggerConfigModule.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return DaggerConfigModule