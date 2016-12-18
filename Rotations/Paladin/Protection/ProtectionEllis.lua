local rotationName = "Ellis"
---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.consecration },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.hammerOfTheRighteous },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.judgment },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.lightOfTheProtector }
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
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.guardianOfAncientKings },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.guardianOfAncientKings }
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
            -- Blinding Light
            br.ui:createSpinner(section, LC_BLINDING_LIGHT_HP, 40, 0, 100, 5, LC_BLINDING_LIGHT_HP_DESCRIPTION)
            br.ui:createSpinner(section, LC_BLINDING_LIGHT_AOE, 3, 0, 10, 1, LC_BLINDING_LIGHT_AOE_DESCRIPTION)
            -- Divine Shield
            br.ui:createSpinner(section, LC_DIVINE_SHIELD,  50,  0,  100,  5,  LC_DIVINE_SHIELD_DESCRIPTION)
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
        local inCombat                                                      = br.player.inCombat
        local lastSpell                                                     = lastSpellCast
        local lastTarget                                                    = lastSpellTarget
        local level                                                         = br.player.level
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
-----------------------
--- Custom Function ---
-----------------------
        local function hasDefender()
            if debuff.eyeOfTyr[units.dyn5].exists
                or buff.aegisOfLight.exists
                or buff.ardentDefender.exists
                or buff.guardianOfAncientKings.exists
                or buff.shieldOfTheRighteous.exists
                or (buff.divineSteed.exists and talent.knightTemplar)
            then
                return true
            end
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
            end
        end -- End Action List - Defensives
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
        -- Seraphim
            --seraphim,if=talent.seraphim.enabled&action.shield_of_the_righteous.charges>=2
                if talent.seraphim and charges.shieldOfTheRighteous >= 2 then
                    if cast.seraphim() then return end
                end
        -- Shield Of The Righteous
            -- shield_of_the_righteous,if=(!talent.seraphim.enabled|action.shield_of_the_righteous.charges>2)&!(debuff.eye_of_tyr.up&buff.aegis_of_light.up&buff.ardent_defender.up&buff.guardian_of_ancient_kings.up&buff.divine_shield.up&buff.potion.up)
            -- shield_of_the_righteous,if=(talent.bastion_of_light.enabled&talent.seraphim.enabled&buff.seraphim.up&cooldown.bastion_of_light.up)&!(debuff.eye_of_tyr.up&buff.aegis_of_light.up&buff.ardent_defender.up&buff.guardian_of_ancient_kings.up&buff.divine_shield.up&buff.potion.up)
            -- shield_of_the_righteous,if=(talent.bastion_of_light.enabled&!talent.seraphim.enabled&cooldown.bastion_of_light.up)&!(debuff.eye_of_tyr.up&buff.aegis_of_light.up&buff.ardent_defender.up&buff.guardian_of_ancient_kings.up&buff.divine_shield.up&buff.potion.up)
                if (not talent.seraphim or charges.shieldOfTheRighteous > 2) and not hasDefender()
                    or talent.bastionOfLight and talent.seraphim and buff.seraphim.exists and cd.bastionOfLight == 0 and not hasDefender()
                    or talent.bastionOfLight and not talent.seraphim and cd.bastionOfLight == 0 and not hasDefender()
                then
                    if cast.shieldOfTheRighteous() then return end
                end
        -- Bastion Of Light
            -- bastion_of_light,if=talent.bastion_of_light.enabled&action.shield_of_the_righteous.charges<1
                if talent.bastionOfLight and charges.shieldOfTheRighteous < 1 then
                    if cast.bastionOfLight() then return end
                end
        -- Light Of The Protector / Hand Of The Protector
            -- light_of_the_protector,if=(health.pct<40)
            -- hand_of_the_protector,if=(health.pct<40)
                if php < 40 then
                    if talent.handOfTheProtector then
                        if cast.handOfTheProtector("player") then return end
                    else
                        if cast.lightOfTheProtector() then return end
                    end
                end
        -- Lay On Hands
            -- lay_on_hands,if=health.pct<15
                if php < 15 and getDebuffRemain("player",25771) == 0 then
                    if cast.layOnHands() then return end
                end
            -- potion,name=unbending_potion
        -- Avenging Wrath
            -- avenging_wrath,if=!talent.seraphim.enabled
            -- avenging_wrath,if=talent.seraphim.enabled&buff.seraphim.up
                if #enemies.yards5 > 0 and not talent.seraphim or talent.seraphim and buff.seraphim.exists then
                    if cast.avengingWrath() then return end
                end
        -- Judgment
            -- judgment
                if cast.judgment() then return end
        -- Avengers Shield
            -- avengers_shield,if=talent.crusaders_judgment.enabled&buff.grand_crusader.up
                if talent.crusadersJudgment and cd.avengersShield == 0 then
                    if cast.avengersShield() then return end
                end
        -- Consecration
            -- consecration
                if #enemies.yards5 > 0 and cast.consecration() then return end
        -- Blessed Hammer
            -- blessed_hammer
                if talent.blessedHammer then
                    if #enemies.yards8 > 0 and cast.blessedHammer() then return end
                end
        -- Avengers Shield
            -- avengers_shield
                if cast.avengersShield() then return end
        -- Blinding Light
            -- blinding_light
                if #enemies.yards8 > 0 and cast.blindingLight() then return end
        -- Hammer Of The Righteous
            -- hammer_of_the_righteous
                if cast.hammerOfTheRighteous() then return end
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
local id = 66
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})