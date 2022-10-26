-- Game Manager Service
-- Username
-- October 25, 2022




local GameManagerService = {Client = {}}




function GameManagerService:StartGame()
-- ROBLOX Services
local Players = game.Players

-- Game Services
local Configurations = self.Shared.ConfigModule
local TeamManager = self.Services.Core.TeamManagerService
local PlayerManager = self.Services.Core.PlayerManagerService
local MapManager = self.Services.Core.MapManagerService
local TimeManager = self.Services.Core.TimeManagerService
local DisplayManager = self.Services.Core.DisplayManagerService
local WeaponsService = self.Services.Core.WeaponsService
-- Local Variables
local IntermissionRunning = false
local EnoughPlayers = false
local GameRunning = false

-- Functions
function GameManagerService:Initialize()
game:GetService("Players").CharacterAutoLoads = false
local fx = Instance.new("Folder",workspace)
fx.Name = "Fx"
MapManager:SaveMap(workspace)
end

function GameManagerService:RunIntermission()
		wait(1)
	local Lighting = game:GetService("Lighting")
	Blur = Instance.new('BlurEffect')
	Blur.Parent = Lighting
	Blur.Name = "Blur"	
	IntermissionRunning = true
	TimeManager:StartTimer(Configurations.INTERMISSION_DURATION) -- Starts a timer used to display the intermission time
	DisplayManager:StartIntermission()
	EnoughPlayers = Players.NumPlayers >= Configurations.MIN_PLAYERS
	DisplayManager:UpdateTimerInfo(true, not EnoughPlayers)
	spawn(function()
		repeat
			if EnoughPlayers and Players.NumPlayers < Configurations.MIN_PLAYERS then
				EnoughPlayers = false
			elseif not EnoughPlayers and Players.NumPlayers >= Configurations.MIN_PLAYERS then
				EnoughPlayers = true
			end
			DisplayManager:UpdateTimerInfo(true, not EnoughPlayers)
			wait(0.5)
		until not IntermissionRunning
	end)
	
	wait(Configurations.INTERMISSION_DURATION)
	IntermissionRunning = false
end

function GameManagerService:StopIntermission()
		Blur:Destroy()
	DisplayManager:UpdateTimerInfo(false, false)
	DisplayManager:StopIntermission()
end

function GameManagerService:GameReady()
	return EnoughPlayers
end

	function GameManagerService:StartRound()
	MapManager:GetSelectedMap()
	TeamManager:ClearTeamScores()
	PlayerManager:ClearPlayerScores()
	
	PlayerManager:AllowPlayerSpawn(true)
	PlayerManager:LoadPlayers()
	
	GameRunning = true
	PlayerManager:SetGameRunning(true)
	TimeManager:StartTimer(Configurations.ROUND_DURATION)
end

function GameManagerService:Update()
	-- TODO: Add custom game code here
end

function GameManagerService:RoundOver()
	local winningTeam = TeamManager:HasTeamWon()
	if winningTeam then
		DisplayManager:DisplayVictory(winningTeam)
		return true
	end
	
	if TimeManager:TimerDone() then
		if TeamManager:AreTeamsTied() then
			DisplayManager:DisplayVictory("Tie")
		else
			winningTeam = TeamManager:GetWinningTeam()
			DisplayManager:DisplayVictory(winningTeam)
		end
		return true
	end
	return false
end

function GameManagerService:RoundCleanup()
	PlayerManager:SetGameRunning(false)
	PlayerManager:AllowPlayerSpawn(false)
	wait(Configurations.END_GAME_WAIT)
	PlayerManager:DestroyPlayers()
	DisplayManager:DisplayVictory(nil)
	if Configurations.TEAMS then
		TeamManager:ShuffleTeams()
	end
	MapManager:ClearMap()
	MapManager:LoadMap()
end



GameManagerService:Initialize()

while true do
	repeat
		GameManagerService:RunIntermission()
	until GameManagerService:GameReady()
	
	GameManagerService:StopIntermission()
	GameManagerService:StartRound()
	
	repeat
		GameManagerService:Update()
		wait()
	until GameManagerService:RoundOver()
	
	GameManagerService:RoundCleanup()
end
end

function GameManagerService:Start()
GameManagerService:StartGame()
end


return GameManagerService