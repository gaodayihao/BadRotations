local rotationName = "Ellis"

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.mindFlay },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.mindSear },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.mindFlay },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.shadowMend}
    };
    CreateButton("Rotation",1,0)
    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.powerInfusion },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.powerInfusion },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.powerInfusion }
    };
   	CreateButton("Cooldown",2,0)
    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.dispersion },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.dispersion }
    };
    CreateButton("Defensive",3,0)
    -- Shadow Word:Death Button
    ShadowWordDeathModes = {
        [1] = { mode = "", value = 1 , overlay = "", tip = "Target to die (s)", highlight = 1, icon = br.player.spell.shadowWordDeath }
    };
    CreateButton("ShadowWordDeath",4,0)
    -- Void Form Button
    VoidEruptionModes = {
        [1] = { mode = "On", value = 1 , overlay = "Void Eruption Enabled", tip = "Void Eruption will be used.", highlight = 1, icon = br.player.spell.voidEruption },
        [2] = { mode = "Off", value = 2 , overlay = "Void Eruption Disabled", tip = "Void Eruption will not be used.", highlight = 0, icon = br.player.spell.voidEruption }
    };
    CreateButton("VoidEruption",5,0)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
    -- General Options
        section = br.ui:createSection(br.ui.window.profile, LC_GENERAL)
        -- Auto Target
            br.ui:createCheckbox(section, LC_AUTO_TARGET, LC_AUTO_TARGET_DESCRIPTION, true)
        -- Auto Facing
            br.ui:createCheckbox(section, LC_AUTO_FACING, LC_AUTO_FACING_DESCRIPTION)
        -- SWP Max Targets
            br.ui:createSpinner(section, LC_SWP_MAX_TARGETS,  6,  1,  10,  1, LC_SWP_MAX_TARGETS_DESCRIPTION)
        -- VT Max Targets
            br.ui:createSpinner(section, LC_VT_MAX_TARGETS,  3,  1,  10,  1, LC_VT_MAX_TARGETS_DESCRIPTION)
        -- VT Max Targets
            --br.ui:createSpinnerWithout(section, LC_DOT_MINIMUM_HEALTH,  3,  1,  5,  1, LC_DOT_MINIMUM_HEALTH_DESCRIPTION)
        -- Body And Soul
            br.ui:createSpinner(section, LC_BODY_AND_SOUL,  1.5,  0,  5,  0.5, LC_BODY_AND_SOUL_DESCRIPTION, nil, false, true)
        -- Nonexecute Actors
            --br.ui:createSpinnerWithout(section, LC_EXECUTE_ACTORS,  1,  1,  25,  1, LC_EXECUTE_ACTORS_DESCRIPTION)
        -- Artifact
            br.ui:createDropdown(section, LC_ARTIFACT, {LC_ARTIFACT_EVERY_TIME,LC_ARTIFACT_CD}, 1)
        br.ui:checkSectionState(section)
    -- Pre-Pull BossMod
        section = br.ui:createSection(br.ui.window.profile, LC_PRE_PULL_BOSSMOD)
        -- Pre-Pull Timer
            br.ui:createSpinner(section, LC_PRE_PULL_TIMER,  3,  1,  10,  1,  LC_PRE_PULL_TIMER_DESCRIPTION)
        -- Potion
            br.ui:createDropdown(section, LC_POTION, {LC_DEADLY_GRACE,LC_PROLONGED_POWER}, 1)
        -- Flask
            br.ui:createCheckbox(section,LC_FLASK)
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, LC_COOLDOWNS)
        -- S2M Check
            br.ui:createSpinnerWithout(section, LC_S2M_CHECK,  120,  90,  150,  1, LC_S2M_CHECK_DESCRIPTION)
        -- Time to use PowerInfusion
            --br.ui:createSpinnerWithout(section, LC_TIME_TO_USE_POWER_INFUSION,  60,  50,  150,  1, LC_TIME_TO_USE_POWER_INFUSION_DESCRIPTION)
        -- MindBender / Shadowfiend
            br.ui:createCheckbox(section, LC_MINDBENDER_SHADOWFIEND)
        -- PowerInfusion
            br.ui:createCheckbox(section, LC_POWER_INFUSION)
        -- Dispersion
            br.ui:createCheckbox(section, LC_DISPERSION, LC_DISPERSION_DESCRIPTION)
            if br.player.race == "BloodElf" then
            -- Arcane Torrent
                br.ui:createCheckbox(section, LC_ARCANE_TORRENT, LC_ARCANE_TORRENT_DESCRIPTION)
            end
            if hasEquiped(130234) then
            -- Blessed Dawnlight Medallion
                br.ui:createCheckbox(section, LC_BLESSED_DAWNLIGHT_MEDALLION, LC_BLESSED_DAWNLIGHT_MEDALLION_DESCRIPTION)
            end
        br.ui:checkSectionState(section)
    -- -- Defensive Options
    --     section = br.ui:createSection(br.ui.window.profile, LC_DEFENSIVE)
    --     -- Healthstone
    --         br.ui:createSpinner(section, "Healthstone",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
    --     -- Gift of The Naaru
    --         if br.player.race == "Draenei" then
    --             br.ui:createSpinner(section, "Gift of the Naaru",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
    --         end
    --     -- Power Word: Shield
    --         br.ui:createSpinner(section, "Power Word: Shield",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
    --     -- Dispel Magic
    --         br.ui:createCheckbox(section,"Dispel Magic")
    --     -- Vampiric Embrace
    --         br.ui:createSpinner(section, LC_VAMPIRIC_EMBRACE,  40,  1,  100,  5, LC_VAMPIRIC_EMBRACE_DESCRIPTION)
    --     br.ui:checkSectionState(section)
    end
    optionTable = {{
        [1] = "Rotation Options",
        [2] = rotationOptions,
    }}
    return optionTable
end

----------------
--- ROTATION ---
----------------
local function runRotation()
    --if br.timer:useTimer("debugShadow", 0.1) then
        --print("Running: "..rotationName)
---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
--------------
--- Locals ---
--------------
        local artifact                                      = br.player.artifact
        local autoFacing                                    = isChecked(LC_AUTO_FACING)
        local autoTarget                                    = isChecked(LC_AUTO_TARGET)
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local combatTime                                    = getCombatTime()
        local debuff                                        = br.player.debuff
        local enemies                                       = br.player.enemies
        local forceAOE                                      = br.player.mode.rotation == 2
        local forceSingle                                   = br.player.mode.rotation == 3
        local friendly                                      = UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local hasteAmount                                   = GetHaste()/100
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastSpell                                     = lastSpellCast
        local lastTarget                                    = lastSpellTarget
        local manaPercent                                   = br.player.power.mana.percent
        local mode                                          = br.player.mode
        local moving                                        = isMoving("player")
        local php                                           = br.player.health
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.insanity, br.player.power.insanity.max, br.player.power.regen, br.player.power.insanity.deficit
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local resable                                       = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
        local solo                                          = GetNumGroupMembers() == 0
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local ttd                                           = getTTD
        local units                                         = br.player.units
        local useArtifact                                   = false

        local bodyAndSoul                                   = -1
        
        if movingStart == nil then movingStart = 0 end
        if isChecked(LC_BODY_AND_SOUL) and not buff.surrenderToMadness.exists then
            bodyAndSoul = getOptionValue(LC_BODY_AND_SOUL)
        end
        if delayHack == nil then delayHack = 0 end
--------------------
-- Custom Function--
--------------------

--------------------
--- Action Lists ---
--------------------
    -- Action List - Auto Target
        function actionList_AutoTarget()
            if not inCombat then return end
            if autoTarget == false then return end
            if isValidUnit("target") then return end
            local theEnemies = enemies.yards40
            local targetUnit = nil
            for i = 1, #theEnemies do
                local thisUnit = theEnemies[i]
                if not targetUnit and UnitGUID(thisUnit) ~= lastTarget then
                    targetUnit = thisUnit
                elseif targetUnit ~= nil then
                    local health = UnitHealth(thisUnit)
                    if health > UnitHealth(targetUnit) and UnitGUID(thisUnit) ~= lastTarget then
                        targetUnit = thisUnit
                    end
                end
            end
            if targetUnit and isInCombat(targetUnit) then
                TargetUnit(targetUnit)
            end
        end -- End Action List - Auto Target
    -- Action List - Auto Facing
        local function actionList_AutoFacing()
            if autoFacing 
                and not isMoving("player") 
                and not getFacing("player","target",120)
            then
                FaceDirection(GetAnglesBetweenObjects("player", "target"), true)
            end
        end -- End Action List - Auto Facing
    -- Action list - Extras
        function actionList_Extras()
            --print(useCDs())
            if IsFlying() or IsMounted() then return end
            if not buff.bodyAndSoul.exists and bodyAndSoul > -1 and isMoving("player") and not buff.surrenderToMadness.exists and talent.bodyAndSoul then
                if movingStart == 0 then
                    movingStart = GetTime()
                elseif GetTime() > movingStart + bodyAndSoul then
                    cast.powerWordShield()
                end
            else
                movingStart = 0
            end
        end -- End Action List - Extra
    -- Action List - Defensive
        function actionList_Defensive()
            if useDefensive() and getHP("player")>0 then
                -- Gift of the Naaru
                if isChecked("Gift of the Naaru") and php <= getOptionValue("Gift of the Naaru") and php > 0 and br.player.race=="Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
                -- Power Word: Shield
                if isChecked("Power Word: Shield") and php <= getOptionValue("Power Word: Shield") and not buff.powerWordShield then
                    if cast.powerWordShield("player") then return end
                end
            end -- End Defensive Check
        end -- End Action List - Defensive
    -- Action List - Interrupts
        function actionList_Interrupts()
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        function actionList_Cooldowns()
            if useCDs() then
            
            end
        end -- End Action List - Cooldowns
    -- Action List - Pre-Combat
        function actionList_PreCombat()

        end  -- End Action List - Pre-Combat
    -- Action List - Opener
        function actionList_Opener()
        end -- End Action List - Pre-Combat
    -- Action List - Main
        function actionList_Main()
        
        end -- End Action List - main
    -- Action List - vf
        function actionList_Vf()
        
        end -- End Action List - vf
    -- Action List - s2m
        function actionList_S2M()
        
        end -- End Action List - s2m
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        local isPause = pause(true)
        if isPause or mode.rotation==4 or delayHack >= 1 then
            if not isPause and not UnitCastingInfo("player") and not UnitChannelInfo("player") and delayHack >= 1 then
                delayHack = delayHack - 1
            end
            return true
        else
-------------------
--- Buid Spells ---
-------------------
            -- if buildSpells() then return end
-----------------------
--- Extras Rotation ---
-----------------------
            if actionList_Extras() then return end
--------------------------
--- Defensive Rotation ---
--------------------------
            if actionList_Defensive() then return end
------------------------------
--- Out of Combat Rotation ---
------------------------------
            if actionList_PreCombat() then return end
-----------------------
--- Opener Rotation ---
-----------------------
            if actionList_Opener() then return end
-------------------------------
--- In Combat - Auto Target ---
-------------------------------
            if inCombat and actionList_AutoTarget() then return end
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and isValidUnit(units.dyn40) then
    -------------------------------
    --- In Combat - Auto Facing ---
    -------------------------------
                if actionList_AutoFacing() then return end
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    ---------------------------
    --- In Combat - Default ---
    ---------------------------
                -- if actionList_Default() then return end
            end --End In Combat
        end --End Rotation Logic
    --end -- End Timer
end -- Run Rotation

local id = 258
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})