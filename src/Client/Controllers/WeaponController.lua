-- Weapon Controller
-- Username
-- October 25, 2022




local WeaponController = {}

function WeaponController:Start()
    local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function(Character)
    local RightHand = Character:WaitForChild("RightHand")
RightHand.ChildAdded:Connect(function(Weapon)
    local IsTagged = game:GetService('CollectionService'):HasTag(Weapon, "GameItem")
    if not IsTagged then return end
    local WeaponTag = Weapon.Name
    local PathConfig = self.Shared.Config.PathConfigModule
    local WeaponConfig = require(PathConfig[WeaponTag]) 
    local Combo = 1
    local Anim = Instance.new('Animation')
    Anim.Parent = script
    local Walk = WeaponConfig.WalkSpeed
    local Jump = WeaponConfig.JumpHeight
    local Tween = game:GetService("TweenService")
    local SwingAnimations = WeaponConfig.SwingAnimations
    local ProjectileAnimation = WeaponConfig.ProjectileAnimation
    local Textures = WeaponConfig.Textures
    local ContextActionService = game:GetService('ContextActionService')
    local LastProjectile = 0      
    local LastSwing = 0
    local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")  
    Humanoid.WalkSpeed = Walk
    Humanoid.JumpHeight = Jump
    
local function Ability(ActionName,input)
        if ActionName == "Ability" and input == Enum.UserInputState.Begin and tick() - LastProjectile >= WeaponConfig.AbilityCooldown then      
			LastProjectile = tick()
			if WeaponConfig.AbilityName == "Projectile" then
			Humanoid.WalkSpeed = 0
			end
            Anim.AnimationId = ProjectileAnimation
            Humanoid:LoadAnimation(Anim):Play() 
            self.Controllers.AbilityController.Ability(WeaponConfig)
            Humanoid.WalkSpeed = WeaponConfig.WalkSpeed
       end
    end

local function SlashEffect(EffectSlash,HumanoidRootPart)
            if WeaponConfig.SlashEffect ~= nil then
                WeaponConfig.SlashEffect(Character)
            else
        wait(0.2)
        EffectSlash.CFrame = HumanoidRootPart.CFrame * CFrame.new(0,0,-3) * CFrame.Angles(0,math.rad(0),math.rad(0))
        Tween:Create(EffectSlash, TweenInfo.new(.3), {CFrame = EffectSlash.CFrame * CFrame.Angles(0,math.rad(0),0), Transparency = 1}):Play()
            end
end

local function slash(comboN)
    local HumanoidRootPart = Character.HumanoidRootPart
    local Count = 1
    if Character == Character then
        self.Services.WeaponsService:HitBox(WeaponTag,WeaponConfig.HitBoxSize)
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Parent = Character.PrimaryPart
        BodyVelocity.MaxForce = Vector3.new(99999,0,99999)
        BodyVelocity.Name = "BodyVelocity"
        BodyVelocity.P = 10
        game.Debris:AddItem(BodyVelocity,.2)
        if comboN == 5 then
            BodyVelocity.Velocity = Character.PrimaryPart.CFrame.LookVector * 50
        else
            BodyVelocity.Velocity = Character.PrimaryPart.CFrame.LookVector * 20
        end
    end
end

local function WeaponActivated(actionName,input)
    if (actionName == "Slash") and tick() - LastSwing >= WeaponConfig.Cooldown and input == Enum.UserInputState.Begin then   
        if tick() - LastSwing > WeaponConfig.ComboResetTimer then
                Combo = 1
            end
            LastSwing = tick()
            Humanoid.WalkSpeed = 0
            Humanoid.JumpHeight = 0
            Anim.AnimationId = SwingAnimations[Combo]
            Humanoid:LoadAnimation(Anim):Play()
            local sound = Instance.new("Sound")
            sound.Parent = script
            sound.SoundId = 'rbxassetid://9119749145'
            sound:Play()
            sound:Destroy()
            slash(Combo)
            if Combo >= #WeaponConfig.SwingAnimations then
                Combo = 1
            else
                Combo = Combo + 1
            end
            Humanoid.WalkSpeed = Walk --game Walk spped
            Humanoid.JumpHeight = Jump --game Jump
        end
end
    ContextActionService:BindAction("Slash",WeaponActivated,false,Enum.UserInputType.MouseButton1,Enum.KeyCode.ButtonR2,Enum.UserInputType.Touch)
    ContextActionService:BindAction("Ability",Ability,true,Enum.KeyCode.E,Enum.KeyCode.ButtonY)         

Humanoid.Died:Connect(function()
    ContextActionService:UnbindAction("Slash")
    ContextActionService:UnbindAction("Ability")
end)

end)
end)
end


return WeaponController