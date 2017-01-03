local rotationName = "Ellis"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.agony},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.corruption},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.drainLife},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.healthFunnel}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.summonDoomguard},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.summonDoomguard},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.summonDoomguard}
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.unendingResolve},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.unendingResolve}
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.fear},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.fear}
    };
    CreateButton("Interrupt",4,0)
-- Seed of Corruption
    SeedOfCorruptionModes = {
        [1] = { mode = "On", value = 1 , overlay = "SOC Enabled", tip = LC_SOC_MODE_ENABLE, highlight = 1, icon = br.player.spell.seedOfCorruption},
        [2] = { mode = "Off", value = 2 , overlay = "SOC Disabled", tip = LC_SOC_MODE_DISABLE, highlight = 0, icon = br.player.spell.seedOfCorruption}
    };
    CreateButton("SeedOfCorruption",5,0)
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
            br.ui:createCheckbox(section, LC_AUTO_TARGET, LC_AUTO_TARGET_DESCRIPTION)
        -- Auto Facing
            br.ui:createCheckbox(section, LC_AUTO_FACING, LC_AUTO_FACING_DESCRIPTION)
        -- Artifact
            br.ui:createDropdown(section, LC_ARTIFACT, {LC_ARTIFACT_EVERY_TIME,LC_ARTIFACT_CD}, 1)
        -- Summon Pet
            br.ui:createDropdownWithout(section, 
                                        LC_SUMMON_PET, 
                                        {
                                            LC_SUMMON_PET_AUTO,
                                            LC_SUMMON_PET_IMP,
                                            LC_SUMMON_PET_VOIDWALKER,
                                            LC_SUMMON_PET_FELHUNTER,
                                            LC_SUMMON_PET_SUCCUBUS
                                        }, 1, LC_SUMMON_PET_DESCRIPTION)
        -- Grimoire of Service
            br.ui:createDropdownWithout(section, LC_GRIMOIRE_OF_SERVICE,
                                        {
                                            LC_GRIMOIRE_OF_SERVICE_IMP,
                                            LC_GRIMOIRE_OF_SERVICE_FELHUNTER,
                                            LC_GRIMOIRE_OF_SERVICE_VOIDWALKER,
                                            LC_GRIMOIRE_OF_SERVICE_SUCCUBUS,
                                        }, 2, LC_GRIMOIRE_OF_SERVICE_DESCRIPTION)
        -- Grimoire of Supremacy
            br.ui:createDropdownWithout(section, LC_GRIMOIRE_OF_SUPREMACY, {LC_GRIMOIRE_OF_SUPREMACY_DOOMGUARD,LC_GRIMOIRE_OF_SUPREMACY_INFERNAL}, 1, LC_GRIMOIRE_OF_SUPREMACY_DESCRIPTION)
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, LC_COOLDOWNS)
        -- Racial
            br.ui:createCheckbox(section,LC_RACIAL,LC_RACIAL_DESCRIPTION)
        -- Trinkets
            br.ui:createCheckbox(section,LC_TRINKETS,LC_TRINKETS_DESCRIPTION)
        -- Soul Harvest
            br.ui:createCheckbox(section,LC_SOUL_HARVEST,LC_SOUL_HARVEST_DESCRIPTION)
        -- Doomguard
            br.ui:createCheckbox(section,LC_COOLDOWN_DOOMGUARD)
        -- Infernal
            br.ui:createCheckbox(section,LC_COOLDOWN_INFERNAL)
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, LC_DEFENSIVE)
        -- Healthstone
            br.ui:createSpinner(section, LC_POT_STONED,  60,  0,  100,  5,  LC_POT_STONED_DESCRIPTION)
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, LC_GIFT_OF_THE_NAARU,  50,  0,  100,  5,  LC_GIFT_OF_THE_NAARU_DESCRIPTION)
            end
        -- Dark Pact
            br.ui:createSpinner(section, LC_DARK_PACT, 50, 0, 100, 5, LC_DARK_PACT_DESCRIPTION)
        -- Health Funnel
            br.ui:createSpinner(section, LC_HEALTH_FUNNEL, 30, 0, 100, 5, LC_HEALTH_FUNNEL_DESCRIPTION)
        -- Unending Resolve
            br.ui:createSpinner(section, LC_UNENDING_RESOLVE, 40, 0, 100, 5, LC_UNENDING_RESOLVE_DESCRIPTION)
        -- Soulstone
            br.ui:createCheckbox(section, LC_SOULSTONE)
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
        -- Shadow Lock
            br.ui:createCheckbox(section,LC_SHADOW_LOCK)
        -- Spell Lock
            br.ui:createCheckbox(section,LC_SPELL_LOCK)
        -- Arcane Torrent
            if br.player.race == "BloodElf" then
                br.ui:createCheckbox(section,LC_ARCANE_TORRENT)
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
    --if br.timer:useTimer("debugDemonology", math.random(0.15,0.3)) then
        --print("Running: "..rotationName)
