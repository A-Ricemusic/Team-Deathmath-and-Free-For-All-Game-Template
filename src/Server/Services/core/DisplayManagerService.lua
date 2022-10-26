-- Display Manager Service
-- Username
-- October 25, 2022



local DisplayManagerService = {Client = {}}


function DisplayManagerService:Start()

    local EventsModule = self.Shared.EventsModule
local StarterGui = game:GetService("StarterGui")

-- Initialize
StarterGui.ResetPlayerGuiOnSpawn = false
local MapPurgeProof = game.Workspace:FindFirstChild('MapPurgeProof')
if not MapPurgeProof then
	MapPurgeProof = Instance.new('Folder')
    MapPurgeProof.Parent = workspace
	MapPurgeProof.Name = 'MapPurgeProof'
end

-- Functions
function DisplayManagerService:StartIntermission(player)
	if player then
		self:FireClient(EventsModule.DISPLAY_INTERMISSION,player,true)
	else
		self:FireAllClients(EventsModule.DISPLAY_INTERMISSION,true)
	end
end

function DisplayManagerService:StopIntermission(player)
	if player then
		self:FireClient(EventsModule.DISPLAY_INTERMISSION,player, false)
	else
		self:FireAllClients(EventsModule.DISPLAY_INTERMISSION,false)
	end
end

function DisplayManagerService:UpdateTimerInfo(isIntermission, waitingForPlayers)
	self:FireAllClients(EventsModule.DISPLAY_TIMER_INFO,isIntermission, waitingForPlayers)
end

function DisplayManagerService:DisplayVictory(winningTeam)
	self:FireAllClients(EventsModule.DISPLAY_VICTORY,winningTeam)
end

function DisplayManagerService:UpdateScore(team, score)
	self:FireAllClients(EventsModule.DISPLAY_SCORE,team, score)
end
	
	
end


function DisplayManagerService:Init()
    local EventsModule = self.Shared.EventsModule
    self:RegisterClientEvent(EventsModule.DISPLAY_BLUR_EVENT)
    self:RegisterClientEvent(EventsModule.DISPLAY_INTERMISSION)
    self:RegisterClientEvent(EventsModule.DISPLAY_SCORE)
    self:RegisterClientEvent(EventsModule.DISPLAY_TIMER_INFO)
    self:RegisterClientEvent(EventsModule.DISPLAY_VICTORY)
	
end


return DisplayManagerService