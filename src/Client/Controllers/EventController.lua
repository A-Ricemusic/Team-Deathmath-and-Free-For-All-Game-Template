-- Event Controller
-- Username
-- December 5, 2022



local EventController = {}


function EventController:Start()
    local EventService = self.Services.Core.EventService
    local ContextActionServiceController = self.Controllers.ContextActionServiceController
    local WeaponController = self.Controllers.WeaponController

    EventService.OnCharacterAdded:Connect(function()
        ContextActionServiceController:OnCharacterAdded()
    end)
  EventService.SwordSetUp:Connect(function(WeaponTag)
        self.Controllers.WeaponController:OnSetUp(WeaponTag)
    end)

    EventService.Unbind:Connect(function(WeaponTag)
        self.Controllers.WeaponController:UnbindAction()
    end)
	
end




return EventController