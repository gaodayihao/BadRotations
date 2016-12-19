local rotationName = "Ellis"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.demonwrath},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.demonwrath},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.shadowbolt},
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
                                            LC_SUMMON_PET_SUCCUBUS,
                                            LC_SUMMON_PET_FELGUARD
                                        }, 1, LC_SUMMON_PET_DESCRIPTION)
        -- Grimoire of Service
            br.ui:createDropdownWithout(section, LC_GRIMOIRE_OF_SERVICE,
                                        {
                                            LC_GRIMOIRE_OF_SERVICE_FELGUARD,
                                            LC_GRIMOIRE_OF_SERVICE_IMP,
                                            LC_GRIMOIRE_OF_SERVICE_FELHUNTER,
                                            LC_GRIMOIRE_OF_SERVICE_VOIDWALKER,
                                            LC_GRIMOIRE_OF_SERVICE_SUCCUBUS,
                                        }, 1, LC_GRIMOIRE_OF_SERVICE_DESCRIPTION)
        -- Grimoire of Supremacy
            br.ui:createDropdownWithout(section, LC_GRIMOIRE_OF_SUPREMACY, {LC_GRIMOIRE_OF_SUPREMACY_DOOMGUARD,LC_GRIMOIRE_OF_SUPREMACY_INFERNAL}, 1, LC_GRIMOIRE_OF_SUPREMACY_DESCRIPTION)
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, LC_COOLDOWNS)
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, LC_DEFENSIVE)
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
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
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local hasteAmount                                   = GetHaste()/100
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastSpell                                     = lastSpellCast
        local manaPercent                                   = br.player.power.mana.percent
        local mode                                          = br.player.mode
        local moving                                        = isMoving("player")
        local petPool                                       = br.player.petPool
        local php                                           = br.player.health
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen, br.player.power.mana.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local shards                                        = br.player.power.amount.soulShards
        local spell                                         = br.player.spell
        local summonPet                                     = getOptionValue(LC_SUMMON_PET)
        local talent                                        = br.player.talent
        local travelTime                                    = getDistance("target")/16
        local ttd                                           = getTimeToDie
        local units                                         = br.player.units
        
        -- Doom
        local doom              = debuff.doom[units.dyn40]
        local nextShard         = 0
        local doomRemain        = 20 / (1+hasteAmount)
        if doom ~= nil and doom.exists then
            if doom.trick == 0 then
                doom.trick = doom.start + doomRemain
            end
            if doom.trick <= GetTime() then
                if doom.remain >= doomRemain then
                    doom.trick = doom.trick + doomRemain
                else
                    doom.trick = doom.trick + doom.remain
                end
            end
            nextShard = math.max(0,doom.trick-GetTime())
        elseif doom ~= nil then
            doom.trick = 0
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
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonInfernal == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    elseif self.talent.grimoireOfSupremacy then
                        return castSpell(thisUnit,spellCast,false,true)
                    else
                        return castGroundAtBestLocation(spellCast,10,1,30)
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
            end -- End Defensive Toggle
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then
               
            end -- End useInterrupts check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance(units.dyn40) < 40 then
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
           
        end -- End Action List - PreCombat
        local function actionList_Opener()
          
        end
    -- Action List - Summon Pet
        local function actionList_SummonPet()
            --print(activePet)
            if not IsMounted() and activePet == "None" and br.timer:useTimer("Summon Pet",1.5) then
                if summonPetDelay == nil then summonPetDelay = 0 end
                if summonPetDelay == 0 then summonPetDelay = 1 return end
                summonPetDelay = 0
                if summonPet == 1 then
                    if talent.grimoireOfSupremacy then
                        if getOptionValue(LC_GRIMOIRE_OF_SUPREMACY) == 1 then
                            if cast.summonDoomguard() then return true end
                        elseif getOptionValue(LC_GRIMOIRE_OF_SUPREMACY) == 2 then
                            if cast.summonInfernal() then return true end
                        end
                    else
                        if cast.summonFelguard() then return true end
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
                elseif summonPet == 6 then
                    if cast.summonFelguard() then return true end
                end
            end
        end 
    -- Action List - Auto Target
        local function actionList_AutoTarget()
            if autoTarget == false then return end
            if isValidUnit("target") then return end
            local theEnemies = enemies.yards40
            local targetUnit = nil
            for i = 1, #theEnemies do
                local thisUnit = theEnemies[i]
                if not targetUnit and UnitGUID(thisUnit) ~= lastTarget and UnitGUID("player") ~= lastTarget then
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
            if not UnitIsUnit("pettarget","target") then
                PetAttack()
            end
    -- Stop Demon Wrath
            if isCastingSpell(spell.demonwrath) and not petPool.demonwrathPet and not moving then
                SpellStopCasting()
            end
    -- Implosion
        -- implosion,if=wild_imp_remaining_duration<=action.shadow_bolt.execute_time&buff.demonic_synergy.remains
        -- implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=3&buff.demonic_synergy.remains
        -- implosion,if=wild_imp_count<=4&wild_imp_remaining_duration<=action.shadow_bolt.execute_time&spell_targets.implosion>1
        -- implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=4&spell_targets.implosion>2
            if talent.implosion and petPool.count.wildImp > 0 and ((petPool.remain.wildImp < getCastTime(spell.shadowbolt) and buff.demonicSynergy.exists)
                or (lastSpell == spell.handOfGuldan and petPool.remain.wildImp <=3 and buff.demonicSynergy.exists)
                or (petPool.count.wildImp <=4 and petPool.remain.wildImp <= getCastTime(spell.shadowbolt) and #enemies.yards8t > 1)
                or (lastSpell == spell.handOfGuldan and petPool.remain.wildImp <= 4 and #enemies.yards8t > 2)) 
            then
                if cast.implosion() then return end
            end
    -- Shadowflame
        -- shadowflame,if=debuff.shadowflame.stack>0&remains<action.shadow_bolt.cast_time+travel_time
            if talent.shadowflame and debuff.shadowflame[units.dyn40] ~= nil then
                if debuff.shadowflame[units.dyn40].stack > 0 and debuff.shadowflame[units.dyn40].remain < getCastTime(spell.shadowbolt) + travelTime then
                    if cast.shadowflame() then return end
                end
            end
    -- Service Pet
            if talent.grimoireOfService and br.timer:useTimer("castGrim", gcd) then
                local grimoirePet = getOptionValue(LC_GRIMOIRE_OF_SERVICE)
                if grimoirePet == 1 then
                    if cast.grimoireFelguard() then return end
                end
                if grimoirePet == 2 then
                    if cast.grimoireImp() then return end
                end
                if grimoirePet == 3 then
                    if cast.grimoireFelhunter() then return end
                end
                if grimoirePet == 4 then
                    if cast.grimoireVoidwalker() then return end
                end
                if grimoirePet == 5 then
                    if cast.grimoireSuccubus() then return end
                end
            end
    -- Summon Doomguard
        --summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<3&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
            if not talent.grimoireOfSupremacy and (ttd("target") > 180 or getHP("target") <=20 or ttd("target") < 30) and #enemies.yards10t < 3 then
                if cast.summonDoomguard() then return end
            end
    -- Summon Infernal
        --summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>=3
            if not talent.grimoireOfSupremacy and #enemies.yards10t >= 3 then
                if cast.summonInfernal() then return end
            end
    -- Summon Doomguard
        -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<3&equipped.132379&!cooldown.sindorei_spite_icd.remains
    -- Summon Infernal
        -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>=3&equipped.132379&!cooldown.sindorei_spite_icd.remains
    -- Call Dreadstalkers
        -- call_dreadstalkers,if=!talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)
            if not (hasEquiped(132393) and buff.demonicCalling.exists and (shards >= 4 or shards >= 3 and getCastTime(spell.callDreadstalkers) > nextShard)) 
                and not talent.summonDarkglare 
                and (not talent.implosion or #enemies.yards10t < 3)
            then
                if cast.callDreadstalkers() then return end
            end
    -- Hand of Guldan
        -- hand_of_guldan,if=soul_shard>=4&!talent.summon_darkglare.enabled
            if (lastSpell ~= spell.handOfGuldan 
                and (shards >= 4 or shards >= 3 and getCastTime(spell.handOfGuldan) > nextShard) 
                and not talent.summonDarkglare)
            then
                if cast.handOfGuldan() then return end
            end
    -- Summon Darkglare
        -- summon_darkglare,if=prev_gcd.hand_of_guldan
        -- summon_darkglare,if=prev_gcd.call_dreadstalkers
        -- summon_darkglare,if=cooldown.call_dreadstalkers.remains>5&soul_shard<3
        -- summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=3
        -- summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=1&buff.demonic_calling.react
            if talent.summonDarkglare and (lastSpell == spell.callDreadstalkers 
                or lastSpell == spell.handOfGuldan 
                or (cd.callDreadstalkers > 5 and shards < 3)
                or (cd.callDreadstalkers <= getCastTime(spell.summonDarkglare) and shards >=3)
                or (cd.callDreadstalkers <= getCastTime(spell.summonDarkglare) and shards >=1 and buff.demonicCalling.exists))
            then
                if cast.summonDarkglare() then return end
            end
    -- Call Dreadstalkers
        -- call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains>2
        -- call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&prev_gcd.summon_darkglare
        -- call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=3
        -- call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=1&buff.demonic_calling.react
            if talent.summonDarkglare and not (hasEquiped(132393) and buff.demonicCalling.exists and (shards >= 4 or shards >= 3 and getCastTime(spell.callDreadstalkers) > nextShard)) and (#enemies.yards10t < 3 or not talent.implosion) and (
                cd.summonDarkglare >2
                or lastSpell == spell.summonDarkglare
                or cd.summonDarkglare <= getCastTime(spell.callDreadstalkers) and shards == 3
                or cd.summonDarkglare <= getCastTime(spell.callDreadstalkers) and shards >=1 and buff.demonicCalling.exists)
            then
                if cast.callDreadstalkers() then return end
            end
    -- Hand of Guldan
        -- hand_of_guldan,if=soul_shard>=3&prev_gcd.call_dreadstalkers
        -- hand_of_guldan,if=soul_shard>=5&cooldown.summon_darkglare.remains<=action.hand_of_guldan.cast_time
        -- hand_of_guldan,if=soul_shard>=4&cooldown.summon_darkglare.remains>2
            if lastSpell ~= spell.handOfGuldan and talent.summonDarkglare and (shards >= 3 and lastSpell == spell.callDreadstalkers 
                or shards >= 5 and cd.summonDarkglare < getCastTime(spell.handOfGuldan)
                or (shards >= 4 or shards >= 3 and getCastTime(spell.handOfGuldan) > nextShard) and cd.summonDarkglare > 2)
            then
                if cast.handOfGuldan() then return end
            end
    -- demonic_empowerment
        -- demonic_empowerment,if=wild_imp_no_de>3|prev_gcd.hand_of_guldan
        -- demonic_empowerment,if=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0
            if lastSpell ~= spell.demonicEmpowerment 
                and (cd.callDreadstalkers > getCastTime(spell.demonbolt) and (shards >= 2 or buff.demonicCalling))
                and (petPool.noDEcount.wildImp > 3 or lastSpell == spell.handOfGuldan or petPool.noDEcount.others > 0) 
            then
                if cast.demonicEmpowerment() then return end
            end
    -- Felstorm
        -- felguard:felstorm
            if cd.Felstorm == 0 and petPool.useFelstorm then
                if cast.commandDemon() then return end
            end
    -- Doom
        -- doom,cycle_targets=1,if=!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3)
            if not talent.handOfDoom then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    local doom = debuff.doom[thisUnit]
                    local unitTTD = ttd(thisUnit)
                    if doom ~= nil then
                        if (not doom.exists and unitTTD > 20 / (1+hasteAmount)) or (unitTTD > doom.duration and doom.refresh) then
                            if cast.doom(thisUnit) then return end
                        end
                    end
                end
            end
    -- Cooldowms
            if actionList_Cooldowns() then return end
    -- Shadowflame
        -- shadowflame,if=charges=2
            if charges.shadowflame == 2 then 
                if cast.shadowflame() then return end
            end
    -- Thal'kiel's Consumption
        -- thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&wild_imp_count>3&wild_imp_remaining_duration>execute_time
            if (petPool.remain.dreadStalkers > getCastTime(spell.thalkielsConsumption) or (talent.implosion and #enemies.yards8t >= 3)) 
                and petPool.count.wildImp > 3 and petPool.remain.wildImp > getCastTime(spell.thalkielsConsumption) 
                and petPool.noDEcount.others + petPool.noDEcount.wildImp == 0
            then
                if cast.thalkielsConsumption() then return end
            end
    -- Life Tap
        -- life_tap,if=mana.pct<=30
            if manaPercent <= 30 then
                if cast.lifeTap() then return end
            end
    -- Demonwrath
        -- demonwrath,chain=1,interrupt=1,if=spell_targets.demonwrath>=3
        -- demonwrath,moving=1,chain=1,interrupt=1
            if petPool.demonwrathPet or moving then
                if cast.demonwrath() then return end
            end
    -- Demonbolt/Shadow Bolt
        -- demonbolt
        -- shadow_bolt
            if talent.demonbolt then
                if cast.demonbolt() then return end
            else 
                if cast.shadowbolt() then return end
            end
    -- Life Tap
        -- life_tap
            if manaPercent < 70 then
                if cast.lifeTap() then return end
            end
        end
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if pause() or mode.rotation==4 then
            if not pause() then
                PetFollow()
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
            if inCombat and not IsMounted() and isValidUnit(units.dyn40) then
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
local id = 266
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})