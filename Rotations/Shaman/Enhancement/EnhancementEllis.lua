local rotationName = "Ellis"
---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.crashLightning},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.crashLightning},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.rockbiter},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.healingSurge}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.feralSpirit},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.feralSpirit},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.feralSpirit}
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.astralShift},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.astralShift}
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.windShear},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.windShear}
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
        -- Ghost Wolf
            br.ui:createSpinner(section, LC_GHOST_WOLF,  1.5,  0,  5,  0.5, LC_GHOST_WOLF_DESCRIPTION)
        -- Water Walking
            br.ui:createCheckbox(section, LC_WATER_WALKING)
        -- Feral Lunge
            br.ui:createCheckbox(section, LC_FERAL_LUNGE)
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_COOLDOWNS)
        -- Racial
            br.ui:createCheckbox(section,LC_RACIAL,LC_RACIAL_DESCRIPTION)
        -- Trinkets
            br.ui:createCheckbox(section,LC_TRINKETS,LC_TRINKETS_DESCRIPTION)
        -- Feral Spirit
            br.ui:createCheckbox(section,LC_FERAL_SPIRIT)
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
        -- Ancestral Spirit
            br.ui:createCheckbox(section,LC_ANCESTRAL_SPIRIT)
        -- Astral Shift
            br.ui:createSpinner(section, LC_ASTRAL_SHIFT,  50,  0,  100,  5,  LC_ASTRAL_SHIFT_DESCRIPTION)
        -- Healing Surge
            br.ui:createSpinner(section, LC_HEALING_SURGE,  80,  0,  100,  5,  LC_HEALING_SURGE_DESCRIPTION)
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
        -- Wind Shear
            br.ui:createCheckbox(section,LC_WIND_SHEAR)
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
        local activeEnemiesCache                                            = -1
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
        local ghostWolfTimer                                                = -1
        local healPot                                                       = getHealthPot()
        local inCombat                                                      = br.player.inCombat
        local lastSpell                                                     = lastSpellCast
        local lastTarget                                                    = lastSpellTarget
        local level                                                         = br.player.level
        local mode                                                          = br.player.mode
        local php                                                           = br.player.health
        local power                                                         = br.player.power.amount.maelstrom
        local pullTimer                                                     = br.DBM:getPulltimer()
        local race                                                          = br.player.race
        local racial                                                        = br.player.getRacial()
        local resable                                                       = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
        local solo                                                          = GetNumGroupMembers() == 0
        local spell                                                         = br.player.spell
        local talent                                                        = br.player.talent
        local units                                                         = br.player.units
        local useArtifact                                                   = false
        local eq                                                            = br.player.eq

        if movingStart == nil then movingStart = 0 end
        if feralSpiritCastTime == nil then feralSpiritCastTime = 0 end
        if feralSpiritRemain == nil then feralSpiritRemain = 0 end
        if lastSpell == spell.feralSpirit then feralSpiritCastTime = GetTime() + 15 end
        if feralSpiritCastTime > GetTime() then feralSpiritRemain = feralSpiritCastTime - GetTime() else feralSpiritCastTime = 0; feralSpiritRemain = 0 end
        
        if isChecked(LC_GHOST_WOLF) then
            ghostWolfTimer = getOptionValue(LC_GHOST_WOLF)
        end
