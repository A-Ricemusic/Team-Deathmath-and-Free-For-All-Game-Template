-- Time Manager Service
-- Username
-- October 25, 2022




local TimeManagerService = {Client = {}}


function TimeManagerService:Start()

    -- Local Variables

local StartTime = 0
local Duration = 0

-- Initialization

local Time = Instance.new('IntValue')
Time.Parent =  game.Workspace:WaitForChild('MapPurgeProof')
Time.Name = 'Time'

-- Functions

function TimeManagerService:StartTimer(duration)
	StartTime = tick()
	Duration = duration
	spawn(function()
		repeat 
			Time.Value = Duration - (tick() - StartTime)
			task.wait()
		until Time.Value <= 0
		Time.Value = 0
	end)
end

function TimeManagerService:TimerDone()
	return tick() - StartTime >= Duration
end

	
	
end


function TimeManagerService:Init()
	
end


return TimeManagerService