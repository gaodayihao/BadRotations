local rotationName = "Ellis" -- Appears in the dropdown of the rotation selector in the Profile Options window

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.bladeFlurry },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.bladeFlurry },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.saberSlash },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.crimsonVial }
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.adrenalineRush },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.adrenalineRush },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.adrenalineRush }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.riposte },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.riposte }
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
        -- Marked For Death
            br.ui:createCheckbox(section,LC_MARKED_FOR_DEATH)
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
        -- Vanish
            br.ui:createCheckbox(section,LC_VANISH)
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
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
        -- Kick
            br.ui:createCheckbox(section,LC_KICK)
        -- Gouge
            br.ui:createCheckbox(section,LC_GOUGE)
        -- Blind
            br.ui:createCheckbox(section,LC_BLIND)
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
        local debuff                                                        = br.player.debuff
        local enemies                                                       = br.player.enemies
        local energy                                                        = br.player.power.energy
        local energyTTM                                                     = br.player.power.ttm
        local forceAOE                                                      = br.player.mode.rotation == 2
        local forceSingle                                                   = br.player.mode.rotation == 3
        local gcd                                                           = br.player.gcd
        local hastar                                                        = ObjectExists("target")
        local healPot                                                       = getHealthPot()
        local inCombat                                                      = br.player.inCombat or lastSpellCast == br.player.spell.vanish 
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
        local useVanish                                                     = isChecked(LC_VANISH) and useCDs
        local playerStealth                                                 = buff.stealth.exists or buff.vanish.exists

        local debuff_curseOfTheDreadblades_exists                           = UnitDebuffID("player",spell.debuffs.curseOfTheDreadblades,"player") ~= nil
        local shivarranSymmetry                                             = 141321
        local thraxisTricksyTreads                                          = 137031
        local greenskinsWaterloggedWristcuffs                               = 137099
        local hasBladeFlurryEnemies                                         = forceAOE or (#enemies.yards8t >= 2 and not forceSingle)
        local broadsidesPoint = 0 if buff.broadsides.exists then broadsidesPoint = 1 end
        local quickDrawPoint = 0 if talent.quickDraw then quickDrawPoint = 1 end
        local anticipationPoint = 0 if talent.anticipation then anticipationPoint = 1 end

        if delayHack == nil then delayHack = 0 end

        if isChecked(LC_ARTIFACT) then
            if getOptionValue(LC_ARTIFACT) == 1 then
                useArtifact = artifact.curseOfTheDreadblades
            else
                useArtifact = useCDs and artifact.curseOfTheDreadblades
            end
        end


        buff.rollTheBones.count    = 0
        buff.rollTheBones.duration = 0
        buff.rollTheBones.remain   = 0 
        for k,v in pairs(spell.buffs.rollTheBones) do
            if UnitBuffID("player",v) ~= nil then
                buff.rollTheBones.count    = buff.rollTheBones.count + 1
                buff.rollTheBones.duration = getBuffDuration("player",v)
                buff.rollTheBones.remain   = getBuffRemain("player",v)
            end
        end

        -- All rtb buffs
        --   buffs.broadsides,
        --   buffs.buried_treasure,
        --   buffs.grand_melee,
        --   buffs.jolly_roger,
        --   buffs.shark_infested_waters,
        --   buffs.true_bearing

        -- variable,name=rtb_reroll,value=!talent.slice_and_dice.enabled&(rtb_buffs<=1&!rtb_list.any.6&((!buff.curse_of_the_dreadblades.up&!buff.adrenaline_rush.up)|!rtb_list.any.5))
        -- Condition to continue rerolling RtB (2- or not TB alone or not SIW alone during CDs); If SnD: consider that you never have to reroll.
        local rtbReroll = false
        if not talent.sliceAndDice 
            and (buff.rollTheBones.count <= 1 
                and not buff.trueBearing.exists 
                and ((not debuff_curseOfTheDreadblades_exists and not buff.adrenalineRush.exists) or not buff.sharkInfestedWaters.exists))
        then
            rtbReroll = true
        end

        -- variable,name=ss_useable_noreroll,value=(combo_points<5+talent.deeper_stratagem.enabled-(buff.broadsides.up|buff.jolly_roger.up)-(talent.alacrity.enabled&buff.alacrity.stack<=4))
        -- Condition to use Saber Slash when not rerolling RtB or when using SnD
        local ssUseableNoreroll = false
        local deeperStratagemPoint = 0 if talent.deeperStratagem then deeperStratagemPoint = 1 end
        local bsOrjrPoint = 0 if buff.broadsides.exists or buff.jollyRoger.exists then bsOrjrPoint = 1 end
        local alacrityPoint = 0 if talent.alacrity and buff.alacrity.stack <= 4 then alacrityPoint = 1 end
        if comboPoints.amount < 5 + deeperStratagemPoint - bsOrjrPoint - alacrityPoint then
            ssUseableNoreroll = true
        end

        -- variable,name=ss_useable,value=(talent.anticipation.enabled&combo_points<4)|(!talent.anticipation.enabled&((variable.rtb_reroll&combo_points<4+talent.deeper_stratagem.enabled)|(!variable.rtb_reroll&variable.ss_useable_noreroll)))
        -- Condition to use Saber Slash, when you have RtB or not
        local ssUseable = false
        if (talent.anticipation and comboPoints.amount < 4)
            or (not talent.anticipation and ((rtbReroll and comboPoints.amount < 4 + deeperStratagemPoint) or (not rtbReroll and ssUseableNoreroll)))
        then
            ssUseable = true
        end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
            if isChecked(LC_STEALTH) and not inCombat and not playerStealth then
                if getOptionValue(LC_STEALTH) == 1 or (UnitCanAttack("player","target") and not UnitIsDeadOrGhost("target")) then
                    if cast.stealth() then return true end
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
            end
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() and br.timer:useTimer("Interrupts",1.5) then
                local interruptAt = getOptionValue(LC_INTERRUPTS_AT)
                for i = 1, #enemies.yards15 do
                    local thisUnit = enemies.yards15[i]
                    local distance = getDistance(thisUnit)
                    if canInterrupt(thisUnit,interruptAt) then
                    -- Arcane Torrent
                        if isChecked(LC_ARCANE_TORRENT) and race == "BloodElf" and getSpellCD(racial) == 0 and distance <=8 then
                            if castSpell("player",racial,false,false,false) then return true end
                        end
                    -- Kick
                        if isChecked(LC_KICK) and distance <=5 and getFacing("player",thisUnit) then
                            if cast.kick(thisUnit) then return true end
                        end
                    -- Blind
                        if isChecked(LC_BLIND) and distance <=15 and getFacing("player",thisUnit) and not isBoss(thisUnit) then
                            if cast.blind(thisUnit) then return true end
                        end
                    -- Gouge
                        if isChecked(LC_GOUGE) and distance <=5 and getFacing("player",thisUnit) and not isBoss(thisUnit) then
                            if cast.gouge(thisUnit) then return true end
                        end
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
            if useCDs and isChecked(LC_RACIAL) then
                if (race == "Orc" or race == "Troll" or (race == "BloodElf" and energy.deficit > 40)) 
                    and getSpellCD(racial) == 0 
                    and castSpell("player",racial,true,false) 
                then 
                    return true
                end
            end
        -- Cannonball Barrage
            -- cannonball_barrage,if=spell_targets.cannonball_barrage>=1
            if useCDs and talent.cannonballBarrage --[[and #enemies.yards5t >= 1]] then
                if cast.cannonballBarrage() then return true end
            end
        -- Adrenaline Rush
            -- adrenaline_rush,if=!buff.adrenaline_rush.up&energy.deficit>0
            if useCDs and not buff.adrenalineRush.exists and energy.deficit > 0 then 
                if cast.adrenalineRush() then return true end
            end
        -- Marked For Death
            -- marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit|((raid_event.adds.in>40|buff.true_bearing.remains>15)&combo_points.deficit>=4+talent.deeper_strategem.enabled+talent.anticipation.enabled)
            if isChecked(LC_MARKED_FOR_DEATH) and cd.markedForDeath == 0 then
                local theEnemies = enemies.yards30
                table.sort(theEnemies,function(a,b) 
                    return ttd(a) < ttd(b) 
                end)
                local thisUnit = theEnemies[1]
                if thisUnit ~= nil and ttd(thisUnit) < comboPoints.deficit or (comboPoints.deficit >=4 + deeperStratagemPoint + anticipationPoint and not debuff_curseOfTheDreadblades_exists) then
                    if cast.markedForDeath(thisUnit) then return true end
                end
            end
        -- Sprint
            -- sprint,if=equipped.thraxis_tricksy_treads&!variable.ss_useable
            if useCDs and hasEquiped(thraxisTricksyTreads) and not ssUseable then
                if cast.sprint() then return true end
            end
        -- Curse Of The Dreadblades
            -- curse_of_the_dreadblades,if=combo_points.deficit>=4&(!talent.ghostly_strike.enabled|debuff.ghostly_strike.up)
            if useArtifact and comboPoints.deficit >= 4 and (not talent.ghostlyStrike or debuff.ghostlyStrike["target"].exists) then
                if cast.curseOfTheDreadblades() then return true end
            end
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
        end -- End Action List - PreCombat
    -- Action List - Opener
        local function actionList_Opener()
        -- Start Attack
            if not playerStealth and getDistance(units.dyn5) <= 5 then StartAttack() end
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
    -- Action List - Blade Flurry
        local function actionList_BladeFlurry()
        -- Blade Flurry
            -- actions.bf=cancel_buff,name=blade_flurry,if=equipped.shivarran_symmetry&cooldown.blade_flurry.up&buff.blade_flurry.up&spell_targets.blade_flurry>=2|spell_targets.blade_flurry<2&buff.blade_flurry.up
            if (hasEquiped(shivarranSymmetry) and cd.bladeFlurry == 0 and buff.bladeFlurry.exists and hasBladeFlurryEnemies)
                or (not hasBladeFlurryEnemies and buff.bladeFlurry.exists)
            then
                CancelUnitBuffID("player", spell.bladeFlurry)
                delayHack = getOptionValue(LC_ROTATION_TPS) / 4
                return true
            end
            -- actions.bf+=/blade_flurry,if=spell_targets.blade_flurry>=2&!buff.blade_flurry.up
            if hasBladeFlurryEnemies and not buff.bladeFlurry.exists then
                if cast.bladeFlurry() then delayHack = getOptionValue(LC_ROTATION_TPS) / 4 return true end
            end
        end -- End Action List - Blade Flurry
    -- Action List - Builders
        local function actionList_Builders()
        -- Ghostly Strike
            -- ghostly_strike,if=combo_points.deficit>=1+buff.broadsides.up&!buff.curse_of_the_dreadblades.up&(debuff.ghostly_strike.remains<debuff.ghostly_strike.duration*0.3|(cooldown.curse_of_the_dreadblades.remains<3&debuff.ghostly_strike.remains<14))&(combo_points>=3|(variable.rtb_reroll&time>=10))
            if talent.ghostlyStrike 
                and comboPoints.deficit >=1 + broadsidesPoint 
                and not debuff_curseOfTheDreadblades_exists 
                and (debuff.ghostlyStrike[units.dyn5].refresh or (cd.curseOfTheDreadblades < 3 and debuff.ghostlyStrike[units.dyn5].remain < 14)) and (comboPoints.amount >= 3 or (rtbReroll and combatTime >= 10)) 
            then
                if cast.ghostlyStrike() then return true end
            end
        -- Pistol Shot
            -- pistol_shot,if=combo_points.deficit>=1+buff.broadsides.up&buff.opportunity.up&(energy.time_to_max>2-talent.quick_draw.enabled|(buff.blunderbuss.up&buff.greenskins_waterlogged_wristcuffs.up))
            if comboPoints.deficit >=1 + broadsidesPoint and buff.opportunity.exists and (energyTTM > 2 - quickDrawPoint or (cast.blunderbuss(nil,"debug") and buff.greenskinsWaterloggedWristcuffs.exists)) then
                if cast.pistolShot() then return true end
            end
        -- Saber Slash
            -- saber_slash,if=variable.ss_useable
            if ssUseable then
                if cast.saberSlash() then return true end
            end
        end -- End Action List - Builders
    -- Action List - Finishers
        local function actionList_Finishers()
        -- Between The Eyes
            -- between_the_eyes,if=equipped.greenskins_waterlogged_wristcuffs&!buff.greenskins_waterlogged_wristcuffs.up
            if hasEquiped(greenskinsWaterloggedWristcuffs) and not buff.greenskinsWaterloggedWristcuffs.exists then
                if cast.betweenTheEyes() then return true end
            end
        -- run_through,if=!talent.death_from_above.enabled|energy.time_to_max<cooldown.death_from_above.remains+3.5
            if not talent.deathFromAbove or energyTTM < cd.deathFromAbove + 3.5 then
                if cast.runThrough() then return true end
            end
        end -- End Action List - Finishers
    -- ACtion List - Stealth
        local function actionList_Stealth()
        -- Variable
            -- variable,name=stealth_condition,value=(combo_points.deficit>=2+2*(talent.ghostly_strike.enabled&!debuff.ghostly_strike.up)+buff.broadsides.up&energy>60&!buff.jolly_roger.up&!buff.hidden_blade.up&!buff.curse_of_the_dreadblades.up)
            -- Condition to use stealth abilities
            local ghostlyStrikePoint = 0
            local otherPoint = 0
            if talent.ghostlyStrike and not debuff.ghostlyStrike[units.dyn5].exists then ghostlyStrikePoint = 1 end
            if buff.broadsides.exists and energy.amount > 60 and not buff.jollyRoger.exists and not buff.hiddenBlade.exists and not debuff_curseOfTheDreadblades_exists then
                otherPoint = 1
            end
            local stealthCondition = false
            if comboPoints.deficit >=2 + 2* ghostlyStrikePoint + otherPoint and not hasOffensiveBuffs("player") then
                stealthCondition = true
            end
        -- Ambush
            -- ambush
            if playerStealth and cast.ambush() then return true end
        -- Vanish
            -- vanish,if=variable.stealth_condition
            if useVanish 
                and cd.vanish == 0
                and (not solo or isDummy(units.dyn5))
                and isBoss()
                and stealthCondition
            then
                if energy.amount < 60 then return true end
                if cast.vanish() then delayHack = getOptionValue(LC_ROTATION_TPS)/2 return true end
            end
        -- Shadowmeld
            -- shadowmeld,if=variable.stealth_condition
            if not solo 
                and isBoss()
                and stealthCondition
                and useCDs
                and isChecked(LC_RACIAL)
                and race == "NightElf"
                and not buff.vanish.exists 
                and cd.vanish ~= 0 
                and not isMoving("player") 
                and getSpellCD(racial)==0
            then
                if castSpell("player",racial,true,false) then delayHack = getOptionValue(LC_ROTATION_TPS)/2 return true end
            end
        end -- End Action List - Stealth
---------------------
--- Begin Profile ---
---------------------
    -- Pause
        local isPause = pause()
        if isPause or mode.rotation==4 or IsMounted() or delayHack > 0 then
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
                if actionList_BladeFlurry() then return end
               
                if actionList_Cooldowns() then return end
                -- call_action_list,name=stealth,if=stealthed.rogue|cooldown.vanish.up|cooldown.shadowmeld.up
                if playerStealth or cd.vanish == 0 or (race == "NightElf" and not buff.vanish.exists and cd.vanish ~= 0 and not isMoving("player") and getSpellCD(racial)==0) then
                    if actionList_Stealth() then return end
                end
            -- Death From Above
                -- death_from_above,if=energy.time_to_max>2&!variable.ss_useable_noreroll
                if energyTTM > 2 and not ssUseableNoreroll then
                    if cast.deathFromAbove() then return end
                end
            -- SnD
                -- slice_and_dice,if=!variable.ss_useable&buff.slice_and_dice.remains<target.time_to_die&buff.slice_and_dice.remains<(1+combo_points)*1.8
                if talent.sliceAndDice and not ssUseable and buff.sliceAndDice.remain < ttd(units.dyn5) and buff.sliceAndDice.remain < (1 + comboPoints.amount) * 1.8 then
                    if cast.sliceAndDice() then return true end
                end
            -- RtB
                -- roll_the_bones,if=!variable.ss_useable&buff.roll_the_bones.remains<target.time_to_die&(buff.roll_the_bones.remains<=3|variable.rtb_reroll)
                if not ssUseable and buff.rollTheBones.remain < ttd(units.dyn5) and (buff.rollTheBones.remain <= 3 or rtbReroll) then
                    if cast.rollTheBones() then return true end
                end
            -- Killing Spree
                -- killing_spree,if=energy.time_to_max>5|energy<15
                if energyTTM > 5 or energy.amount < 15 then
                    if cast.killingSpree() then return end
                end
                -- call_action_list,name=build
                if actionList_Builders() then return end
                -- call_action_list,name=finish,if=!variable.ss_useable
                if not ssUseable and actionList_Finishers() then return end
                --gouge,if=talent.dirty_tricks.enabled&combo_points.deficit>=1
                --Gouge is used as a CP Generator while nothing else is available and you have Dirty Tricks talent. It's unlikely that you'll be able to do this optimally in-game since it requires to move in front of the target, but it's here so you can quantifiy its value.
                if talent.dirtyTricks and comboPoints.deficit >= 1 then
                    if cast.gouge() then return end
                end
            end -- End In Combat
        end -- End Profile
    --end -- Timer
end -- runRotation
local id = 260
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})