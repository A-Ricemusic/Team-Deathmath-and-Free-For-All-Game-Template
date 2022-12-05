-- Event Service
-- Username
-- December 5, 2022



local EventService = {Client = {}}


function EventService:Start()

    function EventService:OnCharacterAddedFireClient(player)
        self:FireClient("OnCharacterAdded",player)
    end
    
    function EventService:FireSwordSetUpClient(plr,WeaponTag)
        self:FireClient("SwordSetUp", plr, WeaponTag)
    end
    
    function EventService:FireUnbindActions(plr)
        self:FireClient("Unbind", plr)
    end
	
end


function EventService:Init()

    self:RegisterClientEvent("OnCharacterAdded")
    self:RegisterClientEvent("SwordSetUp")
	self:RegisterClientEvent("Unbind")
	
end


return EventService