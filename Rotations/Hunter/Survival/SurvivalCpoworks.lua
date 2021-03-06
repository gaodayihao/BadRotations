local rotationName = "Cpoworks" -- Change to name of profile listed in options drop down

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.furyOfTheEagle },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.carve },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.mongooseBite },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.throwingAxes}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.aspectOfTheEagle },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.aspectOfTheEagle },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.aspectOfTheEagle }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.aspectOfTheTurtle },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.aspectOfTheTurtle }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.muzzle },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.muzzle }
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
            br.ui:createDropdownWithout(section, "APL Mode", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 2, "|cffFFFFFFSet APL Mode to use.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
        br.ui:checkSectionState(section)
    -- Pet Options
        section = br.ui:createSection(br.ui.window.profile, "Pet")
        -- Auto Summon
            br.ui:createDropdown(section, "Auto Summon", {"Pet 1","Pet 2","Pet 3","Pet 4","Pet 5",}, 1, "Select the pet you want to use")
        -- Mend Pet
            br.ui:createSpinner(section, "Mend Pet",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
        -- Agi Pot
            br.ui:createCheckbox(section,"Agi-Pot")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"Flask / Crystal")
        -- Racial
            br.ui:createCheckbox(section,"Racial")
        -- Trinkets
            br.ui:createCheckbox(section,"Trinkets")
        -- Aspect of the Eagle
            br.ui:createCheckbox(section,"Aspect of the Eagle")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
        -- Healthstone
            br.ui:createSpinner(section, "Pot/Stoned",  60,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        -- Heirloom Neck
            br.ui:createSpinner(section, "Heirloom Neck",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
        -- Engineering: Shield-o-tronic
            br.ui:createSpinner(section, "Shield-o-tronic",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        -- Exhilaration
            br.ui:createSpinner(section, "Exhilaration",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
        -- Aspect Of The Turtle
            br.ui:createSpinner(section, "Aspect Of The Turtle",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        -- Counter Shot
            br.ui:createCheckbox(section,"Muzzle")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "Interrupts",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At")
        br.ui:checkSectionState(section)
    -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
        -- Single/Multi Toggle
            br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle,  6)
        -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugSurvival", 0.1) then --change "debugFury" to "debugSpec" (IE: debugFire)
        --Print("Running: "..rotationName)

---------------
--- Toggles --- -- List toggles here in order to update when pressed
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
        local animality                                     = false
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local canFlask                                      = canUse(br.player.flask.wod.agilityBig)
        local cast                                          = br.player.cast
        local combatTime                                    = getCombatTime()
        local combo                                         = br.player.comboPoints
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or ObjectExists("target"), UnitIsPlayer("target")
        local debuff, debuffcount                           = br.player.debuff, br.player.debuffcount
        local enemies                                       = br.player.enemies
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local fatality                                      = false
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.agilityBig)
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local hasMouse                                      = ObjectExists("mouseover")
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local multidot                                      = (br.player.mode.cleave == 1 or br.player.mode.rotation == 2) and br.player.mode.rotation ~= 3
        local multishotTargets                              = getEnemies("pet",8)
        local perk                                          = br.player.perk        
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local potion                                        = br.player.potion
        local power, powerMax, powerRegen, powerDeficit     = br.player.power.amount.focus, br.player.power.focus.max, br.player.power.regen, br.player.power.focus.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = #br.friend < 2
        local friendsInRange                                = friendsInRange
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local trinketProc                                   = false
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = br.player.units
        
        -- BeastCleave 118445
        local beastCleaveTimer                              = getBuffDuration("pet", 118445)

        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end

--------------------
--- Action Lists ---
--------------------
    -- Action List - Pet Management
        local function actionList_PetManagement()
            if not IsMounted() then
                if isChecked("Auto Summon") and not UnitExists("pet") and (UnitIsDead("pet") ~= nil or UnitIsDead("pet") == false) then
                  if waitForPetToAppear ~= nil and waitForPetToAppear < GetTime() - 2 then
                    if lastFailedWhistle and lastFailedWhistle > GetTime() - 3 then
                      if castSpell("player",RevivePet) then return; end
                    else
                      local Autocall = getValue("Auto Summon");

                      if Autocall == 1 then
                        if castSpell("player",883) then return; end
                      elseif Autocall == 2 then
                        if castSpell("player",83242) then return; end
                      elseif Autocall == 3 then
                        if castSpell("player",83243) then return; end
                      elseif Autocall == 4 then
                        if castSpell("player",83244) then return; end
                      elseif Autocall == 5 then
                        if castSpell("player",83245) then return; end
                      else
                        Print("Auto Call Pet Error")
                      end
                    end
                  end
                  if waitForPetToAppear == nil then
                    waitForPetToAppear = GetTime()
                  end
                end
            end
                --Revive
                if isChecked("Auto Summon") and UnitIsDeadOrGhost("pet") then
                  if castSpell("player",982) then return; end
                end

                -- Mend Pet
                if isChecked("Mend Pet") and getHP("pet") < getValue("Mend Pet") and not UnitBuffID("pet",136) then
                  if castSpell("pet",136) then return; end
                end

                -- Pet Attack / retreat
                if inCombat and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40 then
                    if not UnitIsUnit("target","pettarget") then
                        PetAttack()
                    end
                else
                    if IsPetAttackActive() then
                        PetStopAttack()
                    end
                end
            
        end
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
        -- Engineering: Shield-o-tronic
                if isChecked("Shield-o-tronic") and php <= getOptionValue("Shield-o-tronic") 
                    and inCombat and canUse(118006) 
                then
                    useItem(118006)
                end
        -- Exhilaration
                if isChecked("Exhilaration") and php <= getOptionValue("Exhilaration") then
                    if cast.exhilaration("player") then return end
                end
        -- Exhilaration
                if isChecked("Aspect Of The Turtle") and php <= getOptionValue("Aspect Of The Turtle") then
                    if cast.aspectOfTheTurtle("player") then return end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then

            end -- End useInterrupts check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() then
                -- Trinkets
                if isChecked("Trinkets") then
                    if canUse(13) then
                        useItem(13)
                    end
                    if canUse(14) then
                        useItem(14)
                    end
                end
                -- Agi-Pot
                if isChecked("Agi-Pot") and canUse(agiPot) and inRaid then
                    useItem(agiPot);
                    return true
                end
                -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                if isChecked("Racial") and getSpellCD(racial) == 0 then
                    if (((br.player.race == "Orc" or br.player.race == "Troll") and (buff.spittingCobra.exists or (not talent.spittingCobra and buff.aspectOfTheEagle.exists))) 
                        or (br.player.race == "BloodElf" and powerDeficit >= 30)) 
                    then
                        if castSpell("player",racial,false,false,false) then return end
                    end
                end
                -- Aspect of the Eagle
                if isChecked("Aspect of the Eagle") then
                    if cast.aspectOfTheEagle(units.dyn40) then return end
                end
            end -- End useCooldowns check
        end -- End Action List - Cooldowns
    -- Action List - Multi Target
        local function actionList_MultiTarget()
            -- Dragonsfire Grenade
            if talent.dragonsfireGrenade then
                if cast.dragonsfireGrenade(units.dyn5) then return end
            end
            -- Explosive Trap
            if cast.explosiveTrap(units.dyn5) then return end
            -- Caltrops
            -- if DotCount(Caltrops) < TargetsInRadius(Caltrops)
            if talent.caltrops then

            end
            -- Butchery / Carve
            if talent.butchery then
                if cast.butchery(units.dyn5) then return end
            else
                if cast.carve(units.dyn5) then return end
            end

        end -- End Action List - Multi Target
    -- Action List - Way of the Moknathal
        local function actionList_WayOfTheMokNathal()
        -- Raptor Strike
            -- raptor_strike,if=buff.moknathal_tactics.stack<=1
            if buff.mokNathalTactics.stack <= 1 then
                if cast.raptorStrike() then return end
            end
            -- raptor_strike,if=buff.moknathal_tactics.remains<gcd
            if buff.mokNathalTactics.remain < gcd then
                if cast.raptorStrike() then return end
            end
        -- Snake Hunter
            -- snake_hunter,if=cooldown.mongoose_bite.charges<=0&buff.mongoose_fury.remains>3*gcd
            if charges.mongooseBite <= 0 and buff.mongooseFury.remain > 3 * gcd then
                if cast.snakeHunter() then return end
            end
        -- A Murder of Crows
            -- a_murder_of_crows,if=focus>55&buff.mongoose_fury.stack<4&buff.mongoose_fury.duration>=gcd
            if power > 55 and buff.mongooseFury.stack < 4 and buff.mongooseFury.duration >= gcd then
                if cast.aMurderOfCrows() then return end
            end
        -- Steel Trap
            -- steel_trap,if=buff.mongoose_fury.duration>=gcd&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and buff.mongooseFury.stack < 4 then
                if cast.steelTrap() then return end
            end
        -- Caltrops
            -- caltrops,if=(buff.mongoose_fury.duration>=gcd&buff.mongoose_fury.stack<4&!dot.caltrops.ticking)
            if (buff.mongooseFury.duration >= gcd and buff.mongooseFury.stack < 4 and not debuff.caltrops[units.dyn5].exists) then
                if cast.caltrops() then return end
            end
        -- Flanking Strike
            -- flanking_strike,if=cooldown.mongoose_bite.charges<=0&buff.aspect_of_the_eagle.remains>=gcd&focus>75
            if charges.mongooseBite <= 0 and buff.aspectOfTheEagle.remain >= gcd and power > 75 then
                if cast.flankingStrike() then return end
            end
        -- Lacerate
            -- lacerate,if=focus>60&buff.mongoose_fury.duration>=gcd&dot.lacerate.remains<=3&cooldown.mongoose_bite.charges>=0&buff.mongoose_fury.stack<4
            if power > 60 and buff.mongooseFury.duration >= gcd and debuff.lacerate[units.dyn5].remain <= 3 and charges.mongooseBite >= 0 and buff.mongooseFury.stack < 4 then
                if cast.lacerate() then return end
            end
        -- Spitting Cobra
            -- spitting_cobra,if=buff.mongoose_fury.duration>=gcd&cooldown.mongoose_bite.charges>=0&buff.mongoose_fury.stack<4&buff.moknathal_tactics.stack=4
            if buff.mongooseFury.duration >= gcd and charges.mongooseBite >= 0 and buff.mongooseFury.stack < 4 and buff.mokNathalTactics.stack == 4 then
                if cast.spittingCobra() then return end
            end
        -- Steel Trap
            -- steel_trap,if=buff.mongoose_fury.duration>=gcd&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and buff.mongooseFury.stack < 4 then
                if cast.steelTrap() then return end
            end
        -- Explosive Trap
            -- explosive_trap,if=buff.mongoose_fury.duration>=gcd&cooldown.mongoose_bite.charges>=0&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and charges.mongooseBite >= 0 and buff.mongooseFury.stack < 4 then
                if cast.explosiveTrap() then return end
            end
        -- Dragonsfire Grenade
            -- dragonsfire_grenade,if=buff.mongoose_fury.duration>=gcd&cooldown.mongoose_bite.charges>=0&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and charges.mongooseBite >= 0 and buff.mongooseFury.stack < 4 then
                if cast.dragonsfireGrenade() then return end
            end
        -- Raptor Strike
            -- raptor_strike,if=talent.serpent_sting.enabled&dot.serpent_sting.remains<gcd
            if talent.serpentSting and debuff.serpentSting[units.dyn5].remain < gcd then
                if cast.raptorStrike() then return end
            end
            -- raptor_strike,if=buff.moknathal_tactics.remains<4&buff.mongoose_fury.stack=6&buff.mongoose_fury.remains>=gcd
            if buff.mokNathalTactics.remain < 4 and buff.mongooseFury.stack == 6 and buff.MongooseFury.remain >= gcd then
                if cast.raptorStrike() then return end
            end
        -- Fury of the Eagle
            -- fury_of_the_eagle,if=buff.moknathal_tactics.remains>4&buff.mongoose_fury.stack=6&cooldown.mongoose_bite.charges<=2
            if buff.mokNathalTactics.remain > 4 and buff.mongooseFury.stack == 6 and charges.mongooseBite <= 2 then
                if cast.furyOfTheEagle() then return end
            end
        -- Mongoose Bite
            -- mongoose_bite,if=buff.aspect_of_the_eagle.up&buff.mongoose_fury.up&buff.moknathal_tactics.stack>=4
            if buff.aspectOfTheEagle.exists and buff.mongooseFury.exists and buff.mokNathalTactics.stack >= 4 then
                if cast.mongooseBite() then return end
            end
        -- Fury of the Eagle
            -- fury_of_the_eagle,if=(buff.moknathal_tactics.remains>4&(buff.mongoose_fury.stack=6&cooldown.mongoose_bite.charges<=0|buff.mongoose_fury.up&buff.mongoose_fury.remains<=2*gcd))
            if (buff.mokNathalTactics.remain > 4 and (buff.mongooseFury.stack == 6 and charges.mongooseBite <= 0) or (buff.mongooseFury.exists and buff.mongooseFury.remain <= 2* gcd)) then
                if cast.furyOfTheEagle() then return end
            end
        -- Raptor Strike
            -- raptor_strike,if=buff.moknathal_tactics.stack<=3
            if buff.mokNathalTactics.stack <= 3 then
                if cast.raptorStrike() then return end
            end
        -- Aspect of the Eagle
            -- aspect_of_the_eagle,if=buff.mongoose_fury.up&buff.mongoose_fury.remains>6&cooldown.mongoose_bite.charges>=2
            if isChecked("Aspect of the Eagle") and useCDs() then
                if buff.mongooseFury.exists and buff.mongooseFury.remain > 6 and charges.mongooseBite >= 2 then
                    if cast.aspectOfTheEagle() then return end
                end
            end
        -- Flanking Strike
            -- flanking_strike,if=cooldown.mongoose_bite.charges<=2&buff.mongoose_fury.remains>(1+action.mongoose_bite.charges*gcd)&focus>75
            if charges.mongooseBite <= 2 and buff.mongooseFury.remain > (1 + charges.mongooseBite * gcd) and power > 75 then
                if cast.flankingStrike() then return end
            end
        -- Mongoose Bite
            -- mongoose_bite,if=buff.mongoose_fury.up&buff.mongoose_fury.remains<cooldown.aspect_of_the_eagle.remains
            if buff.mongooseFury.exists and buff.mongooseFury.remain < cd.aspectOfTheEagle then
                if cast.mongooseBite() then return end
            end
        -- A Murder of Crows
            -- a_murder_of_crows,if=focus>55
            if power > 55 then
                if cast.aMurderOfCrows() then return end
            end
        -- Spitting Cobra
            -- spitting_cobra
            if cast.spittingCobra() then return end
        -- Steel Trap
            -- steel_trap
            if cast.steelTrap() then return end
        -- Explosive Trap
            -- explosive_trap
            if cast.explosiveTrap() then return end
        -- Caltrops
            -- caltrops,if=(!dot.caltrops.ticking)
            if not debuff.caltrops[units.dyn5].exists then
                if cast.caltrops() then return end
            end
        -- Lacerate
            -- lacerate,if=(!dot.lacerate.ticking|dot.lacerate.remains<3)
            if (not debuff.lacerate[units.dyn5].exists or debuff.lacerate[units.dyn5].remain < 3) then
                if cast.lacerate() then return end
            end
        -- Dragonsfire Grenade
            -- dragonsfire_grenade
            if cast.dragonsfireGrenade() then return end
        -- Butchery
            -- butchery,if=(charges=3&focus>65)
            if charges.butchery == 3 and power > 65 then
                if cast.butchery() then return end
            end
        -- Mongoose Bite
            -- mongoose_bite,if=(charges>=2&cooldown.mongoose_bite.remains<=gcd|charges=3)
            if (charges.mongooseBite >= 2 and cd.mongooseBite <= gcd) or charges == 3 then
                if cast.mongooseBite() then return end
            end
        -- Butchery
            -- butchery,if=focus>65
            if power > 65 then
                if cast.butchery() then return end
            end
        -- Flanking Strike
            -- flanking_strike,if=focus>75
            if power > 75 then
                if cast.flankingStrike() then return end
            end
        -- Raptor Strike
            -- raptor_strike,if=focus>75-cooldown.flanking_strike.remains*focus.regen
            if power > 75 - cd.flankingStrike * powerRegen then
                if cast.raptorStrike() then return end
            end 

        end -- End Action List - Way of the Moknathal
    -- Action List - No of the MokNathal
        local function actionList_NoOfTheMokNathal()
            -- A Murder of Crows
            -- a_murder_of_crows,if=cooldown.mongoose_bite.charges>=0&buff.mongoose_fury.stack<4
            if charges.mongooseBite >= 0 and buff.mongooseFury.stack < 4 then
                if cast.aMurderOfCrows() then return end
            end
            -- Snake Hunter
            -- snake_hunter,if=action.mongoose_bite.charges<=0&buff.mongoose_fury.remains>3*gcd
            if charges.mongooseBite <= 0 and buff.mongooseFury.remain > 3 * gcd then
                if cast.snakeHunter() then return end
            end
            -- Steel Trap
            -- steel_trap,if=buff.mongoose_fury.duration>=gcd&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and buff.mongooseFury.stack < 4 then
                if cast.steelTrap() then return end
            end
            -- Caltrops
            -- caltrops,if=(buff.mongoose_fury.duration>=gcd&buff.mongoose_fury.stack<4&!dot.caltrops.ticking)
            if (buff.mongooseFury.duration >= gcd and buff.mongooseFury.stack < 4 and not debuff.caltrops[units.dyn5].exists) then
                if cast.caltrops() then return end
            end
            -- Flanking Strike
            -- flanking_strike,if=cooldown.mongoose_bite.charges<=0&buff.aspect_of_the_eagle.remains>=gcd
            if charges.mongooseBite <= 0 and buff.aspectOfTheEagle.remain >= gcd then
                if cast.flankingStrike() then return end
            end
            -- Lacerate
            -- lacerate,if=buff.mongoose_fury.duration>=gcd&dot.lacerate.remains<=1&&cooldown.mongoose_bite.charges>=0&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and debuff.lacerate[units.dyn5].remain <= 1 and charges.mongooseBite >= 0 and buff.mongooseFury.stack < 4 then
                if cast.lacerate() then return end
            end
            -- Spitting Cobra
            -- spitting_cobra,if=buff.mongoose_fury.duration>=gcd&cooldown.mongoose_bite.charges>=0&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and charges.mongooseBite >= 0 and buff.mongooseFury.stack < 4 then
                if cast.spittingCobra() then return end
            end
            -- Steel Trap
            -- steel_trap,if=buff.mongoose_fury.duration>=gcd&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and buff.mongooseFury.stack < 4 then
                if cast.steelTrap() then return end
            end
            -- Explosive Trap
            -- explosive_trap,if=buff.mongoose_fury.duration>=gcd&cooldown.mongoose_bite.charges>=0&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and charges.mongooseBite >= 0 and buff.mongooseFury.stack < 4 then
                if cast.explosiveTrap() then return end
            end
            -- Dragonsfire Grenade
            -- dragonsfire_grenade,if=buff.mongoose_fury.duration>=gcd&cooldown.mongoose_bite.charges>=0&buff.mongoose_fury.stack<4
            if buff.mongooseFury.duration >= gcd and charges.mongooseBite >= 0 and buff.mongooseFury.stack < 4 then
                if cast.dragonsfireGrenade() then return end
            end
            -- Raptor Strike
            -- raptor_strike,if=talent.serpent_sting.enabled&dot.serpent_sting.remains<gcd
            if talent.serpentSting and debuff.serpentString[units.dyn5].remain < gcd then
                if cast.raptorStrike() then return end
            end
            -- Fury of the Eagle
            -- fury_of_the_eagle,if=buff.mongoose_fury.stack=6&cooldown.mongoose_bite.charges<=2
            if buff.mongooseFury.stack == 6 and charges.mongooseBite <= 2 then
                if cast.furyOfTheEagle() then return end
            end
            -- Mongoose Bite
            -- mongoose_bite,if=buff.aspect_of_the_eagle.up&buff.mongoose_fury.up
            if buff.aspectOfTheEagle.exists and buff.mongooseFury.exists then
                if cast.mongooseBite() then return end
            end
            -- Aspect of the Eagle
            -- aspect_of_the_eagle,if=buff.mongoose_fury.up&buff.mongoose_fury.duration>6&cooldown.mongoose_bite.charges>=2
            if isChecked("Aspect of the Eagle") and useCDs() then
                if buff.mongooseFury.exists and buff.mongooseFury.duration > 6 and charges.mongooseBite >= 2 then
                    if cast.aspectOfTheEagle() then return end
                end
            end
            -- Fury of the Eagle
            -- fury_of_the_eagle,if=cooldown.mongoose_bite.charges<=0&buff.mongoose_fury.duration>6
            if charges.mongooseBite <= 0 and buff.mongooseFury.duration > 6 then
                if cast.furyOfTheEagle() then return end
            end
            -- Flanking Strike
            -- flanking_strike,if=cooldown.mongoose_bite.charges<2&buff.mongoose_fury.remains>(1+action.mongoose_bite.charges*gcd)
            if charges.mongooseBite < 2 and buff.mongooseFury.remain > (1 + charges.mongooseBite * gcd) then
                if cast.flankingStrike() then return end
            end 
            -- Mongoose Bite
            -- mongoose_bite,if=buff.mongoose_fury.up&buff.mongoose_fury.remains<cooldown.aspect_of_the_eagle.remains
            if buff.mongooseFury.exists and buff.mongooseFury.remain < cd.aspectOfTheEagle then
                if cast.mongooseBite() then return end
            end
            -- Flanking Strike
            -- flanking_strike,if=talent.animal_instincts.enabled&cooldown.mongoose_bite.charges<3
            if talent.animalInstincts and charges.mongooseBite < 3 then
                if cast.flankingStrike() then return end
            end
            -- A Murder of Crows
            -- a_murder_of_crows
            if cast.aMurderOfCrows() then return end
            -- Spitting Cobra
            -- spitting_cobra
            if cast.spittingCobra() then return end
            -- Steel Trap
            -- steel_trap
            if cast.steelTrap() then return end
            -- Explosive Trap
            -- explosive_trap
            if cast.explosiveTrap() then return end
            -- Caltrops
            -- caltrops,if=(!dot.caltrops.ticking)
            if not debuff.caltrops[units.dyn5].exists then
                if cast.caltrops() then return end
            end
            -- Lacerate
            -- lacerate,if=(!dot.lacerate.ticking|dot.lacerate.remains<3)
            if (not debuff.lacerate[units.dyn5].exists or debuff.lacerate[units.dyn5].remain < 3) then
                if cast.lacerate() then return end
            end
            -- Dragonsfire Grenade
            -- dragonsfire_grenade
            if cast.dragonsfireGrenade() then return end
            -- Butchery
            -- butchery,if=(charges=3)
            if charges.butchery == 3 then
                if cast.butchery() then return end
            end
            -- Throwing Axes
            -- throwing_axes,if=cooldown.throwing_axes.charges=2
            if charges.throwingAxes == 2 then
                if cast.throwingAxes() then return end
            end
            -- Mongoose Bite
            -- mongoose_bite,if=(charges>=2&cooldown.mongoose_bite.remains<=gcd|charges=3)
            if (charges.mongooseBite >= 2 and cd.mongooseBite <= gcd) or charges == 3 then
                if cast.mongooseBite() then return end
            end
            -- Butchery
            -- butchery
            if cast.butchery() then return end
            -- Throwing Axes
            -- throwing_axes
            if cast.throwingAxes() then return end
            -- Flanking Strike
            -- flanking_strike
            if cast.flankingStrike() then return end
            -- Raptor Strike
            -- raptor_strike,if=focus>75-cooldown.flanking_strike.remains*focus.regen
            if power > 75 - cd.flankingStrike * powerRegen then
                if cast.raptorStrike() then return end
            end
        end

        
-----------------
--- Rotations ---
-----------------
        -- Pause
        if pause() or (UnitExists("target") and (UnitIsDeadOrGhost("target") or not UnitCanAttack("target", "player"))) or mode.rotation == 4 then
            return true
        else
---------------------------------
--- Out Of Combat - Rotations ---
---------------------------------
            if not inCombat and ObjectExists("target") and not UnitIsDeadOrGhost("target") and UnitCanAttack("target", "player") then
    -----------------
    --- Pet Logic ---
    -----------------             
                if actionList_PetManagement() then return end
            end -- End Out of Combat Rotation
-----------------------------
--- In Combat - Rotations --- 
-----------------------------
            if inCombat and isValidUnit(units.dyn40) and getDistance(units.dyn5) < 5 then
    -----------------
    --- Pet Logic ---
    -----------------             
                if actionList_PetManagement() then return end
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
                    
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL Mode") == 1 then
                    -- actions=auto_attack
                    if getDistance(units.dyn5) < 5 then
                        StartAttack()
                    end
                    -- Cooldowns
                    if getDistance(units.dyn5) < 5 then
                        if actionList_Cooldowns() then return end
                    end
                    -- Call Action List - Way of the Moknathal
                    -- call_action_list,name=moknathal,if=talent.way_of_the_moknathal.enabled
                    if talent.wayOfTheMokNathal then
                        if actionList_WayOfTheMokNathal() then return end
                    end
                    -- Call Action List - No of the Moknathal
                    if not talent.wayOfTheMokNathal then
                        if actionList_NoOfTheMokNathal() then return end
                    end 
                end -- End SimC APL
    ------------------------
    --- Ask Mr Robot APL ---
    ------------------------
                if getOptionValue("APL Mode") == 2 then
                    if getDistance(units.dyn5) < 5 then
                        StartAttack()
                    end
                    -- Harpoon
                    -- if not HasDot(OnTheTrail) and ArtifactTraitRank(EaglesBite) > 0
                    
                    -- Cooldowns
                    -- if TargetsInRadius(Carve) > 2 or HasBuff(MongooseFury) or ChargesRemaining(MongooseBite) = SpellCharges(MongooseBite)
                    -- Use your cooldowns during or just before Mongoose Fury or an AoE phase.
                    if #enemies.yards5 > 2 or buff.mongooseFury.exists or charges.mongooseBite == charges.max.mongooseBite then
                        if actionList_Cooldowns() then return end
                    end
                    -- MultiTarget
                    -- if TargetsInRadius(Carve) > 2
                    if (#enemies.yards5 > 2 and mode.rotation == 1) or mode.rotation == 2 then
                        if actionList_MultiTarget() then return end
                    end
                    -- Explosive Trap
                    if cast.explosiveTrap(units.dyn5) then return end
                    -- Dragonsfire Grenade
                    if talent.dragonsfireGrenade then
                        if cast.dragonsfireGrenade(units.dyn5) then return end
                    end
                    -- Raptor Strike
                    -- if HasTalent(WayOfTheMokNathal) and BuffRemainingSec(MokNathalTactics) <= GlobalCooldownSec
                    if talent.wayOfTheMokNathal and buff.mokNathalTactics.remain <= gcd then
                        if cast.raptorStrike(units.dyn5) then return end
                    end
                    -- Snake Hunter
                    -- if ChargesRemaining(MongooseBite) = 0 and BuffRemainingSec(MongooseFury) > GlobalCooldownSec * 4
                    if talent.snakeHunter and charges.mongooseBite == 0 and buff.mongooseFury.remain > gcd * 4 then
                        if cast.snakeHunter(units.dyn5) then return end
                    end
                    -- Fury of the Eagle
                    -- if HasBuff(MongooseFury) and BuffRemainingSec(MongooseFury) <= GlobalCooldownSec * 2
                    -- You want to use this near the end of Mongoose Fury, but leave time to use one or two Mongoose Bite charges you might gain during the channel.
                    if buff.mongooseFury.exists and buff.mongooseFury.remain <= gcd * 2 then
                        if cast.furyOfTheEagle(units.dyn5) then return end
                    end
                    -- Mongoose Bite
                    -- if HasBuff(MongooseFury) or ChargesRemaining(MongooseBite) = SpellCharges(MongooseBite)
                    -- Once you hit max charges of Mongoose Bite, use it.
                    if buff.mongooseFury or charges.mongooseBite == charges.max.mongooseBite then
                        if cast.mongooseBite(units.dyn5) then return end
                    end
                    -- Steel Trap
                    if talent.steelTrap then
                        if cast.steelTrap(units.dyn5) then return end
                    end
                    -- Caltrops
                    -- if not HasDot(Caltrops) or DotCount(Caltrops) < TargetsInRadius(Caltrops)
                    if talent.caltrops and not not UnitDebuffID(units.dyn5,spell.debuffs.caltrops,"player") then
                        if cast.caltrops(units.dyn5) then return end
                    end
                    -- A Murder of Crows
                    if talent.aMurderOfCrows then
                        if cast.aMurderOfCrows(units.dyn5) then return end
                    end
                    -- Lacerate
                    -- if CanRefreshDot(Lacerate)
                    if debuff.lacerate[units.dyn5].refresh then
                        if cast.lacerate(units.dyn5) then return end
                    end
                    -- Spitting Cobra
                    if cast.splittingCobra(units.dyn5) then return end
                    -- Raptor Strike
                    -- if (HasTalent(SerpentSting) and CanRefreshDot(SerpentSting))
                    if talent.serpentSting and not UnitDebuffID(units.dyn5,spell.debuffs.serpentSting,"player") then
                        if cast.raptorStrike(units.dyn5) then return end
                    end
                    -- Flanking Strike
                    if cast.flankingStrike(units.dyn5) then return end
                    -- Butchery
                    -- if TargetsInRadius(Butchery) > 1
                    if talent.butchery and #enemies.yards5 > 1 then
                        if cast.butchery(units.dyn5) then return end
                    end
                    -- Carve
                    -- if TargetsInRadius(Carve) > 1
                    if not talent.butchery and #enemies.yards5 > 1 then
                        if cast.carve(units.dyn5) then return end
                    end
                    -- Throwing Axes
                    if cast.throwingAxes(units.dyn5) then return end
                    -- Raptor Strike
                    -- if Power > 75 - CooldownSecRemaining(FlankingStrike) * PowerRegen and not HasTalent(ThrowingAxes)
                    -- If using Raptor Strike could possibly delay a Flanking Strike by using up your Focus, it is better to just wait for Flanking Strike to come off GCD. It is also not worth using if you have Throwing Axes talented.
                    if power > 75 - cd.flankingStrike * powerRegen and not talent.throwingAxes then
                        if cast.raptorStrike(units.dyn5) then return end
                    end
                end -- End AMR
            end -- End In Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation 
local id = 255 -- Change to the spec id profile is for.
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})