local rotationName = "Ellis" -- Appears in the dropdown of the rotation selector in the Profile Options window

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.fanOfKnives },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.fanOfKnives },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.mutilate },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.crimsonVial}
    }
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.vendetta },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.vendetta },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.vendetta }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.evasion },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.evasion }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.kick },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.kick }
    };
    CreateButton("Interrupt",4,0)
end
---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable
    local function rotationOptions()
        -----------------------
        --- GENERAL OPTIONS ---
        -----------------------
        section = br.ui:createSection(br.ui.window.profile,  LC_GENERAL)
        -- Auto Target
            br.ui:createCheckbox(section, LC_AUTO_TARGET, LC_AUTO_TARGET_DESCRIPTION)
        -- Auto Facing
            br.ui:createCheckbox(section, LC_AUTO_FACING, LC_AUTO_FACING_DESCRIPTION)
        -- Artifact
            br.ui:createDropdown(section, LC_ARTIFACT, {LC_ARTIFACT_EVERY_TIME,LC_ARTIFACT_CD}, 1)
        -- Stealth
            br.ui:createDropdown(section, LC_STEALTH, {LC_STEALTH_ALWAYS,LC_STEALTH_HAS_TARGET}, 1)
        -- Poison
            br.ui:createCheckbox(section, LC_POISON)
        br.ui:checkSectionState(section)
        -- ------------------------
        -- --- Pre-Pull BossMod ---
        -- ------------------------
        -- section = br.ui:createSection(br.ui.window.profile, LC_PRE_PULL_BOSSMOD)
        -- -- Pre-Pull Timer
        --     br.ui:createSpinner(section, LC_PRE_PULL_TIMER,  3,  1,  10,  1,  LC_PRE_PULL_TIMER_DESCRIPTION)
        -- -- Potion
        --     br.ui:createDropdown(section, LC_POTION, {LC_OLD_WAR,LC_PROLONGED_POWER}, 1)
        -- -- Flask
        --     br.ui:createCheckbox(section,LC_FLASK)
        -- br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_COOLDOWNS)
        -- Racial
            br.ui:createCheckbox(section,LC_RACIAL,LC_RACIAL_DESCRIPTION)
        -- Trinkets
            br.ui:createCheckbox(section,LC_TRINKETS,LC_TRINKETS_DESCRIPTION)
        -- Marked For Death
            br.ui:createCheckbox(section,LC_MARKED_FOR_DEATH)
        -- Vendetta
            br.ui:createCheckbox(section,LC_VENDETTA)
        -- Vanish
            br.ui:createCheckbox(section,LC_VANISH)
        -- Exsanguinate
            br.ui:createCheckbox(section,LC_EXSANGUINATE)
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_DEFENSIVE)
            -- Healthstone
            br.ui:createSpinner(section, LC_POT_STONED,  60,  0,  100,  5,  LC_POT_STONED_DESCRIPTION)
            -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, LC_GIFT_OF_THE_NAARU,  50,  0,  100,  5,  LC_GIFT_OF_THE_NAARU_DESCRIPTION)
            end
            -- Crimson Vial
            br.ui:createSpinner(section, LC_CRIMSON_VIAL,  70,  0,  100,  5)
            -- Evasion
            br.ui:createSpinner(section, LC_EVASION,  50,  0,  100,  5)
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
        -- Interrupt Percentage
            br.ui:createSpinnerWithout(section, LC_INTERRUPTS_AT,  0,  0,  95,  5,  LC_INTERRUPTS_AT_DESCRIPTION)
        br.ui:checkSectionState(section)
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
    --if br.timer:useTimer("debugRetribution", math.random(0.15,0.3)) then -- Change debugSpec tp name of Spec IE: debugFeral or debugWindwalker
        --print("Running: "..rotationName)
