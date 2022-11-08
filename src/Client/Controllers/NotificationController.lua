-- Notification Controller
-- Username
-- October 25, 2022





local NotificationController = {}


function NotificationController:Start()


-- Local Variables

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = PlayerGui:WaitForChild('ScreenGui')
local ScoreFrame = ScreenGui.ScoreFrame
local VictoryFrame = ScreenGui.VictoryMessage
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local gameConfig = self.Shared.ConfigModule
local isTeams = gameConfig.TEAMS 
local MouseIcon = Mouse.Icon

-- Local Functions
local function OnScoreChange(team, score)
	ScoreFrame[tostring(team.TeamColor)].Text = score
end

local function OnDisplayVictory(winningTeam)
	if winningTeam then
		VictoryFrame.Visible = true
		if winningTeam == 'Tie' then
			VictoryFrame.Tie.Visible = true
		else
			VictoryFrame.Win.Visible = true
			local WinningFrame = VictoryFrame.Win.TeamDisplay
			WinningFrame.Size = UDim2.new(0, string.len(winningTeam.TeamColor.Name) * 19, 0, 50)
			WinningFrame.Position = UDim2.new(0, -WinningFrame.Size.X.Offset, 0, 0)
			WinningFrame.TextColor3 = winningTeam.TeamColor.Color
			if isTeams then
			WinningFrame.Text = " "..winningTeam.TeamColor.Name
			else
			local teamPlayers = winningTeam:GetPlayers()
			local winningPlayer = winningTeam[1]
			WinningFrame.Text =" "..winningPlayer.Name
			end
			WinningFrame.Visible = true
		end
	else
		VictoryFrame.Visible = false
		VictoryFrame.Win.Visible = false
		VictoryFrame.Win.TeamDisplay.Visible = false
		VictoryFrame.Tie.Visible = false
	end
end

local function OnResetMouseIcon()
	Mouse.Icon = MouseIcon
end

-- Event Bindings
self.Services.Core.DisplayManagerService.DISPLAY_VICTORY:Connect(OnDisplayVictory)
self.Services.Core.DisplayManagerService.DISPLAY_SCORE:Connect(OnScoreChange)
self.Services.Core.PlayerManagerService.RESET_MOUSE_ICON:Connect(OnResetMouseIcon)

	
end


function NotificationController:Init()
	
end


return NotificationController