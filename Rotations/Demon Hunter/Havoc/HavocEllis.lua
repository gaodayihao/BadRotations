local rotationName = "Ellis" -- Appears in the dropdown of the rotation selector in the Profile Options window

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.bladeDance},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.bladeDance},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.chaosStrike},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.spectralSight}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.metamorphosis},
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.metamorphosis},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.metamorphosis}
    };
   	CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.darkness},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.darkness}
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.consumeMagic},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.consumeMagic}
    };
    CreateButton("Interrupt",4,0)
-- Mover
    MoverModes = {
        [1] = { mode = "AC", value = 1 , overlay = "Movement Animation Cancel Enabled", tip = "Will Cancel Movement Animation.", highlight = 1, icon = br.player.spell.felRush},
        [2] = { mode = "On", value = 2 , overlay = "Auto Movement Enabled", tip = "Will Cast Movement Abilities.", highlight = 0, icon = br.player.spell.felRush},
        [3] = { mode = "Off", value = 3 , overlay = "Auto Movement Disabled", tip = "Will NOT Cast Movement Abilities.", highlight = 0, icon = br.player.spell.felRush}
    };
    CreateButton("Mover",5,0)
-- Pooling For ChaosStrike
    PoolingForChaosStrikeModes = {
        [1] = { mode = "Off", value = 1 , overlay = "Pooling For Chaos Strike Disabled", tip = "Use Chaos Strike.", highlight = 1, icon = br.player.spell.chaosStrike},
        [2] = { mode = "On", value = 2 , overlay = "Pooling For Chaos Strike Enabled", tip = "Pooling For Chaos Strike.", highlight = 0, icon = br.player.spell.talents.demonBlades}
    };
    CreateButton("PoolingForChaosStrike",6,0)
-- Fury Of The Illidari
    FuryOfTheIllidariModes = {
        [1] = { mode = "On", value = 1 , overlay = "Fury Of The Illidari Enabled", tip = "Fury Of The Illidari Used.", highlight = 1, icon = br.player.spell.furyOfTheIllidari},
        [2] = { mode = "Off", value = 2 , overlay = "Fury Of The Illidari Disabled", tip = "Disable Fury Of The Illidari.", highlight = 0, icon = br.player.spell.furyOfTheIllidari}
    };
    CreateButton("FuryOfTheIllidari",7,0)
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
            br.ui:createDropdownWithout(section, LC_ARTIFACT, {LC_ARTIFACT_EVERY_TIME,LC_ARTIFACT_CD}, 1)
        -- Enemies For AOE
            br.ui:createSpinnerWithout(section, LC_ENEMIES_FOR_AOE,  3,  2,  10,  1,  LC_ENEMIES_FOR_AOE_HDH)
            -- LC_ENEMIES_FOR_AOE
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_COOLDOWNS)
        -- Racial
            br.ui:createCheckbox(section,LC_RACIAL,LC_RACIAL_DESCRIPTION)
        -- Trinkets
            br.ui:createCheckbox(section,LC_TRINKETS,LC_TRINKETS_DESCRIPTION)
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_DEFENSIVE)
            -- Healthstone
            br.ui:createSpinner(section, LC_POT_STONED,  60,  0,  100,  5,  LC_POT_STONED_DESCRIPTION)
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
        -- Consume Magic
            br.ui:createCheckbox(section,LC_CONSUME_MAGIC)
        -- Chaos Nova
            br.ui:createCheckbox(section,LC_CHAOS_NOVA)
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
    --if br.timer:useTimer("debugRetribution", math.random(0.15,0.3)) then -- Change debugSpec tp name of Spec IE: debugFeral or debugWindwalker
        --print("Running: "..rotationName)