---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        UpdateToggle("SeedOfCorruption",0.25)
--------------
--- Locals ---
--------------
        local activePet                                     = br.player.pet
        local activePetId                                   = br.player.petId
        local artifact                                      = br.player.artifact
        local autoFacing                                    = isChecked(LC_AUTO_FACING)
        local autoTarget                                    = isChecked(LC_AUTO_TARGET)
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local castable                                      = br.player.cast.debug
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local combatTime                                    = getCombatTime()
        local debuff                                        = br.player.debuff
        local enemies                                       = br.player.enemies
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.agilityBig)
        local forceAOE                                      = br.player.mode.rotation == 2
        local forceSingle                                   = br.player.mode.rotation == 3
        local friendly                                      = friendly or UnitIsFriend("target", "player")
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
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen, br.player.power.mana.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local resable                                       = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
        local shards                                        = br.player.power.amount.soulShards
        local solo                                          = GetNumGroupMembers() == 0
        local spell                                         = br.player.spell
        local summonPet                                     = getOptionValue(LC_SUMMON_PET)
        local talent                                        = br.player.talent
        local travelTime                                    = getDistance("target")/16
        local ttd                                           = getTTD
        local units                                         = br.player.units
        local useArtifact                                   = false

		mode.soc = br.data.settings[br.selectedSpec].toggles["SeedOfCorruption"]

        local socMode = mode.soc == 1

        if myTarget == nil then myTarget = "" end
        if delayHack == nil then delayHack = 0 end
        if effigyGUID == nil then effigyGUID = "" end
        if lastCasteffigyTime == nil then lastCasteffigyTime = 0 end

        local sucess,effigyUint = pcall(GetObjectWithGUID,effigyGUID)
        local hasEffigy = sucess and getDistance(effigyUint) <= 40
        if hasEffigy then
            insertUnitIntoEnemiesTable(effigyUint,effigyGUID)
            if UnitIsUnit(effigyUint,"target") then
                local sucess,thisUnit = pcall(GetObjectWithGUID,myTarget)
                if sucess then
                    TargetUnit(thisUnit)
                end
            end
        end

        if not br.player.eventRegisted then
            br.player.roaringBlazeUnits = {}
            AddEventCallback("COMBAT_LOG_EVENT_UNFILTERED",function(...)
                local _, combatEvent, _, sourceGUID, _, _, _, destGUID, destName, _, _, spellId, _, _ = ...
                if sourceGUID == UnitGUID("player") and combatEvent == "SPELL_SUMMON" then
                    local _, _, _, _, _, _, _, unitID, _ = destGUID:find('(%S+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)-(%S+)')
                    if unitID == "103679" then
                        effigyGUID = destGUID
                    end
                end
            end,"Affliction")

            AddEventCallback("PLAYER_SPECIALIZATION_CHANGED",function(source)
                if source ~= "player" then
                    return
                end
                RemoveEventCallback("COMBAT_LOG_EVENT_UNFILTERED","Affliction")
                RemoveEventCallback("PLAYER_SPECIALIZATION_CHANGED","Affliction")
            end,"Affliction")

            br.player.eventRegisted = true
        end
