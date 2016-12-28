local rotationName = "Ellis"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.incinerate},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.rainOfFire},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.immolate},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.drainLife}
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
                                        }, 1, LC_GRIMOIRE_OF_SERVICE_DESCRIPTION)
        -- Grimoire of Supremacy
            br.ui:createDropdownWithout(section, LC_GRIMOIRE_OF_SUPREMACY, {LC_GRIMOIRE_OF_SUPREMACY_DOOMGUARD,LC_GRIMOIRE_OF_SUPREMACY_INFERNAL}, 1, LC_GRIMOIRE_OF_SUPREMACY_DESCRIPTION)
        -- Havoc
            br.ui:createSpinner(section, LC_HAVOC,  2,  0,  15,  1,  LC_HAVOC_DESCRIPTION)
        -- Cataclysm
            br.ui:createCheckbox(section, LC_CATACLYSM)
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
        -- Drain Life
            br.ui:createSpinner(section, LC_DRAIN_LIFE, 30, 0, 100, 5, LC_DRAIN_LIFE_DESCRIPTION)
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
        local ttd                                           = getTimeToDie
        local units                                         = br.player.units
        local useArtifact                                   = false

        if immolateHack == nil then immolateHack = 0 end

        if isChecked(LC_ARTIFACT) then
            if getOptionValue(LC_ARTIFACT) == 1 then
                useArtifact = artifact.dimensionalRift
            else
                useArtifact = useCDs() and artifact.dimensionalRift
            end
        end

        if br.player.roaringBlazeUnits == nil then
            br.player.roaringBlazeUnits = {}

            -- Print("Event Add")
            AddEventCallback("COMBAT_LOG_EVENT_UNFILTERED",function(...)
                local _, combatEvent, _, sourceGUID, _, _, _, destGUID, destName, _, _, spellId, _, _ = ...
                if talent.roaringBlaze and sourceGUID == UnitGUID("player") and combatEvent == "SPELL_CAST_SUCCESS" and spellId == spell.conflagrate then
                    -- Print("Roaring Blaze add.")
                    br.player.roaringBlazeUnits[destGUID] = {}
                    br.player.roaringBlazeUnits[destGUID].start = GetTime()
                    br.player.roaringBlazeUnits[destGUID].remain = debuff.immolate[units.dyn40].remain - gcd * 2
                    if  debuff.havoc["target"].count > 0 then
                        for i = 1,#enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if debuff.havoc[thisUnit].exists then
                                local guid = UnitGUID(thisUnit)
                                -- Print("Roaring Blaze add.")
                                br.player.roaringBlazeUnits[guid] = {}
                                br.player.roaringBlazeUnits[guid].start = GetTime()
                                br.player.roaringBlazeUnits[guid].remain = debuff.immolate[units.dyn40].remain - gcd * 2
                            end
                        end
                    end
                end
            end,"Destruction")

            AddEventCallback("PLAYER_SPECIALIZATION_CHANGED",function(source)
                if source ~= "player" then
                    return
                end
                RemoveEventCallback("COMBAT_LOG_EVENT_UNFILTERED","Destruction")
                RemoveEventCallback("PLAYER_SPECIALIZATION_CHANGED","Destruction")
                -- Print("Event remove.")
            end,"Destruction")
        end

        for k,v in pairs(br.player.roaringBlazeUnits) do
            if br.player.roaringBlazeUnits[k].start + br.player.roaringBlazeUnits[k].remain <= GetTime() then
                br.player.roaringBlazeUnits[k] = nil
                -- Print("Roaring Blaze remove.")
            end
        end

        -- Print(tostring(debuff.immolate["target"].count))
        -- Print(tostring(getCastTime(spell.chaosBolt)))
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
                        if isKnown(spell.summonFelImp) then
                            if cast.summonFelImp() then return true end
                        else  
                            if cast.summonImp() then return true end
                        end
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
                    if (health > UnitHealth(targetUnit) or debuff.havoc[targetUnit].exists) and UnitGUID(thisUnit) ~= lastTarget then
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

            local aEnemiesCount = #getEnemies(units.dyn40,8)
    -- Havoc
            -- havoc,target=2,if=active_enemies>1&active_enemies<6&!debuff.havoc.remains
            -- havoc,target=2,if=active_enemies>1&!talent.wreak_havoc.enabled&talent.roaring_blaze.enabled&!debuff.roaring_blaze.remains
            if cd.havoc == 0 and isChecked(LC_HAVOC) and debuff.havoc["target"].count == 0 and not forceSingle and #enemies.yards40 > 1 then
                local tempTable = {}
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not UnitIsUnit(thisUnit,"target")
                        and isValidUnit(thisUnit) 
                        and UnitHealth(thisUnit) >= getOptionValue(LC_HAVOC) * 1000000 
                    then
                        tinsert(tempTable,thisUnit)
                    end
                end
                if #tempTable > 0 then
                    table.sort(tempTable,function(a,b) 
                        return UnitHealth(a) > UnitHealth(b) 
                    end)
                    local thisUnit = tempTable[1]
                    if aEnemiesCount < 6
                        or (not talent.wreakHavoc and talent.roaringBlaze and br.player.roaringBlazeUnits[UnitGUID(thisUnit)] == nil) 
                    then
                        if cast.havoc(thisUnit) then return end
                    end
                end
            end
    -- Dimensional Rift
            -- dimensional_rift,if=charges=3
            if useArtifact and charges.dimensionalRift == 3 then
                if cast.dimensionalRift() then return end
            end
    -- Cataclysm
            -- cataclysm
            if talent.cataclysm and isChecked(LC_CATACLYSM) and aEnemiesCount > 1 and cast.cataclysm() then return end
    -- Immolate
            -- immolate,if=remains<=tick_time
            if debuff.immolate[units.dyn40].remain <= 3 and (lastSpell ~= spell.immolate or lastTarget ~= UnitGUID(units.dyn40)) then
                if cast.immolate() then return end
            end
            -- immolate,cycle_targets=1,if=active_enemies>1&remains<=tick_time&!debuff.roaring_blaze.remains&action.conflagrate.charges<2
            if not forceSingle and charges.conflagrate < 2 and debuff.immolate["target"].count < 4 then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    local guid = UnitGUID(thisUnit)
                    if debuff.immolate[thisUnit].remain <= 3 and br.player.roaringBlazeUnits[guid] == nil and (lastSpell ~= spell.immolate or lastTarget ~= UnitGUID(thisUnit)) then
                        if cast.immolate(thisUnit) then return end
                    end
                end
            end
            -- immolate,if=talent.roaring_blaze.enabled&remains<=duration&!debuff.roaring_blaze.remains&target.time_to_die>10&(action.conflagrate.charges=2|(action.conflagrate.charges>=1&action.conflagrate.recharge_time<cast_time+gcd)|target.time_to_die<24)
            if talent.roaringBlaze 
                and debuff.immolate[units.dyn40].remain < 18
                and br.player.roaringBlazeUnits[UnitGUID(units.dyn40)] == nil
                and ttd(units.dyn40) > 10
                and (charges.conflagrate == 2 
                        or (charges.conflagrate >= 1 and recharge.conflagrate < getCastTime(spell.immolate) + gcd) 
                        or ttd(units.dyn40) < 24)
            then
                if cast.immolate() then immolateHack = 2 return end
            end
    -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
            -- blood_fury | berserking | arcane_torrent
            if useCDs() then
                if isChecked(LC_RACIAL) 
                    and (br.player.race == "Orc" or br.player.race == "Troll")
                    and getSpellCD(racial) == 0
                then
                    if castSpell("player",racial,false,false,false) then return true end
                end
            end
    -- Conflagrate
            -- if=talent.roaring_blaze.enabled&(charges=2|(action.conflagrate.charges>=1&action.conflagrate.recharge_time<gcd)|target.time_to_die<24)
            -- if=talent.roaring_blaze.enabled&debuff.roaring_blaze.stack>0&dot.immolate.remains>dot.immolate.duration*0.3&(active_enemies=1|soul_shard<3)&soul_shard<5
            if (talent.roaringBlaze 
                    and (charges.conflagrate == 2 
                            or (charges.conflagrate >= 1  and recharge.conflagrate < gcd) 
                            or ttd(units.dyn40) < 24))
                or 
                (talent.roaringBlaze 
                    and br.player.roaringBlazeUnits[UnitGUID(units.dyn40)] ~= nil 
                    and not debuff.immolate[units.dyn40].refresh 
                    and (#enemies.yards40 == 1 or shards < 3) and shards < 5)
            then
                if cast.conflagrate() then return end
            end
    -- Service Pet
            if talent.grimoireOfService and useCDs() and br.timer:useTimer("castGrim", gcd) then
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
    -- Summon Infernal
            -- summon_infernal,if=artifact.lord_of_flames.rank>0&!buff.lord_of_flames.remains
            if useCDs() and artifact.lordOfFlames and getDebuffRemain("player",spell.debuffs.lordOfFlames,"player") == 0 then
                if not talent.grimoireOfSupremacy then
                    if cast.summonInfernal() then return end
                elseif petId == 78217 and cd.meteorStrike == 0 then
                    if cast.meteorStrike() then return end
                end
            end
    -- Summon Doomguard
        --summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<3&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
            if useCDs() and isChecked(LC_COOLDOWN_DOOMGUARD) and not talent.grimoireOfSupremacy and (ttd("target") > 180 or getHP("target") <=20 or ttd("target") < 30) and #enemies.yards10t < 3 then
                if cast.summonDoomguard() then return end
            end
    -- Summon Infernal
            --summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>=3
            if useCDs() and isChecked(LC_COOLDOWN_INFERNAL) and not talent.grimoireOfSupremacy and #enemies.yards10t >= 3 then
                if cast.summonInfernal() then return end
            end
    -- Summon Doomguard
            -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<3&equipped.132379&!cooldown.sindorei_spite_icd.remains
    -- Summon Infernal
            -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>=3&equipped.132379&!cooldown.sindorei_spite_icd.remains
    -- Soul Harvest
            if talent.soulHarvest and useCDs() and isChecked(LC_SOUL_HARVEST) then
                if cast.soulHarvest() then return end
            end
    -- Channel Demonfire
            -- channel_demonfire,if=dot.immolate.remains>cast_time
            if talent.channelDemonfire and debuff.immolate[units.dyn40].remain > getCastTime(spell.channelDemonfire) then
                if cast.channelDemonfire() then return end
            end
    -- Conflagrate
            -- if=!talent.roaring_blaze.enabled&!buff.backdraft.remains&buff.conflagration_of_chaos.remains<=action.chaos_bolt.cast_time
            -- if=!talent.roaring_blaze.enabled&!buff.backdraft.remains&(charges=1&recharge_time<action.chaos_bolt.cast_time|charges=2)&soul_shard<5
            if (not talent.roaringBlaze and not buff.backdraft.exists and buff.conflagrationOfChaos.remain <= getCastTime(spell.chaosBolt))
                or (not talent.roaringBlaze and not buff.backdraft.exists and (charges.conflagrate == 1 and recharge.conflagrate < getCastTime(spell.chaosBolt) or charges.conflagrate == 2) and shards < 5)
            then
                if cast.conflagrate() then return end
            end
    -- Incinerate
            if talent.fireAndBrimstone and buff.backdraft.exists and aEnemiesCount > (1 + debuff.havoc["target"].count) * 2 then
                if cast.incinerate() then return end
            end
    -- Chaos Blot
            -- chaos_bolt,if=soul_shard>3|buff.backdraft.remains
            -- chaos_bolt,if=buff.backdraft.remains&prev_gcd.incinerate
            if shards > 3 or buff.backdraft.exists
                or buff.backdraft.exists and lastSpell == spell.incinerate
            then
                if cast.chaosBolt() then return end
            end
    -- Incinerate
            -- incinerate,if=buff.backdraft.remains
            if buff.backdraft.exists then
                if cast.incinerate() then return end
            end
    -- Havoc
            -- havoc,if=active_enemies=1&talent.wreak_havoc.enabled&equipped.132375&!debuff.havoc.remains
            if isChecked(LC_HAVOC) and #enemies.yards40 == 1 and hasEquiped(132375) and not debuff.havoc[units.yards40].exists then
                if cast.havoc() then return end
            end
    -- Rain Of Fire
            -- rain_of_fire,if=active_enemies>=4&cooldown.havoc.remains<=12&!talent.wreak_havoc.enabled
            -- rain_of_fire,if=active_enemies>=6&talent.wreak_havoc.enabled
            if (not forceSingle and aEnemiesCount >= 4 and cd.havoc <=12 and not talent.wreakHavoc)
                or (not forceSingle and aEnemiesCount >= 6 and talent.wreakHavoc)
            then
                if cast.rainOfFire() then return end
            end
    -- Dimensional Rift
            -- dimensional_rift
            if useArtifact then
                if cast.dimensionalRift() then return end
            end
    -- Mana Tap
            -- mana_tap,if=buff.mana_tap.remains<=buff.mana_tap.duration*0.3&(mana.pct<20|buff.mana_tap.remains<=action.chaos_bolt.cast_time)&target.time_to_die>buff.mana_tap.duration*0.3
            if talent.manaTap and buff.manaTap.refresh and (power < 20 or buff.manaTap.remain <= getCastTime(spell.chaosBolt)) then
                if cast.manaTap() then return end
            end
    -- Incinerate
            if talent.fireAndBrimstone and aEnemiesCount > (1 + debuff.havoc["target"].count) * 2 then
                if cast.incinerate() then return end
            end
    -- Chaos Blot
            -- chaos_bolt
            if cast.chaosBolt() then return end
    -- Cataclysm
            -- cataclysm
            if talent.cataclysm and isChecked(LC_CATACLYSM) and cast.cataclysm() then return end
    -- Conflagrate
            -- conflagrate,if=!talent.roaring_blaze.enabled&!buff.backdraft.remains
            if not talent.roaringBlaze and not buff.backdraft.exists then
                if cast.conflagrate() then return end
            end
    -- Immolate
            -- immolate,if=!talent.roaring_blaze.enabled&remains<=duration*0.3
            if not talent.roaringBlaze and debuff.immolate[units.dyn40].refresh then
                if cast.immolate() then return end
            end
    -- Life Tap
            -- life_tap,if=talent.mana_tap.enabled&mana.pct<=10
            if talent.manaTap and manaPercent <= 10 then
                if cast.lifeTap() then return end
            end
    -- Incinerate
            -- incinerate
            if cast.incinerate() then return end
    -- Life Tap
        -- life_tap
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
        local isPause = pause()
        if isPause or mode.rotation==4 or IsMounted() or immolateHack > 0 then
            if not isPause and activePet ~= "None" then
                PetFollow()
            end
            if not isPause and immolateHack > 0 then
                immolateHack = immolateHack - 1
            end
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
local id = 267
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})