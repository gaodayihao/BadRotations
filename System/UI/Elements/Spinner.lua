local DiesalGUI = LibStub("DiesalGUI-1.0")

function br.ui:createSpinner(parent, text, number, min, max, step, tooltip, tooltipSpin, hideCheckbox, cbDefault)
    local newSpinner = DiesalGUI:Create('Spinner')
    local parent = parent
    local cbDefault = cbDefault or false
    local tooltipSpin = tooltipSpin or tooltip
    if tooltip then
        tooltip = tooltip.."|r|n|n|n|n"..LC_DEFALUT_VALUE.."1: |cffFFFFFF"..tostring(cbDefault).."|r|n"..LC_DEFALUT_VALUE.."2: |cffFFFFFF"..tostring(number)
    end
    if tooltipSpin then
        tooltipSpin = tooltipSpin .."|r|n|n|n|n"..LC_DEFALUT_VALUE.."1: |cffFFFFFF"..tostring(cbDefault).."|r|n"..LC_DEFALUT_VALUE.."2: |cffFFFFFF"..tostring(number)
    end

    -- Create Checkbox for Spinner
    local checkBox = br.ui:createCheckbox(parent, text, tooltip, cbDefault, true)

    -- Calculate position
    local howManyBoxes = 0
    for i=1, #parent.children do
        if parent.children[i].type == "Toggle" then
            howManyBoxes = howManyBoxes + 1
        end
    end
    local y = howManyBoxes
    if y  ~= 1 then y = ((y-1) * -br.spacing) -5 end
    if y == 1 then y = -5 end

    if hideCheckbox then
        checkBox:Disable()
        checkBox:ReleaseTextures()
    end

    -- Set size
    newSpinner.settings.height = 12

    -- Set Steps
    newSpinner.settings.min = min or 0
    newSpinner.settings.max = max or 100
    newSpinner.settings.step = step or 5

    newSpinner:SetParent(parent.content)

    -- Set anchor
    newSpinner:SetPoint("TOPRIGHT", parent.content, "TOPRIGHT", -10, y)

    -- Read number from config or set default
    if br.data.settings[br.selectedSpec][br.selectedProfile][text.."Status"] == nil then br.data.settings[br.selectedSpec][br.selectedProfile][text.."Status"] = number end
    local state = br.data.settings[br.selectedSpec][br.selectedProfile][text.."Status"]
    newSpinner:SetNumber(state)


    -- Event: OnValueChange
    newSpinner:SetEventListener('OnValueChanged', function(this, event, checked)
        br.data.settings[br.selectedSpec][br.selectedProfile][text.."Status"] = newSpinner:GetNumber()
    end)
    -- Event: Tooltip
    if tooltipSpin then
        newSpinner:SetEventListener("OnEnter", function(this, event)
            GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50 , 50)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(tooltipSpin, 255/255, 187/255, 00/255, true)
            GameTooltip:Show()
        end)
        newSpinner:SetEventListener("OnLeave", function(this, event)
            GameTooltip:Hide()
        end)
    end

    newSpinner:ApplySettings()

    parent:AddChild(newSpinner)

    return newSpinner
end

function br.ui:createSpinnerWithout(parent, text, number, min, max, step, tooltip, tooltipSpin, cbDefault)
    return br.ui:createSpinner(parent, text, number, min, max, step, tooltip, tooltipSpin, true, cbDefault)
end