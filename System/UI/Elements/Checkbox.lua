local DiesalGUI = LibStub("DiesalGUI-1.0")

function br.ui:createCheckbox(parent, text, tooltip, defaultValue, tooltipFromOther)
    local newBox = DiesalGUI:Create('Toggle')
    local parent = parent
    local anchor = anchor or "TOPLEFT"
    local defaultValue = defaultValue or false
    local tooltipFromOther = tooltipFromOther or false

    -- Set text
    newBox:SetText(text)

    -- Change size
    --newBox.settings.height = 12
    --newBox.settings.width = 12

    -- Calculate Position
    local howManyBoxes = 1
    for i=1, #parent.children do
        if parent.children[i].type == "Toggle" then
            howManyBoxes = howManyBoxes + 1
        end
    end

    local y = howManyBoxes
    if y  ~= 1 then y = ((y-1) * -br.spacing) -5 end
    if y == 1 then y = -5 end

    -- Set parent
    newBox:SetParent(parent.content)

    -- Set anchor
    newBox:SetPoint("TOPLEFT", parent.content, anchor, 10, y)

    -- Read check value from config, false if nothing found
    -- Set default
    if br.data.settings[br.selectedSpec][br.selectedProfile][text.."Check"] == nil then br.data.settings[br.selectedSpec][br.selectedProfile][text.."Check"] = defaultValue end
    local check = br.data.settings[br.selectedSpec][br.selectedProfile][text.."Check"]
    if check == 0 then check = false end
    if check == 1 then check = true end

    if check == false then newBox:SetChecked(false) end
    if check == true then  newBox:SetChecked(true) end

    -- Event: OnValueChanged
    newBox:SetEventListener('OnValueChanged', function(this, event, checked)
        br.data.settings[br.selectedSpec][br.selectedProfile][text.."Check"] = checked

        -- Create Chat Overlay
        if checked then
            ChatOverlay("|cff15FF00"..text.." Enabled")
        else
            ChatOverlay("|cFFED0000"..text.." Disabled")
        end
    end)
    -- Event: Tooltip
    if tooltip then
        newBox:SetEventListener("OnEnter", function(this, event)
            GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50 , 50)
            GameTooltip:ClearLines()
            if tooltipFromOther then
                GameTooltip:AddLine(tooltip, 255/255, 187/255, 00/255, true)
            else
                GameTooltip:AddLine(tooltip.."|r|n|n|n|n"..LC_DEFALUT_VALUE..": |cffFFFFFF"..tostring(defaultValue).."|r", 255/255, 187/255, 00/255, true)
            end
            GameTooltip:SetWidth(50)
            GameTooltip:Show()
        end)
        newBox:SetEventListener("OnLeave", function(this, event)
            GameTooltip:Hide()
        end)
    end

    -- Apply changed settings like size, position, etc
    newBox:ApplySettings()

    -- Add as a child element to parent
    parent:AddChild(newBox)

    return newBox
end