-- Display Controller
-- Username
-- September 30, 2022



local DisplayController = {}

function DisplayController:Start()
-- ROBLOX Services
local RunService = game:GetService("RunService")

-- Game Services/modules
local NotificationManager = self.Controllers.NotificationController
local TimerManager = self.Controllers.TimeController
local ConfigModule = self.Shared.ConfigModule


-- Local Variables
local Camera = game.Workspace.CurrentCamera
local Player = game.Players.LocalPlayer
local IsTeams = ConfigModule.TEAMS
local InIntermission = false


-- Initialization
game.StarterGui.ResetPlayerGuiOnSpawn = false
local GuiModule = require(script.Parent.Parent.Modules.GuiModule)
GuiModule:MakeGui()
local PlayerGui= Player:WaitForChild("PlayerGui")
local ScreenGui = script.Parent.Parent.Modules.GuiModule:WaitForChild("ScreenGui")
	ScreenGui.Parent = PlayerGui
	
	local function MapVotingGui()
		local maps = game:GetService("ReplicatedStorage").Maps:GetChildren()
		local MapVoteGui = Instance.new("ScreenGui",PlayerGui)
		MapVoteGui.Name = "MapVoteGui"
		local votingFrame = Instance.new("Frame",MapVoteGui)
		votingFrame.Position = UDim2.new(0.2,0,0.2,0)
		votingFrame.Size = UDim2.new(0.7,0,0.7,0)
		votingFrame.BackgroundTransparency = 0.8
		votingFrame.BorderColor3 = Color3.new()
		local uiConstraint = Instance.new("UIAspectRatioConstraint",votingFrame)
		local uiGridLayout = Instance.new("UIGridLayout",votingFrame)
		for _,map in pairs(maps) do
			local button = Instance.new("TextButton",votingFrame)
			button.Size = uiGridLayout.CellSize
			button.Text = map.Name
			button.TextScaled = true
			button.TextWrapped = true
			button.Active = true
			button.Font = Enum.Font.Fantasy
			button.BackgroundTransparency = 0.5
			button.BackgroundColor = BrickColor.new("Rust")
			button.Activated:Connect(function()
				self.Services.Core.MapManagerService:MapSelect(map.Name)
				MapVoteGui:Destroy()
			end)


		end

	end


-- Local Functions
local function StartIntermission()
	-- Default to circle center of map
	local possiblePoints = {}
	table.insert(possiblePoints, Vector3.new(0,50,0))
	
	local focalPoint = possiblePoints[math.random(#possiblePoints)]
	Camera.CameraType = Enum.CameraType.Scriptable
	Camera.Focus = CFrame.new(focalPoint)
	
		local angle = 0
		Blur = game:GetService("Lighting"):WaitForChild("Blur")
		Blur.Enabled = true
		MapVotingGui()
	RunService:BindToRenderStep('IntermissionRotate', Enum.RenderPriority.Camera.Value, function()
		local cameraPosition = focalPoint + Vector3.new(50 * math.cos(angle), 20, 50 * math.sin(angle))
		Camera.CoordinateFrame = CFrame.new(cameraPosition, focalPoint)
		angle = angle + math.rad(.25)
		
	end)
	
	ScreenGui.ScoreFrame["Bright blue"].Visible = false
	ScreenGui.ScoreFrame["Bright red"].Visible = false
end

local function StopIntermission()
	Blur.Enabled = false
	RunService:UnbindFromRenderStep('IntermissionRotate')
	Camera.CameraType = Enum.CameraType.Custom
	if IsTeams then
		ScreenGui.ScoreFrame["Bright blue"].Visible = true
		ScreenGui.ScoreFrame["Bright red"].Visible = true
	end
end

local function OnDisplayIntermission(display)
	if display and not InIntermission then
		InIntermission = true
		StartIntermission()
	end	
	if not display and InIntermission then
			InIntermission = false
			local mapVoteGui = PlayerGui:FindFirstChild("MapVoteGui")
			if mapVoteGui then
				mapVoteGui:Destroy()
			end
		StopIntermission()
	end
end

local function OnSetBlurBlock(block)
	local BlurBlock = block
	BlurBlock.LocalTransparencyModifier = 0
end

local function OnFetchConfiguration(configFetched, configValue)
	if configFetched == "TEAMS" then
		IsTeams = configValue
		ScreenGui.ScoreFrame["Bright blue"].Visible = IsTeams
		ScreenGui.ScoreFrame["Bright red"].Visible = IsTeams
	end
end

-- Event Bindings
self.Services.Core.DisplayManagerService.DISPLAY_INTERMISSION:Connect(OnDisplayIntermission)

-- See if the game is Team or FFA

ScreenGui.ScoreFrame["Bright blue"].Visible = IsTeams
ScreenGui.ScoreFrame["Bright red"].Visible = IsTeams




end

function DisplayController:Init()

end



return DisplayController