-----------------------
--- Custom Function ---
-----------------------
        local function activeEnemies()
            if forceSingle then return 1 end
            if forceAOE then return 99 end
            if activeEnemiesCache > -1 then return activeEnemiesCache end
            activeEnemiesCache = #getFacingUnits("player",enemies.yards5,120)
            return activeEnemiesCache
        end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
            if IsFlying() or IsMounted() then return end

        -- Ghost Wolf
            if isChecked(LC_GHOST_WOLF) then
                if not buff.ghostWolf.exists and ((#enemies.yards20 == 0 and not inCombat) or (#enemies.yards10 == 0 and inCombat)) and isMoving("player") then
                    if movingStart == 0 then
                        movingStart = GetTime()
                    elseif inCombat or (GetTime() > movingStart + ghostWolfTimer) then
                        if cast.ghostWolf() then return true end
                    end
                else
                    movingStart = 0
                end
            end

        -- Water Walking
            if IsSwimming() and not buff.waterWalking.exists and isChecked(LC_WATER_WALKING) and not inCombat then
                if cast.waterWalking() then return true end
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
                    if castSpell("player",racial,false,false,false) then return true end
                end
        -- Ancestral Spirit
                if isChecked(LC_ANCESTRAL_SPIRIT) then
                    if resable and not isMoving("player") then
                        if cast.ancestralSpirit("target","dead") then return true end
                    end
                end
        -- Astral Shift
                if isChecked(LC_ASTRAL_SHIFT) and php <= getOptionValue(LC_ASTRAL_SHIFT) and inCombat then
                    if cast.astralShift() then return true end
                end
        -- Healing Surge
                if isChecked(LC_HEALING_SURGE) 
                    and ((inCombat and ((php <= getOptionValue(LC_HEALING_SURGE) / 2 and power > 20) 
                        or (power >= 90 and php <= getOptionValue(LC_HEALING_SURGE)))) or (not inCombat and php <= getOptionValue(LC_HEALING_SURGE) and not moving)) 
                then
                    if cast.healingSurge() then return true end
                end
            end
        end -- End Action List - Defensives
        -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() and br.timer:useTimer("Interrupts",1.5) then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue(LC_INTERRUPTS_AT)) then
                    -- wind_shear
                        if isChecked(LC_WIND_SHEAR) then
                            if cast.windShear(thisUnit) then return true end
                        end
                    -- War Stomp
                        if isChecked(LC_WAR_STOMP) 
                            and race == "Tauren" 
                            and getDistance("target") < 8 
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
            if useCDs() and getDistance("target") <= 5 then
            -- Trinkets
                if isChecked(LC_TRINKETS) then
                    if canUse(13) and useItem(13) then return true end
                    if canUse(14) and useItem(14) then return true end
                end
            -- Feral Spirit
                -- 	feral_spirit,if=!artifact.alpha_wolf.rank|(maelstrom>=20&cooldown.crash_lightning.remains<=gcd)
                if isChecked(LC_FERAL_SPIRIT) and (not artifact.alphaWolf or (power >= 20 and cd.crashLightning <= gcd)) then
                    if cast.feralSpirit() then return true end
                end
            -- Crash Lightning
                -- crash_lightning,if=artifact.alpha_wolf.rank&prev_gcd.1.feral_spirit
                if artifact.alphaWolf and lastSpell == spell.feralSpirit and #enemies.yards5 > 0 and getFacing("player",units.dyn5,120) then
                    if cast.crashLightning() then return true end
                end
            -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- berserking,if=buff.ascendance.up|!talent.ascendance.enabled|level<100
                -- blood_fury
                if isChecked(LC_RACIAL) 
                    and (br.player.race == "Orc" or (br.player.race == "Troll" and (buff.ascendance.exists or not talent.ascendance or level < 100)))
                    and getSpellCD(racial) == 0
                then
                    if castSpell("player",racial,false,false,false) then return true end
                end
            end
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
        end -- End Action List - PreCombat
    -- Action List - Opener
        local function actionList_Opener()
        -- Start Attack
            if getDistance(units.dyn5) <= 5 then StartAttack() end
        -- Feral Lunge
            if isChecked(LC_FERAL_LUNGE) and talent.feralLunge and getDistance("target") >= 12 then
                if cast.feralLunge() then return true end
            end
        -- Lightning Bolt
            if getDistance("target") >= 12 and not talent.overcharge and (not talent.feralLunge or cd.feralLunge > gcd) then
                if cast.lightningBolt() then return true end
            end
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
        -- Boulderfist
            -- boulderfist,if=buff.boulderfist.remains<gcd|(maelstrom<=50&active_enemies>=3)
            if talent.boulderfist 
                and (buff.boulderfist.remain < gcd or (power <= 50 and activeEnemies() >= 3))
            then
                if cast.boulderfist() then return end
            end
        -- Rockbiter
            -- rockbiter,if=talent.landslide.enabled&buff.landslide.remains<gcd
            if talent.landslide and buff.landslide.remain < gcd then
                if cast.rockbiter() then return true end
            end
        -- Fury Of Air
            -- fury_of_air,if=!ticking&maelstrom>22
            if talent.furyOfAir and not buff.furyOfAir.exists and power > 22 then
                if cast.furyOfAir() then return end
            end
        -- Frostbrand
            -- frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<gcd
            if talent.hailstorm and buff.frostbrand.remain < gcd then
                if cast.frostbrand() then return end
            end
        -- Flametongue
            -- flametongue,if=buff.flametongue.remains<gcd|(cooldown.doom_winds.remains<6&buff.flametongue.remains<4)
            if buff.flametongue.remain < gcd or (cd.doomWinds < 6 and buff.flametongue.remain < 4) then
                if cast.flametongue() then return end
            end
        -- Doom Winds
            -- doom_winds
            if useArtifact and cast.doomWinds() then return end
        -- Crash Lightning
            -- crash_lightning,if=talent.crashing_storm.enabled&active_enemies>=3&(!talent.hailstorm.enabled|buff.frostbrand.remains>gcd)
            if talent.crashingStorm and activeEnemies() >= 3 and (not talent.hailstorm or buff.frostbrand.remain > gcd) then
                if cast.crashLightning() then return end
            end
        -- Earthen Spike
            -- earthen_spike
            if talent.earthenSpike and cast.earthenSpike() then return end
        -- Lightning Bolt
            -- lightning_bolt,if=(talent.overcharge.enabled&maelstrom>=40&!talent.fury_of_air.enabled)|(talent.overcharge.enabled&talent.fury_of_air.enabled&maelstrom>46)
            if (talent.overcharge and power >= 40 and not talent.furyOfAir) or (talent.overcharge and talent.furyOfAir and power > 46) then
                if cast.lightningBolt() then return end
            end
        -- Crash Lightning
            -- crash_lightning,if=buff.crash_lightning.remains<gcd&active_enemies>=2
            if buff.crashLightning.remain < gcd and activeEnemies() >= 2 then
                if cast.crashLightning() then return end
            end
        -- Windsong
            -- windsong
            if talent.windsong and cast.windsong() then return end
        -- Ascendance
            -- ascendance,if=buff.stormbringer.react
            if talent.ascendance and useCDs() and buff.stormbringer.existss then
                if cast.ascendance() then return end
            end
        -- Stormstrike/Windstrike
            -- windstrike,if=buff.stormbringer.react&((talent.fury_of_air.enabled&maelstrom>=26)|(!talent.fury_of_air.enabled))
            -- stormstrike,if=buff.stormbringer.react&((talent.fury_of_air.enabled&maelstrom>=26)|(!talent.fury_of_air.enabled))
            if buff.stormbringer.exists and ((talent.furyOfAir and power >= 26) or not talent.furyOfAir) then
                if buff.ascendance.exists then
                    if cast.windstrike() then return end
                else
                    if cast.stormstrike() then return end
                end
            end
        -- Lava Lash
            -- lava_lash,if=talent.hot_hand.enabled&buff.hot_hand.react
            if talent.hotHand and buff.hotHand.exists then
                if cast.lavaLash() then return end
            end
        -- Boulderfist
            -- boulderfist,if=buff.boulderfist.remains<gcd|(charges_fractional>1.75&maelstrom<=100&active_enemies<=2)
            if talent.boulderfist 
                and (buff.boulderfist.remain < gcd or (charges.frac.boulderfist > 1.75 and power <= 100 and activeEnemies() <= 2))
            then
                if cast.boulderfist() then return end
            end
        -- Crash Lightning
            -- crash_lightning,if=active_enemies>=4
            if activeEnemies() >= 4 then
                if cast.crashLightning() then return end
            end
        -- Windstrike
            -- windstrike
            if buff.ascendance.exists then
                if cast.windstrike() then return end
            end
        -- Stormstrike
            -- stormstrike,if=talent.overcharge.enabled&cooldown.lightning_bolt.remains<gcd&maelstrom>80
            -- stormstrike,if=talent.fury_of_air.enabled&maelstrom>46&(cooldown.lightning_bolt.remains>gcd|!talent.overcharge.enabled)
            -- stormstrike,if=!talent.overcharge.enabled&!talent.fury_of_air.enabled
            if (talent.overcharge and cd.lightningBolt < gcd and power > 80)
                or (talent.furyOfAir and power > 46 and (cd.lightningBolt > gcd or not talent.overcharge))
                or (not talent.overcharge and not talent.furyOfAir)
            then
                if cast.stormstrike() then return end
            end
        -- Crash Lightning
            -- crash_lightning,if=((active_enemies>1|talent.crashing_storm.enabled|talent.boulderfist.enabled)&!set_bonus.tier19_4pc)|feral_spirit.remains>5
            if ((activeEnemies() > 1 or talent.crashingStorm or talent.boulderfist) and not eq.t19_4pc) or feralSpiritRemain > 5 then
                if cast.crashLightning() then return end
            end
        -- Frostbrand
            -- frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8
            if talent.hailstorm and buff.frostbrand.remain < 4.8 then
                if cast.frostbrand() then return end
            end
        -- Lava Lash
            -- lava_lash,if=talent.fury_of_air.enabled&talent.overcharge.enabled&(set_bonus.tier19_4pc&maelstrom>=80)
            -- lava_lash,if=talent.fury_of_air.enabled&!talent.overcharge.enabled&(set_bonus.tier19_4pc&maelstrom>=53)
            -- lava_lash,if=(!set_bonus.tier19_4pc&maelstrom>=120)|(!talent.fury_of_air.enabled&set_bonus.tier19_4pc&maelstrom>=40)
            if (talent.furyOfAir and talent.overcharge and (eq.t19_4pc and power >= 80))
                or (talent.furyOfAir and not talent.overcharge and (eq.t19_4pc and power >= 53))
                or ((not eq.t19_4pc and power >= 120) or (not talent.furyOfAir and eq.t19_4pc and power >=40))
            then
                if cast.lavaLash() then return end
            end
        -- Flametongue
            -- flametongue,if=buff.flametongue.remains<4.8
            if buff.flametongue.remain < 4.8 then
                if cast.flametongue() then return end
            end
        -- Sundering
            -- sundering
            if talent.sundering and getDistance(units.dyn8) < 8 then
                if cast.sundering() then return end
            end
        -- Rockbiter
            -- rockbiter
            if not talent.boulderfist and cast.rockbiter() then return end
        -- Flametongue
            -- flametongue
            if cast.flametongue() then return end
        -- Boulderfist
            -- boulderfist
            if talent.boulderfist and cast.boulderfist() then return end
        end -- End Action List - Default
---------------------
--- Begin Profile ---
---------------------
    -- Pause
        if pause() or mode.rotation == 4 or IsMounted() then
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
local id = 263
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})