-----------------------
--- Custom Function ---
-----------------------
    -- Build Spell
        local function buildSpells()
            local self = br.player
            -- summonDarkglare
            self.cast.summonDarkglare = function(thisUnit,debug)
                local spellCast = self.spell.summonDarkglare
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonDarkglare == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,false,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,false)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonDoomguard
            self.cast.summonDoomguard = function(thisUnit,debug)
                local spellCast = self.spell.summonDoomguard
                local thisUnit = thisUnit
                local moveCheck = true
                if thisUnit == nil then
                    if self.talent.grimoireOfSupremacy then
                        thisUnit = "player"
                        moveCheck = true
                    else
                        thisUnit = "target"
                        moveCheck = false
                    end
                end
                if debug == nil then debug = false end

                if self.cd.summonDoomguard == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,moveCheck,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,moveCheck)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonFelguard
            self.cast.summonFelguard = function(thisUnit,debug)
                local spellCast = self.spell.summonFelguard
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonFelguard == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonFelhunter
            self.cast.summonFelhunter = function(thisUnit,debug)
                local spellCast = self.spell.summonFelhunter
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonFelhunter == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonFelImp
            self.cast.summonFelImp = function(thisUnit,debug)
                local spellCast = self.spell.summonFelImp
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonFelImp == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonImp
            self.cast.summonImp = function(thisUnit,debug)
                local spellCast = self.spell.summonImp
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonImp == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonInfernal
            self.cast.summonInfernal = function(thisUnit,debug)
                local spellCast = self.spell.summonInfernal
                local thisUnit = thisUnit
                local moveCheck = true
                if thisUnit == nil then
                    if self.talent.grimoireOfSupremacy then
                        thisUnit = "player"
                        moveCheck = true
                    else
                        thisUnit = "target"
                        moveCheck = false
                    end
                end
                if debug == nil then debug = false end

                if self.cd.summonInfernal == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,moveCheck,false,false,false,false,false,true)
                    elseif self.talent.grimoireOfSupremacy then
                        return castSpell(thisUnit,spellCast,false,moveCheck)
                    else
                        return castSpell(thisUnit,spellCast,true,moveCheck)
                        --return castGroundAtBestLocation(spellCast,10,1,30)
                    end 
                elseif debug then
                    return false
                end
            end

            -- summonSuccubus
            self.cast.summonSuccubus = function(thisUnit,debug)
                local spellCast = self.spell.summonSuccubus
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonSuccubus == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonVoidwalker
            self.cast.summonVoidwalker = function(thisUnit,debug)
                local spellCast = self.spell.summonVoidwalker
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonVoidwalker == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end
        end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
        end -- End Action List - Extras
    -- Action List - Defensive
        local function actionList_Defensive()
            if useDefensive() then
        -- Pot/Stoned
                if inCombat and isChecked(LC_POT_STONED) and php <= getOptionValue(LC_POT_STONED) 
                    and (hasHealthPot() or hasItem(5512)) 
                then
                    if canUse(5512) and useItem(5512) then return true end
                    if canUse(healPot) and useItem(healPot) then return true end
                end
        -- Gift of the Naaru
                if isChecked(LC_GIFT_OF_THE_NAARU) and getSpellCD(racial)==0 and php <= getOptionValue(LC_GIFT_OF_THE_NAARU) and php > 0 and race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return true end
                end
        -- Dark Pact
                if talent.darkPact and isChecked(LC_DARK_PACT) and php <= getOptionValue(LC_DARK_PACT) and getHP("pet") * 0.8 > getOptionValue(LC_HEALTH_FUNNEL) then
                    if cast.darkPact() then return true end
                end
        -- Unending Resolve
                if isChecked(LC_UNENDING_RESOLVE) and php <= getOptionValue(LC_UNENDING_RESOLVE) then
                    if cast.unendingResolve() then return true end
                end
        -- Health Funnel
                if not inRaid and isChecked(LC_HEALTH_FUNNEL) and activePet ~= "None" and getHP("pet") <= getOptionValue(LC_HEALTH_FUNNEL) and php >= 30 then
                    if cast.healthFunnel() then return true end
                end
        -- Soulstone
                if inCombat and isChecked(LC_SOULSTONE) and resable then
                    if cast.soulstone("target") then return true end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() and br.timer:useTimer("Interrupts",1.5) then
                local dist = 8
                local source = "player"
                if petId == 78158 or petId == 417 then
                    dist = 40
                    source = "pet"
                end
                local theEnemies = getEnemies(source,dist)
                for i=1, #theEnemies do
                    thisUnit = theEnemies[i]
                    if canInterrupt(thisUnit,getOptionValue(LC_INTERRUPTS_AT)) then
                        if petId == 78158 and isChecked(LC_SHADOW_LOCK) then
                    -- Shadow Lock
                            if cast.shadowLock(thisUnit) then return true end
                        elseif petId == 417 and isChecked(LC_SPELL_LOCK) then
                    -- Spell Lock
                            if cast.spellLock(thisUnit) then return true end
                        end
                    -- Arcane Torrent
                        if isChecked(LC_ARCANE_TORRENT) and getSpellCD(racial) == 0 and getDistance(thisUnit) <=8 then
                            if castSpell("player",racial,false,false,false) then return true end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance(units.dyn40) < 40 then
        -- Trinkets
                if isChecked(LC_TRINKETS) then
                    if canUse(13) and useItem(13) then return true end
                    if canUse(14) and useItem(14) then return true end
                end
        -- Service Pet
                -- service_pet,if=dot.corruption.remains&dot.agony.remains
                if talent.grimoireOfService and useCDs() and br.timer:useTimer("castGrim", gcd) and debuff.agony["target"].exists and debuff.corruption["target"].exists then
                    local grimoirePet = getOptionValue(LC_GRIMOIRE_OF_SERVICE)
                    if grimoirePet == 1 then
                        if cast.grimoireImp() then return end
                    end
                    if grimoirePet == 2 then
                        if cast.grimoireFelhunter() then return end
                    end
                    if grimoirePet == 3 then
                        if cast.grimoireVoidwalker() then return end
                    end
                    if grimoirePet == 4 then
                        if cast.grimoireSuccubus() then return end
                    end
                end
        -- Summon Doomguard
            --summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<3&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
                if isChecked(LC_COOLDOWN_DOOMGUARD) and not talent.grimoireOfSupremacy and (ttd("target") > 180 or getHP("target") <=20 or ttd("target") < 30) and #enemies.yards10t < 3 then
                    if cast.summonDoomguard() then return end
                end
        -- Summon Infernal
                --summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>=3
                if isChecked(LC_COOLDOWN_INFERNAL) and not talent.grimoireOfSupremacy and #enemies.yards10t >= 3 then
                    if cast.summonInfernal() then return end
                end
        -- Summon Doomguard
                -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<3&equipped.132379&!cooldown.sindorei_spite_icd.remains
        -- Summon Infernal
                -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>=3&equipped.132379&!cooldown.sindorei_spite_icd.remains
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- blood_fury | berserking | arcane_torrent
                if isChecked(LC_RACIAL) 
                    and (br.player.race == "Orc" or br.player.race == "Troll")
                    and getSpellCD(racial) == 0
                then
                    if castSpell("player",racial,false,false,false) then return true end
                end
        -- Soul Harvest
                if talent.soulHarvest and isChecked(LC_SOUL_HARVEST) then
                    if cast.soulHarvest() then return end
                end
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
           
        end -- End Action List - PreCombat
        local function actionList_Opener()
          
        end
    -- Action List - Summon Pet
        local function actionList_SummonPet()
            if not IsMounted() and talent.grimoireOfSacrifice and not buff.demonicPower.exists and activePet ~= "None" then
                if cast.grimoireOfSacrifice() then return end
            end

            --print(activePet)
            if not IsMounted() and activePet == "None" and (not talent.grimoireOfSacrifice or (talent.grimoireOfSacrifice and not buff.demonicPower.exists)) and br.timer:useTimer("Summon Pet",1) then
                if summonPetDelay == nil then summonPetDelay = 0 end
                if summonPetDelay == 0 then summonPetDelay = 1 return end
                summonPetDelay = 0
                
                if summonPet == 1 then
                    if talent.grimoireOfSupremacy then
                        if solo then
                            if cast.summonInfernal() then return true end
                        elseif getOptionValue(LC_GRIMOIRE_OF_SUPREMACY) == 1 then
                            if cast.summonDoomguard() then return true end
                        elseif getOptionValue(LC_GRIMOIRE_OF_SUPREMACY) == 2 then
                            if cast.summonInfernal() then return true end
                        end
                    elseif solo then
                        if cast.summonVoidwalker() then return true end
                    else
                        if cast.summonFelhunter() then return true end
                    end
                elseif summonPet == 2 then
                    if isKnown(spell.summonFelImp) then
                        if cast.summonFelImp() then return true end
                    else  
                        if cast.summonImp() then return true end
                    end
                elseif summonPet == 3 then
                    if cast.summonVoidwalker() then return true end
                elseif summonPet == 4 then
                    if cast.summonFelhunter() then return true end
                elseif summonPet == 5 then
                    if cast.summonSuccubus() then return true end
                end
            end
        end 
    -- Action List - Auto Target
        local function actionList_AutoTarget()
            if autoTarget == false then return end
            if friendly or isValidUnit("target") then return end
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
    -- Action List - Default
        local function actionList_Default()
    -- Pet Attack
            if activePet ~= "None" and not UnitIsUnit("pettarget","target") then
                PetAttack()
            end
    -- Soul Effigy
            -- soul_effigy,if=!pet.soul_effigy.active
            if talent.soulEffigy and not hasEffigy and lastSpell ~= spell.soulEffigy and lastCasteffigyTime + 5 < GetTime() then
                if cast.soulEffigy() then lastCasteffigyTime = GetTime() myTarget = UnitGUID("target") delayHack = 2 return end
            end
    -- Mana Tap
            -- mana_tap,if=buff.mana_tap.remains<=buff.mana_tap.duration*0.3&(mana.pct<20|buff.mana_tap.remains<=gcd)&target.time_to_die>buff.mana_tap.duration*0.3
            if talent.manaTap and buff.manaTap.refresh and (manaPercent < 20 or buff.manaTap.remain <= gcd) and ttd("target") > buff.manaTap.duration * 0.3 then
                if cast.manaTap() then return end
            end
    -- Reap Souls
            -- if not HasBuff(DeadwindHarvester) and AlternatePower >= 1
            -- Use Reap Souls as long as you have a Soul Shard to cast Unstable Affliction.
            if not buff.deadwindHarvester.exists 
                and (shards >= 3 and buff.tormentedSouls.stack >= 3
                    or buff.tormentedSouls.stack >= 8
                    or buff.soulHarvest.exists
                    or buff.compoundingHorror.stack == 5
                    or buff.compoundingHorror.stack == 4 and buff.compoundingHorror.remain <= getCastTime(spell.unstableAffliction) + gcd
                    or talent.contagion)
                and buff.tormentedSouls.stack >= 1
            then
                if cast.reapSouls() then return end
            end
    -- Agony
            -- agony,cycle_targets=1,if=remains<=tick_time+gcd
            for i = 1, #enemies.yards40 do
                local thisUnit = enemies.yards40[i]
                local agony = debuff.agony[thisUnit]
                if agony ~= nil then
                    if agony.refresh and (agony.exists or debuff.agony["target"].count < 3) then
                        if cast.agony(thisUnit,"face") then return end
                    end
                end
            end
    -- Unstable Affliction
            -- unstable_affliction,if=talent.contagion.enabled|(soul_shard>=4|trinket.proc.intellect.react|trinket.stacking_proc.mastery.react|trinket.proc.mastery.react|trinket.proc.crit.react|trinket.proc.versatility.react|buff.soul_harvest.remains|buff.deadwind_harvester.remains|buff.compounding_horror.react=5|target.time_to_die<=20)
            if shards >=4 
                or talent.contagion
                or buff.soulHarvest.exists
                or buff.compoundingHorror.stack == 5
                or buff.compoundingHorror.stack == 4 and buff.compoundingHorror.remain <= getCastTime(spell.unstableAffliction) + gcd
                or buff.deadwindHarvester.exists and buff.deadwindHarvester.remain > getCastTime(spell.unstableAffliction)
            then
                if cast.unstableAffliction() then delayHack = 2 return end
            end
    -- Haunt
            if talent.haunt and cast.haunt() then return end
    -- Seed of Corruption
            -- if not HasBuff(SeedOfCorruption) and CanRefreshDot(Corruption)
            -- Seed of Corruption is a better way to refresh Corruption right now - definitely a balancing issue. It does too much single target damage compared to Drain Life.
            if not debuff.seedOfCorruption["target"].exists 
                and ((not talent.absoluteCorruption and debuff.corruption["target"].refresh) or (talent.absoluteCorruption and not debuff.corruption["target"].exists))
                and (lastSpell ~= spell.seedOfCorruption or lastTarget ~= UnitGUID("target"))
            then
                if cast.seedOfCorruption() then return end
            end
    -- Corruption
            -- corruption,cycle_targets=1,if=remains<=tick_time+gcd
            if hasEffigy then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    local corruption = debuff.corruption[thisUnit]
                    if corruption ~= nil and UnitIsUnit(effigyUint,thisUnit) then
                        if (not talent.absoluteCorruption and corruption.refresh) or (talent.absoluteCorruption and not corruption.exists) then
                            if cast.corruption(thisUnit,"face") then return end
                        end
                    end
                end
            end
    -- Siphon Life
            -- siphon_life,cycle_targets=1,if=remains<=tick_time+gcd
            for i = 1, #enemies.yards40 do
                local thisUnit = enemies.yards40[i]
                local siphonLife = debuff.siphonLife[thisUnit]
                if siphonLife ~= nil then
                    if siphonLife.refresh and (siphonLife.exists or debuff.siphonLife["target"].count < 2) then
                        if cast.siphonLife(thisUnit,"face") then return end
                    end
                end
            end
    -- Phantom Singularity
            -- phantom_singularity
            if talent.phantomSingularity and cast.phantomSingularity() then return end
    -- Life Tap
            -- life_tap,if=mana.pct<=10
            if manaPercent <= 10 then
                if cast.lifeTap() then return end
            end
    -- Drain Soul / Drain Life
            -- drain_soul,chain=1,interrupt=1
            -- drain_life,chain=1,interrupt=1
            if talent.drainSoul and not isCastingSpell(spell.drainSoul) then
                if cast.drainSoul() then return end
            elseif not isCastingSpell(spell.drainLife) then
                if cast.drainLife() then return end
            end
    -- Life Tap
            if manaPercent < 70 then
                if cast.lifeTap() then return end
            end
        end