---------------
--- Toggles ---
---------------
        br.player.mode.mover = br.data.settings[br.selectedSpec].toggles["Mover"]
        br.player.mode.poolingForChaosStrike = br.data.settings[br.selectedSpec].toggles["PoolingForChaosStrike"]
        br.player.mode.furyOfTheIllidari = br.data.settings[br.selectedSpec].toggles["FuryOfTheIllidari"]
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
        local debuff                                                        = br.player.debuff
        local enemies                                                       = br.player.enemies
        local energyTTM                                                     = br.player.power.ttm
        local forceAOE                                                      = br.player.mode.rotation == 2
        local forceSingle                                                   = br.player.mode.rotation == 3
        local gcd                                                           = br.player.gcd
        local hastar                                                        = ObjectExists("target")
        local healPot                                                       = getHealthPot()
        local inCombat                                                      = br.player.inCombat or lastSpellCast == br.player.spell.vanish 
        local inInstance                                                    = br.player.instance=="party"
        local inRaid                                                        = br.player.instance=="raid"
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
        local fury                                                          = br.player.power.fury
        
        if delayHack == nil then delayHack = 0 end

        if mode.furyOfTheIllidari == 1 then
            if getOptionValue(LC_ARTIFACT) == 1 then
                useArtifact = artifact.furyOfTheIllidari
            else
                useArtifact = useCDs and artifact.furyOfTheIllidari
            end
        end

        -- variable,name=pooling_for_meta,value=cooldown.metamorphosis.ready&(!talent.demonic.enabled|!cooldown.eye_beam.ready)&(!talent.chaos_blades.enabled|cooldown.chaos_blades.ready)&(!talent.nemesis.enabled|debuff.nemesis.up|cooldown.nemesis.ready)
        -- "Getting ready to use meta" conditions, this is used in a few places.
        local poolingForMeta = false
        if cd.metamorphosis == 0 
            and (not talent.demonic or cd.eyeBeam > 0) 
            and (not talent.chaosBlades or cd.chaosBlades == 0) 
            and (not talent.nemesis or debuff.nemesis[units.dyn5].exists or cd.nemesis == 0)
            and useCDs
        then
            poolingForMeta = true
        end

        -- variable,name=blade_dance,value=talent.first_blood.enabled|spell_targets.blade_dance1>=3+(talent.chaos_cleave.enabled*2)
        -- Blade Dance conditions. Always if First Blood is talented, otherwise 5+ targets with Chaos Cleave or 3+ targets without.
        local bladeDanceVar = false
        local chaosCleavePoint = 0 if talent.chaosCleave then chaosCleavePoint = 1 end
        if talent.firstBlood or (forceAOE or #enemies.yards8 >= getOptionValue(LC_ENEMIES_FOR_AOE) + chaosCleavePoint * 2 and not forceSingle) then
            bladeDanceVar = true
        end

        -- variable,name=pooling_for_blade_dance,value=variable.blade_dance&fury-40<35-talent.first_blood.enabled*20&(spell_targets.blade_dance1>=3+(talent.chaos_cleave.enabled*2))
        -- Blade Dance pooling condition, so we don't spend too much fury when we need it soon. No need to pool on # single target since First Blood already makes it cheap enough and delaying it a tiny bit isn't a big deal.
        local poolingForBladeDance = false
        local firstBloodPoint = 0 if talent.firstBlood then firstBloodPoint = 1 end
        if bladeDanceVar and fury.amount - 40 < 35 - firstBloodPoint * 20 and (forceAOE or #enemies.yards8 >= getOptionValue(LC_ENEMIES_FOR_AOE) + chaosCleavePoint * 2 and not forceSingle) then
            poolingForBladeDance = true
        end

        -- variable,name=pooling_for_chaos_strike,value=talent.chaos_cleave.enabled&fury.deficit>40&!raid_event.adds.up&raid_event.adds.in<2*gcd
        -- Chaos Strike pooling condition, so we don't spend too much fury when we need it for Chaos Cleave AoE
        local poolingForChaosStrikeVar = talent.chaosCleave and mode.poolingForChaosStrike == 2 and not hasFacingUnits("player",enemies.yards5,120,2)

        local preparedPoint = 0 if buff.prepared.exists then preparedPoint = 1 end
        
        -- Custom Functions
        local function cancelRushAnimation()
            if cast.felRush(nil,"debug") then 
                MoveBackwardStart()
                JumpOrAscendStart()
                local sucess = cast.felRush()
                MoveBackwardStop()
                AscendStop()
                if sucess then return true end
            end
            return
        end

        local function felRushEx()
            if mode.mover == 1 and getDistance("target") < 5 then
                if cancelRushAnimation() then return true end
            elseif (mode.mover == 2 or (getDistance("target") >= 5 and mode.mover ~= 3)) and getDistance("target") <= 20 then
                if cast.felRush() then return true end
            end
            return false
        end

        local function vengefulRetreatEx()
                if cast.vengefulRetreat() then delayHack = getOptionValue(LC_ROTATION_TPS) return true end
            return false
        end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
        
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
            end
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() and br.timer:useTimer("Interrupts",1.5) then
                local interruptAt = getOptionValue(LC_INTERRUPTS_AT)
                for i = 1, #enemies.yards20 do
                    local thisUnit = enemies.yards20[i]
                    local distance = getDistance(thisUnit)
                    if canInterrupt(thisUnit,interruptAt) then
                    -- Consume Magic
                        if isChecked(LC_CONSUME_MAGIC) and distance <= 20 then
                            if cast.consumeMagic(thisUnit) then return end
                        end
                    -- Chaos Nova
                        if isChecked(LC_CHAOS_NOVA) and distance <= 5 and not isBoss(thisUnit) then
                            if cast.chaosNova() then return end
                        end
                    -- Arcane Torrent
                        if isChecked(LC_ARCANE_TORRENT) and race == "BloodElf" and getSpellCD(racial) == 0 and distance <=8 then
                            if castSpell("player",racial,false,false,false) then return true end
                        end
                    end
                end
            end
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
        -- Nemesis
            -- nemesis,target_if=min:target.time_to_die,if=raid_event.adds.exists&debuff.nemesis.down&((active_enemies>desired_targets&active_enemies>1)|raid_event.adds.in>60)
            -- nemesis,if=!raid_event.adds.exists&(cooldown.metamorphosis.remains>100|target.time_to_die<70)
            -- nemesis,sync=metamorphosis,if=!raid_event.adds.exists
            if talent.nemesis and useCDs and (lastSpell == spell.metamorphosis or cd.metamorphosis > 100 or ttd("target") < 70) then
                if cast.nemesis() then return true end
            end
        -- Chaos Blades
            -- chaos_blades,if=buff.metamorphosis.up|cooldown.metamorphosis.remains>100|target.time_to_die<20
            if talent.chaosBlades and useCDs and buff.metamorphosis.exists or cd.metamorphosis > 100 or ttd("target") < 20 then
                if cast.chaosBlades() then return true end
            end
        -- Metamorphosis
            -- metamorphosis,if=variable.pooling_for_meta&fury.deficit<30
            if useCDs and poolingForMeta and fury.deficit < 30 then
                if cast.metamorphosis() then return true end
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
            local theEnemies = enemies.yards5
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
        local function actionList_Simc()
        -- Blur
            -- blur,if=artifact.demon_speed.enabled&cooldown.fel_rush.charges_fractional<0.5&cooldown.vengeful_retreat.remains-buff.momentum.remains>4
            if talent.momentum and artifact.demonSpeed and charges.frac.felRush < 0.5 and cd.vengefulRetreat - buff.momentum.remain > 4 then
                if cast.blur() then return true end
            end
        -- Cooldowns
            -- call_action_list,name=cooldown
            if actionList_Cooldowns() then return true end
        -- Fel Rush 
            -- fel_rush,animation_cancel=1,if=time=0
            -- Fel Rush in at the start of combat.
            if combatTime < 1 then
                if felRushEx() then return true end
            end
        -- Pick Up Fragment Notification
            -- pick_up_fragment,if=talent.demonic_appetite.enabled&fury.deficit>=35
            if talent.demonicAppetite and powerDeficit >= 30 then
                ChatOverlay(LC_LOW_FURY)
            end
            -- consume_magic
        -- Vengeful Retreat
            -- vengeful_retreat,if=(talent.prepared.enabled|talent.momentum.enabled)&buff.prepared.down&buff.momentum.down
            -- Vengeful Retreat backwards through the target to minimize downtime.
            if (talent.prepared or talent.momentum) and not buff.prepared.exists and not buff.momentum.exists and getDistance(units.dyn5) <= 5 then
                if vengefulRetreatEx() then return true end
            end 
        -- Fel Rush 
            -- fel_rush,if=(talent.momentum.enabled|talent.fel_mastery.enabled)&(!talent.momentum.enabled|(charges=2|cooldown.vengeful_retreat.remains>4)&buff.momentum.down)&(!talent.fel_mastery.enabled|fury.deficit>=25)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
            -- Fel Rush for Momentum and for fury from Fel Mastery.
            if (talent.momentum or talent.felMastery) 
                and (not talent.momentum or (charges.felRush == 2 or cd.vengefulRetreat >4) and not buff.momentum.exists) 
                and (not talent.felMastery or fury.deficit >= 25) 
                and charges.felRush == 2
            then
                if felRushEx() then return true end
            end
        -- Fel Barrage
            -- fel_barrage,if=charges>=5&(buff.momentum.up|!talent.momentum.enabled)&((active_enemies>desired_targets&active_enemies>1)|raid_event.adds.in>30)
            -- Use Fel Barrage at max charges, saving it for Momentum and adds if possible.
            if talent.felBarrage 
                and charges.felBarrage >= 5 
                and (buff.momentum.exists or not talent.momentum)
                and (forceAOE or #enemies.yards8 >= getOptionValue(LC_ENEMIES_FOR_AOE) and not forceSingle)
            then
                if cast.felBarrage() then return true end
            end
        -- Throw Glaive
            -- throw_glaive,if=talent.bloodlet.enabled&(!talent.momentum.enabled|buff.momentum.up)&charges=2
            if talent.bloodlet and (not talent.momentum or buff.momentum.exists) and charges.throwGlaive == 2 then
                if cast.throwGlaive() then return true end
            end
        -- Fel Eruption
            -- fel_eruption
            if talent.felEruption and cast.felEruption() then return true end
        -- Fury Of The Illidari
            -- fury_of_the_illidari,if=(active_enemies>desired_targets&active_enemies>1)|raid_event.adds.in>55&(!talent.momentum.enabled|buff.momentum.up)
            if useArtifact 
                and (isBoss() or (inInstance and (forceAOE or #enemies.yards8 >= getOptionValue(LC_ENEMIES_FOR_AOE) and not forceSingle)) or not inInstance)
                and (not talent.momentum or buff.momentum.exists)
            then
                if cast.furyOfTheIllidari() then return true end
            end
        -- Eye Beam
            -- eye_beam,if=talent.demonic.enabled&(talent.demon_blades.enabled|talent.blind_fury.enabled|(!talent.blind_fury.enabled&fury.deficit<30))&((active_enemies>desired_targets&active_enemies>1)|raid_event.adds.in>30)
            if talent.demonic
                and (talent.demonBlades or talent.blindFury or (not talent.blindFury and fury.deficit < 30)) 
                and (forceAOE or #enemies.yards5t >= getOptionValue(LC_ENEMIES_FOR_AOE) and not forceSingle)
            then
                if cast.eyeBeam() then return true end
            end
        -- Death Sweep
            -- death_sweep,if=variable.blade_dance
            if bladeDanceVar and buff.metamorphosis.exists then
                if cast.bladeDance() then delayHack = getOptionValue(LC_ROTATION_TPS) / 5  return true end
            end
        -- Blade Dance
            -- blade_dance,if=variable.blade_dance
            if bladeDanceVar and not buff.metamorphosis.exists and cast.bladeDance() then delayHack = getOptionValue(LC_ROTATION_TPS) / 5  return true end
        -- Throw Glaive
            -- throw_glaive,if=talent.bloodlet.enabled&spell_targets>=2&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&(spell_targets>=3|raid_event.adds.in>recharge_time+cooldown)
            if talent.bloodlet
                and (forceAOE or not forceSingle and #enemies.yards5t >= 2)
                and (not talent.mastersOfTheGlaive or not talent.momentum or buff.momentum.exists)
            then
                if cast.throwGlaive() then return true end
            end
        -- Felblade
            -- felblade,if=fury.deficit>=30+buff.prepared.up*8
            if talent.felblade and fury.deficit >= 30 + preparedPoint * 8 then
                if cast.felblade() then return true end
            end
        -- Eye Beam
            -- eye_beam,if=talent.blind_fury.enabled&(spell_targets.eye_beam_tick>desired_targets|fury.deficit>=35)
            if talent.blindFury and (forceAOE or (#enemies.yards5t >= getOptionValue(LC_ENEMIES_FOR_AOE) and not forceSingle) or fury.deficit >= 35) then
                if cast.eyeBeam() then return true end
            end
        -- Annihilation
            -- annihilation,if=(talent.demon_blades.enabled|!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance
            if buff.metamorphosis.exists 
                and (talent.demonBlades or not talent.momentum or buff.momentum.exists or fury.deficit < 30 + preparedPoint * 8 or buff.metamorphosis.remain < 5) 
                and not poolingForBladeDance
            then
                if cast.chaosStrike() then return true end
            end
        -- Throw Glaive
            -- throw_glaive,if=talent.bloodlet.enabled&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&raid_event.adds.in>recharge_time+cooldown
            if talent.bloodlet and (not talent.mastersOfTheGlaive or not talent.momentum or buff.momentum.exists) then
                if cast.throwGlaive() then return true end
            end
        -- Eye Beam
            -- eye_beam,if=!talent.demonic.enabled&!talent.blind_fury.enabled&((spell_targets.eye_beam_tick>desired_targets&active_enemies>1)|(raid_event.adds.in>45&!variable.pooling_for_meta&buff.metamorphosis.down&(artifact.anguish_of_the_deceiver.enabled|active_enemies>1)&!talent.chaos_cleave.enabled))
            if not talent.demonic 
                and not talent.blindFury 
                and ((forceAOE or #enemies.yards5t >= getOptionValue(LC_ENEMIES_FOR_AOE) and not forceSingle) or (not poolingForMeta and not buff.metamorphosis.exists and artifact.anguishOfTheDeceiver and not talent.chaosCleave))
            then
                if cast.eyeBeam() then return true end
            end
        -- Demons Bite
            -- demons_bite,if=talent.demonic.enabled&!talent.blind_fury.enabled&buff.metamorphosis.down&cooldown.eye_beam.remains<gcd&fury.deficit>=20
            -- If Demonic is talented, pool fury as Eye Beam is coming off cooldown.
            if not talent.demonBlades and talent.demonic and not talent.blindFury and not buff.metamorphosis.exists and cd.eyeBeam < gcd and fury.deficit >= 20 then
                if cast.demonsBite() then return true end
            end
        -- Demons Bite
            -- demons_bite,if=talent.demonic.enabled&!talent.blind_fury.enabled&buff.metamorphosis.down&cooldown.eye_beam.remains<2*gcd&fury.deficit>=45
            if not talent.demonBlades and talent.demonic and not talent.blindFury and not buff.metamorphosis.exists and cd.eyeBeam < 2 * gcd and fury.deficit >= 45 then
                if cast.demonsBite() then return true end
            end
        -- Throw Glaive
            -- throw_glaive,if=buff.metamorphosis.down&spell_targets>=2
            if not buff.metamorphosis.exists and (forceAOE or not forceSingle and #enemies.yards5t >= 2) then
                if cast.throwGlaive() then return true end
            end
        -- Chaos Strike
            -- chaos_strike,if=(talent.demon_blades.enabled|!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8)&!variable.pooling_for_chaos_strike&!variable.pooling_for_meta&!variable.pooling_for_blade_dance&(!talent.demonic.enabled|!cooldown.eye_beam.ready|(talent.blind_fury.enabled&fury.deficit<35))
            if (talent.demonBlades or not talent.momentum or buff.momentum.exists or fury.deficit < 30 + preparedPoint * 8)
                and not poolingForChaosStrike and not poolingForMeta and not poolingForBladeDance
                and (not talent.demonic or cd.eyeBeam > 0 or (talent.blindFury and fury.deficit < 35))
                and not buff.metamorphosis.exists
            then
                --print(1)
                if cast.chaosStrike() then return true else end
            end
        -- Fel Barrage
            -- fel_barrage,if=charges=4&buff.metamorphosis.down&(buff.momentum.up|!talent.momentum.enabled)&((active_enemies>desired_targets&active_enemies>1)|raid_event.adds.in>30)
            -- Use Fel Barrage if its nearing max charges, saving it for Momentum and adds if possible.
            if talent.felBarrage 
                and charges.felBarrage == 4 
                and not buff.metamorphosis.exists 
                and (buff.momentum.exists or not talent.momentum)
                and (forceAOE or #enemies.yards8 >= getOptionValue(LC_ENEMIES_FOR_AOE) and not forceSingle)
            then
                if cast.felBarrage() then return true end
            end
        -- Fel Rush
            -- fel_rush,if=!talent.momentum.enabled&raid_event.movement.in>charges*10
            if not talent.momentum then
                if felRushEx() then return true end
            end
        -- Demons Bite
            -- demons_bite
            if not talent.demonBlades and cast.demonsBite() then return true end
        -- Throw Glaive
            -- throw_glaive
            if getDistance(units.dyn5) > 5 and cast.throwGlaive() then return true end
        -- Felblade
            -- felblade,if=movement.distance|buff.out_of_range.up
            if talent.felblade and getDistance(units.dyn5) > 5 and cast.felblade() then return true end
        -- Fel Rush
            -- 	fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum.enabled)
            if not talent.momentum and getDistance(units.dyn5) > 15 then
                if felRushEx() then return true end
            end
        -- Vengeful Retreat
            -- vengeful_retreat,if=movement.distance>15
            -- if getDistance(units.dyn5) > 15 then
            --     FaceDirection(-GetAnglesBetweenObjects("player", "target"), true)
            --     if cast.vengefulRetreat() then return true end
            -- end
        -- Throw Glaive
            -- throw_glaive,if=!talent.bloodlet.enabled
            if not talent.bloodlet then
                if cast.throwGlaive() then return true end
            end
        end
---------------------
--- Begin Profile ---
---------------------
    -- Pause
        local isPause = pause() or buff.bladeDance.exists
        if isPause or mode.rotation==4 or IsMounted() or delayHack >= 1 then
            if not isPause and delayHack >= 1 then
                -- Print("delayHack:"..tostring(delayHack))
                delayHack = delayHack - 1
            end
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
----------------------------------
--- In Combat - Begin Rotation ---
----------------------------------
                if actionList_Simc() then return end
            end -- End In Combat
        end -- End Profile
    --end -- Timer
end -- runRotation
local id = 577
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
