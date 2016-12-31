local rotationName = "Ellis"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.lavaBeam},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.chainLightning},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.lightningBolt},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.healingSurge}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.fireElemental},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.fireElemental},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.fireElemental}
    };
       CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.astralShift},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.astralShift}
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.windShear},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.windShear}
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
        local section = br.ui:createSection(br.ui.window.profile,  LC_GENERAL)
        -- Auto Target
            br.ui:createCheckbox(section, LC_AUTO_TARGET, LC_AUTO_TARGET_DESCRIPTION)
        -- Auto Facing
            br.ui:createCheckbox(section, LC_AUTO_FACING, LC_AUTO_FACING_DESCRIPTION)
        -- Ghost Wolf
            br.ui:createSpinner(section, LC_GHOST_WOLF,  1.5,  0,  5,  0.5, LC_GHOST_WOLF_DESCRIPTION)
        -- Water Walking
            br.ui:createCheckbox(section, LC_WATER_WALKING)
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_COOLDOWNS)
        -- Racial
            br.ui:createCheckbox(section,LC_RACIAL,LC_RACIAL_DESCRIPTION)
        -- Trinkets
            br.ui:createCheckbox(section,LC_TRINKETS,LC_TRINKETS_DESCRIPTION)
        -- Ascendance
            br.ui:createCheckbox(section,LC_ASCENDANCE,LC_ASCENDANCE_DESCRIPTION)
        -- Elemental Mastery
            br.ui:createCheckbox(section,LC_ELEMENTAL_MASTERY,LC_ELEMENTAL_MASTERY_DESCRIPTION)
        -- Fire Elemental
            br.ui:createCheckbox(section,LC_FIRE_ELEMENTAL,LC_FIRE_ELEMENTAL_DESCRIPTION)
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
        -- Ancestral Spirit
            br.ui:createCheckbox(section,LC_ANCESTRAL_SPIRIT)
        -- Astral Shift
            br.ui:createSpinner(section, LC_ASTRAL_SHIFT,  50,  0,  100,  5,  LC_ASTRAL_SHIFT_DESCRIPTION)
        -- Healing Surge
            br.ui:createSpinner(section, LC_HEALING_SURGE,  80,  0,  100,  5,  LC_HEALING_SURGE_DESCRIPTION)
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
        -- Wind Shear
            br.ui:createCheckbox(section,LC_WIND_SHEAR)
        -- War Stomp
            if br.player.race == "Tauren" then
                br.ui:createCheckbox(section,LC_WAR_STOMP)
            end
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
    --if br.timer:useTimer("debugElemental", math.random(0.15,0.3)) then
        --print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)

--------------
--- Locals ---
--------------
        local activeEnemiesCache                                            = -1
        local artifact                                                      = br.player.artifact
        local autoFacing                                                    = isChecked(LC_AUTO_FACING)
        local autoTarget                                                    = isChecked(LC_AUTO_TARGET)
        local buff                                                          = br.player.buff
        local cast                                                          = br.player.cast
        local cd                                                            = br.player.cd
        local charges                                                       = br.player.charges
        local combatTime                                                    = getCombatTime()
        local debuff                                                        = br.player.debuff
        local enemies                                                       = br.player.enemies
        local forceAOE                                                      = br.player.mode.rotation == 2
        local forceSingle                                                   = br.player.mode.rotation == 3
        local gcd                                                           = br.player.gcd
        local ghostWolfTimer                                                = -1
        local hasAllTotemBuffs                                              = false
        local healPot                                                       = getHealthPot()
        local inCombat                                                      = br.player.inCombat
        local lastSpell                                                     = lastSpellCast
        local lastTarget                                                    = lastSpellTarget
        local level                                                         = br.player.level
        local mode                                                          = br.player.mode
        local php                                                           = br.player.health
        local power                                                         = br.player.power.amount.maelstrom
        local pullTimer                                                     = br.DBM:getPulltimer()
        local race                                                          = br.player.race
        local racial                                                        = br.player.getRacial()
        local resable                                                       = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
        local solo                                                          = GetNumGroupMembers() == 0
        local spell                                                         = br.player.spell
        local talent                                                        = br.player.talent
        local totemDuration                                                 = 120
        local totemRemain                                                   = -1
        local units                                                         = br.player.units
        local useArtifact                                                   = false
        local useAscendance                                                 = false

        if movingStart == nil then movingStart = 0 end
        if totemStart == nil then totemStart = 0 end

        if isChecked(LC_GHOST_WOLF) then
            ghostWolfTimer = getOptionValue(LC_GHOST_WOLF)
        end

        hasAllTotemBuffs = buff.emberTotem.exists and buff.stormTotem.exists and buff.tailwindTotem.exists and buff.resonanceTotem.exists
        if totemStart > 0 then totemRemain =  totemDuration - (GetTime() - totemStart) end
        if totemRemain <= 0 then totemStart = 0 totemRemain = 0 end

        useAscendance = isChecked(LC_ASCENDANCE) and useCDs()
