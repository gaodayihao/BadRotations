local rotationName = "Ellis"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.agony},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.corruption},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.drainSoul},
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
        [1] = { mode = "Off", value = 1 , overlay = "SOC Disabled", tip = LC_SOC_MODE_DISABLE, highlight = 1, icon = br.player.spell.seedOfCorruption},
        [2] = { mode = "On", value = 2 , overlay = "SOC Enabled", tip = LC_SOC_MODE_ENABLE, highlight = 0, icon = br.player.spell.seedOfCorruption}
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
        -- Agony Targets Maxinum
            br.ui:createSpinnerWithout(section, LC_AGONY_TARGETS,  5,  1,  10,  1)
        -- Agony Target Health Mininum
            br.ui:createSpinnerWithout(section, LC_AGONY_TARGETS_HP,  3,  0,  10,  1)
        -- Agony Target Time To Die
            br.ui:createSpinnerWithout(section, LC_AGONY_TARGETS_TTD,  6,  0,  10,  1)
        -- Corruption Targets Maxinum
            br.ui:createSpinnerWithout(section, LC_CORRUPTION_TARGETS,  3,  1,  10,  1)
        -- Corruption Target Health Mininum
            br.ui:createSpinnerWithout(section, LC_CORRUPTION_TARGETS_HP,  3,  0,  10,  1)
        -- Corruption Target Time To Die
            br.ui:createSpinnerWithout(section, LC_CORRUPTION_TARGETS_TTD,  6,  0,  10,  1)
        -- Siphon Life Targets Maxinum
            br.ui:createSpinnerWithout(section, LC_SIPHON_LIFE_TARGETS,  3,  1,  10,  1)
        -- Siphon Life Target Health Mininum
            br.ui:createSpinnerWithout(section, LC_SIPHON_LIFE_TARGETS_HP,  3,  0,  10,  1)
        -- Siphon Life Target Time To Die
            br.ui:createSpinnerWithout(section, LC_SIPHON_LIFE_TARGETS_TTD,  6,  0,  10,  1)
        -- Reap Souls
            -- br.ui:createSpinnerWithout(section, LC_REAP_SOULS,  3,  1,  18,  1, LC_REAP_SOULS_DESCRIPTION)
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
        if delayHack == nil then delayHack = 0 end

        local socMode = mode.soc == 2

        local dotCountUA = 0
        if debuff.unstableAffliction[units.dyn40].exists then
            dotCountUA = dotCountUA + 1
        end
        if debuff.unstableAffliction2[units.dyn40].exists then
            dotCountUA = dotCountUA + 1
        end
        if debuff.unstableAffliction3[units.dyn40].exists then
            dotCountUA = dotCountUA + 1
        end
        if debuff.unstableAffliction4[units.dyn40].exists then
            dotCountUA = dotCountUA + 1
        end
        if debuff.unstableAffliction5[units.dyn40].exists then
            dotCountUA = dotCountUA + 1
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
                        if isChecked(LC_ARCANE_TORRENT) and getSpellCD(racial) == 0 and getDistance(thisUnit) <=8 and race == "BloodElf" then
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
                        if cast.grimoireImp() then return true end
                    end
                    if grimoirePet == 2 then
                        if cast.grimoireFelhunter() then return true end
                    end
                    if grimoirePet == 3 then
                        if cast.grimoireVoidwalker() then return true end
                    end
                    if grimoirePet == 4 then
                        if cast.grimoireSuccubus() then return true end
                    end
                end
        -- Summon Doomguard
            --summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<3&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
                if isChecked(LC_COOLDOWN_DOOMGUARD) and not talent.grimoireOfSupremacy and (ttd("target") > 180 or getHP("target") <=20 or ttd("target") < 30) and #enemies.yards10t < 3 then
                    if cast.summonDoomguard() then return true end
                end
        -- Summon Infernal
                --summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>=3
                if isChecked(LC_COOLDOWN_INFERNAL) and not talent.grimoireOfSupremacy and #enemies.yards10t >= 3 then
                    if cast.summonInfernal() then return true end
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
                    if cast.soulHarvest() then return true end
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
            if not IsMounted() 
                and activePet == "None" 
                and (not talent.grimoireOfSacrifice or (talent.grimoireOfSacrifice and not buff.demonicPower.exists)) 
                and br.timer:useTimer("Summon Pet",1)
            then
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
            if friendly or (isValidUnit("target") and GetObjectID("target") ~= 103679) then return end
            local theEnemies = enemies.yards40
            local targetUnit = nil
            for i = 1, #theEnemies do
                local thisUnit = theEnemies[i]
                if not targetUnit and UnitGUID(thisUnit) ~= lastTarget and GetObjectID(thisUnit) ~= 103679 then
                    targetUnit = thisUnit
                elseif targetUnit ~= nil then
                    local health = UnitHealth(thisUnit)
                    if health > UnitHealth(targetUnit) and UnitGUID(thisUnit) ~= lastTarget and GetObjectID(thisUnit) ~= 103679 then
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
            if not UnitIsUnit("pettarget","target") then
                PetAttack()
            end
    -- Soul Effigy
            -- soul_effigy,if=!pet.soul_effigy.active
            local hasEffigy = effigyUnit ~= nil and ObjectExists(effigyUnit) and getDistance(effigyUnit) <= 40
            if not hasEffigy then
                for i = 1 ,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if GetObjectID(thisUnit) == 103679 then
                        print(1)
                        effigyUnit = thisUnit
                        hasEffigy = true
                        break
                    end
                end
            end
            if not hasEffigy then
                if cast.soulEffigy() then delayHack = getOptionValue(LC_ROTATION_TPS)/3 return end
            end
    -- Agony
            if debuff.agony[units.dyn40].remain <= 2 + gcd then
                if cast.agony(units.dyn40,"face") then return true end
            end
            -- cycle_targets=1,if=remains<=tick_time+gcd
            if getOptionValue(LC_AGONY_TARGETS) > 1 and not forceSingle then
                for i = 1 ,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (debuff.agony["target"].count < getOptionValue(LC_AGONY_TARGETS) or debuff.agony[thisUnit].exists)
                        and debuff.agony[thisUnit].remain <= 2 + gcd
                        and ttd(thisUnit) >= getOptionValue(LC_AGONY_TARGETS_TTD)
                        and UnitHealth(thisUnit) >= getOptionValue(LC_AGONY_TARGETS_HP) * 1000000
                    then
                        if cast.agony(thisUnit,"face") then return true end
                    end
                end
            end
    -- In Combat - Cooldowns
            if actionList_Cooldowns() then return end
    -- Seed Of Corruption
            if socMode then
                if talent.sowTheSeeds and #enemies.yards10t >= 3 or #enemies.yards10t >= 4 then
                    if cast.seedOfCorruption() then delayHack = getOptionValue(LC_ROTATION_TPS) / 3 return true end
                end
            end
    -- Corruption
            -- if=remains<=tick_time+gcd
            -- cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=tick_time+gcd
            if (talent.absoluteCorruption and not debuff.corruption[units.dyn40].exists) or (not talent.absoluteCorruption and debuff.corruption[units.dyn40].remain <= 2 + gcd) then
                if not debuff.seedOfCorruption[units.dyn40].exists and cast.corruption(units.dyn40,"face") then return true end
            end
            if getOptionValue(LC_CORRUPTION_TARGETS) > 1 and (talent.absoluteCorruption or not talent.maleficGrasp or not talent.soulEffigy) and not forceSingle then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if ((talent.absoluteCorruption and not debuff.corruption[thisUnit].exists)
                        or (not talent.absoluteCorruption 
                            and (debuff.corruption["target"].count < getOptionValue(LC_CORRUPTION_TARGETS) or debuff.corruption[thisUnit].exists) 
                            and debuff.corruption[thisUnit].remain <= gcd + 2))
                        and ttd(thisUnit) >= getOptionValue(LC_CORRUPTION_TARGETS_TTD)
                        and UnitHealth(thisUnit) >= getOptionValue(LC_CORRUPTION_TARGETS_HP) * 1000000
                    then
                        if not debuff.seedOfCorruption[thisUnit].exists and cast.corruption(thisUnit,"face") then return true end
                    end
                end
            end
    -- Siphon Life
            -- if=remains<=tick_time+gcd&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)<2
            -- cycle_targets=1,if=(!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=tick_time+gcd
            if debuff.siphonLife[units.dyn40].remain <= 2 + gcd and dotCountUA < 2 then
                if cast.siphonLife(units.dyn40,"face") then return true end
            end
            if getOptionValue(LC_SIPHON_LIFE_TARGETS) > 1 and (not talent.maleficGrasp or not talent.soulEffigy) and not forceSingle then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (debuff.siphonLife["target"].count < getOptionValue(LC_SIPHON_LIFE_TARGETS) or debuff.siphonLife[thisUnit].exists) 
                        and debuff.siphonLife[thisUnit].remain <= 2 + gcd
                        and ttd(thisUnit) >= getOptionValue(LC_SIPHON_LIFE_TARGETS_TTD)
                        and UnitHealth(thisUnit) >= getOptionValue(LC_SIPHON_LIFE_TARGETS_HP) * 1000000
                    then
                        if cast.siphonLife(thisUnit,"face") then return true end
                    end
                end
            end
    -- Life Tap
            -- if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
            if talent.empoweredLifeTap and buff.empoweredLifeTap.remain <= gcd then
                if cast.lifeTap() then return true end
            end
    -- Phantom Singularity
            -- phantom_singularity
            if talent.phantomSingularity then
                if cast.phantomSingularity() then return true end
            end
    -- Haunt
            -- haunt
            if talent.haunt then
                if cast.haunt() then return true end
            end
    -- Agony
            -- cycle_targets=1,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
            if not talent.maleficGrasp then
                if ttd(units.dyn40) >= debuff.agony[units.dyn40].remain and debuff.agony[units.dyn40].refresh then
                    if cast.agony(units.dyn40) then return true end
                end
                if getOptionValue(LC_AGONY_TARGETS) > 1 and not forceSingle then
                    for i = 1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if (debuff.agony["target"].count < getOptionValue(LC_AGONY_TARGETS) or debuff.agony[thisUnit].exists)
                            and debuff.agony[thisUnit].refresh
                            and ttd(thisUnit) >= getOptionValue(LC_AGONY_TARGETS_TTD)
                            and UnitHealth(thisUnit) >= getOptionValue(LC_AGONY_TARGETS_HP) * 1000000
                        then
                            if cast.agony(thisUnit) then return true end
                        end
                    end
                end
            end
            -- cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
            if dotCountUA == 0 and not forceSingle then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (debuff.agony["target"].count < getOptionValue(LC_AGONY_TARGETS) or debuff.agony[thisUnit].exists)
                        and debuff.agony[thisUnit].refresh
                        and ttd(thisUnit) >= getOptionValue(LC_AGONY_TARGETS_TTD)
                        and UnitHealth(thisUnit) >= getOptionValue(LC_AGONY_TARGETS_HP) * 1000000
                    then
                        if cast.agony(thisUnit) then return true end
                    end
                end
            end
    -- Life Tap
            -- if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3|talent.malefic_grasp.enabled&target.time_to_die>15&mana.pct<10
            if talent.empoweredLifeTap and buff.empoweredLifeTap.refresh or talent.maleficGrasp and ttd(units.dyn40) > 15 and manaPercent < 10 then
                if cast.lifeTap() then return true end
            end
    -- Seed Of Corruption
            -- if=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3|spell_targets.seed_of_corruption>=4
            if talent.sowTheSeeds and #enemies.yards10t >= 3 or #enemies.yards10t >= 4 then
                if cast.seedOfCorruption() then delayHack = getOptionValue(LC_ROTATION_TPS) / 3 return true end
            end
    -- Corruption
            -- if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
            -- if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
            if not (talent.absoluteCorruption and debuff.corruption[units.dyn40].exists) and
             ((not talent.maleficGrasp and debuff.corruption[units.dyn40].refresh and ttd(units.dyn40) >= debuff.corruption[units.dyn40].remain)
                or
                (debuff.corruption[units.dyn40].refresh and ttd(units.dyn40) >= debuff.corruption[units.dyn40].remain and dotCountUA == 0))
            then
                if not debuff.seedOfCorruption[units.dyn40].exists and cast.corruption(units.dyn40,"face") then return true end
            end
            -- cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
            if getOptionValue(LC_CORRUPTION_TARGETS) > 1 and (talent.absoluteCorruption or not talent.maleficGrasp or not talent.soulEffigy) and not forceSingle then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not (talent.absoluteCorruption 
                        and debuff.corruption[thisUnit].exists)
                        and (debuff.corruption["target"].count < getOptionValue(LC_CORRUPTION_TARGETS) or debuff.corruption[thisUnit].exists)
                        and debuff.corruption[thisUnit].refresh
                        and ttd(thisUnit) >= getOptionValue(LC_CORRUPTION_TARGETS_TTD)
                        and UnitHealth(thisUnit) >= getOptionValue(LC_CORRUPTION_TARGETS_HP) * 1000000
                    then
                        if not debuff.seedOfCorruption[thisUnit].exists and cast.corruption(thisUnit,"face") then return true end
                    end
                end
            end
    -- Siphon Life
            -- if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
            -- if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
            if (not talent.maleficGrasp and debuff.siphonLife[units.dyn40].refresh and ttd(units.dyn40) >= debuff.siphonLife[units.dyn40].remain)
                or
                (debuff.siphonLife[units.dyn40].refresh and ttd(units.dyn40) >= debuff.siphonLife[units.dyn40].remain and dotCountUA == 0)
            then
                if cast.siphonLife(units.dyn40,"face") then return true end
            end
            -- cycle_targets=1,if=(!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
            if getOptionValue(LC_SIPHON_LIFE_TARGETS) > 1 and (not talent.maleficGrasp or not talent.soulEffigy) and not forceSingle then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (debuff.siphonLife["target"].count < getOptionValue(LC_SIPHON_LIFE_TARGETS) or debuff.siphonLife[thisUnit].exists)
                        and debuff.siphonLife[thisUnit].refresh
                        and ttd(thisUnit) >= getOptionValue(LC_SIPHON_LIFE_TARGETS_TTD)
                        and UnitHealth(thisUnit) >= getOptionValue(LC_SIPHON_LIFE_TARGETS_HP) * 1000000
                    then
                        if cast.siphonLife(thisUnit) then return true end
                    end
                end
            end
    -- Unstable Affliction
            -- if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.writhe_in_agony.enabled&talent.contagion.enabled
            if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.writheInAgony and talent.contagion then
                if not moving and cast.unstableAffliction() then delayHack = getOptionValue(LC_ROTATION_TPS) / 4 return true end
            end
            -- if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.contagion.enabled&(soul_shard>=4|trinket.proc.intellect.react|trinket.stacking_proc.mastery.react|trinket.proc.mastery.react|trinket.proc.crit.react|trinket.proc.versatility.react|buff.soul_harvest.remains|buff.deadwind_harvester.remains|buff.compounding_horror.react=5|target.time_to_die<=20)
            if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.contagion and
                (shards >=4 
                    or buff.soulHarvest.exists 
                    or buff.deadwindHarvester.exists 
                    or buff.compoundingHorror.stack == 5 
                    or ttd(units.dyn40) <= 20)
            then
                if not moving and cast.unstableAffliction() then delayHack = getOptionValue(LC_ROTATION_TPS) / 4 return true end
            end
            -- if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&target.time_to_die<30
            if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.maleficGrasp and ttd(units.dyn40) < 30 then
                if not moving and cast.unstableAffliction() then delayHack = getOptionValue(LC_ROTATION_TPS) / 4 return true end
            end
            -- if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&soul_shard=5
            if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.maleficGrasp and shards == 5 then
                if not moving and cast.unstableAffliction() then delayHack = getOptionValue(LC_ROTATION_TPS) / 4 return true end
            end
            -- if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&!prev_gcd.3.unstable_affliction&dot.agony.remains>cast_time*3+6.5&(!talent.soul_effigy.enabled|pet.soul_effigy.dot.agony.remains>cast_time*3+6.5)&(dot.corruption.remains>cast_time+6.5|talent.absolute_corruption.enabled)&(dot.siphon_life.remains>cast_time+6.5|!talent.siphon_life.enabled)
            if (not talent.sowTheSeeds or #enemies.yards10t < 3) 
                and #enemies.yards10t < 4 
                and talent.maleficGrasp
                and debuff.agony[units.dyn40].remain > getCastTime(spell.unstableAffliction) * 3 + 6.5
                and (talent.absoluteCorruption or debuff.corruption[units.dyn40].remain > getCastTime(spell.unstableAffliction) + 6.5)
                and (not talent.siphonLife or debuff.siphonLife[units.dyn40].remain > getCastTime(spell.unstableAffliction) + 6.5)
            then
                if not moving and cast.unstableAffliction() then delayHack = getOptionValue(LC_ROTATION_TPS) / 4 return true end
            end
            -- if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&talent.haunt.enabled&(soul_shard>=4|debuff.haunt.remains>6.5|target.time_to_die<30)
            if (not talent.sowTheSeeds or #enemies.yards10t < 3)
                and talent.haunt
                and (shards >=4 or debuff.haunt[units.dyn40].remain > 6.5 or ttd(units.dyn40) < 30)
            then
                if not moving and cast.unstableAffliction() then delayHack = getOptionValue(LC_ROTATION_TPS) / 4 return true end
            end
    -- Reap Souls
            -- if=!buff.deadwind_harvester.remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)>1&((!trinket.has_stacking_stat.any&!trinket.has_stat.any)|talent.malefic_grasp.enabled)
            if buff.tormentedSouls.stack > 0 and not buff.deadwindHarvester.exists and dotCountUA > 1 then
                if cast.reapSouls() then return true end
            end
            -- !buff.deadwind_harvester.remains&prev_gcd.1.unstable_affliction&((!trinket.has_stacking_stat.any&!trinket.has_stat.any)|talent.malefic_grasp.enabled)&buff.tormented_souls.react>1
            if not buff.deadwindHarvester.exists and lastSpell == spell.unstableAffliction and buff.tormentedSouls.stack > 1 then
                if cast.reapSouls() then return true end
            end
    -- Life Tap
            -- if=mana.pct<=10
            if manaPercent <= 10 then
                if cast.lifeTap() then return true end
            end
    -- Drain Soul
            -- drain_soul,chain=1,interrupt=1
            if not moving and not isCastingSpell(spell.drainSoul) and cast.drainSoul() then return true end
    -- Life Tap
            if moving and manaPercent <= 70 then
                if cast.lifeTap() then return true end
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
        if isPause or mode.rotation==4 or delayHack >= 1 then
            if mode.rotation==4 and activePet ~= "None" then
                PetFollow()
            end
            if not isPause and not UnitCastingInfo("player") and not UnitChannelInfo("player") and delayHack >= 1 then
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
            if actionList_SummonPet() then delayHack = getOptionValue(LC_ROTATION_TPS)/2 return end
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
            if inCombat and isValidUnit(units.dyn40) and GetObjectID("target") ~= 103679 then
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