---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
--- FELL FREE TO EDIT ANYTHING BELOW THIS AREA THIS IS JUST HOW I LIKE TO SETUP MY ROTATIONS ---
--------------
--- Locals ---
--------------
        local artifact                                                      = br.player.artifact
        local autoFacing                                                    = isChecked(LC_AUTO_FACING)
        local autoTarget                                                    = isChecked(LC_AUTO_TARGET)
        local buff                                                          = br.player.buff
        local cast                                                          = br.player.cast
        local cd                                                            = br.player.cd
        local charges                                                       = br.player.charges
        local combatTime                                                    = getCombatTime()
        local comboPoints                                                   = br.player.power.comboPoints
        local cpMaxSpend                                                    = select(5,getSpellCost(br.player.spell.rupture))
        local debuff                                                        = br.player.debuff
        local enemies                                                       = br.player.enemies
        local energy                                                        = br.player.power.energy
        local energyTTM                                                     = br.player.power.ttm
        local forceAOE                                                      = br.player.mode.rotation == 2
        local forceSingle                                                   = br.player.mode.rotation == 3
        local gcd                                                           = br.player.gcd
        local hastar                                                        = ObjectExists("target")
        local healPot                                                       = getHealthPot()
        local inCombat                                                      = br.player.inCombat
        local lastSpell                                                     = lastSpellCast
        local lastTarget                                                    = lastSpellTarget
        local level                                                         = br.player.level
        local lowestHP                                                      = br.friend[1].unit
        local mode                                                          = br.player.mode
        local php                                                           = br.player.health
        local race                                                          = br.player.race
        local racial                                                        = br.player.getRacial()
        local solo                                                          = GetNumGroupMembers() == 0
        local spell                                                         = br.player.spell
        local talent                                                        = br.player.talent
        local ttd                                                           = getTTD
        local units                                                         = br.player.units
        local useArtifact                                                   = false
        local useCDs                                                        = useCDs()
        local useVendetta                                                   = isChecked(LC_VENDETTA) and useCDs
        local useVanish                                                     = isChecked(LC_VANISH) and useCDs
        local useExsanguinate                                               = isChecked(LC_EXSANGUINATE) and useCDs

        if isChecked(LC_ARTIFACT) then
            if getOptionValue(LC_ARTIFACT) == 1 then
                useArtifact = artifact.kingsbane
            else
                useArtifact = useCDs and artifact.kingsbane
            end
        end

        if not br.player.eventRegisted then
            br.player.exsanguinateList = {}
            AddEventCallback("COMBAT_LOG_EVENT_UNFILTERED",function(...)
                local _, combatEvent, _, sourceGUID, _, _, _, destGUID, destName, _, _, spellId, _, _ = ...
                if combatEvent == "SPELL_CAST_SUCCESS" 
                    and sourceGUID == UnitGUID("player")
                    and (spellId == spell.rupture or spellId == spell.garrote or spellId == spell.internalBleeding or spellId == spell.exsanguinate)
                then
                    local sucess,thisUnit = pcall(GetObjectWithGUID,destGUID)
                    if not sucess then
                        return
                    end
                    if br.player.exsanguinateList[destGUID] == nil then
                        br.player.exsanguinateList[destGUID] = {}
                        br.player.exsanguinateList[destGUID].unit = thisUnit
                    end
                    if spellId == spell.rupture then
                        br.player.exsanguinateList[destGUID].exRupture = false
                    elseif spellId == spell.garrote then
                        br.player.exsanguinateList[destGUID].exGarrote = false
                    elseif spellId == spell.internalBleeding then
                        br.player.exsanguinateList[destGUID].exInternalBleeding = false
                    elseif spellId == spell.exsanguinate then
                        if debuff.rupture[thisUnit].exists then
                            br.player.exsanguinateList[destGUID].exRupture = true
                        end
                        if debuff.garrote[thisUnit].exists then
                            br.player.exsanguinateList[destGUID].exGarrote = true
                        end
                        if debuff.internalBleeding[thisUnit].exists then
                            br.player.exsanguinateList[destGUID].exInternalBleeding = true
                        end
                    end
                end
            end,"Assassination")

            AddEventCallback("PLAYER_SPECIALIZATION_CHANGED",function(source)
                if source ~= "player" then
                    return
                end
                RemoveEventCallback("COMBAT_LOG_EVENT_UNFILTERED","Assassination")
                RemoveEventCallback("PLAYER_SPECIALIZATION_CHANGED","Assassination")
            end,"Assassination")
            br.player.eventRegisted = true
        end

        if debuff.rupture["target"].count == 0 and debuff.garrote["target"].count == 0 and debuff.internalBleeding["target"].count == 0 then
            table.wipe(br.player.exsanguinateList)
        end

        for k,v in pairs(br.enemy) do
            if br.player.exsanguinateList[v.guid] == nil then
                br.player.exsanguinateList[v.guid] = {}
                br.player.exsanguinateList[v.guid].unit = k
                br.player.exsanguinateList[v.guid].exRupture = false
                br.player.exsanguinateList[v.guid].exGarrote = false
                br.player.exsanguinateList[v.guid].exInternalBleeding = false
            end
        end

        if ObjectExists("target") and br.player.exsanguinateList[UnitGUID("target")] == nil then
            local guid = UnitGUID("target")
            br.player.exsanguinateList[guid] = {}
            br.player.exsanguinateList[guid].unit = "target"
            br.player.exsanguinateList[guid].exRupture = false
            br.player.exsanguinateList[guid].exGarrote = false
            br.player.exsanguinateList[guid].exInternalBleeding = false
        end

        for k,v in pairs(br.player.exsanguinateList) do
            if UnitIsUnit(v.unit,"target") then
                if not debuff.rupture["target"].exists then
                    br.player.exsanguinateList[k].exRupture = false
                end
                if not debuff.garrote["target"].exists then
                    br.player.exsanguinateList[k].exGarrote = false
                end
                if not debuff.internalBleeding["target"].exists then
                    br.player.exsanguinateList[k].exInternalBleeding = false
                end
            else
                if debuff.rupture[v.unit] and not debuff.rupture[v.unit].exists then
                    br.player.exsanguinateList[k].exRupture = false
                end
                if debuff.garrote[v.unit] and not debuff.garrote[v.unit].exists then
                    br.player.exsanguinateList[k].exGarrote = false
                end
                if debuff.internalBleeding[v.unit] and not debuff.internalBleeding[v.unit].exists then
                    br.player.exsanguinateList[k].exInternalBleeding = false
                end
            end
        end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
            if isChecked(LC_STEALTH) and not inCombat and not buff.stealth.exists then
                if getOptionValue(LC_STEALTH) == 1 or isValidUnit("target") then
                    if cast.stealth() then return true end
                end
            end
            if not inCombat and isChecked(LC_POISON) and br.timer:useTimer("Poison",2) then
                if buff.cripplingPoison.remain < 300 then
                    if cast.cripplingPoison("player") then return true end
                end
                if buff.agonizingPoison.remain < 300 and buff.woundPoison.remain < 300 and buff.deadlyPoison.remain < 300 then
                    if talent.agonizingPoison then
                        if cast.agonizingPoison("player") then return true end
                    else
                        if cast.deadlyPoison("player") then return true end
                    end
                end
            end
        end -- End Action List - Extras
    -- Action List - Defensives
        local function actionList_Defensive()
            if useDefensive() then
        -- Pot/Stoned
                if isChecked(LC_POT_STONED) and php <= getOptionValue(LC_POT_STONED) 
                    and inCombat and (hasHealthPot() or hasItem(5512)) 
                then
                    if canUse(5512) and useItem(5512) then return true end
                    if canUse(healPot) and useItem(healPot) then return true end
                end
        -- Gift of the Naaru
                if isChecked(LC_GIFT_OF_THE_NAARU) and getSpellCD(racial)==0 and php <= getOptionValue(LC_GIFT_OF_THE_NAARU) and php > 0 and race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Crimson Vial
                if isChecked(LC_CRIMSON_VIAL) and php < getOptionValue(LC_CRIMSON_VIAL) then
                    if cast.crimsonVial() then return true end
                end
        -- Evasion
                if isChecked(LC_EVASION) and php < getOptionValue(LC_EVASION) and inCombat then
                    if cast.evasion() then return end
                end
            end
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() and br.timer:useTimer("Interrupts",1.5) then
                local interruptAt = getOptionValue(LC_INTERRUPTS_AT)
                for i = 1, #enemies.yards10 do
                    local thisUnit = enemies.yards10[i]
                    local distance = getDistance(thisUnit)
                    if canInterrupt(thisUnit,interruptAt) then
                    
                    end
                end
            end
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
    -- Racial
            -- blood_fury,if=debuff.vendetta.up
            -- berserking,if=debuff.vendetta.up
            -- arcane_torrent,if=debuff.vendetta.up&energy.deficit>50
            if useCDs and (debuff.vendetta[units.dyn5].exists or not useVendetta) and isChecked(LC_RACIAL) then
                if (race == "Orc" or race == "Troll" or (race == "BloodElf" and energy.deficit > 50)) 
                    and getSpellCD(racial) == 0 
                    and castSpell("player",racial,true,false) 
                then 
                    return true 
                end
            end
    -- Marked For Death
            -- marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit|combo_points.deficit>=5
            if useCDs and talent.markedForDeath and isChecked(LC_MARKED_FOR_DEATH) and (comboPoints.deficit >= 5 or ttd(units.dyn5) < comboPoints.deficit) then
                if cast.markedForDeath() then return true end
            end
    -- Vendetta
            -- vendetta,if=talent.exsanguinate.enabled&cooldown.exsanguinate.remains<5&dot.rupture.ticking
            -- vendetta,if=!talent.exsanguinate.enabled&(!artifact.urge_to_kill.enabled|energy.deficit>=70)
            if useVendetta and 
                ((talent.exsanguinate and cd.exsanguinate < 5 and debuff.rupture[units.dyn5].exists)
                    or ((not talent.exsanguinate or not useExsanguinate) and (not artifact.urgeToKill or energy.deficit >= 70)))
            then
                if cast.vendetta() then return true end
            end
    -- Vanish
            -- vanish,if=talent.nightstalker.enabled&combo_points>=cp_max_spend&((talent.exsanguinate.enabled&cooldown.exsanguinate.remains<1&(dot.rupture.ticking|time>10))(!talent.exsanguinate.enabled&dot.rupture.refreshable))
            -- vanish,if=talent.subterfuge.enabled&dot.garrote.refreshable&((spell_targets.fan_of_knives<=3&combo_points.deficit>=1+spell_targets.fan_of_knives)(spell_targets.fan_of_knives>=4&combo_points.deficit>=4))
            -- vanish,if=talent.shadow_focus.enabled&energy.time_to_max>=2&combo_points.deficit>=4
            if useVanish 
                and not solo 
                and isBoss()
                and 
                ((talent.nightstalker 
                and comboPoints.amount >= cpMaxSpend 
                and ((talent.exsanguinate 
                        and cd.exsanguinate < 1 
                        and (debuff.rupture[units.dyn5].exists or combatTime > 10)) 
                    or ((not talent.exsanguinate or not useExsanguinate) and debuff.rupture[units.dyn5].refresh)))
                or
                (talent.subterfuge 
                 and debuff.garrote[units.dyn5].refresh 
                 and ((#enemies.yards10 <= 3 and comboPoints.deficit >= 1 + #enemies.yards10) 
                        or (#enemies.yards10 >= 4 and comboPoints.deficit >= 4)))
                or
                (talent.shadowFocus and energyTTM >= 2 and comboPoints.deficit >= 4))
            then
                 if cast.vanish() then return true end
            end
    -- Exsanguinate
            -- exsanguinate,if=prev_gcd.rupture&dot.rupture.remains>4+4*cp_max_spend
            if useExsanguinate and lastSpell == spell.rupture and debuff.rupture[units.dyn5].remain > 4 + 4 * cpMaxSpend then
                if cast.exsanguinate() then return true end
            end
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
        end -- End Action List - PreCombat
    -- Action List - Opener
        local function actionList_Opener()
        -- Start Attack
            if getDistance(units.dyn5) <= 5 then StartAttack() end
        end -- End Action List - Opener
    -- Action List - Auto Target
        local function actionList_AutoTarget()
            if autoTarget == false then return end
            if isValidUnit("target") or UnitIsFriend("target","player") then return end
            local theEnemies = enemies.yards8
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
            if targetUnit then
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
    -- Action List - Maintain
        local function actionList_Maintain()
        -- Rupture
            -- rupture,if=(talent.nightstalker.enabled&stealthed.rogue)|(talent.exsanguinate.enabled&((combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1)|(!ticking&(time>10|combo_points>=2+artifact.urge_to_kill.enabled))))
            local urgeToKillPoint = 0
            if artifact.urgeToKill then urgeToKillPoint = 1 end
            if (talent.nightstalker and buff.stealth.exists)
                or (talent.exsanguinate and useExsanguinate
                    and ((comboPoints.amount >= cpMaxSpend and cd.exsanguinate < 1) 
                            or (not debuff.rupture[units.dyn5].exists and (combatTime > 10 
                            or comboPoints.amount >= 2 + urgeToKillPoint))))
            then
                if cast.rupture() then return true end
            end
            -- rupture,cycle_targets=1,if=combo_points>=cp_max_spend-talent.exsanguinate.enabled&refreshable&(!exsanguinated|remains<=1.5)&target.time_to_die-remains>4
            local exsanguinatePoint = 0
            if talent.exsanguinate and useExsanguinate then exsanguinatePoint = 1 end
            if comboPoints.amount >= cpMaxSpend - exsanguinatePoint
                and getFacing("player",units.dyn5,120)
                and debuff.rupture[units.dyn5].refresh 
                and (not br.player.exsanguinateList[UnitGUID(units.dyn5)].exRupture or debuff.rupture[units.dyn5].remain <= 1.5)
                and ttd(units.dyn5) - debuff.rupture[units.dyn5].remain > 4
            then
                if cast.rupture() then return true end
            end
            if not forceSingle and comboPoints.amount >= cpMaxSpend - exsanguinatePoint then
                for i = 1,#enemies.yards5 do
                    local thisUnit = enemies.yards5[i]
                    if getFacing("player",thisUnit,120)
                        and ((debuff.rupture[thisUnit].refresh and debuff.rupture[thisUnit].exists) 
                            or (not debuff.rupture[thisUnit].exists and debuff.rupture[units.dyn5].count < 10))
                        and (not br.player.exsanguinateList[UnitGUID(thisUnit)].exRupture or debuff.rupture[thisUnit].remain <= 1.5)
                        and ttd(thisUnit) - debuff.rupture[thisUnit].remain > 4
                    then
                        if cast.rupture(thisUnit) then return true end
                    end
                end
            end
        -- Kingsbane
            -- kingsbane,if=(talent.exsanguinate.enabled&dot.rupture.exsanguinated)|(!talent.exsanguinate.enabled&(debuff.vendetta.up|cooldown.vendetta.remains>10))
            if useArtifact and ((talent.exsanguinate and br.player.exsanguinateList[UnitGUID(units.dyn5)].exRupture) 
                                or ((not talent.exsanguinate or not useExsanguinate) and (debuff.vendetta[units.dyn5].exists or cd.vendetta > 10 or not useVendetta)))
            then
                if cast.kingsbane() then return true end
            end
        -- Garrote
            -- pool_resource,for_next=1
            -- garrote,cycle_targets=1,if=refreshable&(!exsanguinated|remains<=1.5)&target.time_to_die-remains>4
            if debuff.garrote[units.dyn5].refresh 
                and (not br.player.exsanguinateList[UnitGUID(units.dyn5)].exGarrote or debuff.garrote[units.dyn5].remain <= 1.5) 
                and ttd(units.dyn5) - debuff.garrote[units.dyn5].remain > 4
            then
                if energy.amount <= select(1, getSpellCost(spell.garrote)) then
                    return true
                end
                if cast.garrote() then return true end
            end
        end -- End Action List - Maintain
    -- Action List - Finish
        local function actionList_Finish()
        -- Death From Above
            -- death_from_above,if=combo_points>=cp_max_spend
            if comboPoints.amount >= cpMaxSpend then
                if cast.deathFromAbove() then return true end
            end
        -- Envenom
            -- envenom,if=combo_points>=cp_max_spend-talent.master_poisoner.enabled|(talent.elaborate_planning.enabled&combo_points>=3+!talent.exsanguinate.enabled&buff.elaborate_planning.remains<2)
            local masterPoisonerPoint = 0
            local exsanguinatePoint = 0
            if not talent.exsanguinate or not useExsanguinate then exsanguinatePoint = 1 end
            if talent.masterPoisoner then masterPoisonerPoint = 1 end
            if comboPoints.amount >= cpMaxSpend - masterPoisonerPoint 
                or (talent.elaboratePlanning and comboPoints.amount >= 3 + exsanguinatePoint and buff.elaboratePlanning.remain < 2)
            then
                if cast.envenom() then return true end
            end
        end -- End Action List - Finish
    -- Action List - Build
        local function actionList_Build()
        -- Hemorrhage
            -- hemorrhage,if=refreshable
            if talent.hemorrhage and debuff.hemorrhage[units.dyn5].refresh then
                if cast.hemorrhage() then return true end
            end
            -- hemorrhage,cycle_targets=1,if=refreshable&dot.rupture.ticking&spell_targets.fan_of_knives<=3
            if talent.hemorrhage and not forceSingle then
                for i = 1,#enemies.yards5 do
                    local thisUnit = enemies.yards5[i]
                    if getFacing("player",thisUnit,120)
                        and ((debuff.hemorrhage[thisUnit].refresh and debuff.hemorrhage[thisUnit].exists) 
                            or (not debuff.hemorrhage[thisUnit].exists and debuff.hemorrhage[units.dyn5].count < 10))
                        and #enemies.yards10 <= 3
                    then
                        if cast.hemorrhage(thisUnit) then return true end
                    end
                end
            end
        -- Fan Of Knives
            -- fan_of_knives,if=spell_targets>=3|buff.the_dreadlords_deceit.stack>=29
            if not forceSingle and (#enemies.yards10 >= 3 or buff.theDreadlordsDeceit.stack >= 29 or forceAOE) then
                if cast.fanOfKnives() then return true end
            end
        -- Mutilate
            -- mutilate,cycle_targets=1,if=(!talent.agonizing_poison.enabled&dot.deadly_poison_dot.refreshable)|(talent.agonizing_poison.enabled&debuff.agonizing_poison.remains<debuff.agonizing_poison.duration*0.3)|(set_bonus.tier19_2pc=1&dot.mutilated_flesh.refreshable)
            for i = 1,#enemies.yards5 do
                local thisUnit = enemies.yards5[i]
                if getFacing("player",thisUnit,120) and 
                    ((not talent.agonizingPoison and debuff.deadlyPoison[thisUnit].exists and debuff.deadlyPoison[thisUnit].refresh)
                    or
                    (talent.agonizingPoison and debuff.agonizingPoison[thisUnit].exists and debuff.agonizingPoison[thisUnit].refresh))
                then
                    if cast.mutilate(thisUnit) then return true end
                end
            end
            -- mutilate
            if cast.mutilate() then return true end 
        end -- End Action List - Build
---------------------
--- Begin Profile ---
---------------------
    -- Pause
        if pause() or mode.rotation == 4 or IsMounted() then
            return true
        else
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
-------------------------------
--- In Combat - Auto Target ---
-------------------------------
            if inCombat and actionList_AutoTarget() then return end
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and isValidUnit(units.dyn5) then
------------------------
--- In Combat Opener ---
------------------------
                if actionList_Opener() then return end
-------------------------------
--- In Combat - Auto Facing ---
-------------------------------
                if actionList_AutoFacing() then return end
------------------------------
--- In Combat - Interrupts ---
------------------------------
                if actionList_Interrupts() then return end
-----------------------------
--- In Combat - Cooldowns ---
-----------------------------
                if actionList_Cooldowns() then return end
----------------------------------
--- In Combat - Begin Rotation ---
----------------------------------
               if actionList_Maintain() then return end

               -- call_action_list,name=finish,if=(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)&(!dot.rupture.refreshable|(dot.rupture.exsanguinated&dot.rupture.remains>=3.5)|target.time_to_die-dot.rupture.remains<=4)&active_dot.rupture>=spell_targets.rupture
               -- The 'active_dot.rupture>=spell_targets.rupture' means that we don't want to envenom as long as we can multi-rupture (i.e. units that don't have rupture yet).
               if (not talent.exsanguinate or cd.exsanguinate > 2 or not useExsanguinate) 
                    and (not debuff.rupture[units.dyn5].refresh or (br.player.exsanguinateList[UnitGUID(units.dyn5)].exRupture and debuff.rupture[units.dyn5].remain >= 3.5) or ttd(units.dyn5) - debuff.rupture[units.dyn5].remain <= 4) 
                    and debuff.rupture[units.dyn5].count >= math.min(#enemies.yards5,10)
               then
                    if actionList_Finish() then return end
               end
               if comboPoints.deficit > 0 or energyTTM < 1 then
                    if actionList_Build() then return end
               end
            end -- End In Combat
        end -- End Profile
    --end -- Timer
end -- runRotation
local id = 259
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})