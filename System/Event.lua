local brEventFrame = CreateFrame("Frame");

-- Event callbacks
local eventCallbacks = {};

brEventFrame:SetScript("OnEvent",
    function (self, Event, ...)
        local Callbacks = eventCallbacks[Event];
        if Callbacks then
            for _, CallBackWapper in pairs(Callbacks) do
                CallBackWapper.Callback(...);
            end
        end
    end
);

function addEventCallbackBR (Event, Callback, Mark)
    if Mark == nil then
        Mark = "BR"
    end
    local Callbacks = eventCallbacks[Event];
    if not Callbacks then
        brEventFrame:RegisterEvent(Event);
        eventCallbacks[Event] = {};
        Callbacks = eventCallbacks[Event];
    end
    for _, CallBackWapper in pairs(Callbacks) do
        if CallBackWapper.Mark == Mark then
            return
        end
    end
    local CallBackWapper =
    {
        Mark = Mark,
        Callback = Callback,
    }
    table.insert(Callbacks, CallBackWapper);
end

function RemoveEventCallback (Event, Mark)
    if Mark == nil then
        Mark = "BR"
    end
    local Callbacks = eventCallbacks[Event];
    if Callbacks and Mark then
        for i, CallBackWapper in pairs(Callbacks) do
            if CallBackWapper.Mark == Mark then
                Callbacks[i] = nil
            end
        end
    end
end