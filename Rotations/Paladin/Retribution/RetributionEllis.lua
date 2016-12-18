local rotationName = "Ellis" -- Appears in the dropdown of the rotation selector in the Profile Options window

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.divineStorm },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.divineStorm },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.crusaderStrike },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.flashOfLight }
    }
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.avengingWrath },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.avengingWrath },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.avengingWrath }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.flashOfLight },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.flashOfLight }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.rebuke },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.rebuke }
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
        -- Greater Blessing
            br.ui:createCheckbox(section, LC_GREATER_BLESSING, LC_GREATER_BLESSING_DESCRIPTION)
        -- Judgment ignore
            br.ui:createCheckbox(section, LC_JUDGMENT_IGNORE, LC_JUDGMENT_IGNORE_DESCRIPTION)
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
            br.ui:createSpinnerWithout(section,LC_TRINKETS1_DURATION,  20,  0,  60,  5)
            br.ui:createSpinnerWithout(section,LC_TRINKETS2_DURATION,  20,  0,  60,  5)
        -- Holy Wrath
            br.ui:createSpinner(section,LC_HOLY_WRATH,  100,  40,  100,  5,LC_HOLY_WRATH_DESCRIPTION)
        -- Avenging Wrath / Crusade
            br.ui:createCheckbox(section,LC_AVENGING_WRATH_CRUSADE,LC_AVENGING_WRATH_CRUSADE_DESCRIPTION)
        -- Execution Sentence
            br.ui:createCheckbox(section,LC_EXCUTION_SENTENCE,LC_EXCUTION_SENTENCE_DESCRIPTION)
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
            -- Blessing of Protection
            br.ui:createSpinner(section, LC_BLESSING_OF_PROTECTION,  30,  0,  100,  5,  LC_BLESSING_OF_PROTECTION_DESCRIPTION)
            -- Blinding Light
            br.ui:createSpinner(section, LC_BLINDING_LIGHT_HP, 40, 0, 100, 5, LC_BLINDING_LIGHT_HP_DESCRIPTION)
            br.ui:createSpinner(section, LC_BLINDING_LIGHT_AOE, 3, 0, 10, 1, LC_BLINDING_LIGHT_AOE_DESCRIPTION)
            -- Divine Shield
            br.ui:createSpinner(section, LC_DIVINE_SHIELD,  50,  0,  100,  5,  LC_DIVINE_SHIELD_DESCRIPTION)
            -- Eye for an Eye
            br.ui:createSpinner(section, LC_EYE_FOR_AN_EYE, 70, 0 , 100, 5, LC_EYE_FOR_AN_EYE_DESCRIPTION)
            -- Flash of Light
            br.ui:createSpinner(section, LC_FLASH_OF_LIGHT,  60,  0,  100,  5,  LC_FLASH_OF_LIGHT_DESCRIPTION)
            -- Hammer of Justice
            br.ui:createSpinner(section, LC_HAMMER_OF_JUSTICE_HP,  80,  0,  100,  5,  LC_HAMMER_OF_JUSTICE_HP_DESCRIPTION)
            -- Redemption
            br.ui:createCheckbox(section, LC_REDEMPTION, LC_REDEMPTION_DESCRIPTION)
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
        -- Hammer of Justice
            br.ui:createCheckbox(section,LC_HAMMER_OF_JUSTICE,LC_HAMMER_OF_JUSTICE_DESCRIPTION)
        -- Rebuke
            br.ui:createCheckbox(section,LC_REBUKE,LC_REBUKE_DESCRIPTION)
        -- Blinding Light
            br.ui:createCheckbox(section,LC_BLINDING_LIGHT,LC_BLINDING_LIGHT_DESCRIPTION)
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
        local autoUseCrusade                                                = false
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
        local hastar                                                        = ObjectExists("target")
        local healPot                                                       = getHealthPot()
        local holyPower                                                     = br.player.holyPower
        local holyPowerMax                                                  = br.player.holyPowerMax
        local inCombat                                                      = br.player.inCombat
        local judgmentUp                                                    = false
        local lastSpell                                                     = lastSpellCast
        local lastTarget                                                    = lastSpellTarget
        local level                                                         = br.player.level
        local lowestHP                                                      = br.friend[1].unit
        local mode                                                          = br.player.mode
        local php                                                           = br.player.health
        local race                                                          = br.player.race
        local racial                                                        = br.player.getRacial()
        local resable                                                       = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
        local solo                                                          = GetNumGroupMembers() == 0
        local spell                                                         = br.player.spell
        local talent                                                        = br.player.talent
        local units                                                         = br.player.units
        local useArtifact                                                   = false
        
        if isChecked(LC_ARTIFACT) then
            if getOptionValue(LC_ARTIFACT) == 1 then
                useArtifact = artifact.wakeOfAshes
            else
                useArtifact = useCDs() and artifact.wakeOfAshes
            end
        end
        if debuff.judgment["target"] ~= nil then
            if debuff.judgment["target"].exists or (#enemies.yards8 > 3 and cd.judgment > gcd * 2) or level < 3 then
                judgmentUp = true
            else
                judgmentUp = isChecked(LC_JUDGMENT_IGNORE) and cd.judgment > 12/(1+GetHaste()/100)-8
            end
        else
            judgmentUp = isChecked(LC_JUDGMENT_IGNORE) and cd.judgment > 12/(1+GetHaste()/100)-8
        end
        autoUseCrusade = useCDs() and isChecked(LC_AVENGING_WRATH_CRUSADE)
-----------------------
--- Custom Function ---
-----------------------
        local function divineStormValid()
            if forceAOE then return true end
            if forceSingle then return false end
            if #enemies.yards8 >=3 then return true end
            if #enemies.yards8 < 2 then return false end
            for i=1,#enemies.yards8 do
                local theUnit = enemies.yards8[i]
                if not debuff.judgment[theUnit].exists then
                    return false
                end
            end
            return true
        end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
        -- Hand of Hindrance
            if inCombat 
                and isMoving("target") 
                and not getFacing("target","player") 
                and getDistance("target") > 8 
                and getDistance("target") < 30
                and isValidUnit("target") 
            then
                if cast.handOfHindrance("target") then return true end
            end
            if br.timer:useTimer("GreaterBlessingDelay",1.5) then
                if gbDelay == nil then gbDelay = 0 end
                if gbDelay == 0 then gbDelay = 1 return end
                gbDelay = 0
                local useGreaterBlessing = isChecked(LC_GREATER_BLESSING)
                if useGreaterBlessing and solo and (not buff.greaterBlessingOfMight.exists or buff.greaterBlessingOfMight.remain < 60*10) then
                    if cast.greaterBlessingOfMight() then return true end
                end
                if useGreaterBlessing and solo and (not buff.greaterBlessingOfKings.exists or buff.greaterBlessingOfKings.remain < 60*10) then
                    if cast.greaterBlessingOfKings() then return true end
                end
                if useGreaterBlessing and solo and (not buff.greaterBlessingOfWisdom.exists or buff.greaterBlessingOfWisdom.remain < 60*10) then
                    if cast.greaterBlessingOfWisdom() then return true end
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
        -- Blessing of Protection
                if isChecked(LC_BLESSING_OF_PROTECTION) then
                    if getHP(lowestHP) < getOptionValue(LC_BLESSING_OF_PROTECTION) and inCombat and getDebuffRemain(lowestHP,25771) == 0 then
                        if cast.blessingOfProtection(lowestHP) then return end
                    end
                end
        -- Blinding Light
                if talent.blindingLight and isChecked(LC_BLINDING_LIGHT_HP) and php <= getOptionValue(LC_BLINDING_LIGHT_HP) and inCombat and #enemies.yards10 > 0 then
                    if cast.blindingLight() then return end
                end
                if talent.blindingLight and isChecked(LC_BLINDING_LIGHT_AOE) and #enemies.yards10 >= getOptionValue(LC_BLINDING_LIGHT_AOE) and inCombat then
                    if cast.blindingLight() then return end
                end
        -- Divine Shield
                if isChecked(LC_DIVINE_SHIELD) then
                    if php <= getOptionValue(LC_DIVINE_SHIELD) and inCombat and getDebuffRemain("player",25771) == 0 then
                        if cast.divineShield() then return end
                    end
                end
        -- Eye for an Eye
                if isChecked(LC_EYE_FOR_AN_EYE) then
                    if php <= getOptionValue(LC_EYE_FOR_AN_EYE) and inCombat then
                        if cast.eyeForAnEye() then return end
                    end
                end
        -- Flash of Light
                if isChecked(LC_FLASH_OF_LIGHT) then
                    if (forceHeal or (inCombat and php <= getOptionValue(LC_FLASH_OF_LIGHT) / 2) or (not inCombat and php <= getOptionValue(LC_FLASH_OF_LIGHT))) and not isMoving("player") then 
                        if cast.flashOfLight() then return end
                    end
                end
        -- Hammer of Justice
                if isChecked(LC_HAMMER_OF_JUSTICE_HP) and php <= getOptionValue(LC_HAMMER_OF_JUSTICE_HP) and inCombat and not isBoss() then
                    if cast.hammerOfJustice() then return end
                end
        -- Redemption
                if isChecked(LC_REDEMPTION) then
                    if not isMoving("player") and resable then
                        if cast.redemption("target","dead") then return end
                    end
                end
            end
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() and br.timer:useTimer("Interrupts",1.5) then
                local interruptAt = getOptionValue(LC_INTERRUPTS_AT)
                for i = 1, #enemies.yards10 do
                    local thisUnit = enemies.yards10[i]
                    local distance = getDistance(thisUnit)
                    if canInterrupt(thisUnit,interruptAt) then
        -- Rebuke
                        if isChecked(LC_REBUKE) and distance <= 5 then
                            if cast.rebuke(thisUnit) then return true end
                        end
        -- Hammer of Justice
                        if isChecked(LC_HAMMER_OF_JUSTICE) and distance < 10 and not isBoss() then
                            if cast.hammerOfJustice(thisUnit) then return true end
                        end
        -- Blinding Light
                        if talent.blindingLight and isChecked(LC_BLINDING_LIGHT) and distance < 10 and not isBoss() then
                            if cast.blindingLight() then return true end
                        end
        -- War Stomp
                        if isChecked(LC_WAR_STOMP) 
                            and distance < 8 
                            and race == "Tauren" 
                            and not isBoss() 
                            and getSpellCD(racial)==0 
                            and not isMoving("player") then
                            if castSpell("player",racial,false,false,false) then return true end
                        end
                    end
                end
            end
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() then
        -- Trinkets
                if isChecked(LC_TRINKETS) then
                    if canUse(13) 
                        and (buff.crusade.exists and buff.crusade.remain <= getOptionValue(LC_TRINKETS1_DURATION) 
                            or buff.avengingWrath.exists and buff.avengingWrath.remain <= getOptionValue(LC_TRINKETS1_DURATION)
                            or getOptionValue(LC_TRINKETS1_DURATION) == 0) 
                    then
                        useItem(13)
                    end
                    if canUse(14) 
                        and (buff.crusade.exists and buff.crusade.remain <= getOptionValue(LC_TRINKETS2_DURATION) 
                            or buff.avengingWrath.exists and buff.avengingWrath.remain <= getOptionValue(LC_TRINKETS2_DURATION)
                            or getOptionValue(LC_TRINKETS2_DURATION) == 0) 
                    then
                        useItem(14)
                    end
                end
        -- Holy Wrath
                if talent.holyWrath and isChecked(LC_HOLY_WRATH) and php <= getOptionValue(LC_HOLY_WRATH) then
                    if cast.holyWrath() then return true end
                end
        -- Avenging Wrath / Crusade
                if isChecked(LC_AVENGING_WRATH_CRUSADE) then
                    if talent.crusade then
                        if holyPower >=5 and judgmentUp and cast.crusade() then return true end
                    else
                        if cast.avengingWrath() then return true end
                    end
                end
        -- Execution Sentence
            --if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
                if talent.executionSentence 
                    and #enemies.yards8 <=3 
                    and (cd.judgment < gcd *4.5 or (debuff.judgment[units.dyn5] ~= nil and debuff.judgment[units.dyn5].remain > gcd*4.67)) 
                    and (not talent.crusade or cd.crusade > gcd*2)
                then
                    if cast.executionSentence() then return true end
                end
        -- Racial
                if isChecked(LC_RACIAL) and getSpellCD(racial)==0 then
                    if race == "BloodElf" and holyPower <=4 or race == "Orc" or race == "Troll" then
                        if castSpell("player",racial,false,false,false) then return true end
                    end
                end
            end
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
        end -- End Action List - PreCombat
    -- Action List - Opener
        local function actionList_Opener()
        -- Start Attack
            if getDistance(units.dyn5) < 5 then StartAttack() end
        -- Judgment
            if getDistance(units.dyn5) > 5 and cast.judgment("target") then return end
        end -- End Action List - Opener
    -- Action List - Auto Target
        local function actionList_AutoTarget()
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
    -- Wake of Ashes
        -- if=holy_power>=0&time<2
            if useArtifact 
                and combatTime < 2 
                and holyPower >= 0
                and getDistance(units.dyn5) <= 5
                and getFacing("player",units.dyn5,120) then
                if cast.wakeOfAshes() then return end
            end
    -- Judgment
            if  holyPower >=3 and #enemies.yards8 >= 5 then
                if cast.judgment("target") then return end
            end
    -- Divine Storm
        -- if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
        -- if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
        -- if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
            if judgmentUp and divineStormValid() and ((buff.divinePurpose.exists and buff.divinePurpose.remain < gcd*2)
                or (holyPower >=5 and buff.divinePurpose.exists)
                or (holyPower >=5 and (not talent.crusade or cd.crusade > gcd*3 or not autoUseCrusade))
                or (holyPower >=3 and talent.crusade and buff.crusade.exists and buff.crusade.remain < gcd)
                or (holyPower >=3 and #enemies.yards8 >= 5))
            then
                if cast.divineStorm() then return end
            end
    -- Justicar's Vengeance
        -- if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
        -- if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
            if talent.justicarsVengeance and judgmentUp and ((buff.divinePurpose.exists and buff.divinePurpose.remain < gcd*2 and not hasEquiped(137020))
                or (holyPower >=5 and buff.divinePurpose.exists and not hasEquiped(137020)))
            then
                if cast.justicarsVengeance() then return end
            end
    -- Templar's Verdict
        -- if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
        -- if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
        -- if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
            if judgmentUp and ((buff.divinePurpose.exists and buff.divinePurpose.remain < gcd*2)
                or (holyPower >= 5 and buff.divinePurpose.exists)
                or (holyPower >=5 and (not talent.crusade or cd.crusade > gcd*3 or not autoUseCrusade))
                or (holyPower >=3 and talent.crusade and buff.crusade.exists and buff.crusade.remain < gcd))
            then
                if cast.templarsVerdict() then return end
            end
    -- Divine Storm
        -- if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
            if judgmentUp and holyPower>=3 and divineStormValid() 
                and (cd.wakeOfAshes < gcd*2 and artifact.wakeOfAshes or buff.whisperOfTheNathrezim.exists and buff.whisperOfTheNathrezim.remain < gcd)
                and (not talent.crusade or cd.crusade > gcd * 4 or not autoUseCrusade)
            then
                if cast.divineStorm() then return end
            end
    -- Justicar's Vengeance
        -- if=debuff.judgment.up&holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
            if talent.justicarsVengeance and judgmentUp and holyPower >=3 and buff.divinePurpose.exists and cd.wakeOfAshes < gcd * 2 and artifact.wakeOfAshes and not hasEquiped(137020) then
                if cast.justicarsVengeance() then return end
            end
    -- Templar's Verdict
        -- if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
            if judgmentUp and holyPower >=3 
                and (cd.wakeOfAshes < gcd*2 and artifact.wakeOfAshes or buff.whisperOfTheNathrezim.exists and buff.whisperOfTheNathrezim.remain < gcd)
                and (not talent.crusade or cd.crusade > gcd *4 or not autoUseCrusade)
            then
                if cast.templarsVerdict() then return end
            end
    -- Wake of Ashes
        -- if=holy_power=0|holy_power=1&(cooldown.blade_of_justice.remains>gcd|cooldown.divine_hammer.remains>gcd)|holy_power=2&(cooldown.zeal.charges_fractional<=0.65|cooldown.crusader_strike.charges_fractional<=0.65)
            if useArtifact and (holyPower == 0 
                or holyPower == 1 and (cd.bladeOfJustice > gcd or talent.divineHammer and cd.divineHammer > gcd) 
                or holyPower == 2 and (talent.zeal and charges.frac.zeal <= 0.65 or charges.frac.crusaderStrike <= 0.65))
                and getDistance(units.dyn5) <= 5
                and getFacing("player",units.dyn5,120)
            then
                if cast.wakeOfAshes() then return end
            end
    -- Zeal
        -- if=charges=2&holy_power<=4
            if talent.zeal and charges.zeal == 2 and holyPower <= 4 then
                if cast.zeal() then return end
            end
    -- Crusader Strike
        -- if=charges=2&holy_power<=4
            if charges.crusaderStrike == 2 and holyPower <= 4 then
                if cast.crusaderStrike() then return end
            end
    -- Blade of Justice
        -- if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
            if holyPower <= 2 or (holyPower <=3 and (talent.zeal and charges.frac.zeal <= 1.34 or charges.frac.crusaderStrike <= 1.34)) then
                if cast.bladeOfJustice() then return end
            end
    -- Divine Hammer
        -- if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
            if talent.divineHammer and holyPower <= 2 or (holyPower <=3 and (talent.zeal and charges.frac.zeal <= 1.34 or charges.frac.crusaderStrike <= 1.34)) then
                if cast.divineHammer() then return end
            end
    -- Judgment
        -- if=holy_power>=3|((cooldown.zeal.charges_fractional<=1.67|cooldown.crusader_strike.charges_fractional<=1.67)&(cooldown.divine_hammer.remains>gcd|cooldown.blade_of_justice.remains>gcd))|(talent.greater_judgment.enabled&target.health.pct>50)
            if holyPower >=3 
                or ((talent.zeal and charges.frac.zeal <= 1.67 or charges.frac.crusaderStrike <= 1.67) 
                    and (talent.divineHammer and cd.divineHammer > gcd or cd.bladeOfJustice > gcd))
                or (talent.greaterJudgment and UnitHealth(units.dyn5) > 50)
            then
                if cast.judgment("target") then return end
            end
    -- Consecration
            if talent.consecration and cast.consecration() then return end
    -- Divine Storm
        -- if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
        -- if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
        -- if=debuff.judgment.up&spell_targets.divine_storm>=2&(holy_power>=4|((cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34)&(cooldown.divine_hammer.remains>gcd|cooldown.blade_of_justice.remains>gcd)))&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
            if judgmentUp and divineStormValid() and 
                (buff.divinePurpose.exists
                    or (buff.theFiresOfJustice.exists and (not talent.crusade or cd.crusade > gcd *3))
                    or ((holyPower >= 4 or ((talent.zeal and charges.frac.zeal <= 1.34 or charges.frac.crusaderStrike <= 1.34)
                        and (talent.divineHammer and cd.divineHammer > gcd or cd.bladeOfJustice > gcd))) and (not talent.crusade or cd.crusade > gcd*4 or not autoUseCrusade))) 
            then
                if cast.divineStorm() then return end
            end
    -- Justicar's Vengeance
        -- if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
            if talent.justicarsVengeance and judgmentUp and buff.divineHammer.exists and not hasEquiped(137020) then
                if cast.justicarsVengeance() then return end
            end
    -- Templar's Verdict
        -- if=debuff.judgment.up&buff.divine_purpose.react
        -- if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
        -- if=debuff.judgment.up&(holy_power>=4|((cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34)&(cooldown.divine_hammer.remains>gcd|cooldown.blade_of_justice.remains>gcd)))&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
            if judgmentUp and
                (buff.divinePurpose.exists
                    or (buff.theFiresOfJustice.exists and (not talent.crusade or cd.crusade > gcd *3 or not autoUseCrusade))
                    or ((holyPower >= 4 or ((talent.zeal and charges.frac.zeal <= 1.34 or charges.frac.crusaderStrike <= 1.34)
                        and (talent.divineHammer and cd.divineHammer > gcd or cd.bladeOfJustice > gcd))) and (not talent.crusade or cd.crusade > gcd*4 or not autoUseCrusade))) 
            then
                if cast.templarsVerdict() then return end
            end
    -- Zeal
        -- if=holy_power<=4
            if talent.zeal and holyPower <= 4 then
                if cast.zeal() then return end
            end
    -- Crusader Strike
        -- if=holy_power<=4
            if holyPower <= 4 then
                if cast.crusaderStrike() then return end
            end
    -- Divine Storm
        -- if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
            if judgmentUp and holyPower >=3 and divineStormValid() and (not talent.crusade or cd.crusade > gcd * 5 or not autoUseCrusade) then
                if cast.divineStorm() then return end
            end
    -- Templar's Verdict
        -- if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
            if judgmentUp and holyPower >=3 and (not talent.crusade or cd.crusade > gcd * 5 or not autoUseCrusade) then
                if cast.templarsVerdict() then return end
            end
        end -- End Action List - Default
---------------------
--- Begin Profile ---
---------------------
    -- Pause
        if pause() or mode.rotation == 4 or (IsMounted() and not buff.divineSteed.exists) then
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
-----------------------------
--- In Combat - Cooldowns ---
-----------------------------
                if actionList_Cooldowns() then return end
----------------------------------
--- In Combat - Begin Rotation ---
----------------------------------
               if actionList_Default() then return end
            end -- End In Combat
        end -- End Profile
    --end -- Timer
end -- runRotation
local id = 70
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})