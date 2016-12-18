local rotationName = "Ellis"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.howlingBlast },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.frostscythe },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.frostStrike },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.talent.icyTalons}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.empowerRuneWeapon },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.empowerRuneWeapon },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.empowerRuneWeapon }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.iceboundFortitude },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.iceboundFortitude }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.mindFreeze },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.mindFreeze }
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
        section = br.ui:createSection(br.ui.window.profile, LC_GENERAL)
        -- Auto Target
            br.ui:createCheckbox(section, LC_AUTO_TARGET, LC_AUTO_TARGET_DESCRIPTION)
        -- Auto Facing
            br.ui:createCheckbox(section, LC_AUTO_FACING, LC_AUTO_FACING_DESCRIPTION)
        -- Pillar of Frost
            br.ui:createCheckbox(section, LC_PILLAR_OF_FROST, LC_PILLAR_OF_FROST_DESCRIPTION)
        -- Chains of Ice
            br.ui:createCheckbox(section, LC_CHAINS_OF_ICE, LC_CHAINS_OF_ICE_DESCRIPTION)
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
        -- Arcane Torrent
            if br.player.race == "BloodElf" then
                br.ui:createCheckbox(section, LC_ARCANE_TORRENT,LC_ARCANE_TORRENT_DESCRIPTION)
            end
        -- Blood Fury
            if br.player.race == "Orc" then
                br.ui:createCheckbox(section, LC_BLOOD_FURY,LC_BLOOD_FURY_DESCRIPTION)
            end
        -- Berserking
            if br.player.race == "Troll" then
                br.ui:createCheckbox(section, LC_BERSERKING,LC_BERSERKING_DESCRIPTION)
            end
        -- Obliteration
                br.ui:createCheckbox(section, LC_OBLITERATION,LC_OBLITERATION_DESCRIPTION)
        -- Horn of Winter
                br.ui:createCheckbox(section, LC_HORN_OF_WINTER,LC_HORN_OF_WINTER_DESCRIPTION)
        -- Empower Rune Weapon / Hungering Rune Weapon
                br.ui:createCheckbox(section, LC_RUNE_WEAPON,LC_RUNE_WEAPON_DESCRIPTION)
        -- Breath of Sindragosa
                br.ui:createCheckbox(section,LC_BREATH_OF_SINDRAGOSA,LC_BREATH_OF_SINDRAGOSA_DESCRIPTION)
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_DEFENSIVE)
        -- Dark Succor
            br.ui:createSpinner(section, LC_DARK_SUCCOR,  85,  10,  100,  5,  LC_DARK_SUCCOR_DESCRIPTION)
        -- Death Strike
            br.ui:createSpinner(section, LC_DEATH_STRIKE,  50, 10,  100,  5,  LC_DEATH_STRIKE_DESCRIPTION)
        -- Icebound Fortitude
            br.ui:createSpinner(section, LC_ICEBOUND_FORTITUDE,  40,  10,  100,  5,  LC_ICEBOUND_FORTITUDE_DESCRIPTION)
        -- Blinding Sleet
            br.ui:createSpinner(section, LC_BLINDING_SLEET_HP,  60,  10,  100,  5,  LC_BLINDING_SLEET_HP_DESCRIPTION)
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
        -- Mind Freeze
            br.ui:createCheckbox(section, LC_MIND_FREEZE, LC_MIND_FREEZE_DESCRIPTION)
        -- Blinding Sleet
            br.ui:createCheckbox(section, LC_BLINDING_SLEET,  LC_BLINDING_SLEET_DESCRIPTION)
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
    --if br.timer:useTimer("debugFrost", 0.1) then
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
        local autoFacing                                    = isChecked(LC_AUTO_FACING)
        local autoTarget                                    = isChecked(LC_AUTO_TARGET)
        local buff                                          = br.player.buff
        local canFlask                                      = canUse(br.player.flask.wod.agilityBig)
        local cast                                          = br.player.cast
        local cd                                            = br.player.cd
        local combatTime                                    = getCombatTime()
        local debuff                                        = br.player.debuff
        local enemies                                       = br.player.enemies
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.agilityBig)
        local forceAOE                                      = br.player.mode.rotation == 2
        local forceSingle                                   = br.player.mode.rotation == 3
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastTarget                                    = lastSpellTarget
        local maxRunes                                      = br.player.runes
        local mode                                          = br.player.mode
        local php                                           = br.player.health
        local power, powerDeficit                           = br.player.power, br.player.powerDeficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local race                                          = br.player.race
        local racial                                        = br.player.getRacial()
        local runes                                         = 0
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local ttd                                           = getTTD
        local ttm                                           = br.player.timeToMax
        local units                                         = br.player.units
        for i=1,maxRunes do
            if select(3,GetRuneCooldown(i)) then
                runes = runes + 1
            end
        end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Auto Target
        local function actionList_AutoTarget()
            if not inCombat then return end
            if autoTarget == false then return end
            if isValidUnit("target") then return end
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
    -- Action List - Extras
        function actionList_Extras()
            if inCombat 
                and isMoving("target") 
                and not getFacing("target","player") 
                and getDistance("target") > 8 
                and getDistance("target") < 30
                and isValidUnit("target") 
                and isChecked(LC_CHAINS_OF_ICE)
            then
                if cast.chainsOfIce("target") then return true end
            end
        end -- End Action List - Extras
    -- Action List - Defensive
        function actionList_Defensive()
            if buff.darkSuccor.exists and isChecked(LC_DARK_SUCCOR) and php < getOptionValue(LC_DARK_SUCCOR) then
                if cast.deathStrike() then return true end
            end
            if isChecked(LC_DEATH_STRIKE) and php < getOptionValue(LC_DEATH_STRIKE) then
                if cast.deathStrike() then return true end
            end
            if isChecked(LC_ICEBOUND_FORTITUDE) and php < getOptionValue(LC_ICEBOUND_FORTITUDE) then
                if cast.iceboundFortitude() then return true end
            end
            if talent.blindingSleet 
                and inCombat 
                and isChecked(LC_BLINDING_SLEET_HP) 
                and php < getOptionValue(LC_BLINDING_SLEET_HP) 
                and #getFacingUnits("player",enemies.yards12,60) > 1 
            then
                if cast.blindingSleet() then return true end
            end
        end -- End Action List - Defensive
    -- Action List - Interrupts
        function actionList_Interrupts()
            if useInterrupts() and br.timer:useTimer("Interrupts",0.5) then
                for i=1, #enemies.yards15 do
                    thisUnit = enemies.yards15[i]
                    if canInterrupt(thisUnit,getOptionValue(LC_INTERRUPTS_AT)) then
                    -- Mind Freeze
                        if isChecked(LC_MIND_FREEZE) then
                            if cast.mindFreeze(thisUnit) then return true end
                        end
                    -- War Stomp
                        if isChecked(LC_WAR_STOMP) 
                            and getDistance(thisUnit) < 8 
                            and race == "Tauren" 
                            and not isBoss() 
                            and getSpellCD(racial)==0 
                            and not isMoving("player") then
                            if castSpell("player",racial,false,false,false) then return true end
                        end
                    -- Blinding Sleet
                        if talent.blindingSleet 
                            and isChecked(LC_BLINDING_SLEET) 
                            and getFacing("player",thisUnit,60) 
                            and getDistance(thisUnit) < 12 
                        then
                            if cast.blindingSleet(thisUnit) then return true end
                        end
                    end
                end
            end
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        function actionList_Cooldowns()
            if useCDs() then
        -- Arcane Torrent
            -- arcane_torrent,if=runic_power.deficit>20
                if race == "BloodElf" and isChecked(LC_ARCANE_TORRENT) and getSpellCD(racial)==0 and powerDeficit > 20 then
                    if castSpell("player",racial,false,false,false) then return true end
                end
        -- Blood Fury
            -- blood_fury,if=!talent.breath_of_sindragosa.enabled|dot.breath_of_sindragosa.ticking
                if race == "Orc" and isChecked(LC_BLOOD_FURY) and getSpellCD(racial)==0 and (not talent.breathOfSindragosa or buff.breathOfSindragosa.exists) then
                    if castSpell("player",racial,false,false,false) then return true end
                end
        -- Berserking
            -- berserking,if=buff.pillar_of_frost.up
                if race == "Troll" and isChecked(LC_BERSERKING) and getSpellCD(racial)==0 and buff.pillarOfFrost.exists then
                    if castSpell("player",racial,false,false,false) then return true end
                end
        -- Obliteration
            -- Obliteration
                if isChecked(LC_OBLITERATION) and cast.obliteration() then return true end
        -- Breath of Sindragosa
            -- Breath of Sindragosa,if=runic_power>=50
                if isChecked(LC_BREATH_OF_SINDRAGOSA) and power >= 50 then
                    if cast.breathOfSindragosa() then return true end
                end
            end
        end -- End Action List - Cooldowns
    -- Action List - Pre-Combat
        function actionList_PreCombat()
       
        end -- End Action List - PreCombat
    -- Action List - Core rotation
        function actionList_Core()
        -- Frost Strike
            -- Frost Strike,if=buff.obliteration.up&!buff.killing_machine.react
            if buff.obliteration.exists and not buff.killingMachine.exists then
                if cast.frostStrike() then return true end
            end
        -- Remorseless Winter
            -- Remorseless Winter,if=(spell_targets.remorseless_winter>=2|talent.gathering_storm.enabled)&!(talent.frostscythe.enabled&buff.killing_machine.react&spell_targets.frostscythe>=2)
            if (#enemies.yards8 >=2 or talent.gatheringStorm or forceAOE) and 
                not (talent.frostscythe and buff.killingMachine.exists and #getFacingUnits("player",enemies.yards8,120) >= 2) and
                not forceSingle
            then
                if cast.remorselessWinter() then return true end
            end
        -- Frostscythe
            -- Frostscythe,if=(buff.killing_machine.react&spell_targets.frostscythe>=2)
            if talent.frostscythe and buff.killingMachine.exists and (#getFacingUnits("player",enemies.yards8,120) >= 2 or forceAOE) and not forceSingle then
                if cast.frostscythe() then return true end
            end
        -- Glacial Advance
            -- Glacial Advance,if=spell_targets.glacial_advance>=2
            if (#getFacingUnits("player",enemies.yards20,25) >= 2 or forceAOE) and not forceSingle then
                if cast.glacialAdvance() then return true end
            end
        -- Frostscythe
            -- Frostscythe,if=spell_targets.frostscythe>=3
            if talent.frostscythe and (#getFacingUnits("player",enemies.yards8,120) >= 3 or forceAOE) and not forceSingle then
                if cast.frostscythe() then return true end
            end
        -- Obliterate
            -- Obliterate,if=buff.killing_machine.react
            if buff.killingMachine.exists then
                if cast.obliterate() then return true end
            end
        -- Obliterate
            -- Obliterate
            if cast.obliterate() then return true end
        -- Glacial Advance
            -- Glacial Advance
            if not forceSingle then
                if cast.glacialAdvance() then return true end
            end
        -- Remorseless Winter
            -- Remorseless Winter,if=talent.frozen_pulse.enabled
            if talent.frozenPulse and not forceSingle then
                if cast.remorselessWinter() then return true end
            end
        end -- End Action List - Core rotation
    -- Action List - Generic single target rotation
        function actionList_Generic()
        -- Refresh Icy talons if it's about to expire
        -- Frost Strike
            -- Frost Strike,if=buff.icy_talons.remains<1.5&talent.icy_talons.enabled
            if buff.icyTalons.remain < 1.5 and talent.icyTalons then
                if cast.frostStrike() then return end
            end
        -- Howling blast disease upkeep and rimeing
        -- Howling Blast
            -- Howling Blast,target_if=!dot.frost_fever.ticking
            if not debuff.frostFever["target"].exists then
                if cast.howlingBlast() then return end
            end
            -- Howling Blast,if=buff.rime.react
            if buff.rime.exists then
                if cast.howlingBlast() then return end
            end
        -- Prevent RP waste
        -- Frost Strike
            -- Frost Strike,if=runic_power>=80
            if power >= 80 then
                if cast.frostStrike() then return end
            end
        -- Do core rotation
            if actionList_Core() then return end
        -- Horn of Winter
            -- Horn of Winter,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
            if useCDs() and isChecked(LC_HORN_OF_WINTER) and talent.hornOfWinter and talent.breathOfSindragosa and cd.breathOfSindragosa > 15 then
                if cast.hornOfWinter() then return end
            end
            -- Horn of Winter,if=!talent.breath_of_sindragosa.enabled
            if useCDs() and isChecked(LC_HORN_OF_WINTER) and talent.hornOfWinter and not talent.breathOfSindragosa then
                if cast.hornOfWinter() then return end
            end
        -- Frost Strike
            -- Frost Strike,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
            if talent.breathOfSindragosa and cd.breathOfSindragosa > 15 then
                if cast.frostStrike() then return end
            end
            -- Frost Strike,if=!talent.breath_of_sindragosa.enabled
            if not talent.breathOfSindragosa then
                if cast.frostStrike() then return end
            end
        -- Empower Rune Weapon / Hungering Rune Weapon
            -- if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
            if isChecked(LC_RUNE_WEAPON) and runes == 0 and useCDs() and talent.breathOfSindragosa and cd.breathOfSindragosa > 15 then
                if talent.hungeringRuneWeapon then
                    if cast.hungeringRuneWeapon() then return end
                else
                    if cast.empowerRuneWeapon() then return end
                end
            end
            -- if=!talent.breath_of_sindragosa.enabled
            if isChecked(LC_RUNE_WEAPON) and runes == 0 and useCDs() and not talent.breathOfSindragosa then
                if talent.hungeringRuneWeapon then
                    if cast.hungeringRuneWeapon() then return end
                else
                    if cast.empowerRuneWeapon() then return end
                end
            end
        end -- End Action List - Generic single target rotation
        
    -- Action List - Shattering Strikes single target rotation
        function actionList_Shattering()
        -- Frost Strike on 5 Razorice
        -- Frost Strike
            -- Frost Strike,if=debuff.razorice.stack=5
            if debuff.razorice["target"].stack == 5 then
                if cast.frostStrike() then return end
            end
        -- Howling blast disease upkeep and rimeing
        -- Howling Blast
            -- Howling Blast,target_if=!dot.frost_fever.ticking
            if not debuff.frostFever["target"].exists then
                if cast.howlingBlast() then return end
            end
            -- Howling Blast,if=buff.rime.react
            if buff.rime.exists then
                if cast.howlingBlast() then return end
            end
        -- Prevent RP waste
        -- Frost Strike
            -- Frost Strike,if=runic_power>=80
            if power >= 80 then
                if cast.frostStrike() then return end
            end
        -- Do core rotation
            if actionList_Core() then return end
        -- Horn of Winter
            -- Horn of Winter,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
            if useCDs() and isChecked(LC_HORN_OF_WINTER) and talent.breathOfSindragosa and cd.breathOfSindragosa > 15 then
                if cast.hornOfWinter() then return end
            end
            -- Horn of Winter,if=!talent.breath_of_sindragosa.enabled
            if useCDs() and isChecked(LC_HORN_OF_WINTER) and not talent.breathOfSindragosa then
                if cast.hornOfWinter() then return end
            end
        -- Frost Strike
            -- Frost Strike,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
            if talent.breathOfSindragosa and cd.breathOfSindragosa > 15 then
                if cast.frostStrike() then return end
            end
            -- Frost Strike,if=!talent.breath_of_sindragosa.enabled
            if not talent.breathOfSindragosa then
                if cast.frostStrike() then return end
            end
        -- Empower Rune Weapon / Hungering Rune Weapon
            -- if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
            if isChecked(LC_RUNE_WEAPON) and runes == 0 and useCDs() and talent.breathOfSindragosa and cd.breathOfSindragosa > 15 then
                if talent.hungeringRuneWeapon then
                    if cast.hungeringRuneWeapon() then return end
                else
                    if cast.empowerRuneWeapon() then return end
                end
            end
            -- if=!talent.breath_of_sindragosa.enabled
            if isChecked(LC_RUNE_WEAPON) and runes == 0 and useCDs() and not talent.breathOfSindragosa then
                if talent.hungeringRuneWeapon then
                    if cast.hungeringRuneWeapon() then return end
                else
                    if cast.empowerRuneWeapon() then return end
                end
            end
        end -- End Action List - Shattering Strikes single target rotation
    -- Action List - Breath of Sindragosa rotation
        function actionList_Bos()
        -- Howling Blast
            -- Howling Blast,target_if=!dot.frost_fever.ticking
            if not debuff.frostFever["target"].exists then
                if cast.howlingBlast() then return end
            end
        -- Do core rotation
            if actionList_Core() then return end
        -- Horn of Winter
            if useCDs() and isChecked(LC_HORN_OF_WINTER) and cast.hornOfWinter() then return end
        -- Empower Rune Weapon / Hungering Rune Weapon
            -- if=runic_power<=70
            if isChecked(LC_RUNE_WEAPON) and runes == 0 and power <= 70 then
                if talent.hungeringRuneWeapon then
                    if cast.hungeringRuneWeapon() then return end
                else
                    if cast.empowerRuneWeapon() then return end
                end
            end
        -- Howling Blast
            -- Howling Blast,if=buff.rime.react
            if buff.rime.exists then
                if cast.howlingBlast() then return end
            end
        end -- End Action List - Breath of Sindragosa rotation
---------------------
--- Out Of Combat ---
---------------------
        if pause() or mode.rotation == 4 then
            return true
        else
            if actionList_Extras() then return end
            if actionList_Defensive() then return end
            actionList_AutoTarget()
-----------------
--- In Combat ---
-----------------
            if not inCombat then
                if actionList_PreCombat() then return end
            end
            if inCombat and isValidUnit("target") then
                if actionList_Cooldowns() then return end
                if actionList_Interrupts() then return end
        -- Auto facing
                if autoFacing 
                    and not isMoving("player") 
                    and not getFacing("player","target",120)
                then
                    FaceDirection(GetAnglesBetweenObjects("player", "target"), true)
                end
        -- Start Attack
            -- auto_attack
                if getDistance("target") < 5 then
                    StartAttack()
                end
        -- Pillar of Frost
            -- Pillar of Frost
                if isChecked(LC_PILLAR_OF_FROST) and cast.pillarOfFrost() then return end
        -- Start Action List
                if buff.breathOfSindragosa.exists then
                    actionList_Bos()
                elseif talent.shatteringStrikes then
                    actionList_Shattering()
                else
                    actionList_Generic()
                end
            end -- End Combat Check
        end -- End Rotation Pause
    --end -- End Timer
end -- runRotation
local id = 251
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})-- End Class Select
