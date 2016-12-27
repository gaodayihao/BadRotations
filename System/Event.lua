local Frame = CreateFrame("Frame");

-- Event callbacks
local EventCallbacks = {};

Frame:SetScript("OnEvent",
	function (self, Event, ...)
		local Callbacks = EventCallbacks[Event];
		if Callbacks then
			for _, CallBackWapper in pairs(Callbacks) do
				CallBackWapper.Callback(...);
			end
		end
	end
);

function AddEventCallback (Event, Callback, Mark)
    if Mark == nil then
        Mark = "BR"
    end
	local Callbacks = EventCallbacks[Event];
	if not Callbacks then
		Frame:RegisterEvent(Event);
		EventCallbacks[Event] = {};
		Callbacks = EventCallbacks[Event];
	end

    local CallBackWapper = 
    {
        Mark = Mark,
        Callback = Callback,
    }
	table.insert(Callbacks, CallBackWapper);
end

function RemoveEventCallback (Event, Mark)
	local Callbacks = EventCallbacks[Event];
    if Callbacks and Mark then
        for i, CallBackWapper in pairs(Callbacks) do
            if CallBackWapper.Mark == Mark then
                Callbacks[i] = nil
            end
		end
    end
end