-- Time Controller
-- Username
-- October 25, 2022




local TimeController = {}


function TimeController:Start()

    -- Local Variables
local TimeObject = game.Workspace:WaitForChild("MapPurgeProof"):WaitForChild("Time")
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = PlayerGui:WaitForChild('ScreenGui')
local Timer = ScreenGui.ScoreFrame.Timer

-- Local Functions
local function OnTimeChanged(newValue)
	local currentTime = math.max(0, newValue)
	local minutes = math.floor(currentTime / 60)-- % 60
	local seconds = math.floor(currentTime) % 60
	Timer.Text = string.format("%02d:%02d", minutes, seconds)
end

local function OnDisplayTimerInfo(intermission, waitingForPlayers)
	Timer.Intermission.Visible = intermission
	Timer.WaitingForPlayers.Visible = waitingForPlayers
end

-- Event Bindings
TimeObject.Changed:Connect(OnTimeChanged)
self.Services.Core.DisplayManagerService.DISPLAY_TIMER_INFO:Connect(OnDisplayTimerInfo)

	
end


function TimeController:Init()
	
end


return TimeController