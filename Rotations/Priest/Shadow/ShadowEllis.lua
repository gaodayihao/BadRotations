if select(2, UnitClass("player")) == "PRIEST" then
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
                br.ui:createCheckbox(section, LC_AUTO_TARGET, LC_AUTO_TARGET_DESCRIPTION)
            -- Auto Facing
                br.ui:createCheckbox(section, LC_AUTO_FACING, LC_AUTO_FACING_DESCRIPTION)
            -- SWP Max Targets
                br.ui:createSpinner(section, LC_SWP_MAX_TARGETS,  6,  1,  10,  1, LC_SWP_MAX_TARGETS_DESCRIPTION)
            -- VT Max Targets
                br.ui:createSpinner(section, LC_VT_MAX_TARGETS,  3,  1,  10,  1, LC_VT_MAX_TARGETS_DESCRIPTION)
            -- VT Max Targets
                --br.ui:createSpinnerWithout(section, LC_DOT_MINIMUM_HEALTH,  3,  1,  5,  1, LC_DOT_MINIMUM_HEALTH_DESCRIPTION)
            -- Body And Soul
                br.ui:createSpinner(section, LC_BODY_AND_SOUL,  1.5,  0,  5,  0.5, LC_BODY_AND_SOUL_DESCRIPTION)
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
            local addsExist                                     = false 
            local addsIn                                        = 999
            local artifact                                      = br.player.artifact
            local autoFacing                                    = isChecked(LC_AUTO_FACING)
            local autoTarget                                    = isChecked(LC_AUTO_TARGET)
            local bodyAndSoul                                   = -1
            local buff                                          = br.player.buff
            local canFlask                                      = canUse(br.player.flask.wod.intellectBig)
            local cast                                          = br.player.cast
            local castable                                      = br.player.cast.debug
            local cd                                            = br.player.cd
            local charges                                       = br.player.charges
            local combatTime                                    = getCombatTime()
            local debuff                                        = br.player.debuff
            local dieAtNextGCD                                  = false
            local enemies                                       = br.player.enemies
            local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
            local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.intellectBig)
            local friendly                                      = friendly or UnitIsFriend("target", "player")
            local gcd                                           = br.player.gcd
            local gcdMax                                        = br.player.gcdMax
            local inCombat                                      = br.player.inCombat
            local inInstance                                    = br.player.instance=="party"
            local inRaid                                        = br.player.instance=="raid"
            local lastSpell                                     = lastSpellCast
            local lastTarget                                    = lastSpellTarget
            local level                                         = br.player.level
            local mode                                          = br.player.mode
            local perk                                          = br.player.perk        
            local php                                           = br.player.health
            local power, powmax, powgen, powerDeficit           = br.player.power, br.player.powerMax, br.player.powerRegen, br.player.powerDeficit
            local pullTimer                                     = br.DBM:getPulltimer()
            local racial                                        = br.player.getRacial()
            local recharge                                      = br.player.recharge
            local s2mcheck                                      = getOptionValue(LC_S2M_CHECK)
            local solo                                          = br.player.instance=="none"
            local spell                                         = br.player.spell
            local SWPmaxTargets                                 = getOptionValue(LC_SWP_MAX_TARGETS)
            local talent                                        = br.player.talent
            local thp                                           = getHP(br.player.units.dyn40)
            local timeToPowerInfusion                           = 60 --[[ getOptionValue(LC_TIME_TO_USE_POWER_INFUSION) ]]
            local ttd                                           = getTTD
            local units                                         = br.player.units
            local useArcaneTorrent                              = isChecked(LC_ARCANE_TORRENT)
            local useArtifact                                   = true
            local useBlessedDawnlightMedallion                  = isChecked(LC_BLESSED_DAWNLIGHT_MEDALLION)
            local useDispersion                                 = isChecked(LC_DISPERSION)
            local useMindBenderOrShadowFiend                    = isChecked(LC_MINDBENDER_SHADOWFIEND)
            local usePowerInfusion                              = isChecked(LC_POWER_INFUSION)
            local useVoidEruption                               = br.player.mode.voidEruption == 1
            local VTmaxTargets                                  = getOptionValue(LC_VT_MAX_TARGETS)

            if currentInsanityDrain == nil then currentInsanityDrain = 0 end
            if insanityDrainStacks == nil then insanityDrainStacks = 0 end
            if insanityDrainStart == nil then insanityDrainStart = 0 end
            if movingStart == nil then movingStart = 0 end
            if nAP == nil then nAP = -1 end
            if rawHastePct == nil then rawHastePct = 0 end
            if rWait == nil then rWait = 0 end  -- Rotations Wait
            if forceDelay == nil then forceDelay = false end

            if isChecked(LC_BODY_AND_SOUL) and not buff.surrenderToMadness then
                bodyAndSoul = getOptionValue(LC_BODY_AND_SOUL)
            end

            if not isChecked(LC_SWP_MAX_TARGETS) then
                SWPmaxTargets = 1
            end

            if not isChecked(LC_VT_MAX_TARGETS) then
                VTmaxTargets = 1
            end

            if isChecked(LC_ARTIFACT) then
                if getOptionValue(LC_ARTIFACT) == 1 then
                    useArtifact = true
                else
                    useArtifact = useCDs()
                end
            else
                useArtifact = false
            end
            --if leftCombat == nil then leftCombat = GetTime() end
            --if profileStop == nil then profileStop = false end
            --if IsHackEnabled("NoKnockback") ~= nil then SetHackEnabled("NoKnockback", false) end
            
    --------------------
    -- Custom Function--
    --------------------
            function usePotion()
                if isChecked(LC_POTION) and inRaid then
                    if getOptionValue(LC_POTION) == 1 and canUse(127843) and not buff.deadlyGrace then -- Deadly Grace
                        useItem(127843)
                    elseif getOptionValue(LC_POTION) == 2 and canUse(142117) and not buff.prolongedPower then -- Prolonged Power
                        useItem(142117)
                    end
                end
            end

            function nonexecuteActorsPct()
                local execute, nonexecute = getOptionValue(LC_EXECUTE_ACTORS), 0
                nonexecute = #br.friend - execute
                if execute > #br.friend then
                    execute = 1
                end
                if nonexecute < 0 then
                    nonexecute = 0
                end
                if nonexecute > 0 then
                    return execute / (execute + nonexecute)
                end
                return 0
            end

            function updateInsanityDrainStacks()
                if buff.voidForm then
                    if insanityDrainStart == 0 then
                        insanityDrainStart = GetTime()
                        insanityDrainStacks = 0
                    else
                        insanityDrainStacks = GetTime()-insanityDrainStart
                    end
                else
                    insanityDrainStart = 0
                    insanityDrainStacks = 0
                end
                currentInsanityDrain = (insanityDrainStacks-1) * 0.55 + 8
            end

            function updateRawHate()
                if br.timer:useTimer("debugUpdateRawHate", 2) then
                    if not hasBloodLust() and buff.stack.voidForm == 0 and not buff.powerInfusion then
                        rawHastePct = round2(GetHaste()/100,4)
                    end
                end
            end

            function updateTTD()
                _G["text".."ShadowWordDeath"]:SetText(round2(ttd("target"),0))
            end

            function analyzeS2M()
                if inCombat then 
                    if not isValidUnit("target") then return end
                    local targetTTD = ttd("target")
                -- variable,op=set,name=actors_fight_time_mod,value=0
                    local actorsFightTimeMod = 0
                -- variable,op=set,name=actors_fight_time_mod,value=-((-(450)+(time+target.time_to_die))%10),if=time+target.time_to_die>450&time+target.time_to_die<600
                    if combatTime + targetTTD > 450 and combatTime + targetTTD < 600 then
                        actorsFightTimeMod = -((-(450) + (combatTime + targetTTD)) % 10)
                -- variable,op=set,name=actors_fight_time_mod,value=((450-(time+target.time_to_die))%5),if=time+target.time_to_die<=450
                    elseif combatTime + targetTTD <= 450 then
                        actorsFightTimeMod = ((450 - (combatTime + targetTTD)) % 5)
                    end
                -- variable,op=set,name=s2mcheck,value=0.8*(135+((raw_haste_pct*25)*(2+(1*talent.reaper_of_souls.enabled)+(2*artifact.mass_hysteria.rank)-(1*talent.sanlayn.enabled))))-(variable.actors_fight_time_mod*nonexecute_actors_pct)
                    if nAP == -1 then
                        nAP = nonexecuteActorsPct()
                    end
                    local reaperOfSoulsNum = 0
                    local sanlarynNum = 0
                    if talent.reaperOfSouls then
                        reaperOfSoulsNum = 1
                    end
                    if talent.sanlaryn then
                        sanlarynNum = 1
                    end
                    s2mcheck = 0.8 * (130+((rawHastePct*25)*(2+(1*reaperOfSoulsNum)+(2*artifact.rank.massHysteria)-(1*sanlarynNum))))
                                -(actorsFightTimeMod*nAP)
                    --s2mcheck = s2mcheck * 0.9 -- 2016/11/15 hotfix
                -- variable,op=min,name=s2mcheck,value=180
                    s2mcheck = math.min(s2mcheck,180)
                    _G["text".."ShadowWordDeath"]:SetText(round2(targetTTD,0))
                else
                    if nAP > -1 then
                        nAP = -1
                        _G["text".."ShadowWordDeath"]:SetText("")
                    end
                    updateRawHate()
                end
            end
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
        -- Action list - Extras
            function actionList_Extra()
                --print(useCDs())
                if IsFlying() or IsMounted() then return end
                if inCombat then
                    --analyzeS2M()
                    updateTTD()
                    dieAtNextGCD = currentInsanityDrain*(gcd + math.min(0.05,getLatency())) > power
                end

                updateInsanityDrainStacks()

                if bodyAndSoul > -1 and isMoving("player") and not buff.surrenderToMadness and talent.bodyAndSoul then
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
                -- Potion
                    -- potion,name=deadly_grace,if=buff.bloodlust.react|target.time_to_die<=40|(buff.voidform.stack>80&buff.power_infusion.up)
                    if hasBloodLust() or ttd("target") <= 40 or (buff.stack.voidForm > 80 and buff.powerInfusion) then
                        usePotion()
                    end
                end
            end -- End Action List - Cooldowns
        -- Action List - Pre-Combat
            function actionList_PreCombat()
                if not (IsFlying() or IsMounted()) then
                -- Flask
                    --flask,type=flask_of_the_whispered_pact
                    if isChecked(LC_FLASK) then
                        if canFlask and flaskBuff < 420 then
                            useItem(br.player.flask.wod.intellectBig)
                            return true
                        end
                    end
                
                -- Shadowform
                    if not buff.shadowform then
                        if cast.shadowform() then return end
                    end
                    
                    if isChecked(LC_PRE_PULL_TIMER) and pullTimer <= getOptionValue(LC_PRE_PULL_TIMER) then
                    -- Potion
                        usePotion()
                    end
                end
            end  -- End Action List - Pre-Combat
        -- Action List - Main
            function actionList_Main()
            -- surrender_to_madness,if=talent.surrender_to_madness.enabled&target.time_to_die<=variable.s2mcheck
                -- Never automatic use SurrenderToMadness
            -- mindbender,if=talent.mindbender.enabled&!talent.surrender_to_madness.enabled
                if useMindBenderOrShadowFiend and useCDs() and talent.mindBender and not talent.surrenderToMadness then
                    if cast.mindBender() then return end
                end
            -- mindbender,if=talent.mindbender.enabled&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck+60
                if useMindBenderOrShadowFiend and useCDs() and talent.mindBender and talent.surrenderToMadness and ttd("target") > s2mcheck + 60 then
                    if cast.mindBender() then return end
                end
            -- shadow_word_pain,if=dot.shadow_word_pain.remains<(3+(4%3))*gcd
                if getDebuffRemain("target",spell.shadowWordPain,"player") < (3+(4%3))*gcd then
                    if cast.shadowWordPain("target") then return end
                end
            -- vampiric_touch,if=dot.vampiric_touch.remains<(4+(4%3))*gcd
                if getDebuffRemain("target",spell.vampiricTouch,"player") < (4+(4%3))*gcd then
                    if cast.vampiricTouch("target") then return end
                end
            -- void_eruption,if=insanity>=85|(talent.auspicious_spirits.enabled&insanity>=(80-shadowy_apparitions_in_flight*4))
                if useVoidEruption and ((talent.legacyOfTheVoid and power >= 70) or power >= 100) then --can't do this
                    if cast.voidEruption() then return end
                end
            -- shadow_crash,if=talent.shadow_crash.enabled
                if talent.shadowCrash then
                    if cast.shadowCrash() then return end
                end
            -- mindbender,if=talent.mindbender.enabled&set_bonus.tier18_2pc
                --ignore
            -- shadow_word_pain,if=!ticking&talent.legacy_of_the_void.enabled&insanity>=70,cycle_targets=1
                if (debuff.count.shadowWordPain < SWPmaxTargets or isMoving("player")) and talent.legacyOfTheVoid and power >= 70 then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff then
                            if cast.shadowWordPain(thisUnit) then return end 
                        end
                    end
                end
            -- vampiric_touch,if=!ticking&talent.legacy_of_the_void.enabled&insanity>=70,cycle_targets=1
                if debuff.count.vampiricTouch < VTmaxTargets and talent.legacyOfTheVoid and power >= 70 then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.vampiricTouch,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff then
                            if cast.vampiricTouch(thisUnit) then return end 
                        end
                    end
                end
            -- shadow_word_death,if=!talent.reaper_of_souls.enabled&cooldown.shadow_word_death.charges=2&insanity<=90
                if not talent.reaperOfSouls and charges.shadowWordDeath == charges.max.shadowWordDeath and power <= 90 then
                    if cast.shadowWordDeath() then return end
                end
            -- shadow_word_death,if=talent.reaper_of_souls.enabled&cooldown.shadow_word_death.charges=2&insanity<=70
                if talent.reaperOfSouls and charges.shadowWordDeath == charges.max.shadowWordDeath and power <= 70 then
                    if cast.shadowWordDeath() then return end
                end
            -- mind_blast,if=talent.legacy_of_the_void.enabled&(insanity<=81|(insanity<=75.2&talent.fortress_of_the_mind.enabled))
                if talent.legacyOfTheVoid and (power <= 81 or (power <= 75.2 and talent.fortressOfTheMind)) then
                    if cast.mindBlast() then return end
                end
            -- mind_blast,if=!talent.legacy_of_the_void.enabled|(insanity<=96|(insanity<=95.2&talent.fortress_of_the_mind.enabled))
                if not talent.legacyOfTheVoid or (power <= 96 or (power <= 95.2 and talent.fortressOfTheMind)) then
                    if cast.mindBlast() then return end
                end
            -- shadow_word_pain,if=!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
                if debuff.count.shadowWordPain < SWPmaxTargets or isMoving("player") and (talent.auspiciousSpirits or talent.shadowyInsight) then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit) then return end 
                        end
                    end
                end
            -- vampiric_touch,if=!ticking&target.time_to_die>10&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank)),cycle_targets=1
                if debuff.count.vampiricTouch < VTmaxTargets or talent.sanlaryn or (talent.auspiciousSpirits and artifact.unleashTheShadows) then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.vampiricTouch,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff and ttd(thisUnit) > 10 then
                            if cast.vampiricTouch(thisUnit) then return end 
                        end
                    end
                end
            -- shadow_word_pain,if=!ticking&target.time_to_die>10&(active_enemies<5&artifact.sphere_of_insanity.rank),cycle_targets=1
                if (debuff.count.shadowWordPain < SWPmaxTargets or isMoving("player")) and artifact.sphereOfInsanity then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit) then return end 
                        end
                    end
                end
            -- shadow_word_void,if=(insanity<=70&talent.legacy_of_the_void.enabled)|(insanity<=85&!talent.legacy_of_the_void.enabled)
                if (power <= 70 and talent.legacyOfTheVoid) or (power <= 85 and not talent.legacyOfTheVoid) then
                    if cast.shadowWordVoid() then return end
                end
            -- mind_flay,line_cd=10,if=!talent.mind_spike.enabled&active_enemies>=2&active_enemies<4,interrupt=1,chain=1
                -- ???
            -- mind_sear,if=active_enemies>=2,interrupt=1,chain=1
                if (#getEnemies("target",10) > 2 and mode.rotation == 1) or mode.rotation == 2 then
                    if isCastingSpell(spell.mindSear) then return end
                    if cast.mindSear() then return end
                end
            -- mind_flay,if=!talent.mind_spike.enabled,interrupt=1,chain=1
                if not talent.mindSpike then
                    if isCastingSpell(spell.mindFlay) then return end
                    if cast.mindFlay() then return end
                end
            -- mind_spike,if=talent.mind_spike.enabled
                if talent.mindSpike then
                    if cast.mindSpike() then return end
                end
            -- shadow_word_pain
                if isMoving("player") then
                    if cast.shadowWordPain() then return end 
                end
            end -- End Action List - main
        -- Action List - vf
            function actionList_Vf()
                if isCastingSpell(spell.mindFlay) then
                    local castStartTime = select(5,UnitChannelInfo("player"))
                    local castEndTime = select(6,UnitChannelInfo("player"))
                    local castDuration = (castEndTime - castStartTime)/1000
                    local castTimeRemain = ((castEndTime/1000) - GetTime())
                    if castTimeRemain < castDuration * (3/4) and cd.voidBolt == 0 then
                        SpellStopCasting()
                    else
                        return
                    end
                end
                
                if isCastingSpell(spell.mindSear) then
                    local castStartTime = select(5,UnitChannelInfo("player"))
                    local castEndTime = select(6,UnitChannelInfo("player"))
                    local castDuration = (castEndTime - castStartTime)/1000
                    local castTimeRemain = ((castEndTime/1000) - GetTime())
                    if castTimeRemain < castDuration * (5/6) and cd.voidBolt == 0 then
                        SpellStopCasting()
                    else
                        return
                    end
                end

            -- actions.vf=surrender_to_madness,if=talent.surrender_to_madness.enabled&insanity>=25&(cooldown.void_bolt.up|cooldown.void_torrent.up|cooldown.shadow_word_death.up|buff.shadowy_insight.up)&target.time_to_die<=variable.s2mcheck-(buff.insanity_drain_stacks.stack)
                -- Never automatic use SurrenderToMadness
            -- shadow_crash,if=talent.shadow_crash.enabled
                if talent.shadowCrash then
                    if cast.shadowCrash() then return end
                end
            --void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60
                if useArtifact and talent.surrenderToMadness and getDebuffRemain("target",spell.shadowWordPain,"player") > 5.5 and getDebuffRemain("target",spell.vampiricTouch,"player") > 5.5
                         and ttd("target") > s2mcheck - insanityDrainStacks + 60 then
                    if cast.voidTorrent() then return end
                end
            -- void_torrent,if=!talent.surrender_to_madness.enabled
                if useArtifact and not talent.surrenderToMadness then
                    if cast.voidTorrent() then return end
                end
            -- mindbender,if=talent.mindbender.enabled&!talent.surrender_to_madness.enabled
                if useMindBenderOrShadowFiend and useCDs() and talent.mindBender and not talent.surrenderToMadness then
                    if cast.mindBender() then return end
                end
            -- mindbender,if=talent.mindbender.enabled&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+30
                if useMindBenderOrShadowFiend and useCDs() and talent.mindBender and talent.surrenderToMadness and ttd("target") > s2mcheck - insanityDrainStacks + 80 then
                    if cast.mindBender() then return end
                end
            -- power_infusion,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=30&!talent.surrender_to_madness.enabled
                if usePowerInfusion and useCDs() and buff.stack.voidForm >= 10 and insanityDrainStacks <= 30 and not talent.surrenderToMadness then
                    if cast.powerInfusion() then return end
                end
            -- power_infusion,if=buff.voidform.stack>=10&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+25
                if usePowerInfusion and useCDs() and buff.stack.voidForm >= 10 and talent.surrenderToMadness and ttd("target") > s2mcheck - insanityDrainStacks + 41 then
                    if cast.powerInfusion() then return end
                end
            -- berserking,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=20&!talent.surrender_to_madness.enabled
                if buff.stack.voidForm >= 10 and insanityDrainStacks <=20 and not talent.surrenderToMadness and br.player.race == "Troll" then
                    if castSpell("player",racial,false,false,false) then return end
                end
            -- berserking,if=buff.voidform.stack>=10&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60
                if buff.stack.voidForm >= 10 and talent.surrenderToMadness and ttd("target") > s2mcheck - insanityDrainStacks + 60 and br.player.race == "Troll" then
                    if castSpell("player",racial,false,false,false) then return end
                end
            -- void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&dot.vampiric_touch.remains<3.5*gcd&target.time_to_die>10,cycle_targets=1
                if cd.voidBolt == 0 then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.vampiricTouch,"player") ~= nil and 
                                                UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and tempestDebuff and ttd(thisUnit) > 10
                            and getDebuffRemain(thisUnit,spell.shadowWordPain,"player") < 3.5*gcd
                            and getDebuffRemain(thisUnit,spell.vampiricTouch,"player") < 3.5*gcd then
                            if cast.voidBolt(thisUnit) then return end
                        end
                    end
                end
            -- void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)&target.time_to_die>10,cycle_targets=1
                if cd.voidBolt == 0 and (talent.auspiciousSpirits or talent.shadowyInsight) then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and tempestDebuff and ttd(thisUnit) > 10
                            and getDebuffRemain(thisUnit,spell.shadowWordPain,"player") < 3.5*gcd then
                            if cast.voidBolt(thisUnit) then return end
                        end
                    end
                end
            -- void_bolt,if=dot.vampiric_touch.remains<3.5*gcd&(talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank))&target.time_to_die>10,cycle_targets=1
                if cd.voidBolt == 0 and (talent.sanlaryn or (talent.auspiciousSpirits and artifact.unleashTheShadows)) then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.vampiricTouch,"player") ~= nil
                        if isInCombat(thisUnit) and tempestDebuff and ttd(thisUnit) > 10
                            and getDebuffRemain(thisUnit,spell.vampiricTouch,"player") < 3.5*gcd then
                            if cast.voidBolt(thisUnit) then return end
                        end
                    end
                end
            -- void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&artifact.sphere_of_insanity.rank&target.time_to_die>10,cycle_targets=1
                if cd.voidBolt == 0 and artifact.sphereOfInsanity then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and tempestDebuff and ttd(thisUnit) > 10
                            and getDebuffRemain(thisUnit,spell.shadowWordPain,"player") < 3.5*gcd then
                            if cast.voidBolt(thisUnit) then return end
                        end
                    end
                end
            -- void_bolt
                if cd.voidBolt == 0 then
                    if cast.voidBolt(thisUnit) then return end
                end
            -- shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+10)<100
                if not talent.reaperOfSouls and dieAtNextGCD and (power - (currentInsanityDrain * gcdMax) + 10 ) < 100 then
                    if cast.shadowWordDeath() then return end
                end
            -- shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+30)<100
                if talent.reaperOfSouls and dieAtNextGCD and (power -(currentInsanityDrain * gcdMax) + 30 ) < 100 then
                    if cast.shadowWordDeath() then return end
                end
            -- wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
                if cd.voidBolt < gcdMax*0.28 then
                    rWait = cd.voidBolt
                    return
                end
            -- mind_blast
                if cast.mindBlast() then return end
            -- wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28
                if cd.mindBlast < gcdMax*0.28 then
                    rWait = cd.mindBlast
                    return
                end
            -- shadow_word_death,if=cooldown.shadow_word_death.charges=2
                if charges.shadowWordDeath == charges.max.shadowWordDeath then
                    if cast.shadowWordDeath() then return end
                end
            -- shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
                if useMindBenderOrShadowFiend and useCDs() and not talent.mindBender and buff.stack.voidForm > 15 then
                    if cast.shadowfiend() then return end
                end
            -- shadow_word_void,if=(insanity-(current_insanity_drain*gcd.max)+25)<100
                if power - (currentInsanityDrain * gcdMax) + 25 < 100 then
                    if cast.shadowWordDeath() then return end
                end
            -- shadow_word_pain,if=!ticking&(active_enemies<5|talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled|artifact.sphere_of_insanity.rank)
                if getDebuffRemain("target",spell.shadowWordPain,"player") == 0 and
                        (debuff.count.shadowWordPain < SWPmaxTargets or talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity) then
                    if cast.shadowWordPain() then return end
                end
            -- vampiric_touch,if=!ticking&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank))
                if getDebuffRemain("target",spell.vampiricTouch,"player") == 0 and
                        (debuff.count.vampiricTouch < VTmaxTargets or talent.sanlaryn or (talent.auspiciousSpirits and artifact.unleashTheShadows)) then
                    if cast.vampiricTouch() then return end
                end
            -- shadow_word_pain,if=!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
                if debuff.count.shadowWordPain < SWPmaxTargets and (talent.auspiciousSpirits or talent.shadowyInsight) then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit) then return end
                        end
                    end
                end
            -- vampiric_touch,if=!ticking&target.time_to_die>10&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank)),cycle_targets=1
                if debuff.count.vampiricTouch < VTmaxTargets or talent.sanlaryn or (talent.auspiciousSpirits and artifact.unleashTheShadows) then
                     for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.vampiricTouch,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff and ttd(thisUnit) > 10 then
                            if cast.vampiricTouch(thisUnit) then return end
                        end
                    end
                end
            -- shadow_word_pain,if=!ticking&target.time_to_die>10&(active_enemies<5&artifact.sphere_of_insanity.rank),cycle_targets=1
                if debuff.count.shadowWordPain < SWPmaxTargets and artifact.sphereOfInsanity then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit) then return end
                        end
                    end
                end
            -- wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable|action.void_bolt.usable_in<gcd.max*0.8
                if cd.voidBolt < gcdMax*0.8 then
                    rWait = cd.voidBolt
                    return
                end
            -- mind_flay,line_cd=10,if=!talent.mind_spike.enabled&active_enemies>=2&active_enemies<4,chain=1,interrupt_immediate=1,interrupt_if=action.void_bolt.usable
                -- ??
            -- mind_sear,if=active_enemies>=2,interrupt_immediate=1,interrupt_if=action.void_bolt.usable
                if (#getEnemies("target",10) > 2 and mode.rotation == 1) or mode.rotation == 2 then
                    if cast.mindSear() then return end
                end
            -- mind_flay,if=!talent.mind_spike.enabled,chain=1,interrupt_immediate=1,interrupt_if=action.void_bolt.usable
                if not talent.mindSpike then
                    if cast.mindFlay() then return end
                end
            -- mind_spike,if=talent.mind_spike.enabled
                if talent.mindSpike then
                    if cast.mindSpike() then return end
                end
            -- shadow_word_pain
                if isMoving("player") then
                    if cast.shadowWordPain() then return end 
                end
            end -- End Action List - vf
        -- Action List - s2m
            function actionList_S2M()
                if forceDelay and br.timer:useTimer("forceDelay",0.5) then
                    forceDelay = false
                end

                if isCastingSpell(spell.mindFlay) then
                    local castStartTime = select(5,UnitChannelInfo("player"))
                    local castEndTime = select(6,UnitChannelInfo("player"))
                    local castDuration = (castEndTime - castStartTime)/1000
                    local castTimeRemain = ((castEndTime/1000) - GetTime())
                    if castTimeRemain < castDuration * (3/4) and 
                        (cd.voidBolt == 0 or 
                        (charges.shadowWordDeath > 0 and dieAtNextGCD and (power-(currentInsanityDrain*gcdMax)+75) < 100) or
                        (dieAtNextGCD and cd.dispersion == 0)) 
                    then
                        SpellStopCasting()
                        return
                    else
                        return
                    end
                end
                
                if isCastingSpell(spell.mindSear) then
                    local castStartTime = select(5,UnitChannelInfo("player"))
                    local castEndTime = select(6,UnitChannelInfo("player"))
                    local castDuration = (castEndTime - castStartTime)/1000
                    local castTimeRemain = ((castEndTime/1000) - GetTime())
                    if castTimeRemain < castDuration * (5/6) and 
                        (cd.voidBolt == 0 or 
                        (charges.shadowWordDeath > 0 and dieAtNextGCD and (power-(currentInsanityDrain*gcdMax)+75) < 100) or
                        (dieAtNextGCD and cd.dispersion == 0)) 
                    then
                        SpellStopCasting()
                        return
                    else
                        return
                    end
                end

                if lastSpell == spell.dispersion and insanityDrainStacks > 95 then
                    if cast.shadowWordDeath() then return end
                end
            -- shadow_crash,if=talent.shadow_crash.enabled  
                if talent.shadowCrash then
                    if cast.shadowCrash() then return end
                end
            -- mindbender,if=talent.mindbender.enabled
                if useMindBenderOrShadowFiend and useCDs() and talent.mindBender then
                    if cast.mindBender() then return end
                end
            -- void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5
                if useArtifact and getDebuffRemain("target",spell.shadowWordPain,"player") > 5.5 and getDebuffRemain("target",spell.vampiricTouch,"player") > 5.5
                then
                    if cast.voidTorrent() then return end
                end
            -- berserking,if=buff.voidform.stack>=80
                if buff.stack.voidForm >= 80 and br.player.race == "Troll" then
                    if castSpell("player",racial,false,false,false) then return end
                end
            -- dispersion,if=dot.shadow_word_pain.remains>7.5&dot.vampiric_touch.remains>7.5&buff.voidform.stack<10
                if useDispersion and getDebuffRemain("target",spell.shadowWordPain,"player") > 7.5 and getDebuffRemain("target",spell.vampiricTouch,"player") > 7.5 and buff.stack.voidForm >= 5 and buff.stack.voidForm <= 10 then
                    if cast.dispersion() then return end
                end
            -- shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+15)<100&!buff.power_infusion.up&buff.insanity_drain_stacks.stack<=60&cooldown.shadow_word_death.charges=2
                if not talent.reaperOfSouls and dieAtNextGCD and (power - (currentInsanityDrain * gcdMax)+15)<100 and not buff.powerInfusion and insanityDrainStacks <= timeToPowerInfusion and charges.shadowWordDeath == 2 then
                    if cast.shadowWordDeath() then return end
                end
            -- shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+75)<100&!buff.power_infusion.up&buff.insanity_drain_stacks.stack<=60&cooldown.shadow_word_death.charges=2
                if talent.reaperOfSouls and 
                    dieAtNextGCD and 
                    (power-(currentInsanityDrain*gcdMax)+75)<100 and 
                    not buff.powerInfusion and 
                    insanityDrainStacks <= timeToPowerInfusion and 
                    charges.shadowWordDeath == 2 
                then
                    if cast.shadowWordDeath() then return end
                end
            -- void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&dot.vampiric_touch.remains<3.5*gcd&target.time_to_die>10,cycle_targets=1
                if cd.voidBolt == 0 then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.vampiricTouch,"player") ~= nil and 
                                                UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and tempestDebuff and ttd(thisUnit) > 10
                            and getDebuffRemain(thisUnit,spell.shadowWordPain,"player") < 3.5*gcd
                            and getDebuffRemain(thisUnit,spell.vampiricTouch,"player") < 3.5*gcd then
                            if cast.voidBolt(thisUnit) then return end
                        end
                    end
                end
            -- void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)&target.time_to_die>10,cycle_targets=1
                if cd.voidBolt == 0 and (talent.auspiciousSpirits or talent.shadowyInsight) then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and tempestDebuff and ttd(thisUnit) > 10
                            and getDebuffRemain(thisUnit,spell.shadowWordPain,"player") < 3.5*gcd then
                            if cast.voidBolt(thisUnit) then return end
                        end
                    end
                end
            -- void_bolt,if=dot.vampiric_touch.remains<3.5*gcd&(talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank))&target.time_to_die>10,cycle_targets=1
                if cd.voidBolt == 0 and (talent.sanlaryn or (talent.auspiciousSpirits and artifact.unleashTheShadows)) then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.vampiricTouch,"player") ~= nil
                        if isInCombat(thisUnit) and tempestDebuff and ttd(thisUnit) > 10
                            and getDebuffRemain(thisUnit,spell.vampiricTouch,"player") < 3.5*gcd then
                            if cast.voidBolt(thisUnit) then return end
                        end
                    end
                end
            -- void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&artifact.sphere_of_insanity.rank&target.time_to_die>10,cycle_targets=1
                if cd.voidBolt == 0 and artifact.sphereOfInsanity then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and tempestDebuff and ttd(thisUnit) > 10
                            and getDebuffRemain(thisUnit,spell.shadowWordPain,"player") < 3.5*gcd then
                            if cast.voidBolt(thisUnit) then return end
                        end
                    end
                end
            -- void_bolt
                if currentInsanityDrain*(gcdMax + math.min(0.05,getLatency())) - 40 < power then
                    if cast.voidBolt(thisUnit) then return end
                end
            -- shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+15)<100
                if not talent.reaperOfSouls and dieAtNextGCD and (power -(currentInsanityDrain*gcdMax)+15) < 100 then
                    if cast.shadowWordDeath() then return end
                end
            -- shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+75)<100
                if talent.reaperOfSouls and dieAtNextGCD and (power-(currentInsanityDrain*gcdMax)+75) < 100 then
                    if cast.shadowWordDeath() then return end
                end
            -- power_infusion,if=cooldown.shadow_word_death.charges=0&cooldown.shadow_word_death.remains>3*gcd.max
                if usePowerInfusion and useCDs() and
                    charges.shadowWordDeath == 0 and 
                    cd.shadowWordDeath > 3*gcdMax
                then
                    if cast.powerInfusion() then return end
                end
            -- wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
                if cd.voidBolt < gcdMax*0.28 then
                    rWait = cd.voidBolt
                    return
                end
            -- mind_blast
                -- if cast.mindBlast() then return end
            -- wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28
                -- if cd.mindBlast < gcdMax*0.28 then
                --     rWait = cd.mindBlast
                --     return
                -- end
            -- mind_blast,if=(insanity-current_insanity_drain*action.void_bolt.usable_in)>-30&(insanity-current_insanity_drain*0.6)>0
                if (power - currentInsanityDrain * cd.voidBolt) > -20 and (power - currentInsanityDrain *0.6) > 0 then
                    if cast.mindBlast() then return end
                end
            -- shadow_word_death,if=cooldown.shadow_word_death.charges=2
                if charges.shadowWordDeath == 2 then
                    if cast.shadowWordDeath() then return end
                end
            -- Arcane Torrent
                if useArcaneTorrent and insanityDrainStacks >= timeToPowerInfusion and useCDs() and br.player.race == "BloodElf"
                    and dieAtNextGCD and (power-(currentInsanityDrain*gcdMax)+35) < 100 
                then
                    if getSpellCD(racial)==0 and castSpell("player",racial,false,false,false) then return end
                end
            -- hasEquiped 130234, Blessed Dawnlight Medallion
                if useBlessedDawnlightMedallion and 
                    insanityDrainStacks >= timeToPowerInfusion and 
                    useCDs() and 
                    hasEquiped(130234) and 
                    dieAtNextGCD and 
                    (power-(currentInsanityDrain*gcdMax)+75) < 100
                    and lastSpell ~= racial
                then
                    if useItem(2) then return end
                end
            -- dispersion,if=current_insanity_drain*gcd.max>insanity&!buff.power_infusion.up
                if not forceDelay and 
                    useDispersion and 
                    dieAtNextGCD and 
                    insanityDrainStacks > 70 and 
                    not buff.powerInfusion 
                then
                    if cast.dispersion() then return end
                end
            -- shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
                if useMindBenderOrShadowFiend and useCDs() and not talent.mindbender and buff.stack.voidForm > 15 then
                    if cast.shadowfiend() then return end
                end
            -- shadow_word_void,if=(insanity-(current_insanity_drain*gcd.max)+75)<100
                if power - (currentInsanityDrain * gcdMax + 75) < 100 then
                    if cast.shadowWordVoid() then return end
                end
            -- shadow_word_pain,if=!ticking&(active_enemies<5|talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled|artifact.sphere_of_insanity.rank)
                if debuff.count.shadowWordPain < SWPmaxTargets or talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity then
                    local thisUnit = "target"
                    local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                    if not tempestDebuff then
                        if cast.shadowWordPain(thisUnit) then return end
                    end
                end
            -- vampiric_touch,if=!ticking&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank))
                if debuff.count.vampiricTouch < VTmaxTargets or talent.sanlaryn or (talent.auspiciousSpirits and artifact.unleashTheShadows) then
                    local thisUnit = "target"
                    local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.vampiricTouch,"player") ~= nil
                    if not tempestDebuff then
                        if cast.vampiricTouch(thisUnit) then return end 
                    end
                end
            -- shadow_word_pain,if=!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
                if debuff.count.shadowWordPain < SWPmaxTargets and (talent.auspiciousSpirits or talent.shadowyInsight) then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit) then return end
                        end
                    end
                end
            -- vampiric_touch,if=!ticking&target.time_to_die>10&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank)),cycle_targets=1
                if debuff.count.vampiricTouch < VTmaxTargets or talent.sanlaryn or (talent.auspiciousSpirits and artifact.unleashTheShadows) then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.vampiricTouch,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff and ttd(thisUnit) > 10 then
                            if cast.vampiricTouch(thisUnit) then return end 
                        end
                    end
                end
            -- shadow_word_pain,if=!ticking&target.time_to_die>10&(active_enemies<5&artifact.sphere_of_insanity.rank),cycle_targets=1
                if debuff.count.shadowWordPain < SWPmaxTargets and artifact.sphereOfInsanity then
                    for i=1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local tempestDebuff = UnitDebuffID(thisUnit,spell.spec.debuffs.shadowWordPain,"player") ~= nil
                        if isInCombat(thisUnit) and not tempestDebuff and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit) then return end
                        end
                    end
                end
            -- wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable|action.void_bolt.usable_in<gcd.max*0.8
                if cd.voidBolt < gcdMax *0.8 then
                    rWait = cd.voidBolt
                    return
                end
            -- mind_flay,line_cd=10,if=!talent.mind_spike.enabled&active_enemies>=2&active_enemies<4,chain=1,interrupt_immediate=1,interrupt_if=action.void_bolt.usable
                --???
            -- mind_sear,if=active_enemies>=2,interrupt=1
                if (#getEnemies("target",10) > 2 and mode.rotation == 1) or mode.rotation == 2 then
                    if cast.mindSear() then return end
                end
            -- mind_flay,if=!talent.mind_spike.enabled,chain=1,interrupt_immediate=1,interrupt_if=((current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+75)<100&cooldown.shadow_word_death.charges>=1)|action.void_bolt.usable)&ticks>=2
                if not talent.mindSpike then
                    if cast.mindFlay() then return end
                end
            -- mind_spike,if=talent.mind_spike.enabled
                if talent.mindSpike then
                    if cast.mindSpike() then return end
                end
            end -- End Action List - s2m
        
    -----------------
    --- Rotations ---
    -----------------
            if actionList_Extra() then return end
            if actionList_Defensive() then return end
    ---------------------------------
    --- Out Of Combat - Rotations ---
    ---------------------------------
            if inRaid and not inCombat and isBoss("target") and isValidUnit("target") then
                if actionList_PreCombat() then return end
            end
    -----------------------------
    --- In Combat - Rotations --- 
    -----------------------------
            if IsFlying() or IsMounted() then return end
            actionList_AutoTarget()
            --useItem(2)
            --UseItemByName(130234)
            if inCombat and isValidUnit("target") 
                    and getDistance("target") < 40 
            -- hasEquiped 130234, Blessed Dawnlight Medallion
                    and not isCastingSpell(spell.voidTorrent) and (lastSpell ~= spell.voidTorrent or br.timer:useTimer("voidTorrentMutex",2))
                    and not isCastingSpell(spell.vampiricTouch)
                    and not isCastingSpell(spell.mindBlast) then

                if actionList_Cooldowns() then return end
                
                if rWait == 0 or br.timer:useTimer("RotationsWait",rWait) then
                    rWait = 0
                    --auto_face
                    if autoFacing 
                        and not isMoving("player") 
                        and not getFacing("player","target",120) 
                        and not isCastingSpell(spell.mindFlay) 
                        and not isCastingSpell(spell.mindSear) 
                    then
                        FaceDirection(GetAnglesBetweenObjects("player", "target"), true)
                    end

                    -- call_action_list,name=s2m,if=buff.voidform.up&buff.surrender_to_madness.up
                    if buff.surrenderToMadness and buff.voidForm then
                        actionList_S2M()
                    elseif buff.voidForm then
                    -- call_action_list,name=vf,if=buff.voidform.up
                        actionList_Vf()
                    else
                    -- call_action_list,name=main
                        actionList_Main()
                    end
                end
            end -- End Combat Rotation
        --end -- End Timer
    end -- Run Rotation

    tinsert(cShadow.rotations, {
        name = rotationName,
        toggles = createToggles,
        options = createOptions,
        run = runRotation,
    })
end --End Class Check