---------------------
--- Begin Profile ---
---------------------
    -- Stop Health Funnel
        if isCastingSpell(spell.healthFunnel) and getHP("pet") >= 98 then
            SpellStopCasting()
        end
    -- Profile Stop | Pause
        local isPause = pause(true)
        if isPause or mode.rotation==4 or IsMounted() or delayHack > 0 then
            if (mode.rotation==4 or IsMounted()) and activePet ~= "None" then
                PetFollow()
            end
            if not isPause and delayHack > 0 then
                delayHack = delayHack - 1
            end
            return true
        elseif isCastingSpell(spell.seedOfCorruption) or isCastingSpell(spell.unstableAffliction) then
            return true
        else
-------------------
--- Buid Spells ---
-------------------
            if buildSpells() then return end
-----------------------
--- Extras Rotation ---
-----------------------
            if actionList_Extras() then return end
-------------------------
--- Extras Summon Pet ---
-------------------------
            if actionList_SummonPet() then return end
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
    -----------------------------
    --- In Combat - Cooldowns ---
    -----------------------------
                if actionList_Cooldowns() then return end
    ---------------------------
    --- In Combat - Default ---
    ---------------------------
                if actionList_Default() then return end
            end --End In Combat
        end --End Rotation Logic
    --end -- End Timer
end -- End runRotation
local id = 265
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})