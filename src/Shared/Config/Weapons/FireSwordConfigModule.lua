-- Fire Sword Module
-- Username
-- October 25, 2022



local FireSwordWeaponConfig = {}
FireSwordWeaponConfig.TagName = "FireSword"
FireSwordWeaponConfig.DisplayName = "Fire Sword"
FireSwordWeaponConfig.HumanoidToKill = ("Humanoid")
	FireSwordWeaponConfig.WalkSpeed = 22
	FireSwordWeaponConfig.JumpHeight = 12
	FireSwordWeaponConfig.MaxDamage = 30
	FireSwordWeaponConfig.MinDamage = 25
	FireSwordWeaponConfig.AbilityDamage = 10
	FireSwordWeaponConfig.Cooldown = 0.5
	FireSwordWeaponConfig.Cost = 0
	FireSwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	FireSwordWeaponConfig.ProjectileName = "BasicFireball"
	FireSwordWeaponConfig.AbilityForce = 100
	FireSwordWeaponConfig.AbilityCooldown = 1
	FireSwordWeaponConfig.AbilityDebrisTimer = 2
	FireSwordWeaponConfig.PlayerKnockbackVelocity = 35
	FireSwordWeaponConfig.ComboResetTimer = 1.2
	FireSwordWeaponConfig.HitBoxSize = Vector3.new(10,3,7)
	FireSwordWeaponConfig.AbilityName = "Projectile"
	FireSwordWeaponConfig.Description = "Lightweight and versitile sword, Ability: Fire Ball with BaseDamage: "..tostring(FireSwordWeaponConfig.AbilityDamage)..", Cooldown: "..tostring(FireSwordWeaponConfig.AbilityCooldown)

	-- Animations & Sounds
	FireSwordWeaponConfig.SwingAnimations = {
        'rbxassetid://9820421213', --1
        'rbxassetid://9991378000', --2
        'rbxassetid://9991581812', --3
        'rbxassetid://9820421213', --4
        'rbxassetid://9991697436', --5
    }
	FireSwordWeaponConfig.Textures = { -- Slash
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
	FireSwordWeaponConfig.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return FireSwordWeaponConfig