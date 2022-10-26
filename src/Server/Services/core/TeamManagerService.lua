-- Team Manager Service
-- Username
-- October 25, 2022


local TeamManagerService = {Client = {}}


function TeamManagerService:Start()
Configurations = self.Shared.ConfigModule

-- ROBLOX Services
local Teams = game.Teams
local Players = game.Players

-- Local Variables
local TeamPlayers = {}
local TeamScores = {}

-- Local Functions
local function GetTeamFromColor(teamColor)
	for _, team in ipairs(Teams:GetTeams()) do
		if team.TeamColor == teamColor then
			return team
		end
	end
	return nil
end

-- Functions
function TeamManagerService:CreateTeams()
	local newTeam = Instance.new("Team")
	newTeam.Parent = game.Teams
	newTeam.AutoAssignable = true
	newTeam.TeamColor = BrickColor.new("Bright red")
	TeamPlayers[newTeam] = {}
	TeamScores[newTeam] = 0
	newTeam = nil
	newTeam = Instance.new("Team")
	newTeam.Parent = game.Teams
	newTeam.AutoAssignable = true
	newTeam.TeamColor = BrickColor.new("Bright blue")
	TeamPlayers[newTeam] = {}
	TeamScores[newTeam] = 0
    newTeam = nil
end

function TeamManagerService:CreateFFATeam()
	local newTeamColor = BrickColor.Random()
	while GetTeamFromColor(newTeamColor) do
		newTeamColor = BrickColor.Random()
	end
	
	local newTeam = Instance.new("Team")
    newTeam.Parent = game.Teams
	newTeam.TeamColor = newTeamColor
	TeamPlayers[newTeam] = {}
	TeamScores[newTeam] = 0
	return newTeam
end

function TeamManagerService:AssignPlayerToTeam(player)
	local smallestTeam
	local lowestCount = math.huge
	for team, playerList in pairs(TeamPlayers) do
		if #playerList < lowestCount then
			smallestTeam = team
			lowestCount = #playerList
		end
	end
	
	if not Configurations.TEAMS and (not smallestTeam or #TeamPlayers[smallestTeam] > 0) then
		smallestTeam = TeamManagerService:CreateFFATeam()
	end
	
	table.insert(TeamPlayers[smallestTeam], player)
	player.Neutral = false
		player.TeamColor = smallestTeam.TeamColor
		player.CharacterAdded:Connect(function(character)
			local guiPlayer = Instance.new("BillboardGui",character)
			guiPlayer.Adornee = character:WaitForChild("Head")
			guiPlayer.Active = true
			guiPlayer.AlwaysOnTop = true
			guiPlayer.Enabled = true
			guiPlayer.Size = UDim2.new(0,100,0,100)
			guiPlayer.ExtentsOffsetWorldSpace = Vector3.new(0,5,0)
			local text = Instance.new("TextLabel",guiPlayer)
			text.Text = player.Name
			text.Size = UDim2.new(0,50,0,50)
			text.Visible = true
			text.Selectable = false
			text.TextWrapped = false
			text.TextScaled = false
			text.TextSize = 20
			text.BackgroundTransparency = 1
			text.TextColor = player.TeamColor
		end)
end

function TeamManagerService:RemovePlayer(player)
    local Configurations = self.Shared.ConfigModule
	local team = GetTeamFromColor(player.TeamColor)
	local teamTable = TeamPlayers[team]
	for i = 1, #teamTable do
		if teamTable[i] == player then
			table.remove(teamTable, i)
			if not Configurations.TEAMS then
				team:Destroy()
			end
			return
		end
	end
end

function TeamManagerService:ClearTeamScores()
    local DisplayManager = self.Services.Core.DisplayManagerService
    local Configurations = self.Shared.ConfigModule
    for _, team in pairs(Teams:GetTeams()) do
		TeamScores[team] = 0
		if Configurations.TEAMS then
			DisplayManager:UpdateScore(team, 0)
		end
	end
end

function TeamManagerService:AddTeamScore(teamColor, score)
    local DisplayManager = self.Services.Core.DisplayManagerService
    local Configurations = self.Shared.ConfigModule
    local team = GetTeamFromColor(teamColor)
	TeamScores[team] = TeamScores[team] + score
	if Configurations.TEAMS then
		DisplayManager:UpdateScore(team, TeamScores[team])
	end
end

function TeamManagerService:HasTeamWon()
	for _, team in pairs(Teams:GetTeams()) do
		if TeamScores[team] >= Configurations.POINTS_TO_WIN then
			return team
		end
	end
	return false
end

function TeamManagerService:GetWinningTeam()
	local highestScore = 0
	local winningTeam = nil
	for _, team in pairs(Teams:GetTeams()) do
		if TeamScores[team] > highestScore then
			highestScore = TeamScores[team]
			winningTeam = team
		end
	end
	return winningTeam
end

function TeamManagerService:AreTeamsTied()
	local teams = Teams:GetTeams()
	local highestScore = 0
	local tied = false
	for _, team in pairs(teams) do
		if TeamScores[team] == highestScore then
			tied = true
		elseif TeamScores[team] > highestScore then
			tied = false
			highestScore = TeamScores[team]
		end
	end
	return tied
end

function TeamManagerService:ShuffleTeams()
    for _, team in pairs(Teams:GetTeams()) do
		TeamPlayers[team] = {}
	end
	local players = Players:GetPlayers()
	while #players > 0 do
		local rIndex = math.random(1, #players)
		local player = table.remove(players, rIndex)
		TeamManagerService:AssignPlayerToTeam(player)
	end
end


local Configurations = self.Shared.ConfigModule
if Configurations.TEAMS then
TeamManagerService:CreateTeams()
end

	
	
end


function TeamManagerService:Init()

       local EventsModule = self.Shared.EventsModule
    self:RegisterEvent(EventsModule.DISPLAY_BLUR_EVENT)
    self:RegisterEvent(EventsModule.DISPLAY_INTERMISSION)
    self:RegisterEvent(EventsModule.DISPLAY_SCORE)
    self:RegisterEvent(EventsModule.DISPLAY_TIMER_INFO)
    self:RegisterEvent(EventsModule.DISPLAY_VICTORY)
    self:RegisterEvent(EventsModule.DISPLAY_WAITING_FOR_OTHER_PLAYERS)
    self:RegisterEvent(EventsModule.FETCH_CONFIG)
    self:RegisterEvent(EventsModule.RESET_MOUSE_ICON)
    self:RegisterEvent(EventsModule.SET_BLUR_BLOCK)
	
end


return TeamManagerService