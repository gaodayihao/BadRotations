local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.agony},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.corruption},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.drainLife},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.healthFunnel}
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
        section = br.ui:createSection(br.ui.window.profile, "General")
        -- APL
            br.ui:createDropdownWithout(section, "APL Mode", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFFSet APL Mode to use.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
        -- Opener
            br.ui:createCheckbox(section,"Opener")
        -- Summon Pet
            br.ui:createDropdownWithout(section, "Summon Pet", {"Imp","Voidwalker","Felhunter","Succubus","Felguard", "Doomguard", "Infernal", "None"}, 1, "|cffFFFFFFSelect default pet to summon.")
        -- Grimoire of Service
            br.ui:createDropdownWithout(section, "Grimoire of Service", {"Imp","Voidwalker","Felhunter","Succubus","Felguard","None"}, 1, "|cffFFFFFFSelect pet to Grimoire.")
        -- Artifact 
            br.ui:createDropdownWithout(section,"Artifact", {"|cff00FF00Everything","|cffFFFF00Cooldowns","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Artifact Ability.")
        -- Mana Tap
            br.ui:createSpinner(section, "Life Tap HP Limit", 30, 0, 100, 5, "|cffFFFFFFHP Limit that Life Tap will not cast below.")
        -- Multi-Dot Limit
            br.ui:createSpinnerWithout(section, "Multi-Dot Limit", 5, 0, 10, 1, "|cffFFFFFFUnit Count Limit that DoTs will be cast on.")
            br.ui:createSpinnerWithout(section, "Multi-Dot HP Limit", 5, 0, 10, 1, "|cffFFFFFFHP Limit that DoTs will be cast/refreshed on.") 
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
        -- Racial
            br.ui:createCheckbox(section,"Racial")
        -- Trinkets
            br.ui:createCheckbox(section,"Trinkets")
        -- Soul Harvest
            br.ui:createCheckbox(section,"Soul Harvest")
        -- Summon Doomguard
            br.ui:createCheckbox(section,"Summon Doomguard")
        -- Summon Infernal
            br.ui:createCheckbox(section,"Summon Infernal")
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
        -- Dark Pact
            br.ui:createSpinner(section, "Dark Pact", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        -- Drain Soul
            br.ui:createSpinner(section, "Drain Soul", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        -- Health Funnel
            br.ui:createSpinner(section, "Health Funnel", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        -- Unending Resolve
            br.ui:createSpinner(section, "Unending Resolve", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        -- Couterspell
            br.ui:createCheckbox(section, "Counterspell")
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
    if br.timer:useTimer("debugAffliction", math.random(0.15,0.3)) then
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
        local activePet                                     = br.player.pet
        local activePetId                                   = br.player.petId
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
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
        local grimoirePet                                   = getOptionValue("Grimoire of Service")
        local hasMouse                                      = ObjectExists("mouseover")
        local hasteAmount                                   = GetHaste()/100
        local hasPet                                        = IsPetActive()
        local healPot                                       = getHealthPot()
        local heirloomNeck                                  = 122663 or 122664
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local manaPercent                                   = br.player.power.mana.percent
        local mode                                          = br.player.mode
        local moveIn                                        = 999
        local moving                                        = isMoving("player")
        local perk                                          = br.player.perk
        local petInfo                                       = br.player.petInfo        
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen, br.player.power.mana.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local shards                                        = br.player.power.amount.soulShards
        local summonPet                                     = getOptionValue("Summon Pet")
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local travelTime                                    = getDistance("target")/16
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = br.player.units

        local agonyCount = getDebuffCount(spell.debuffs.agony)
        local corruptionCount = getDebuffCount(spell.debuffs.corruption)
        local siphonLifeCount = getDebuffCount(spell.debuffs.siphonLife)
        
   		if leftCombat == nil then leftCombat = GetTime() end
		if profileStop == nil or not inCombat then profileStop = false end
        if castSummonId == nil then castSummonId = 0 end
        if summonTime == nil then summonTime = 0 end
        if effigied == nil then effigied = false; effigyCount = 0 end
        if isBoss() then dotHPLimit = getOptionValue("Multi-Dot HP Limit")/10 else dotHPLimit = getOptionValue("Multi-Dot HP Limit") end

        if debuff.unstableAffliction1[units.dyn40] ~= nil then
            if debuff.unstableAffliction1[units.dyn40].exists then UA1 = 1; UA1remain = debuff.unstableAffliction1[units.dyn40].remain else UA1 = 0; UA1remain = 0 end
        end
        if debuff.unstableAffliction2[units.dyn40] ~= nil then
            if debuff.unstableAffliction2[units.dyn40].exists then UA2 = 1; UA2remain = debuff.unstableAffliction2[units.dyn40].remain else UA2 = 0; UA2remain = 0 end
        end
        if debuff.unstableAffliction3[units.dyn40] ~= nil then
            if debuff.unstableAffliction3[units.dyn40].exists then UA3 = 1; UA3remain = debuff.unstableAffliction3[units.dyn40].remain else UA3 = 0; UA3remain = 0 end
        end
        if debuff.unstableAffliction4[units.dyn40] ~= nil then
            if debuff.unstableAffliction4[units.dyn40].exists then UA4 = 1; UA4remain = debuff.unstableAffliction4[units.dyn40].remain else UA4 = 0; UA4remain = 0 end
        end
        if debuff.unstableAffliction5[units.dyn40] ~= nil then
            if debuff.unstableAffliction5[units.dyn40].exists then UA5 = 1; UA5remain = debuff.unstableAffliction5[units.dyn40].remain else UA5 = 0; UA5remain = 0 end
        end
        if sindoreiSpiteOffCD == nil then sindoreiSpiteOffCD = true end
        if buff.sindoreiSpite.exits and sindoreiSpiteOffCD then 
            sindoreiSpiteOffCD = false 
            C_Timer.After(180, function()
                sindoreiSpiteOffCD = true
            end) 
        end

        -- Opener Variables
        if not inCombat and not ObjectExists("target") then 
            -- DE1 = false
            -- DSB1 = false
            -- DOOM = false
            -- SDG = false
            -- GRF = false
            -- DE2 = false
            -- DSB2 = false
            -- DGL = false
            -- DE3 = false
            -- DSB3 = false
            -- DSB4 = false
            -- DSB5 = false
            -- HVST = false
            -- DRS = false
            -- HOG = false
            -- DE5 = false
            -- TKC = false
            opener = false
        end

        for i = 1, #enemies.yards40 do
            local thisUnit = enemies.yards40[i]
            if ObjectID(thisUnit) == 103679 then
                effigyUnit = thisUnit;
                effigied = true;
                effigyCount = 1;
                break
            end
            effigyUnit = "player";
            effigyCount = 0;
            effigied = false
        end

        -- Pet Data
        if summonPet == 1 then summonId = 416 end
        if summonPet == 2 then summonId = 1860 end
        if summonPet == 3 then summonId = 417 end
        if summonPet == 4 then summonId = 1863 end
        if summonPet == 5 then summonId = 17252 end
        if summonPet == 6 then summonId = 78158 end
        if summonPet == 7 then summonId = 78217 end
        if cd.grimoireOfService == 0 or prevService == nil then prevService = "None" end
        
        local doomguard = false
        local infernal = false
        if br.player.petInfo ~= nil then
            for i = 1, #br.player.petInfo do
                local thisUnit = br.player.petInfo[i].id
                if thisUnit == 11859 then doomguard = true end
                if thisUnit == 89 then infernal = true end
            end
        end
        if UnitExists(effigyUnit) and UnitIsUnit("target",effigyUnit) then FocusUnit(effigyUnit); ClearTarget(); TargetUnit(units.dyn40); return end

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
                        PetFollow()
						Print(tonumber(getOptionValue("DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
						profileStop = true
					end
				end
			end -- End Dummy Test
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
                    if hasEquiped(heirloomNeck) then
                        if GetItemCooldown(heirloomNeck)==0 then
                            useItem(heirloomNeck)
                        end
                    end
                end
        -- Gift of the Naaru
                if isChecked("Gift of the Naaru") and php <= getOptionValue("Gift of the Naaru") and php > 0 and br.player.race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Dark Pact
                if isChecked("Dark Pact") and php <= getOptionValue("Dark Pact") then
                    if cast.darkPact() then return end
                end
        -- Drain Soul
                if isChecked("Drain Soul") and php <= getOptionValue("Drain Soul") and isValidTarget("target") then
                    if cast.drainSoul() then return end
                end
        -- Health Funnel
                if isChecked("Health Funnel") and getHP("pet") <= getOptionValue("Health Funnel") and ObjectExists("pet") and not UnitIsDeadOrGhost("pet") then
                    if cast.healthFunnel() then return end
                end
        -- Unending gResolve
                if isChecked("Unending Resolve") and php <= getOptionValue("Unending Resolve") and inCombat then
                    if cast.unendingResolve() then return end
                end
    		end -- End Defensive Toggle
		end -- End Action List - Defensive
	-- Action List - Interrupts
		local function actionList_Interrupts()
			if useInterrupts() then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("Interrupt At")) then

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
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- blood_fury | berserking | arcane_torrent
                if isChecked("Racial") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "Blood Elf") then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Soul Harvest
                -- soul_harvest
                if isChecked("Soul Harvest") then
                    if cast.soulHarvest() then return end
                end
        -- Potion
                -- potion,name=deadly_grace,if=buff.soul_harvest.remains|target.time_to_die<=45|trinket.proc.any.react
                -- TODO
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
            -- Summon Pet
            -- summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
            if not (IsFlying() or IsMounted()) and (not talent.grimoireOfSacrifice or not buff.demonicPower.exists) and level >= 5 and br.timer:useTimer("summonPet", getCastTime(spell.summonVoidwalker) + gcd) then
                if (activePetId == 0 or activePetId ~= summonId) and (lastSpell ~= castSummonId or activePetId ~= summonId) then
                    if summonPet == 1 then
                        if isKnown(spell.summonFelImp) then
                            if cast.summonFelImp("player") then castSummonId = spell.summonFelImp; return end
                        else  
                            if cast.summonImp("player") then castSummonId = spell.summonImp; return end
                        end
                    end
                    if summonPet == 2 then
                        if cast.summonVoidwalker("player") then castSummonId = spell.summonVoidwalker; return end
                    end
                    if summonPet == 3 then
                        if cast.summonFelhunter("player") then castSummonId = spell.summonFelhunter; return end
                    end
                    if summonPet == 4 then
                        if cast.summonSuccubus("player") then castSummonId = spell.summonSuccubus; return end
                    end
                    if summonPet == 5 then
                        if cast.summonFelguard("player") then castSummonId = spell.summonFelguard; return end
                    end
                    if summonPet == 6 then
                       if talent.grimoireOfSupremacy then
                            if cast.summonDoomguard("player") then castSummonId = spell.summonDoomguard; return end
                        end 
                    end
                    if summonPet == 7 then
                        if talent.grimoireOfSupremacy then
                            if cast.summonInfernal("player") then castSummonId = spell.summonInfernal; return end
                        end
                    end
                    if summonPet == 8 then return end
                end
            end
            if not inCombat and not (IsFlying() or IsMounted()) then
            -- Flask
                -- flask,type=whispered_pact
                -- TODO
            -- Food
                -- food,type=azshari_salad
                -- TODO
                if (not isChecked("Opener") or opener == true) then
                -- Augmentation
                    -- augmentation,type=defiled
                    -- TODO
                -- Grimoire of Sacrifice
                    -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
                    if talent.grimoireOfSacrifice and ObjectExists("pet") and not UnitIsDeadOrGhost("pet") then
                        if cast.grimoireOfSacrifice() then return end
                    end
                    if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then

                    end -- End Pre-Pull
                    if isValidUnit("target") and getDistance("target") < 40 and (not isChecked("Opener") or opener == true) then
                -- Life Tap
                        -- life_tap,if=talent.empowered_life_tap.enabled&!buff.empowered_life_tap.remains
                        if talent.empoweredLifeTap and not buff.empoweredLifeTap.exists then
                            if cast.lifeTap() then return end
                        end
                -- Potion
                        -- potion,name=deadly_grace
                        -- TODO
                -- Pet Attack/Follow
                        if UnitExists("target") and not UnitAffectingCombat("pet") then
                            PetAssistMode()
                            PetAttack("target")
                        end
                -- Opening Ability
                        if cast.agony("target","aoe") then return end
                        if level < 10 then 
                            if cast.shadowBolt() then return end
                        end
                    end
                end
            end -- End No Combat
        end -- End Action List - PreCombat
        local function actionList_Opener()
            if isBoss("target") and isValidUnit("target") and opener == false then
                if (isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer")) or not isChecked("Pre-Pull Timer") then
                        opener = true
                end
            end
        end
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or pause(true) or isCastingSpell(spell.soulEffigy) or mode.rotation==4 then
            if not pause() then
                PetFollow()
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
-----------------------
--- Opener Rotation ---
-----------------------
            if opener == false and isChecked("Opener") and isBoss("target") then
                if actionList_Opener() then return end
            end
---------------------------
--- Pre-Combat Rotation ---
---------------------------
			if actionList_PreCombat() then return end
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and profileStop==false and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40 
                and (opener == true or not isChecked("Opener") or not isBoss("target")) 
            then
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL Mode") == 1 then
        -- Pet Attack
                    if UnitIsUnit("target",units.dyn40) and not UnitIsUnit("pettarget",units.dyn40) then
                        PetAttack()
                    end
        -- Reap Souls
                    -- reap_souls,if=!buff.deadwind_harvester.remains&(buff.soul_harvest.remains|buff.tormented_souls.react>=8|target.time_to_die<=buff.tormented_souls.react*5|!talent.malefic_grasp.enabled&(trinket.proc.any.react|trinket.stacking_proc.any.react))
                    --if not buff.deadwindHarvester.exists and (buff.soulHarvest.exists or buff.tormentedSouls.stack >= 8 or ttd(units.dyn40) <= buff.tormentedSouls.stack * 5) then
                    if (getOptionValue("Artifact") == 1 or (getOptionValue("Artifact") == 2 and useCDs())) 
                        and (buff.tormentedSouls.stack >= 8 or (hasEquiped(144364) and buff.tormentedSouls.stack >= 6)) 
                    then
                        if cast.reapSouls() then return end
                    end
        -- Soul Effigy
                    -- soul_effigy,if=!pet.soul_effigy.active
                    if not effigied then
                        if cast.soulEffigy("target") then return end
                    end
                    if effigied then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if ObjectID(thisUnit) == 103679 then
                                -- Agony
                                if getDebuffRemain(thisUnit,spell.debuffs.agony,"player") < 2 + gcd then
                                    if cast.agony(thisUnit,"aoe") then return end
                                end
                                -- Corruption
                                if math.abs(getDebuffRemain(thisUnit,spell.debuffs.corruption,"player")) < 2 + gcd then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                                -- Siphon Life
                                if getDebuffRemain(thisUnit,spell.debuffs.siphonLife,"player") < 2 + gcd then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Agony
                    -- agony,cycle_targets=1,if=remains<=tick_time+gcd
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local agony = debuff.agony[thisUnit]
                        if agony ~= nil then
                            if agonyCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) and agony.remain <= 2 + gcd then
                                if cast.agony(thisUnit,"aoe") then return end
                            end
                        end
                    end
        -- Service Pet
                    -- service_pet,if=dot.corruption.remains&dot.agony.remains
                    if ObjectExists("target") then
                        if debuff.corruption["target"].exists and debuff.agony["target"].exists and br.timer:useTimer("summonPet", getCastTime(spell.summonVoidwalker)+gcd) then
                            if grimoirePet == 1 then
                                if cast.grimoireImp("player") then prevService = "Imp"; return end
                            end
                            if grimoirePet == 2 then
                                if cast.grimoireVoidwalker("player") then prevService = "Voidwalker"; return end
                            end
                            if grimoirePet == 3 then
                                if cast.grimoireFelhunter("player") then prevService = "Felhunter"; return end
                            end
                            if grimoirePet == 4 then
                                if cast.grimoireSuccubus("player") then prevService = "Succubus"; return end
                            end
                            if grimoirePet == 5 then
                                if cast.grimoireFelguard("player") then prevService = "Felguard"; return end
                            end
                            if summonPet == 6 then
                               if talent.grimoireOfSupremacy and not hasEquiped(132379) then
                                    if cast.summonDoomguard("player") then castSummonId = spell.summonDoomguard; return end
                                end 
                            end
                            if summonPet == 7 then
                                if talent.grimoireOfSupremacy and not hasEquiped(132379) then
                                    if cast.summonInfernal("player") then castSummonId = spell.summonInfernal; return end
                                end
                            end
                            if summonPet == 8 then return end
                        end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
                    if useCDs() and isChecked("Summon Doomguard") then
                        if not talent.grimoireOfSupremacy and #enemies.yards8t <= 2
                            and (ttd(units.dyn40) > 180 or getHP(units.dyn40) <= 20 or ttd(units.dyn40) < 30 or isDummy())
                        then
                            if cast.summonDoomguard() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>2
                    if useCDs() and isChecked("Summon Infernal") then
                        if not talent.grimoireOfSupremacy and #enemies.yards8t > 2 then
                            if cast.summonInfernal() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
                    if useCDs() and isChecked("Summon Doomguard") then
                        if talent.grimoireOfSupremacy and #enemies.yards8t == 1 and hasEquiped(132379) and sindoreiSpiteOffCD and GetTime() > summonTime + 275 then
                            
                            if cast.summonDoomguard() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
                    if useCDs() and isChecked("Summon Infernal") then
                        if talent.grimoireOfSupremacy and #enemies.yards8t > 1 and hasEquiped(132379) and sindoreiSpiteOffCD and GetTime() > summonTime + 275 then
                            
                            if cast.summonInfernal() then summonTime = GetTime(); return end
                        end
                    end
        -- Cooldowns
                    if actionList_Cooldowns() then return end
        -- Corruption
                    -- corruption,if=remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<4)
                    if debuff.corruption[units.dyn40] ~= nil then
                        if corruptionCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                            if debuff.corruption[units.dyn40].remain <= 2 + gcd and ((#enemies.yards10t < 10 and talent.sowTheSeeds) or #enemies.yards10t < 4) then
                                if cast.corruption(units.dyn40,"aoe") then return end
                            end
                        end
                    end
                    -- corruption,cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<4)
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local corruption = debuff.corruption[thisUnit]
                        if corruption ~= nil then
                            if corruptionCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if (talent.absoluteCorruption or not talent.maleficGrasp or not talent.soulEffigy) and corruption.remain <= 2 + gcd 
                                    and ((#enemies.yards10t < 10 and talent.sowTheSeeds) or #enemies.yards10t < 4) 
                                then                                
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Siphon Life
                    -- siphon_life,if=remains<=tick_time+gcd
                    -- siphon_life,if=remains<=tick_time+gcd&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)<2
                    if debuff.siphonLife[units.dyn40] ~= nil then
                        if siphonLifeCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                            if debuff.siphonLife[units.dyn40].remain <= 2 + gcd and (UA1 + UA2 + UA3 + UA4 + UA5) < 2 then
                                if cast.siphonLife(units.dyn40,"aoe") then return end
                            end
                        end
                    end
                    -- siphon_life,cycle_targets=1,if=(!talent.malefic_grasp.enabled||!talent.soul_effigy.enabled)&remains<=tick_time+gcd
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local siphonLife = debuff.siphonLife[thisUnit]
                        if siphonLife ~= nil then
                            if siphonLifeCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if (not talent.maleficGrasp or not talent.soulEffigy) and siphonLife.remain <= 2 + gcd then                                
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Life Tap
                    -- life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
                    if talent.empoweredLifeTap and buff.empoweredLifeTap.remain <= gcd then
                        if cast.lifeTap() then return end
                    end
        -- Phantom Singularity
                    -- phantom_singularity
                    if cast.phantomSingularity(nil,"debug") then
                        if cast.phantomSingularity() then return end
                    end
        -- Haunt
                    -- haunt
                    if castable.haunt then
                        if cast.haunt() then return end
                    end
        -- Agony
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local agony = debuff.agony[thisUnit]
                        local ua1 = debuff.unstableAffliction1[thisUnit]
                        local ua2 = debuff.unstableAffliction2[thisUnit]
                        local ua3 = debuff.unstableAffliction3[thisUnit]
                        local ua4 = debuff.unstableAffliction4[thisUnit]
                        local ua5 = debuff.unstableAffliction5[thisUnit]
                        if ua1 ~= nil and ua1.exists then ua1count = 1 else ua1count = 0 end
                        if ua2 ~= nil and ua2.exists then ua2count = 1 else ua2count = 0 end
                        if ua3 ~= nil and ua3.exists then ua3count = 1 else ua3count = 0 end
                        if ua4 ~= nil and ua4.exists then ua4count = 1 else ua4count = 0 end
                        if ua5 ~= nil and ua5.exists then ua5count = 1 else ua5count = 0 end
                        if agony ~= nil then
                            if agonyCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                -- agony,cycle_targets=1,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
                                if not talent.maleficGrasp and agony.refresh and ttd(thisUnit) >= agony.remain then
                                    if cast.agony(thisUnit,"aoe") then return end
                                end
                                -- agony,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
                                if agony.refresh and ttd(thisUnit) >= agony.remain and (ua1count + ua2count + ua3count + ua4count + ua5count) == 0 then
                                    if cast.agony(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Life Tap
                    -- life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3|talent.malefic_grasp.enabled&target.time_to_die>15&mana.pct<10
                    if talent.empoweredLifeTap and buff.empoweredLifeTap.refresh or (talent.maleficGrasp and ttd(units.dyn40) > 15 and manaPercent < 10) then
                        if cast.lifeTap() then return end
                    end
        -- Seed of Corruption
                    -- seed_of_corruption,if=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3|spell_targets.seed_of_corruption>=4|spell_targets.seed_of_corruption=3&dot.corruption.remains<=cast_time+travel_time
                    if (talent.sowTheSeeds and #enemies.yards10t >= 3) or #enemies.yards10t >= 4 or (#enemies.yards10t == 3 and debuff.corruption[units.dyn40] ~= nil and debuff.corruption[units.dyn40].remain <= getCastTime(spell.seedOfCorruption)) then
                        if cast.seedOfCorruption() then return end
                    end
        -- Corruption
                    if debuff.corruption[units.dyn40] ~= nil then
                        if corruptionCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                            -- corruption,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
                            if not talent.maleficGrasp and debuff.corruption[units.dyn40].refresh and ttd(units.dyn40) >= debuff.corruption[units.dyn40].remain then
                                if cast.corruption(units.dyn40,"aoe") then return end
                            end
                            -- corruption,if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
                            if debuff.corruption[units.dyn40].refresh and (UA1 + UA2 + UA3 + UA4 + UA5) == 0 then
                                if cast.corruption(units.dyn40,"aoe") then return end
                            end
                        end
                    end
                    -- corruption,cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local corruption = debuff.corruption[thisUnit]
                        if corruption ~= nil then
                            if corruptionCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if (talent.absoluteCorruption or not talent.maleficGrasp or not talent.soulEffigy) and corruption.refresh and ttd(thisUnit) >= corruption.remain then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Haunt
                    -- haunt
                    if cast.haunt(nil,"debug") then
                        
                        if cast.haunt() then return end
                    end
        -- Siphon Life
                    if debuff.siphonLife[units.dyn40] ~= nil then
                        if siphonLifeCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                            -- siphon_life,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
                            if not talent.maleficGrasp and debuff.siphonLife[units.dyn40].refresh and ttd(units.dyn40) >= debuff.siphonLife[units.dyn40].remain then
                                if cast.siphonLife(units.dyn40,"aoe") then return end
                            end
                            -- siphon_life,if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
                            if debuff.siphonLife[units.dyn40].refresh and (UA1 + UA2 + UA3 + UA4 + UA5) == 0 then
                                if cast.siphonLife(units.dyn40,"aoe") then return end
                            end
                        end
                    end
                    -- siphon_life,cycle_targets=1,if=(!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        local siphonLife = debuff.siphonLife[thisUnit]
                        if siphonLife ~= nil then
                            if siphonLifeCount < getOptionValue("Multi-Dot Limit") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if isValidUnit(thisUnit) and (not talent.maleficGrasp or not talent.soulEffigy) and siphonLife.refresh and ttd(thisUnit) >= siphonLife.remain then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end

        -- Unsable Affliction
                   -- unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.writhe_in_agony.enabled&talent.contagion.enabled&dot.unstable_affliction_1.remains<cast_time&dot.unstable_affliction_2.remains<cast_time&dot.unstable_affliction_3.remains<cast_time&dot.unstable_affliction_4.remains<cast_time&dot.unstable_affliction_5.remains<cast_time
                    if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.writheInAgony 
                        and talent.contagion and UA1remain < getCastTime(spell.unstableAffliction) 
                    then
                        if cast.unstableAffliction(units.dyn40,"aoe") then return end
                    end
                    -- unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.writhe_in_agony.enabled&(soul_shard>=4|trinket.proc.intellect.react|trinket.stacking_proc.mastery.react|trinket.proc.mastery.react|trinket.proc.crit.react|trinket.proc.versatility.react|buff.soul_harvest.remains|buff.deadwind_harvester.remains|buff.compounding_horror.react=5|target.time_to_die<=20)
                    if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.writheInAgony 
                        and (shards >= 4 or buff.soulHarvest.exists or buff.deadwindHarvester.exists or buff.compoundingHorror.stack == 5 or ttd(units.dyn40) <= 20) 
                    then
                        if cast.unstableAffliction(units.dyn40,"aoe") then return end
                    end
                    -- unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&target.time_to_die<30
                    if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.maleficGrasp and ttd(units.dyn40) < 30 then
                        if cast.unstableAffliction(units.dyn40,"aoe") then return end
                    end
                    -- unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&(soul_shard=5|talent.contagion.enabled&soul_shard>=4)
                    if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.maleficGrasp and (shards == 5 or (talent.contagion and shards >= 4)) then
                        if cast.unstableAffliction(units.dyn40,"aoe") then return end
                    end
                    -- unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&!prev_gcd.3.unstable_affliction&dot.agony.remains>cast_time*3+6.5&(!talent.soul_effigy.enabled|pet.soul_effigy.dot.agony.remains>cast_time*3+6.5)&(dot.corruption.remains>cast_time+6.5|talent.absolute_corruption.enabled)&(dot.siphon_life.remains>cast_time+6.5|!talent.siphon_life.enabled)
                    if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.maleficGrasp 
                        and (lastSpell ~= spell.unstableAffliction and not UA3) and debuff.agony[units.dyn40] ~= nil and debuff.agony[units.dyn40].remain > getCastTime(spell.unstableAffliction) * 3 + 6.5 
                        and (not talent.soulEffigy or getDebuffRemain("Soul Effigy",spell.debuffs.agony,"player") > getCastTime(spell.unstableAffliction) * 3 + 6.5) 
                        and (debuff.corruption[units.dyn40] ~= nil and debuff.corruption[units.dyn40].remain > getCastTime(spell.unstableAffliction) + 6.5 or talent.absoluteCorruption) 
                        and (debuff.siphonLife[units.dyn40] ~= nil and debuff.siphonLife[units.dyn40].remain > getCastTime(spell.unstableAffliction) + 6.5 or not talent.siphonLife) 
                    then
                        if cast.unstableAffliction(units.dyn40,"aoe") then return end
                    end
                    -- unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&talent.haunt.enabled&(soul_shard>=4|debuff.haunt.remains>6.5|target.time_to_die<30)
                    if (not talent.sowTheSeeds or #enemies.yards10t < 3) and #enemies.yards10t < 4 and talent.haunt 
                        and (shards >= 4 or (debuff.haunt[units.dyn40] ~= nil and debuff.haunt[units.dyn40].exists) or ttd(units.dyn40) < 30) 
                    then
                        if cast.unstableAffliction(units.dyn40,"aoe") then return end
                    end
        -- -- Reap Soul
        --             -- reap_souls,if=!buff.deadwind_harvester.remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)>1&((!trinket.has_stacking_stat.any&!trinket.has_stat.any)|talent.malefic_grasp.enabled)
        --             if not buff.deadwindHarvester.exists and (UA1 + UA2 + UA3 + UA4 + UA5) > 1 and talent.maleGrasp then
        --                 if cast.reapSouls() then return end
        --             end
        --             -- reap_souls,if=!buff.deadwind_harvester.remains&prev_gcd.1.unstable_affliction&((!trinket.has_stacking_stat.any&!trinket.has_stat.any)|talent.malefic_grasp.enabled)&buff.tormented_souls.react>1
        --             if not buff.deadwindHarvester.exists and (lastSpell ~= spell.unstableAffliction and UA1) and talent.maleGrasp and buff.tormentedSouls.stack > 1 then
        --                 if cast.reapSouls() then return end
        --             end
        -- Life Tap
                    -- life_tap,if=mana.pct<=10
                    if manaPercent <= 10 and php > getOptionValue("Life Tap HP Limit") then
                        if cast.lifeTap() then return end
                    end
        -- Drain Soul
                    -- drain_soul,chain=1,interrupt=1
                    if not isCastingSpell(spell.drainSoul,"player") then
                        if not ObjectExists("target") then TargetUnit("target") end
                        if cast.drainSoul("target") then return end
                    end
        -- Life Tap
                    --life_tap
                    if manaPercent < 70 and php > getOptionValue("Life Tap HP Limit") then
                        if cast.lifeTap() then return end
                    end
        -- Shadow Bolt
                    if level < 13 then
                        if cast.shadowBolt() then return end
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
local id = 265
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})