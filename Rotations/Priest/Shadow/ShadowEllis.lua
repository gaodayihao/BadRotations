local rotationName = "Ellis"

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.mindFlay },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.vampiricTouch },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.mindBlast },
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
    -- Void Eruption Button
    VoidEruptionModes = {
        [1] = { mode = "On", value = 1 , overlay = "Void Eruption Enabled", tip = "Void Eruption will be used.", highlight = 1, icon = br.player.spell.voidEruption },
        [2] = { mode = "Off", value = 2 , overlay = "Void Eruption Disabled", tip = "Void Eruption will not be used.", highlight = 0, icon = br.player.spell.voidEruption }
    };
    CreateButton("VoidEruption",5,0)
    -- Void Torrent Button
    VoidTorrentModes = {
        [1] = { mode = "On", value = 1 , overlay = "Void Torrent Enabled", tip = "Void Torrent will be used.", highlight = 1, icon = br.player.spell.voidTorrent },
        [2] = { mode = "Off", value = 2 , overlay = "Void Torrent Disabled", tip = "Void Torrent will not be used.", highlight = 0, icon = br.player.spell.voidTorrent }
    };
    CreateButton("VoidTorrent",6,0)
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
            br.ui:createCheckbox(section, LC_AUTO_TARGET, LC_AUTO_TARGET_DESCRIPTION, true)
        -- Auto Facing
            br.ui:createCheckbox(section, LC_AUTO_FACING, LC_AUTO_FACING_DESCRIPTION)
        -- SWP Max Targets
            br.ui:createSpinnerWithout(section, LC_SWP_MAX_TARGETS, 5,  1,  10,  1, LC_SWP_MAX_TARGETS_DESCRIPTION)
        -- VT Max Targets
            br.ui:createSpinnerWithout(section, LC_VT_MAX_TARGETS,  3,  1,  10,  1, LC_VT_MAX_TARGETS_DESCRIPTION)
        -- Body And Soul
            br.ui:createSpinner(section, LC_BODY_AND_SOUL,  1.5,  0,  5,  0.5, LC_BODY_AND_SOUL_DESCRIPTION, nil, false, true)
        -- Nonexecute Actors
            --br.ui:createSpinnerWithout(section, LC_EXECUTE_ACTORS,  1,  1,  25,  1, LC_EXECUTE_ACTORS_DESCRIPTION)
        -- Artifact
            br.ui:createDropdownWithout(section, LC_ARTIFACT, {LC_ARTIFACT_EVERY_TIME,LC_ARTIFACT_CD}, 1)
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
            br.ui:createSpinnerWithout(section, LC_S2M_CHECK,  110,  70,  180,  1, LC_S2M_CHECK_DESCRIPTION)
        -- Time to use PowerInfusion
            --br.ui:createSpinnerWithout(section, LC_TIME_TO_USE_POWER_INFUSION,  60,  50,  150,  1, LC_TIME_TO_USE_POWER_INFUSION_DESCRIPTION)
        -- Mindbender / Shadowfiend
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
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, LC_DEFENSIVE)
        -- Healthstone
            br.ui:createSpinner(section, "Healthstone",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "Gift of the Naaru",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            end
        -- Power Word: Shield
            br.ui:createSpinner(section, "Power Word: Shield",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
        -- Dispel Magic
            br.ui:createCheckbox(section,"Dispel Magic")
        -- Vampiric Embrace
            br.ui:createSpinner(section, LC_VAMPIRIC_EMBRACE,  40,  1,  100,  5, LC_VAMPIRIC_EMBRACE_DESCRIPTION)
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
    --if br.timer:useTimer("debugShadow", 0.1) then
        --print("Running: "..rotationName)
---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        br.player.mode.voidTorrent = br.data.settings[br.selectedSpec].toggles["VoidTorrent"]
--------------
--- Locals ---
--------------
        local artifact                                      = br.player.artifact
        local autoFacing                                    = isChecked(LC_AUTO_FACING)
        local autoTarget                                    = isChecked(LC_AUTO_TARGET)
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local combatTime                                    = getCombatTime()
        local debuff                                        = br.player.debuff
        local enemies                                       = br.player.enemies
        local eq                                            = br.player.eq
        local forceAOE                                      = br.player.mode.rotation == 2
        local forceSingle                                   = br.player.mode.rotation == 3
        local friendly                                      = UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local gcdMax                                        = 1.5
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
        local insanity                                      = br.player.power.amount.insanity
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local resable                                       = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
        local solo                                          = GetNumGroupMembers() == 0
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local ttd                                           = getTTD
        local units                                         = br.player.units
        local useArtifact                                   = false

        local bodyAndSoul                                   = -1
        
        if mode.voidTorrent == 1 then
            if getOptionValue(LC_ARTIFACT) == 1 then
                useArtifact = artifact.voidTorrent
            else
                useArtifact = useCDs() and artifact.voidTorrent
            end
        end

        if movingStart == nil then movingStart = 0 end
        if isChecked(LC_BODY_AND_SOUL) and not buff.surrenderToMadness.exists then
            bodyAndSoul = getOptionValue(LC_BODY_AND_SOUL)
        end
        if delayHack == nil then delayHack = 0 end

        local s2mcheck = getOptionValue(LC_S2M_CHECK)
        local s2mbeltcheck = charges.mindBlast >= 2
        local s2mbeltcheckVar = 0 if s2mbeltcheck then s2mbeltcheckVar = 1 end
        local activeEnemies = math.min(math.max(getOptionValue(LC_VT_MAX_TARGETS),getOptionValue(LC_SWP_MAX_TARGETS)),#enemies.yards40)
        if forceSingle then activeEnemies = 1 end

        if voidFormStart == nil or (voidFormStart > 0 and not buff.voidForm.exists) then voidFormStart = 0 end
        if voidFormStart == 0 and buff.voidForm.exists then voidFormStart = GetTime() end

        if voidFormTimeStacks == nil or not buff.voidForm.exists then voidFormTimeStacks = 0 end
        if insanityDrainStacks == nil or not buff.voidForm.exists then insanityDrainStacks = 0 end
        
        if voidFormStart > 0 then
            local temp = math.ceil(GetTime() - voidFormStart)

            if temp - voidFormTimeStacks >= 1 then
                voidFormTimeStacks = voidFormTimeStacks + 1
                if not buff.dispersion.exists and not buff.voidTorrent.exists then
                    insanityDrainStacks = insanityDrainStacks + 1
                end
            end
        end

        -- Current Insanity Drain for the next 1.0 sec.
        -- Does not account for a new stack occurring in the middle and can be anywhere from 0.0 - 0.5 off the real value.
        -- Does not account for Dispersion or Void Torrent
        local currentInsanityDrain = (-3000 / -500) + insanityDrainStacks * (2.0/3.0)
--------------------
-- Custom Function--
--------------------
        local function updateTTDButton()
            _G["text".."ShadowWordDeath"]:SetText(round2(ttd(units.dyn40),0))
        end

        local function buildSpells()
            local self = br.player
            -- vampiricTouch
            self.cast.vampiricTouch = function(thisUnit,debug)
                local spellCast = self.spell.vampiricTouch
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "target" end
                if debug == nil then debug = false end

                if self.cd.vampiricTouch == 0 and IsUsableSpell(spellCast) and isKnown(spellCast) then
                    if debug then
                        return castSpell(thisUnit,spellCast,true,not self.buff.surrenderToMadness.exists,false,false,false,false,false,true)
                    else
                        local sucess = castSpell(thisUnit,spellCast,true,not self.buff.surrenderToMadness.exists)
                        if sucess then
                            delayHack = getOptionValue(LC_ROTATION_TPS) / 3
                        end
                        return sucess
                    end
                elseif debug then
                    return false
                end
            end

            -- mindBlast
            self.cast.mindBlast = function(thisUnit,debug)
                local spellCast = self.spell.mindBlast
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "target" end
                if debug == nil then debug = false end

                if self.cd.mindBlast == 0 and IsUsableSpell(spellCast) and isKnown(spellCast) then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,not self.buff.surrenderToMadness.exists,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,not self.buff.surrenderToMadness.exists)
                    end
                elseif debug then
                    return false
                end
            end

            -- voidBolt
            self.cast.voidBolt = function(thisUnit,debug)
                local spellCast = self.spell.voidEruption
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "target" end
                if debug == nil then debug = false end

                if getDistance(thisUnit) < 40 and self.cd.voidEruption == 0 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,false,false,true,false,false,true,true)
                    else
                        return castSpell(thisUnit,spellCast,false,false,false,true,false,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- mindFlay
            self.cast.mindFlay = function(thisUnit,debug)
                local spellCast = self.spell.mindFlay
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = self.units.dyn40 end
                if debug == nil then debug = false end

                if self.cd.mindFlay == 0 and not UnitChannelInfo("player") then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,not self.buff.surrenderToMadness.exists,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,not self.buff.surrenderToMadness.exists)
                    end
                elseif debug then
                    return false
                end
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
    -- Action List - Auto Facing
        local function actionList_AutoFacing()
            if autoFacing 
                and not isMoving("player") 
                and not getFacing("player","target",120)
            then
                FaceDirection(GetAnglesBetweenObjects("player", "target"), true)
            end
        end -- End Action List - Auto Facing
    -- Action list - Extras
        local function actionList_Extras()
            --print(useCDs())
            if IsFlying() or IsMounted() then return end
            if not buff.bodyAndSoul.exists and bodyAndSoul > -1 and isMoving("player") and not buff.surrenderToMadness.exists and talent.bodyAndSoul then
                if movingStart == 0 then
                    movingStart = GetTime()
                elseif GetTime() > movingStart + bodyAndSoul then
                    if cast.powerWordShield() then return true end
                end
            else
                movingStart = 0
            end
        end -- End Action List - Extra
    -- Action List - Defensive
        local function actionList_Defensive()
            if useDefensive() and getHP("player")>0 then
                -- Gift of the Naaru
                if isChecked("Gift of the Naaru") and php <= getOptionValue("Gift of the Naaru") and php > 0 and br.player.race=="Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
                -- Power Word: Shield
                if isChecked("Power Word: Shield") and php <= getOptionValue("Power Word: Shield") and not buff.powerWordShield.exists and not buff.surrenderToMadness.exists then
                    if cast.powerWordShield("player") then return end
                end
            end -- End Defensive Check
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() then
            
            end
        end -- End Action List - Cooldowns
    -- Action List - Pre-Combat
        local function actionList_PreCombat()

        end  -- End Action List - Pre-Combat
    -- Action List - Opener
        local function actionList_Opener()
        end -- End Action List - Pre-Combat
    -- Action List - Main
        local function actionList_Main()
    -- Surrender To Madness
            -- if=talent.surrender_to_madness.enabled&target.time_to_die<=variable.s2mcheck
    -- Mindbender
            -- if=talent.mindbender.enabled&((talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck+60)|!talent.surrender_to_madness.enabled)
            if useCDs() and talent.mindbender and ((not talent.surrenderToMadness and ttd(units.dyn40) > s2mcheck + 60) or not talent.surrenderToMadness) then
                if cast.mindbender() then return true end
            end
    -- Shadow Word:Pain
            -- if=talent.misery.enabled&dot.shadow_word_pain.remains<gcd.max,moving=1,cycle_targets=1
            if moving and talent.misery and debuff.shadowWordPain[units.dyn40].remain < gcdMax then
                if cast.shadowWordPain(units.dyn40,"face") then return true end
            end
            if moving and talent.misery and not forceSingle and getOptionValue(LC_SWP_MAX_TARGETS) > 1 then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (debuff.shadowWordPain["target"].count < getOptionValue(LC_SWP_MAX_TARGETS) or debuff.shadowWordPain[thisUnit].exists)
                        and debuff.shadowWordPain[thisUnit].remain < gcdMax
                    then
                        if cast.shadowWordPain(thisUnit,"face") then return true end
                    end
                end
            end
    -- Vampiric Touch
            -- if=talent.misery.enabled&(dot.vampiric_touch.remains<3*gcd.max|dot.shadow_word_pain.remains<3*gcd.max),cycle_targets=1
            if talent.misery and (debuff.vampiricTouch[units.dyn40].remain < 3*gcdMax or debuff.shadowWordPain[units.dyn40].remain < 3*gcdMax) then
                if cast.vampiricTouch() then return true end
            end
            if talent.misery and not forceSingle and getOptionValue(LC_VT_MAX_TARGETS) > 1 then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (debuff.shadowWordPain["target"].count < getOptionValue(LC_SWP_MAX_TARGETS) or debuff.shadowWordPain[thisUnit].exists)
                        and debuff.shadowWordPain[thisUnit].remain < 3*gcdMax
                        or
                       (debuff.vampiricTouch["target"].count < getOptionValue(LC_VT_MAX_TARGETS) or debuff.vampiricTouch[thisUnit].exists)
                        and debuff.vampiricTouch[thisUnit].remain < 3*gcdMax
                    then
                        if cast.vampiricTouch(thisUnit) then return true end
                    end
                end
            end
    -- Shadow Word:Pain
            -- if=!talent.misery.enabled&dot.shadow_word_pain.remains<(3+(4%3))*gcd
            if not talent.misery and debuff.shadowWordPain[units.dyn40].remain <(3+(4%3))*gcd then
                if cast.shadowWordPain(units.dyn40,"face") then return true end
            end
    -- Vampiric Touch
            -- if=!talent.misery.enabled&dot.vampiric_touch.remains<(4+(4%3))*gcd
            if not talent.misery and debuff.vampiricTouch[units.dyn40].remain <(3+(4%3))*gcd then
                if cast.vampiricTouch() then return true end
            end
    -- Void Eruption
            -- if=insanity>=70|(talent.auspicious_spirits.enabled&insanity>=(65-shadowy_apparitions_in_flight*3))|set_bonus.tier19_4pc
            if (talent.legacyOfTheVoid and (insanity >= 70 or (talent.auspiciousSpirits and insanity >= 65))) 
                or 
                (eq.t19_4pc and (insanity >=100 or (insanity >= 65 and talent.legacyOfTheVoid))) 
            then
                if cast.voidEruption("player") then delayHack = getOptionValue(LC_ROTATION_TPS) / 3 return true end
            end
    -- Shadow Crash
            -- if=talent.shadow_crash.enabled
            if talent.shadowCrash then
                if cast.shadowCrash() then return true end
            end
    -- Mindbender
            -- mindbender,if=talent.mindbender.enabled&set_bonus.tier18_2pc
    -- Shadow Word:Pain
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&talent.legacy_of_the_void.enabled&insanity>=70,cycle_targets=1
            if not talent.misery and not debuff.shadowWordPain[units.dyn40].exists and talent.legacyOfTheVoid and insanity >= 70 then
                if cast.shadowWordPain(units.dyn40,"face") then return true end
            end
            if not talent.misery 
                and talent.legacyOfTheVoid 
                and insanity >= 70 
                and not forceSingle 
                and debuff.shadowWordPain["target"].count < getOptionValue(LC_SWP_MAX_TARGETS) 
            then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain[thisUnit].exists then
                        if cast.shadowWordPain(thisUnit,"face") then return true end
                    end
                end
            end
    -- Vampiric Touch
            -- vampiric_touch,if=!talent.misery.enabled&!ticking&talent.legacy_of_the_void.enabled&insanity>=70,cycle_targets=1
            if not talent.misery and not debuff.vampiricTouch[units.dyn40].exists and talent.legacyOfTheVoid and insanity >= 70 then
                if cast.vampiricTouch(units.dyn40,"face") then return true end
            end
            if not talent.misery 
                and talent.legacyOfTheVoid 
                and insanity >= 70 
                and not forceSingle 
                and debuff.vampiricTouch["target"].count < getOptionValue(LC_SWP_MAX_TARGETS)
            then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.vampiricTouch[thisUnit].exists then
                        if cast.vampiricTouch(thisUnit) then return true end
                    end
                end
            end
    -- Shadow Word:Death
            -- if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&cooldown.shadow_word_death.charges=2&insanity<=(90-20*talent.reaper_of_souls.enabled)
            if (activeEnemies <= 4 or talent.reaperOfSouls)
                and charges.shadowWordDeath == 2
                and (insanity <= 90 and not talent.reaperOfSouls or insanity <= 70 and talent.reaperOfSouls)
            then
                if getHP(units.dyn40) <= 20 and not talent.reaperOfSouls
                    or getHP(units.dyn40) <= 35 and talent.reaperOfSouls
                then
                    if cast.shadowWordDeath() then return true end
                end
            end
    -- Mind Blast
            -- if=active_enemies<=4&talent.legacy_of_the_void.enabled&(insanity<=81|(insanity<=75.2&talent.fortress_of_the_mind.enabled))
            -- if=active_enemies<=4&!talent.legacy_of_the_void.enabled|(insanity<=96|(insanity<=95.2&talent.fortress_of_the_mind.enabled))
            if (activeEnemies <= 4 and talent.legacyOfTheVoid and (insanity <= 81 or (insanity <= 75.2 and talent.fortressOfTheMind)))
                or
                (activeEnemies <= 4 and not talent.legacyOfTheVoid or (insanity <= 96 or (insanity <= 95.2 and talent.fortressOfTheMind)))
            then
                if cast.mindBlast() then delayHack = getOptionValue(LC_ROTATION_TPS) / 3 return true end
            end
    -- Shadow Word:Pain
            -- if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
            if not talent.misery and (activeEnemies < 5 or (talent.auspiciousSpirits or talent.shadowyInsight)) then
                if not debuff.shadowWordPain[units.dyn40].exists and ttd(units.dyn40) > 10 then
                    if cast.shadowWordPain(units.dyn40,"face") then return true end
                end
                if not forceSingle and debuff.shadowWordPain["target"].count < getOptionValue(LC_SWP_MAX_TARGETS) then
                    for i = 1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not debuff.shadowWordPain[thisUnit].exists and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit,"face") then return true end
                        end
                    end
                end
            end
    -- Vampiric Touch
            -- if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank)),cycle_targets=1
            if not talent.misery and (activeEnemies < 4 or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows)) then
                if not debuff.vampiricTouch[units.dyn40].exists and ttd(units.dyn40) > 10 then
                    if cast.vampiricTouch() then return true end
                end
                if not forceSingle and debuff.vampiricTouch["target"].count < getOptionValue(LC_VT_MAX_TARGETS) then
                    for i = 1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not debuff.vampiricTouch[thisUnit].exists and ttd(thisUnit) > 10 then
                            if cast.vampiricTouch(thisUnit) then return true end
                        end
                    end
                end
            end
    -- Shadow Word:Pain
            -- if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&artifact.sphere_of_insanity.rank),cycle_targets=1
            if not talent.misery and (activeEnemies < 5 and artifact.sphereOfInsanity) then
                if not debuff.shadowWordPain[units.dyn40].exists and ttd(units.dyn40) > 10 then
                    if cast.shadowWordPain(units.dyn40,"face") then return true end
                end
                if not forceSingle and debuff.shadowWordPain["target"].count < getOptionValue(LC_SWP_MAX_TARGETS) then
                    for i = 1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not debuff.shadowWordPain[thisUnit].exists and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit,"face") then return true end
                        end
                    end
                end
            end
    -- Shadow Word:Void
            -- if=talent.shadow_word_void.enabled&(insanity<=70&talent.legacy_of_the_void.enabled)|(insanity<=85&!talent.legacy_of_the_void.enabled)
            if talent.shadowWordVoid and ((insanity <= 70 and talent.legacyOfTheVoid) or (insanity <= 85 and not talent.legacyOfTheVoid)) then
                if cast.shadowWordVoid() then return true end
            end
    -- Mind Flay
            -- mind_flay,interrupt=1,chain=1
            if isCastingSpell(spell.mindFlay) or cast.mindFlay() then return true end
    -- Shadow Word:Pain
            if cast.shadowWordPain(units.dyn40,"face") then return true end
        end -- End Action List - main
    -- Action List - vf
        local function actionList_Vf()
    -- Surrender To Madness
            -- surrender_to_madness,if=talent.surrender_to_madness.enabled&insanity>=25&(cooldown.void_bolt.up|cooldown.void_torrent.up|cooldown.shadow_word_death.up|buff.shadowy_insight.up)&target.time_to_die<=variable.s2mcheck-(buff.insanity_drain_stacks.stack)
    -- Void Bolt
            -- void_bolt
            if cast.voidBolt() then return true end
    -- Shadow Crash
            -- if=talent.shadow_crash.enabled
            if talent.shadowCrash then
                if cast.shadowCrash() then return true end
            end
    -- Void Torrent
            -- if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60))
            if useArtifact
                and debuff.shadowWordPain[units.dyn40].remain > 5.5 
                and debuff.vampiricTouch[units.dyn40].remain > 5.5
                and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mcheck - insanityDrainStacks + 60))
            then
                if cast.voidTorrent() then return true end
            end
    -- Mindbender
            -- mindbender,if=talent.mindbender.enabled&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+30))
            if useCDs() and talent.mindbender and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mcheck - (insanityDrainStacks) + 30)) then
                if cast.mindbender() then return true end
            end
    -- Power Infusion
            -- if=buff.insanity_drain_stacks.stack>=(10+2*set_bonus.tier19_2pc+5*buff.bloodlust.up+5*variable.s2mbeltcheck)&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+61))
            local t19_2pcVar = 0 if eq.t19_2pc then t19_2pcVar = 1 end
            local bloodlustVar = 0 if hasBloodLust() then bloodlustVar = 1 end
            if useCDs() and insanityDrainStacks >= (10+2*t19_2pcVar + 5*bloodlustVar + 5*s2mbeltcheckVar) 
                and (not talent.surrenderToMadness or(talent.surrenderToMadness and ttd(units.dyn40) > s2mcheck-insanityDrainStacks + 61))
            then
                if cast.powerInfusion() then return true end
            end
    -- Berserking
            -- if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=20&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60))
            if race == "Troll" and getSpellCD(racial) == 0 then
                if buff.voidForm.stack >= 10 and insanityDrainStacks <= 20 and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mcheck - insanityDrainStacks + 60)) then
                    if castSpell("player",racial,false,false,false) then return true end
                end
            end
    -- Void Bolt
            -- void_bolt
            if cast.voidBolt() then return true end
    -- Shadow Word:Death
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+(10+20*talent.reaper_of_souls.enabled))<100
            local reaperOfSoulsVar = 0 if talent.reaperOfSouls then reaperOfSoulsVar = 1 end
            if (activeEnemies <= 4 or talent.reaperOfSouls) and currentInsanityDrain*gcdMax > insanity and (insanity - (currentInsanityDrain*gcdMax) + (10+20*reaperOfSoulsVar)) < 100 then
                if getHP(units.dyn40) <= 20 and not talent.reaperOfSouls
                    or getHP(units.dyn40) <= 35 and talent.reaperOfSouls
                then
                    if cast.shadowWordDeath() then return true end
                end
            end
    -- Wait
            -- wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
            if cd.voidBolt > 0 and cd.voidBolt < gcdMax*0.28 then
                br.timer:wait(cd.voidBolt)
                return true
            end
    -- Mind Blast
            -- if=active_enemies<=4
            if activeEnemies <= 4 then
                if cast.mindBlast() then delayHack = getOptionValue(LC_ROTATION_TPS) / 3 return true end
            end
    -- Wait
            -- wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28&active_enemies<=4
            if cd.mindBlast > 0 and cd.mindBlast < gcdMax*0.28 and activeEnemies <= 4 then
                br.timer:wait(cd.mindBlast)
                return true
            end
    -- Shadow Word:Death
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&cooldown.shadow_word_death.charges=2
            if (activeEnemies <= 4 or talent.reaperOfSouls) and charges.shadowWordDeath == 2 then
                if getHP(units.dyn40) <= 20 and not talent.reaperOfSouls
                    or getHP(units.dyn40) <= 35 and talent.reaperOfSouls
                then
                    if cast.shadowWordDeath() then return true end
                end
            end
    -- Shadowfiend
            -- shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
            if useCDs() and not talent.mindbender and buff.voidForm.stack > 15 then
                if cast.shadowfiend() then return true end
            end
    -- Shadow Word:Void
            -- shadow_word_void,if=talent.shadow_word_void.enabled&(insanity-(current_insanity_drain*gcd.max)+25)<100
            if talent.shadowWordVoid and (insanity - (currentInsanityDrain * gcdMax) + 25)<100 then
                if cast.shadowWordVoid() then return true end
            end
    -- Shadow Word:Pain
            -- if=talent.misery.enabled&dot.shadow_word_pain.remains<gcd,moving=1,cycle_targets=1
            if moving and talent.misery and debuff.shadowWordPain[units.dyn40].remain < gcd then
                if cast.shadowWordPain(units.dyn40,"face") then return true end
            end
            if moving and talent.misery and not forceSingle and getOptionValue(LC_SWP_MAX_TARGETS) > 1 then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (debuff.shadowWordPain["target"].count < getOptionValue(LC_SWP_MAX_TARGETS) or debuff.shadowWordPain[thisUnit].exists)
                        and debuff.shadowWordPain[thisUnit].remain < gcd
                    then
                        if cast.shadowWordPain(thisUnit,"face") then return true end
                    end
                end
            end
    -- Vampiric Touch
            -- if=talent.misery.enabled&(dot.vampiric_touch.remains<3*gcd.max|dot.shadow_word_pain.remains<3*gcd.max),cycle_targets=1
            if talent.misery and (debuff.vampiricTouch[units.dyn40].remain < 3*gcdMax or debuff.shadowWordPain[units.dyn40].remain < 3*gcdMax) then
                if cast.vampiricTouch() then return true end
            end
            if talent.misery and not forceSingle and getOptionValue(LC_VT_MAX_TARGETS) > 1 then
                for i = 1,#enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (debuff.shadowWordPain["target"].count < getOptionValue(LC_SWP_MAX_TARGETS) or debuff.shadowWordPain[thisUnit].exists)
                        and debuff.shadowWordPain[thisUnit].remain < 3*gcdMax
                        or
                       (debuff.vampiricTouch["target"].count < getOptionValue(LC_VT_MAX_TARGETS) or debuff.vampiricTouch[thisUnit].exists)
                        and debuff.vampiricTouch[thisUnit].remain < 3*gcdMax
                    then
                        if cast.vampiricTouch(thisUnit) then return true end
                    end
                end
            end
    -- Shadow Word:Pain
            -- if=!talent.misery.enabled&!ticking&(active_enemies<5|talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled|artifact.sphere_of_insanity.rank)
            if not talent.misery and not debuff.shadowWordPain[units.dyn40].exists and (activeEnemies < 5 or talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity) then
                if cast.shadowWordPain(units.dyn40,"face") then return true end
            end
    -- Vampiric Touch
            -- if=!talent.misery.enabled&!ticking&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank))
            if not debuff.vampiricTouch[units.dyn40].exists and not talent.misery and (activeEnemies < 4 or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows)) then
                if cast.vampiricTouch() then return true end
            end
    -- Shadow Word:Pain
            -- if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
            if not talent.misery and (activeEnemies < 5 or talent.auspiciousSpirits or talent.shadowyInsight) then
                if not forceSingle and debuff.shadowWordPain["target"].count < getOptionValue(LC_SWP_MAX_TARGETS) then
                    for i = 1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not debuff.shadowWordPain[thisUnit].exists and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit,"face") then return true end
                        end
                    end
                end
            end
    -- Vampiric Touch
            -- if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank)),cycle_targets=1
            if not talent.misery and (activeEnemies < 4 or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows)) then
                if not forceSingle and debuff.vampiricTouch["target"].count < getOptionValue(LC_VT_MAX_TARGETS) then
                    for i = 1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not debuff.vampiricTouch[thisUnit].exists and ttd(thisUnit) > 10 then
                            if cast.vampiricTouch(thisUnit) then return true end
                        end
                    end
                end
            end
    -- Shadow Word:Pain
            -- if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&artifact.sphere_of_insanity.rank),cycle_targets=1
            if not talent.misery and (activeEnemies < 5 and artifact.sphereOfInsanity) then
                if not forceSingle and debuff.shadowWordPain["target"].count < getOptionValue(LC_SWP_MAX_TARGETS) then
                    for i = 1,#enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not debuff.shadowWordPain[thisUnit].exists and ttd(thisUnit) > 10 then
                            if cast.shadowWordPain(thisUnit,"face") then return true end
                        end
                    end
                end
            end
    -- Mind Flay
            -- chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(action.void_bolt.usable|(current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+30)<100&cooldown.shadow_word_death.charges>=1))
            if isCastingSpell(spell.mindFlay) or cast.mindFlay() then return true end
    -- Shadow Word:Pain
            if cast.shadowWordPain(units.dyn40,"face") then return true end
        end -- End Action List - vf
    -- Action List - s2m
        local function actionList_S2M()
        
        end -- End Action List - s2m
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        local isPause = pause(true)
        if isPause or mode.rotation==4 or delayHack >= 1 or isCastingSpell(spell.voidTorrent) or isCastingSpell(spell.voidEruption) then
            if not isPause and not UnitCastingInfo("player") and not UnitChannelInfo("player") and delayHack >= 1 then
                delayHack = delayHack - 1
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
    ------------------------------
    --- In Combat - Update TTD ---
    ------------------------------
                updateTTDButton()
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
                if buff.voidForm.exists and buff.surrenderToMadness.exists then
                    if actionList_S2M() then return true end
                end
                if buff.voidForm.exists then
                    if actionList_Vf() then return true end
                end
                if actionList_Main() then return true end
            end --End In Combat
        end --End Rotation Logic
    --end -- End Timer
end -- Run Rotation

local id = 258
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})