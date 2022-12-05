-- Bronze Sword Config Module
-- Username
-- September 29, 2022


mult = 3
local FireSwordWeaponConfig = {}
FireSwordWeaponConfig.TagName = "FireSword"
FireSwordWeaponConfig.DisplayName = "Fire Sword"
FireSwordWeaponConfig.HumanoidToKill = ("Humanoid")
	FireSwordWeaponConfig.WalkSpeed = 14
	FireSwordWeaponConfig.JumpHeight = 12
	FireSwordWeaponConfig.MaxDamage = 7 * mult
	FireSwordWeaponConfig.MinDamage = 5 * mult
	FireSwordWeaponConfig.AbilityDamage = 10
	FireSwordWeaponConfig.Cooldown = 0.5
	FireSwordWeaponConfig.Cost = 200
	FireSwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	FireSwordWeaponConfig.ProjectileName = "BasicFireball"
	FireSwordWeaponConfig.AbilityForce = 100
	FireSwordWeaponConfig.AbilityCooldown = 1
	FireSwordWeaponConfig.AbilityDebrisTimer = 1
	FireSwordWeaponConfig.PlayerKnockbackVelocity = 35
	FireSwordWeaponConfig.ComboResetTimer = 1.2
	FireSwordWeaponConfig.HitBoxSize = Vector3.new(15,5,10)
	FireSwordWeaponConfig.AbilityName = "Projectile"
	FireSwordWeaponConfig.Description = "Medium Weight Sword, Ability: Aniba's Fire (Shoots a big fireball)"

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