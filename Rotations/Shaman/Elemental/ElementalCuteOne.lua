local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.lavaBeam},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.chainLightning},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.lightningBolt},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.healingSurge}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.fireElemental},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.fireElemental},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.fireElemental}
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
        local section
    -- General Options
        section = br.ui:createSection(br.ui.window.profile, "General")
        -- APL
            br.ui:createDropdownWithout(section, "APL Mode", {"|cffFFFFFFSimC"--[[,"|cffFFFFFFAMR"]]}, 1, "|cffFFFFFFSet APL Mode to use.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
        -- Ghost Wolf
            br.ui:createCheckbox(section,"Ghost Wolf")
        -- Spirit Walk
            br.ui:createCheckbox(section,"Spirit Walk")
        -- Water Walking
            br.ui:createCheckbox(section,"Water Walking")
        -- Artifact 
            br.ui:createDropdownWithout(section,"Artifact", {"|cff00FF00Everything","|cffFFFF00Cooldowns","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Artifact Ability.")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
        -- Agi Pot
            br.ui:createCheckbox(section,"Agi-Pot")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"Flask / Crystal")
        -- Legendary Ring
            br.ui:createCheckbox(section,"Legendary Ring")
        -- Racial
            br.ui:createCheckbox(section,"Racial")
        -- Trinkets
            br.ui:createCheckbox(section,"Trinkets")
        -- Ascendance
            br.ui:createCheckbox(section,"Ascendance")
        -- Elemental Mastery
            br.ui:createCheckbox(section,"Elemental Mastery")
        -- Fire/Storm Elemental Totem
            br.ui:createCheckbox(section,"Fire/Storm Elemental Totem")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
        -- Healthstone
            br.ui:createSpinner(section, "Pot/Stoned",  60,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        -- Heirloom Neck
            br.ui:createSpinner(section, "Heirloom Neck",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "Gift of the Naaru",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            end
        -- Ancestral Spirit
            br.ui:createDropdown(section, "Ancestral Spirit", {"|cffFFFF00Selected Target","|cffFF0000Mouseover Target"}, 1, "|ccfFFFFFFTarget to Cast On")
        -- Astral Shift
            br.ui:createSpinner(section, "Astral Shift",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")    
        -- Cleanse Spirit
            br.ui:createDropdown(section, "Clease Spirit", {"|cff00FF00Player Only","|cffFFFF00Selected Target","|cffFF0000Mouseover Target"}, 1, "|ccfFFFFFFTarget to Cast On")
        -- Earth Elemental Totem
            br.ui:createSpinner(section, "Earth Elemental Totem", 30, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        -- Earthquake Totem
            br.ui:createSpinner(section, "Earthquake Totem", 40, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        -- Healing Surge
            br.ui:createSpinner(section, "Healing Surge",  80,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        -- Lightning Surge Totem
            br.ui:createSpinner(section, "Lightning Surge Totem - HP", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
            br.ui:createSpinner(section, "Lightning Surge Totem - AoE", 5, 0, 10, 1, "|cffFFFFFFNumber of Units in 5 Yards to Cast At")
        -- Purge
            br.ui:createCheckbox(section,"Purge")
        -- Thunderstorm
            br.ui:createSpinner(section, "Thunderstorm", 25, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        -- Wind Shear
            br.ui:createCheckbox(section,"Wind Shear")
        -- Hex
            br.ui:createCheckbox(section,"Hex")
        -- Lightning Surge Totem
            br.ui:createCheckbox(section,"Lightning Surge Totem")
        -- Thunderstorm
            br.ui:createCheckbox(section,"Thunderstorm - Interrupt")
        -- Earthquake Totem
            br.ui:createCheckbox(section,"Earthquake Totem - Interrupt")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "Interrupt At",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At")
        br.ui:checkSectionState(section)
    -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
        -- Single/Multi Toggle
            br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle,  4)
        -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  3)
        -- Defensive Key Toggle
            br.ui:createDropdown(section, "Defensive Mode", br.dropOptions.Toggle,  6)
        -- Interrupts Key Toggle
            br.ui:createDropdown(section, "Interrupt Mode", br.dropOptions.Toggle,  6)
        -- Pause Toggle
            br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugElemental", math.random(0.15,0.3)) then
        --Print("Running: "..rotationName)

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
        local addsExist                                     = false 
        local addsIn                                        = 999
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local canFlask                                      = canUse(br.player.flask.wod.agilityBig)
        local cast                                          = br.player.cast
        local castable                                      = br.player.cast.debug
        local combatTime                                    = getCombatTime()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or ObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = br.player.enemies
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.agilityBig)
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local hasMouse                                      = ObjectExists("mouseover")
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local moveIn                                        = 999
        local moving                                        = isMoving("player")
        -- local multidot                                      = (useCleave() or br.player.mode.rotation ~= 3)
        local perk                                          = br.player.perk        
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powmax, powgen, powerDeficit           = br.player.power, br.player.powerMax, br.player.powerRegen, br.player.powerDeficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local ttd                                           = getTTD
        local ttm                                           = br.player.timeToMax
        local units                                         = br.player.units
        
   		if leftCombat == nil then leftCombat = GetTime() end
		if profileStop == nil then profileStop = false end
        if resonanceTotemCastTime == nil then resonanceTotemCastTime = 0 end
        if resonanceTotemTimer == nil then resonanceTotemTimer = 0 end
        if lastSpell == spell.totemMastery then resonanceTotemCastTime = GetTime() + 120 end
        if resonanceTotemCastTime > GetTime() then resonanceTotemTimer = resonanceTotemCastTime - GetTime() else resonanceTotemCastTime = 0; resonanceTotemTimer = 0 end

--------------------
--- Action Lists ---
--------------------
	-- Action List - Extras
		local function actionList_Extras()
		-- Dummy Test
			if isChecked("DPS Testing") then
				if ObjectExists("target") then
					if getCombatTime() >= (tonumber(getOptionValue("DPS Testing"))*60) and isDummy() then
						StopAttack()
						ClearTarget()
						Print(tonumber(getOptionValue("DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
						profileStop = true
					end
				end
			end -- End Dummy Test
        -- Ghost Wolf
            if isChecked("Ghost Wolf") and not UnitBuffID("player",202477) then
                if ((#enemies.yards20 == 0 and not inCombat) or (#enemies.yards10 == 0 and inCombat)) and isMoving("player") and not buff.ghostWolf.exists then
                    if cast.ghostWolf() then return end
                end
            end
        -- Purge
            if isChecked("Purge") and canDispel("target",spell.purge) and not isBoss() and ObjectExists("target") then
                if cast.purge() then return end
            end
        -- Spirit Walk
            if isChecked("Spirit Walk") and hasNoControl(spell.spiritWalk) then
                if cast.spiritWalk() then return end
            end
        -- Water Walking
            if falling > 1.5 and buff.waterWalking.exists then
                CancelUnitBuffID("player", spell.waterWalking)
            end
            if isChecked("Water Walking") and not inCombat and IsSwimming() then
                if cast.waterWalking() then return end
            end
		end -- End Action List - Extras
	-- Action List - Defensive
		local function actionList_Defensive()
			if useDefensive() then
		-- Pot/Stoned
                if isChecked("Pot/Stoned") and php <= getOptionValue("Pot/Stoned") 
                    and inCombat and (hasHealthPot() or hasItem(5512)) 
                then
                    if canUse(5512) then
                        useItem(5512)
                    elseif canUse(healPot) then
                        useItem(healPot)
                    end
                end
        -- Heirloom Neck
                if isChecked("Heirloom Neck") and php <= getOptionValue("Heirloom Neck") then
                    if hasEquiped(122668) then
                        if GetItemCooldown(122668)==0 then
                            useItem(122668)
                        end
                    end
                end
        -- Gift of the Naaru
                if isChecked("Gift of the Naaru") and php <= getOptionValue("Gift of the Naaru") and php > 0 and br.player.race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Ancestral Spirit
                if isChecked("Ancestral Spirit") then
                    if getOptionValue("Ancestral Spirit")==1 and hastar and playertar and deadtar then
                        if cast.ancestralSpirit("target") then return end
                    end
                    if getOptionValue("Ancestral Spirit")==2 and hasMouse and playerMouse and deadMouse then
                        if cast.ancestralSpirit("mouseover") then return end
                    end
                end
        -- Astral Shift
                if isChecked("Astral Shift") and php <= getOptionValue("Astral Shift") and inCombat then
                    if cast.astralShift() then return end
                end
        -- Cleanse Spirit
                if isChecked("Cleanse Spirit") then
                    if getOptionValue("Cleanse Spirit")==1 and canDispel("player",spell.cleanseSpirit) then
                        if cast.cleanseSpirit("player") then return; end
                    end
                    if getOptionValue("Cleanse Spirit")==2 and canDispel("target",spell.cleanseSpirit) then
                        if cast.cleanseSpirit("target") then return end
                    end
                    if getOptionValue("Cleanse Spirit")==3 and canDispel("mouseover",spell.cleanseSpirit) then
                        if cast.cleanseSpirit("mouseover") then return end
                    end
                end
        -- Earth Elemental Totem
                if isChecked("Earth Elemental Totem") then
                    if inCombat and php <= getOptionValue("Earth Elemental Totem") then
                        if cast.earthElemental() then return end
                    end
                end
        -- Earthquake Totem
                if isChecked("Earthquake Totem") then
                    if inCombat and php <= getOptionValue("Earthquake Totem") and lastSpell ~= spell.earthquake then
                        if cast.earthquake() then return end
                    end
                end
        -- Healing Surge
                if isChecked("Healing Surge") 
                    and ((inCombat and ((php <= getOptionValue("Healing Surge") / 2 and power > 20) 
                        or (power >= 90 and php <= getOptionValue("Healing Surge")))) or (not inCombat and php <= getOptionValue("Healing Surge") and not moving)) 
                then
                    if cast.healingSurge() then return end
                end
        -- Lightning Surge Totem
                if isChecked("Lightning Surge Totem - HP") and php <= getOptionValue("Lightning Surge Totem - HP") and inCombat and #enemies.yards5 > 0 and lastSpell ~= spell.lightningSurgeTotem then
                    if cast.lightningSurgeTotem("player","ground") then return end
                end
                if isChecked("Lightning Surge Totem - AoE") and #enemies.yards5 >= getOptionValue("Lightning Surge Totem - AoE") and inCombat and lastSpell ~= spell.lightningSurgeTotem then
                    if cast.lightningSurgeTotem("best",nil,getOptionValue("Lightning Surge Totem - AoE"),8) then return end
                end
        -- Thunderstorm
                if inCombat and isChecked("Thunderstorm") and php <= getOptionValue("Thunderstorm") and #enemies.yards5 >= 0 then
                    if cast.thunderstorm() then return end
                end
    		end -- End Defensive Toggle
		end -- End Action List - Defensive
	-- Action List - Interrupts
		local function actionList_Interrupts()
			if useInterrupts() then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("Interrupt At")) then
        -- Wind Shear
                        -- wind_shear
                        if isChecked("Wind Shear") then
                            if cast.windShear(thisUnit) then return end
                        end
        -- Hex
                        if isChecked("Hex") then
                            if cast.hex(thisUnit) then return end
                        end
        -- Lightning Surge Totem
                        if isChecked("Lightning Surge Totem") and cd.windShear > gcd then
                            if hasThreat(thisUnit) and not isMoving(thisUnit) and ttd(thisUnit) > 7 and lastSpell ~= spell.lightningSurgeTotem then
                                if cast.lightningSurgeTotem(thisUnit,"ground") then return end
                            end
                        end
        -- Tunderstorm
                        if isChecked("Thunderstorm - Interrupt") and cd.windShear > gcd and cd.lightningSurgeTotem > gcd then
                            if getDistance(thisUnit) < 10 then
                                if cast.thunderstorm() then return end
                            end
                        end
        -- Earthquake Totem
                        if isChecked("Earthquake Totem - Interrupt") and cd.windShear > gcd and cd.lightningSurgeTotem > gcd and lastSpell ~= spell.earthquake then
                            if getDistance(thisUnit) < 8 then
                                if cast.earthquake() then return end
                            end
                        end
                    end
                end
            end -- End useInterrupts check
		end -- End Action List - Interrupts
	-- Action List - Cooldowns
		local function actionList_Cooldowns()
			if useCDs() and getDistance(units.dyn40) < 40 then
        -- Trinkets
                -- use_item,slot=trinket2,if=buff.chaos_blades.up|!talent.chaos_blades.enabled 
                if isChecked("Trinkets") then
                    -- if buff.chaosBlades or not talent.chaosBlades then 
                        if canUse(13) then
                            useItem(13)
                        end
                        if canUse(14) then
                            useItem(14)
                        end
                    -- end
                end
        -- Legendary Ring
                -- use_item,slot=finger1
                if isChecked("Legendary Ring") then
                    if hasEquiped(124636) and canUse(124636) then
                        useItem(124636)
                    end
                end
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- blood_fury,buff.tigers_fury | berserking,buff.tigers_fury | arcane_torrent,buff.tigers_fury
                if isChecked("Racial") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "Blood Elf") then
                    if castSpell("player",racial,false,false,false) then return end
                end
                if getOptionValue("APL Mode") == 1 then -- SimC

                end
                if getOptionValue("APL Mode") == 2 then -- AMR

                end
        -- Agi-Pot
                -- potion,name=deadly_grace,if=buff.metamorphosis.remains>25
                if isChecked("Agi-Pot") and canUse(109217) and inRaid then
                    -- if buff.remain.metamorphosis > 25 then
                        useItem(109217)
                    -- end
                end
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying() or IsMounted()) then
            -- Flask / Crystal
                -- flask,type=flask_of_the_seventh_demon
                if isChecked("Flask / Crystal") then
                    if inRaid and canFlask and flaskBuff==0 and not UnitBuffID("player",188033) then
                        useItem(br.player.flask.wod.agilityBig)
                        return true
                    end
                    if flaskBuff==0 then
                        if not UnitBuffID("player",188033) and canUse(118922) then --Draenor Insanity Crystal
                            useItem(118922)
                            return true
                        end
                    end
                end
                if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then
            -- Potion - Deadly Grace
                --TODO

                end -- End Pre-Pull
                if isValidUnit("target") and getDistance("target") < 40 then
            -- Stormkeeper
                    if getOptionValue("Artifact") == 1 or (getOptionValue("Artifact") == 2 and useCDs()) then
                        if cast.stormkeeper() then return end
                    end
            -- Totem Mastery
                    if br.timer:useTimer("delayTotemMastery", gcd) and lastSpell ~= spell.totemMastery then
                        if cast.totemMastery() then resonanceTotemCastTime = GetTime() + 120; return end
                    end
            -- Flame Shock
                    if debuff.flameShock[units.dyn10].refresh then
                        if cast.flameShock("target") then StartAttack(); return end
                    else
            -- Lightning Bolt
                        if cast.lightningBolt("target") then StartAttack(); return end
                    end
                end
            end -- End No Combat
        end -- End Action List - PreCombat
    -- Action List - Single Target
        local function actionList_SingleTarget()
        -- Ascendance
            -- ascendance,if=dot.flame_shock.remains>buff.ascendance.duration&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&!buff.stormkeeper.up
            if debuff.flameShock[units.dyn10].remain > buff.ascendance.duration and (combatTime >= 60 or (buff.bloodlust.exists or buff.heroism.exists)) and cd.lavaBurst > 0 and not buff.stormkeeper.exists then
                if useCDs() and isChecked("Ascendance") then
                    if cast.ascendance() then return end
                end
            end
        -- Flame Shock
            -- flame_shock,if=!ticking
            if not debuff.flameShock[units.dyn10].exists then
                if cast.flameShock() then return end
            end
        -- Flame Shock 
            -- flame_shock,if=maelstrom>=20&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<=duration
            if power >= 20 and debuff.flameShock[units.dyn10].remain <= buff.ascendance.duration and cd.ascendance + buff.ascendance.duration <= debuff.flameShock[units.dyn10].duration then
                if cast.flameShock() then return end
            end
        -- Earth Shock
            -- earth_shock,if=maelstrom>=92
            if power >= 92 then
                if cast.earthShock() then return end
            end
        -- Icyfury
            -- icefury,if=raid_event.movement.in<5
            if moveIn < 5 then
                if cast.icefury() then return end
            end
        -- Lava Burst
            -- lava_burst,if=dot.flame_shock.remains>cast_time&(cooldown_react|buff.ascendance.up)
            if debuff.flameShock[units.dyn10].remain > getCastTime(spell.lavaBurst) and (cd.lavaBurst == 0 or buff.ascendance.exists) then
                if cast.lavaBurst() then return end
            end
        -- Elemental Blast
            -- elemental_blast
            if cast.elementalBlast() then return end
        -- Flame Shock
            -- flame_shock,if=maelstrom>=20,target_if=refreshable
            if power >= 20 and debuff.flameShock[units.dyn10].refresh then
                if cast.flameShock() then return end
            end
        -- Frost Shock
            -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&((maelstrom>=20&raid_event.movement.in>buff.icefury.remains)|buff.icefury.remains<(1.5*spell_haste*buff.icefury.stack))
            -- frost_shock,moving=1,if=buff.icefury.up
            if talent.icefury and buff.icefury.exists and ((power >= 20 and moveIn > buff.icefury.remain) or buff.icefury.remain < (1.5 * UnitSpellHaste("player") * buff.icefury.stack)) then
                if cast.frostShock() then return end
            end
            if moving and buff.icefury.exists then
                if cast.frostShock() then return end
            end
        -- Earth Shock
            -- earth_shock,if=maelstrom>=86
            if power >= 86 then
                if cast.earthShock() then return end
            end
        -- Ice Fury
            -- icefury,if=maelstrom<=70&raid_event.movement.in>30&((talent.ascendance.enabled&cooldown.ascendance.remains>buff.icefury.duration)|!talent.ascendance.enabled)
            if power <= 70 and moveIn > 30 and ((talent.ascendance and cd.ascendance > buff.icefury.duration) or not talent.ascendance) then
                if cast.icefury() then return end
            end
        -- Liquid Magma
            -- liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
            if (#enemies.yards8 < 3 or addsIn > 50) and getDistance(units.dyn8) < 8 and lastSpell ~= spell.liquidMagmaTotem then
                if cast.liquidMagmaTotem("target") then return end
            end
        -- Stormkeeper
            -- stormkeeper,if=(talent.ascendance.enabled&cooldown.ascendance.remains>10)|!talent.ascendance.enabled
            if getOptionValue("Artifact") == 1 or (getOptionValue("Artifact") == 2 and useCDs()) then
                if (talent.ascendance and cd.ascendance > 10) or not talent.ascendance then
                    if cast.stormkeeper() then return end
                end
            end
        -- Totem Mastery 
            -- totem_mastery,if=buff.resonance_totem.remains<10|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15)
            if (resonanceTotemTimer < 10 or (resonanceTotemTimer < (buff.ascendance.duration + cd.ascendance) and cd.ascendance < 15)) and lastSpell ~= spell.totemMastery then
                if cast.totemMastery() then resonanceTotemCastTime = GetTime() + 120; return end
            end
        -- Lava Beam
            -- lava_beam,if=active_enemies>1&spell_targets.lava_beam>1,target_if=!debuff.lightning_rod.up
            -- lava_beam,if=active_enemies>1&spell_targets.lava_beam>1
            if #enemies.yards8 > 1 and not mode.rotation == 3 then
                if cast.lavaBeam() then return end
            end
        -- Chain Lightning
            -- chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1,target_if=!debuff.lightning_rod.up
            -- chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
            if #enemies.yards8 > 1 and not mode.rotation == 3 and not debuff.lightningRod[units.dyn10].exists then
                if cast.chainLightning() then return end
            end
            if #enemies.yards8 > 1 and not mode.rotation == 3 then
                if cast.chainLightning() then return end
            end
        -- Lightning Bolt
            -- lightning_bolt,target_if=!debuff.lightning_rod.up
            -- lightning_bolt
            if not debuff.lightningRod[units.dyn10].exists then
                if cast.lightningBolt() then return end
            end
            if cast.lightningBolt() then return end
        -- Frost Shock
            -- frost_shock,if=maelstrom>=20&dot.flame_shock.remains>19
            if power >= 20 and debuff.flameShock[units.dyn10].remain > 19 then
                if cast.frostShock() then return end
            end
        -- Flame Shock
            -- flame_shock,moving=1,target_if=refreshable
            -- flame_shock,moving=1
            if moving and debuff.flameShock[units.dyn10].refresh then 
                if cast.flameShock() then return end
            end
            if moving then
                if cast.flameShock() then return end
            end
        end  -- End Single Target Action List
    -- Action List - Multi Target
        local function actionList_MultiTarget()
        -- Stormkeeper
            -- stormkeeper
            if getOptionValue("Artifact") == 1 or (getOptionValue("Artifact") == 2 and useCDs()) then
                if cast.stormkeeper() then return end
            end
        -- Ascendance
            -- ascendance
            if useCDs() and isChecked("Ascendance") then
                if cast.ascendance() then return end
            end
        -- Liquid Magma Totem
            -- liquid_magma_totem
            if lastSpell ~= spell.liquidMagmaTotem then
                if cast.liquidMagmaTotem("target") then return end 
            end
        -- Flame Shock
            -- flame_shock,if=spell_targets.chain_lightning=3&maelstrom>=20,target_if=refreshable
            if power >= 20 then
                for i = 1, #enemies.yards8 do
                    local thisUnit = enemies.yards8[i]
                    if debuff.flameShock[thisUnit].remain < 2 and (UnitIsUnit(thisUnit,"target") or hasThreat(thisUnit) or isDummy(thisUnit)) then
                        if cast.flameShock(thisUnit) then return end
                    end
                end
            end
        -- Earthquake Totem
            -- earthquake_totem
            if lastSpell ~= spell.earthquake then
                if cast.earthquake() then return end
            end
        -- Lava Burst
            -- lava_burst,if=buff.lava_surge.up&spell_targets.chain_lightning=3
            if buff.lavaSurge.exists and (#enemies.yards8 == 3 or mode.rotation == 2) then
                if cast.lavaBurst() then return end
            end
        -- Lava Beam
            -- lava_beam
            if cast.lavaBeam() then return end
        -- Chain Lightning
            -- chain_lightning,target_if=!debuff.lightning_rod.up
            -- chain_lightning
            if not debuff.lightningRod[units.dyn10].exists then
                if cast.chainLightning() then return end
            end
            if cast.chainLightning() then return end
        -- Lava Burst
            -- lava_burst,moving=1
            if moving then
                if cast.lavaBurst() then return end
            end
        -- Flame Shock
            -- flame_shock,moving=1,target_if=refreshable
            if moving then
                for i = 1, #enemies.yards8 do
                    local thisUnit = enemies.yards8[i]
                    if debuff.flameShock[thisUnit].remain < 2 and (UnitIsUnit(thisUnit,"target") or hasThreat(thisUnit) or isDummy(thisUnit)) then
                        if cast.flameShock(thisUnit) then return end
                    end
                end
            end
        end -- End Multi Target Action List
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or pause() or mode.rotation==4 then
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
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and profileStop==false and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40 then
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL Mode") == 1 then
            -- Potion - Deadly Grace
                    -- if=buff.ascendance.up|target.time_to_die<=30
                    -- TODO
            -- Totem Mastery
                    -- totem_mastery,if=buff.resonance_totem.remains<2
                    if resonanceTotemTimer < 2 and lastSpell ~= spell.totemMastery then
                        if cast.totemMastery() then resonanceTotemCastTime = GetTime() + 120; return end
                    end
                    if useCDs() then
                        if isChecked("Fire/Storm Elemental Totem") then
            -- Fire Elemental
                            -- fire_elemental
                            if cast.fireElemental() then return end
            -- Storm Elemental
                            -- storm_elemental
                            if cast.stormElemental() then return end
                        end
                        if isChecked("Elemental Mastery") then
            -- Elemental Mastery
                            -- elemental_mastery
                            if cast.elementalMastery() then return end
                        end
            -- Racials
                        -- blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
                        -- berserking,if=!talent.ascendance.enabled|buff.ascendance.up
                        if not talent.ascendance or buff.ascendance.exists or cd.ascendance > 50 then
                            if race == "Orc" then
                                if castRacial() then return end
                            end
                        end
                        if not talent.ascendance or buff.ascendance.exists then
                            if race == "Troll" then
                                if castRacial() then return end
                            end
                        end
                    end
            -- Action List - Multi Target
                    -- run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2)
                    if (#enemies.yards8 > 2 and mode.rotation == 1) or mode.rotation == 2 then
                        if actionList_MultiTarget() then return end
                    end
            -- Action List - Single Target
                    -- run_action_list,name=single
                    if (#enemies.yards8 <= 2 and mode.rotation == 1) or mode.rotation == 3 then
                        if actionList_SingleTarget() then return end
                    end
                end -- End SimC APL
    ----------------------
    --- AskMrRobot APL ---
    ----------------------
                if getOptionValue("APL Mode") == 2 then

                end
			end --End In Combat
		end --End Rotation Logic
    end -- End Timer
end -- End runRotation
local id = 262
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})