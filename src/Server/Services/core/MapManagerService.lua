-- Map Manager Service
-- Username
-- October 25, 2022



local MapManagerService = {Client = {}}



function MapManagerService:OnInit()
local MapPurgeProof = Instance.new('Folder')
MapPurgeProof.Parent = workspace
local MapSave = game.ServerStorage:FindFirstChild("MapSave")
	if not MapSave then
		MapSave = Instance.new("Folder")
		MapSave.Parent =  game.ServerStorage
		MapSave.Name = "MapSave"
	end
	
end

local Spawns = { }
local Maps = game:GetService("ReplicatedStorage").Maps:GetChildren()
local mapTable = {}

for _,map in pairs(Maps)  do
mapTable[map.Name] = 0
end

function MapManagerService.Client:MapSelect(plr,mapSelected)
	if mapTable[mapSelected] == nil then return end
	mapTable[mapSelected] = mapTable[mapSelected] + 1
	plr = nil
	
end

function MapManagerService:GetSelectedMap()
	
	local mapSelected = ''
	local mapSelectedClone
	for key,value in pairs(mapTable) do
		local voteCount = 0
		if mapTable[key] > voteCount then
			voteCount = mapTable[key]
			mapSelected = key
		end
	end
		local mapSelectedModel = game:GetService("ReplicatedStorage").Maps:FindFirstChild(mapSelected)
		if mapSelectedModel then
			mapSelectedClone = mapSelectedModel:Clone()
		else
			mapSelectedClone = Maps[1]:Clone()
		end
			mapSelectedClone.Parent = game.Workspace
			mapSelectedClone = nil
	
end


-- Local Functions
local function FindAndSaveSpawns(object)
	for _, child in pairs(object:GetChildren()) do
		if child:IsA("SpawnLocation") then
			table.insert(Spawns, child)
		end
		FindAndSaveSpawns(child)
	end
end

-- Functions
function MapManagerService:SaveMap(object)
    local Configurations = self.Shared.ConfigModule
	FindAndSaveSpawns(object)
	for i = #Spawns, 1, -1 do
		if Configurations.TEAMS then
			if Spawns[i].TeamColor.Name == "Bright red" or Spawns[i].TeamColor.Name == "Bright blue" then
				Spawns[i].Neutral = false
				Spawns[i].Transparency = 1
			else
				table.remove(Spawns, i):Destroy()
			end
		else
			Spawns[i].Neutral = true
			Spawns[i].Transparency = 1
		end
	end
	
	for _, child in pairs(object:GetChildren()) do
		if not child:IsA("Camera") and not child:IsA("Terrain") and child.Name ~= "MapPurgeProof" then
			local copy = child:Clone()
			if copy then
				copy.Parent = MapSave
			end
		end
	end
end

function MapManagerService:ClearMap()
	for _, child in ipairs(game.Workspace:GetChildren()) do
		if not child:IsA('Camera') and not child:IsA('Terrain') and child.Name ~= "MapPurgeProof" then
			child:Destroy()
		end
	end
end

function MapManagerService:LoadMap()
	spawn(function()
		for _, child in ipairs(MapSave:GetChildren()) do
			local copy = child:Clone()
			copy.Parent = game.Workspace
		end
	end)
end

function MapManagerService:Start()
end

function MapManagerService:Init()
    MapManagerService:OnInit()
end


return MapManagerService