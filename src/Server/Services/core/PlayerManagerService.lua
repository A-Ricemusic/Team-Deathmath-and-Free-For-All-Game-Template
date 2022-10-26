-- Player Manager Service
-- Username
-- October 25, 2022



local PlayerManagerService = {Client = {}}

function PlayerManagerService:Start()

    local EventsModule = self.Shared.EventsModule

-- ROBLOX Services
local Players = game.Players
local PointsService = game:GetService("PointsService")

-- Game Services

-- Local Variables
local PlayersCanSpawn = false
local GameRunning = false
local HitArray = { }
local ScoreArray = { }

-- Functions/Methods
function PlayerManagerService:OnPlayerAdded(player)
    local DisplayManager = self.Services.Core.DisplayManagerService
    local Configurations = self.Shared.ConfigModule
	-- Setup leaderboard stats
	local leaderstats = Instance.new("Model")
    leaderstats.Parent = player
	leaderstats.Name = "leaderstats"
    local KWA = Instance.new("StringValue")
	KWA.Parent = leaderstats
    if Configurations.GRANT_ASSISTS then
		KWA.Name = "KO - WO - A"
		KWA.Value = "0 - 0 - 0"
	else
		KWA.Name = "KO - WO"
		KWA.Value = "0 - 0"
	end
	
	ScoreArray[player] = { 0, 0, 0 } -- KOs, WOs, Assists
	local TeamManager = self.Services.Core.TeamManagerService
	TeamManager:AssignPlayerToTeam(player)
	player.CharacterAdded:connect(function(character)
		character:WaitForChild("Humanoid").Died:connect(function()
			PlayerManagerService:PlayerDied(player)
			wait(Configurations.RESPAWN_TIME)
			if GameRunning then
				player:LoadCharacter()
			end
		end)
	end)
	
	if PlayersCanSpawn then
		player:LoadCharacter()
	else
		DisplayManager:StartIntermission(player)
	end
end

function PlayerManagerService:OnPlayerRemoving(player)
    local TeamManager = self.Services.Core.TeamManagerService
	TeamManager:RemovePlayer(player)
end

function PlayerManagerService:UpdatePlayerScore(player)
    local Configurations = self.Shared.ConfigModule
	local KOString = tostring(ScoreArray[player][1])
	local WOString = tostring(ScoreArray[player][2])
	local AssistString = tostring(ScoreArray[player][3])
	
	if not Configurations.GRANT_ASSISTS then
		if KOString:len() < WOString:len() then
			while KOString:len() < WOString:len() do
				KOString = " " .. KOString
			end
		else
			while WOString:len() < WOString:len() do
				WOString = WOString .. " "
			end
		end
		player.leaderstats["KO - WO"].Value = KOString .. " - " .. WOString
	else
		player.leaderstats["KO - WO - A"].Value = KOString .. " - " .. WOString .. " - " .. AssistString
	end
end

-- Functions
function PlayerManagerService:SetGameRunning(running)
	GameRunning = running
end

function PlayerManagerService:AllowPlayerSpawn(allow)
	PlayersCanSpawn = allow
end

function PlayerManagerService:ClearPlayerScores()
    local Configurations = self.Shared.ConfigModule
	for _, player in ipairs(Players:GetPlayers()) do
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local KWA
			if Configurations.GRANT_ASSISTS then
				KWA = leaderstats:FindFirstChild("KO - WO - A")
				if KWA then
					KWA.Value = "0 - 0 - 0"
				end
			else
				KWA = leaderstats:FindFirstChild("KO - WO")
				if KWA then
					KWA.Value = "0 - 0"
				end
			end
		end
	end
end

function PlayerManagerService:LoadPlayers()
	for _, player in pairs(Players:GetPlayers()) do
		player:LoadCharacter()
	end
end

function PlayerManagerService:DestroyPlayers()
	for _, player in pairs(Players:GetPlayers()) do
		player.Character:Destroy()
		for _, item in pairs(player.Backpack:GetChildren()) do
			item:Destroy()
		end
	end
	self:FireAllClients(EventsModule.RESET_MOUSE_ICON)
end

function PlayerManagerService:PlayerHit(hitPlayer, hittingPlayer)
	if hitPlayer == hittingPlayer then
		return
	end
	
	if not HitArray[hitPlayer] then
		HitArray[hitPlayer] = { }
	end
	
	for i = 1, #HitArray[hitPlayer] do
		if HitArray[hitPlayer][i]== hittingPlayer then
			return
		end
	end
	table.insert(HitArray[hitPlayer], hittingPlayer)
end

function PlayerManagerService:PlayerDied(player)
    local Configurations = self.Shared.ConfigModule
    local TeamManager = self.Services.Core.TeamManagerService
    if HitArray[player] then
		for i = #HitArray[player], 1, -1 do
			local hittingPlayer = HitArray[player][i]
			if hittingPlayer ~= player then
				if i == #HitArray[player] then
					ScoreArray[hittingPlayer][1] = ScoreArray[hittingPlayer][1] + 1
					TeamManager:AddTeamScore(hittingPlayer.TeamColor, 1)
					spawn(function() pcall(function() PointsService:AwardPoints(hittingPlayer.userId, Configurations.PLAYER_POINTS_PER_KO) end) end)
				else
					ScoreArray[hittingPlayer][3] = ScoreArray[hittingPlayer][3] + 1
					spawn(function() pcall(function() PointsService:AwardPoints(hittingPlayer.userId, Configurations.PLAYER_POINTS_PER_ASSIST) end) end)
				end
				PlayerManagerService:UpdatePlayerScore(hittingPlayer)
			end
		end
	end
	
	ScoreArray[player][2] = ScoreArray[player][2] + 1
	HitArray[player] = nil
	PlayerManagerService:UpdatePlayerScore(player)
end

-- Event Bindings
Players.PlayerAdded:Connect(function(player)
    PlayerManagerService:OnPlayerAdded(player)
end)
Players.PlayerRemoving:Connect(function(player)
    PlayerManagerService:OnPlayerRemoving(player)
end)

	
end


function PlayerManagerService:Init()

    local EventsModule = self.Shared.EventsModule
    self:RegisterClientEvent(EventsModule.RESET_MOUSE_ICON)
	
end





return PlayerManagerService