-----------------------
--- Custom Function ---
-----------------------
        local function activeEnemies()
            if forceSingle then return 1 end
            if forceAOE then return 99 end
            if activeEnemiesCache > -1 then return activeEnemiesCache end
            activeEnemiesCache = #getEnemies(units.dyn40,10)
            return activeEnemiesCache
        end

        if not br.player.handlerEvent then
            local frame = CreateFrame("FRAME")
            frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED","player")
            frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

            function frame:OnEvent(event,...)
                if event == "UNIT_SPELLCAST_SUCCEEDED" then
                    local _,_,_,_,spellId = ...
                    if spellId == spell.totemMastery then
                        totemStart = GetTime()
                    end
                elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
                    frame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
                    frame:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED")
                end
            end
            
            frame:SetScript("OnEvent",frame.OnEvent)
            br.player.handlerEvent = true
        end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Auto Target
        local function actionList_AutoTarget()
            if autoTarget == false then return end
            if isValidUnit("target") or UnitIsFriend("player","target") then return end
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
    -- Action List - Extras
        local function actionList_Extras()
        -- Ghost Wolf
            if isChecked(LC_GHOST_WOLF) then
                if not buff.ghostWolf.exists and isMoving("player") then
                    if movingStart == 0 then
                        movingStart = GetTime()
                    elseif inCombat or (GetTime() > movingStart + ghostWolfTimer) then
                        if cast.ghostWolf() then return true end
                    end
                else
                    movingStart = 0
                end
            end

        -- Water Walking
            if IsSwimming() and not buff.waterWalking.exists and isChecked(LC_WATER_WALKING) and not inCombat then
                if cast.waterWalking() then return true end
            end
        -- Totem Mastery
            if inCombat and not (IsFlying() or IsMounted()) and (not hasAllTotemBuffs or totemRemain < 2) then
                if cast.totemMastery() then return true end
            end
        end -- End Action List - Extras
    -- Action List - Defensive
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
                    if castSpell("player",racial,false,false,false) then return true end
                end
        -- Ancestral Spirit
                if isChecked(LC_ANCESTRAL_SPIRIT) then
                    if resable and not isMoving("player") then
                        if cast.ancestralSpirit("target","dead") then return true end
                    end
                end
        -- Astral Shift
                if isChecked(LC_ASTRAL_SHIFT) and php <= getOptionValue(LC_ASTRAL_SHIFT) and inCombat then
                    if cast.astralShift() then return true end
                end
        -- Healing Surge
                if isChecked(LC_HEALING_SURGE) 
                    and ((inCombat and php <= getOptionValue(LC_HEALING_SURGE) / 2) 
                    or (not inCombat and php <= getOptionValue(LC_HEALING_SURGE) and not moving))
                then
                    if cast.healingSurge() then return true end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() and br.timer:useTimer("Interrupts",1.5) then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue(LC_INTERRUPTS_AT)) then
                    -- wind_shear
                        if isChecked(LC_WIND_SHEAR) then
                            if cast.windShear(thisUnit) then return true end
                        end
                    -- War Stomp
                        if isChecked(LC_WAR_STOMP) 
                            and race == "Tauren" 
                            and getDistance("target") < 8 
                            and not isBoss() 
                            and getSpellCD(racial)==0 
                            and not isMoving("player") then
                            if castSpell("player",racial,false,false,false) then return true end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance("target") <= 40 then
            -- Trinkets
                if isChecked(LC_TRINKETS) then
                    if canUse(13) and useItem(13) then return true end
                    if canUse(14) and useItem(14) then return true end
                end
            -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- berserking,if=buff.ascendance.up|!talent.ascendance.enabled|level<100
                -- blood_fury
                if isChecked(LC_RACIAL) 
                    and (br.player.race == "Orc" or (br.player.race == "Troll" and (buff.ascendance.exists or not talent.ascendance or level < 100 or not useAscendance)))
                    and getSpellCD(racial) == 0
                then
                    if castSpell("player",racial,false,false,false) then return true end
                end
            -- Elemental Mastery
                if isChecked(LC_ELEMENTAL_MASTERY) then
                    if cast.elementalMastery() then return true end
                end
            -- Fire Elemental
                if isChecked(LC_FIRE_ELEMENTAL) then
                    if cast.fireElemental() then return true end
                end
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying() or IsMounted()) then

            end -- End No Combat
        end -- End Action List - PreCombat
    -- Action List - AoE
        local function actionList_AoE()
    -- Stormkeeper
        -- stormkeeper
            if cast.stormkeeper() then return true end
    -- Ascendance
        -- ascendance
            if talent.ascendance and useAscendance and cast.ascendance() then return true end
    -- Liquid Magma Totem
        -- liquid_magma_totem
            if cast.liquidMagmaTotem() then return true end
    -- Flame Shock
        -- flame_shock,if=spell_targets.chain_lightning=3&maelstrom>=20,target_if=refreshable
            local targets = getEnemies(units.dyn40,10)
            if power >= 20 and #targets == 3 then
                for i = 1, #targets do
                    local thisUnit = targets[i]
                    if debuff.flameShock[thisUnit].refresh and cast.flameShock(thisUnit) then return true end
                end
            end
    -- Earthquake
        -- earthquake
            if power >= 50 and cast.earthquake() then return true end
    -- Lava Burst
        -- lava_burst,if=buff.lava_surge.up&spell_targets.chain_lightning=3
            if buff.lavaSurge.exists then
                if cast.lavaBurst() then return true end
            end
    -- Lava Beam
        -- lava_beam
            if buff.ascendance.exists then
                if cast.lavaBeam() then return true end
            end
    -- Chain Lightning
        -- chain_lightning,target_if=debuff.lightning_rod.down
            for i = 1, #targets do
                local thisUnit = targets[i]
                if not debuff.lightningRod[thisUnit].exists and cast.chainLightning(thisUnit) then return true end
            end
            for i = 1, #targets do
                local thisUnit = targets[i]
                if debuff.lightningRod[thisUnit].refresh and cast.chainLightning(thisUnit) then return true end
            end
        -- chain_lightning
            if cast.chainLightning() then return true end
        -- lava_burst,moving=1
    -- Flame Shock
        -- flame_shock,moving=1,target_if=refreshable
            if isMoving("player") then
                for i = 1, #targets do
                    local thisUnit = targets[i]
                    if debuff.flameShock[thisUnit].refresh and cast.flameShock(thisUnit) then return true end
                end
            end
        end -- End Action List - AoE
    -- Action List - Single Target
        local function actionList_Single()
    -- Ascendance
        -- ascendance,if=dot.flame_shock.remains>buff.ascendance.duration&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&!buff.stormkeeper.up
            if talent.ascendance 
                and useAscendance
                and debuff.flameShock[units.dyn40].remain > 16
                and (combatTime >= 60 or hasBloodLust())
                and cd.lavaBurst > 0
                and not buff.stormkeeper.exists
            then
                if cast.ascendance() then return end
            end
    -- Flame Shock
        -- flame_shock,if=!ticking
        -- flame_shock,if=maelstrom>=20&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<=duration
            if not debuff.flameShock[units.dyn40].exists 
                or (talent.ascendance and useAscendance and power >= 20 and debuff.flameShock[units.dyn40].remain <= 16 and cd.ascendance + 16 <= debuff.flameShock[units.dyn40].duration)
            then
                if cast.flameShock() then return end
            end
    -- Earthquake
        -- earthquake,if=buff.echoes_of_the_great_sundering.up
            if (hasEquiped(137074) and buff.echoesOfTheGreatSundering.exists) 
                or (#getEnemies(units.dyn40,10) == 2 and (hasBloodLust() or buff.elementalMastery.exist))
            then
                if cast.earthquake() then return end
            end
    -- Earth Shock
        -- earth_shock,if=maelstrom>=92
            if power >= 92 then
                if cast.earthShock() then return end
            end
    -- Icefury
        -- icefury,if=raid_event.movement.in<5
    -- Lava Burst
        -- lava_burst,if=dot.flame_shock.remains>cast_time&(cooldown_react|buff.ascendance.up)
            if debuff.flameShock[units.dyn40].remain > getCastTime(spell.lavaBurst) and (cd.lavaBurst == 0 or buff.ascendance.exists) then
                if cast.lavaBurst() then return end
            end
    -- Elemental Blast
        -- elemental_blast
            if talent.elementalBlast and cast.elementalBlast() then return end
    -- Flame Shock
        -- flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
            if power >= 20 and buff.elementalFocus.exists then
                local targets = getEnemies(units.dyn40,10)
                for i = 1, #targets do
                    local thisUnit = targets[i]
                    if debuff.flameShock[thisUnit].refresh and cast.flameShock(thisUnit) then return end
                end
            end
    -- Frost Shock
        -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&((maelstrom>=20&raid_event.movement.in>buff.icefury.remains)|buff.icefury.remains<(1.5*spell_haste*buff.icefury.stack))
        -- frost_shock,moving=1,if=buff.icefury.up
            if talent.icefury
                and buff.icefury.exist
                and ((power >= 20 or buff.icefury.remain < (1.5 * (UnitSpellHaste("player")/100) * buff.icefury.stack))
                    or isMoving("player"))
            then
                if cast.frostShock() then return end
            end
    -- Earth Shock
        -- earth_shock,if=maelstrom>=86
            if power >= 86 then
                if cast.earthShock() then return end
            end
    -- Icefury
        -- icefury,if=maelstrom<=70&raid_event.movement.in>30&((talent.ascendance.enabled&cooldown.ascendance.remains>buff.icefury.duration)|!talent.ascendance.enabled)
            if talent.icefury and power <= 70 and ((talent.ascendance and cd.ascendance > 15) or not talent.ascendance or not useAscendance) then
                if cast.icefury() then return end
            end
    -- Liquid Magma Totem
        -- liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
            if talent.liquidMagmaTotem and #getEnemies(units.dyn40,10) == 2 then
                if cast.liquidMagmaTotem() then return end
            end
    -- Stormkeeper
        -- stormkeeper,if=(talent.ascendance.enabled&cooldown.ascendance.remains>10)|!talent.ascendance.enabled
            if talent.ascendance and cd.ascendance > 10 or not talent.ascendance or not useAscendance then
                if cast.stormkeeper() then return end
            end
    -- Totem Mastery
        -- totem_mastery,if=buff.resonance_totem.remains<10|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15)
            if totemRemain < 10 or (talent.ascendance and useAscendance and totemRemain < (16 + cd.ascendance) and cd.ascendance < 15) then
                if cast.totemMastery() then return end
            end
    -- Lava Beam
        -- lava_beam,if=active_enemies>1&spell_targets.lava_beam>1
            if talent.ascendance and buff.ascendance.exist and #getEnemies(units.dyn40,10) == 2 then
                if cast.lavaBeam() then return end
            end
    -- Lightning Bolt
        -- lightning_bolt,if=buff.power_of_the_maelstrom.up,target_if=debuff.lightning_rod.down
        -- lightning_bolt,if=buff.power_of_the_maelstrom.up
            if artifact.powerOfTheMaelstrom and buff.powerOfTheMaelstrom.exist then
                local targets = getEnemies(units.dyn40,10)
                for i = 1, #targets do
                    local thisUnit = targets[i]
                    if not debuff.lightningRod[thisUnit].exist and cast.lightningBolt(thisUnit) then return end
                end
                for i = 1, #targets do
                    local thisUnit = targets[i]
                    if debuff.lightningRod[thisUnit].refresh and cast.lightningBolt(thisUnit) then return end
                end
                if cast.lightningBolt() then return end
            end
    -- Chain Lightning
        -- chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1,target_if=debuff.lightning_rod.down
        -- chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
            local targets = getEnemies(units.dyn40,10)
            if #targets == 2 then
                for i = 1, #targets do
                    local thisUnit = targets[i]
                    if not debuff.lightningRod[thisUnit].exist and cast.chainLightning(thisUnit) then return end
                end
                for i = 1, #targets do
                    local thisUnit = targets[i]
                    if debuff.lightningRod[thisUnit].refresh and cast.chainLightning(thisUnit) then return end
                end
                if cast.chainLightning() then return end
            end
    -- Lightning Bolt
        -- lightning_bolt,target_if=debuff.lightning_rod.down
        -- lightning_bolt
            for i = 1, #targets do
                local thisUnit = targets[i]
                if not debuff.lightningRod[thisUnit].exist and cast.lightningBolt(thisUnit) then return end
            end
            for i = 1, #targets do
                local thisUnit = targets[i]
                if debuff.lightningRod[thisUnit].refresh and cast.lightningBolt(thisUnit) then return end
            end
            if cast.lightningBolt() then return end
    -- Flame Shock
        -- flame_shock,moving=1,target_if=refreshable
            if isMoving("player") then
                for i = 1, #targets do
                    local thisUnit = targets[i]
                    if debuff.flameShock[thisUnit].refresh and cast.flameShock(thisUnit) then return true end
                end
            end
    -- Earth Shock
        -- earth_shock,moving=1
            if power >= 10 and isMoving("player") then
                if cast.earthShock() then return end
            end
        end -- End Action List - Single Target
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if pause() or mode.rotation==4 or IsMounted() then
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
            if inCombat and isValidUnit(units.dyn40) and getDistance(units.dyn40) <= 40 then
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
                if activeEnemies() >= 3 then
                    if actionList_AoE() then return end
                else
                    if actionList_Single() then return end
                end
            end --End In Combat
        end --End Rotation Logic
    --end -- End Timer
end -- End runRotation
local id = 262
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})