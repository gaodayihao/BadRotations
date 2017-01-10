local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of #enemies.yards8 in range.", highlight = 1, icon = br.player.spell.thunderClap },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.thunderClap },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.devastate },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.enragedRegeneration}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.battleCry },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.battleCry },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.battleCry }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.shieldWall },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.shieldWall }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.pummel },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.pummel }
    };
    CreateButton("Interrupt",4,0)
-- Movement Button
    MoverModes = {
        [1] = { mode = "On", value = 1 , overlay = "Mover Enabled", tip = "Will use Charge/Heroic Leap.", highlight = 1, icon = br.player.spell.charge },
        [2] = { mode = "Off", value = 2 , overlay = "Mover Disabled", tip = "Will NOT use Charge/Heroic Leap.", highlight = 0, icon = br.player.spell.charge }
    };
    CreateButton("Mover",5,0)
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
        section = br.ui:createSection(br.ui.window.profile,  "General")
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
            -- Berserker Rage
            br.ui:createCheckbox(section,"Berserker Rage", "Check to use Berserker Rage")
            -- Heroic Leap
            br.ui:createDropdown(section,"Heroic Leap", br.dropOptions.Toggle, 6, "Set auto usage (No Hotkey) or desired hotkey to use Heroic Leap.")
            br.ui:createDropdownWithout(section,"Heroic Leap - Target",{"Best","Target"},1,"Desired Target of Heroic Leap")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
            -- Artifact 
            br.ui:createDropdownWithout(section,"Artifact", {"|cff00FF00Everything","|cffFFFF00Defensive","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Artifact Ability.")
            br.ui:createSpinner(section, "Artifact HP",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile,  "Cooldowns")
            -- Agi Pot
            br.ui:createCheckbox(section,"Str-Pot")
            -- Legendary Ring
            br.ui:createCheckbox(section, "Legendary Ring", "Enable or Disable usage of Legendary Ring.")
            -- Flask / Crystal
            br.ui:createCheckbox(section,"Flask / Crystal")
            -- Racials
            br.ui:createCheckbox(section,"Racial")
            -- Trinkets
            br.ui:createCheckbox(section,"Trinkets")
            -- Touch of the Void
            br.ui:createCheckbox(section,"Touch of the Void")
            -- Avatar
            br.ui:createCheckbox(section,"Avatar")
            -- Battle Cry
            br.ui:createCheckbox(section,"Battle Cry")
            -- Demoralizing Shout
            br.ui:createCheckbox(section,"Demoralizing Shout - CD")
            -- Ravager
            br.ui:createCheckbox(section,"Ravager")
            -- Shockwave
            br.ui:createCheckbox(section,"Shockwave")
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
            -- Healthstone
            br.ui:createSpinner(section, "Healthstone/Potion",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Heirloom Neck
            br.ui:createSpinner(section, "Heirloom Neck",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "Gift of the Naaru",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            end
            -- Demoralizing Shout
            br.ui:createSpinner(section, "Demoralizing Shout",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Last Stand
            br.ui:createSpinner(section, "Last Stand",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Shield Wall
            br.ui:createSpinner(section, "Shield Wall",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Shockwave
            br.ui:createSpinner(section, "Shockwave - HP", 60, 0, 100, 5, "|cffFFBB00Health Percentage to use at.")
            br.ui:createSpinner(section, "Shockwave - Units", 3, 1, 10, 1, "|cffFFBB00Minimal units to cast on.")
            -- Storm Bolt
            br.ui:createSpinner(section, "Storm Bolt", 60, 0, 100, 5, "|cffFFBB00Health Percentage to use at.") 
            -- Victory Rush
            br.ui:createSpinner(section, "Victory Rush", 60, 0, 100, 5, "|cffFFBB00Health Percentage to use at.")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
            -- Pummel
            br.ui:createCheckbox(section,"Pummel")
            -- Intimidating Shout
            br.ui:createCheckbox(section,"Intimidating Shout - Int")
            -- Shockwave
            br.ui:createCheckbox(section,"Shockwave - Int")
            -- Storm Bolt
            br.ui:createCheckbox(section,"Storm Bolt - Int")
            -- Interrupt Percentage
            br.ui:createSpinner(section,  "InterruptAt",  0,  0,  95,  5,  "|cffFFBB00Cast Percentage to use at.")    
        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS ---
        ----------------------
        section = br.ui:createSection(br.ui.window.profile,  "Toggle Keys")
            -- Single/Multi Toggle
            br.ui:createDropdown(section,  "Rotation Mode", br.dropOptions.Toggle,  4)
            --Cooldown Key Toggle
            br.ui:createDropdown(section,  "Cooldown Mode", br.dropOptions.Toggle,  3)
            --Defensive Key Toggle
            br.ui:createDropdown(section,  "Defensive Mode", br.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
            br.ui:createDropdown(section,  "Interrupt Mode", br.dropOptions.Toggle,  6)
            -- Mover Toggle
            br.ui:createDropdown(section,  "Mover Mode", br.dropOptions.Toggle,  6)
            -- Pause Toggle
            br.ui:createDropdown(section,  "Pause Mode", br.dropOptions.Toggle,  6)   
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
    if br.timer:useTimer("debugProtection", 0.1) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        UpdateToggle("Mover",0.25)
        br.player.mode.mover = br.data.settings[br.selectedSpec].toggles["Mover"]
        
--------------
--- Locals ---
--------------
        local addsExist                                     = false 
        local addsIn                                        = 999
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local combatTime                                    = getCombatTime()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or ObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = br.player.enemies
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local hasMouse                                      = ObjectExists("mouseover")
        local healPot                                       = getHealthPot()
        local heirloomNeck                                  = 122667 or 122668
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local perk                                          = br.player.perk        
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powerMax, powerGen                     = br.player.power.amount.rage, br.player.power.rage.max, br.player.power.regen
        local pullTimer                                     = br.DBM:getPulltimer()
        local race                                          = br.player.race
        local racial                                        = br.player.getRacial()
        local rage                                          = br.player.power.amount.rage
        local recharge                                      = br.player.recharge
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local thp                                           = getHP(br.player.units.dyn5)
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = br.player.units
        
        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end

        -- ChatOverlay(round2(getDistance2("target"),2)..", "..round2(getDistance3("target"),2)..", "..round2(getDistance4("target"),2)..", "..round2(getDistance("target"),2))

--------------------
--- Action Lists ---
--------------------
    -- Action list - Extras
        function actionList_Extra()
            -- Berserker Rage
            if isChecked("Berserker Rage") and hasNoControl(spell.berserkerRage) then
                if cast.berserkerRage() then return end
            end
        end -- End Action List - Extra
    -- Action List - Defensive
        function actionList_Defensive()
            if useDefensive() then
            -- Healthstone/Health Potion
                if isChecked("Healthstone/Potion") and php <= getOptionValue("Healthstone/Potion") 
                    and inCombat and (hasHealthPot() or hasItem(5512)) 
                then
                    if canUse(5512) then
                        useItem(5512)
                    elseif canUse(getHealthPot()) then
                        useItem(getHealthPot())
                    end
                end
            -- Heirloom Neck
                if isChecked("Heirloom Neck") and php <= getOptionValue("Heirloom Neck") then
                    if hasEquiped(heirloomNeck) then
                        if canUse(heirloomNeck) then
                            useItem(heirloomNeck)
                        end
                    end
                end 
            -- Gift of the Naaru
                if isChecked("Gift of the Naaru") and php <= getOptionValue("Gift of the Naaru") and php > 0 and cd.giftOfTheNaaru==0 then
                    if cast.giftOfTheNaaru() then return end
                end
            -- Shockwave
                if inCombat and ((isChecked("Shockwave - HP") and php <= getOptionValue("Shockwave - HP")) or (isChecked("Shockwave - Units") and #enemies.yards8 >= getOptionValue("Shockwave - Units"))) then
                    if cast.shockwave() then return end
                end
            -- Storm Bolt
                if inCombat and isChecked("Storm Bolt") and php <= getOptionValue("Storm Bolt") then
                    if cast.stormBolt() then return end
                end
            -- Victory Rush
                if inCombat and isChecked("Victory Rush") and php <= getOptionValue("Victory Rush") and buff.victorious.exists then
                    if cast.victoryRush() then return end
                end
            end -- End Defensive Check
        end -- End Action List - Defensive
    -- Action List - Interrupts
        function actionList_Interrupts()
            if useInterrupts() then
                for i=1, #enemies.yards40 do
                    thisUnit = enemies.yards40[i]
                    unitDist = getDistance(thisUnit)
                    targetMe = UnitIsUnit("player",thisUnit) or false
                    if canInterrupt(thisUnit,getOptionValue("InterruptAt")) then
                    -- Pummel
                        if isChecked("Pummel") and unitDist < 5 then
                            if cast.pummel(thisUnit) then return end
                        end
                    -- Shockwave
                        if isChecked("Shockwave - Int") and unitDist < 10 then
                            if cast.shockwave() then return end
                        end
                    -- Storm Bolt
                        if isChecked("Storm Bolt - Int") and unitDist < 20 then
                            if cast.stormBolt() then return end
                        end
                    end
                end
            end
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        function actionList_Cooldowns()
            if useCDs() and getDistance("target") < 5 then
        -- Touch of the Void
                if isChecked("Touch of the Void") then
                    if hasEquiped(128318) then
                        if GetItemCooldown(128318)==0 then
                            useItem(128318)
                        end
                    end
                end
        -- Trinkets
                if isChecked("Trinkets") then
                    if canUse(13) then
                        useItem(13)
                    end
                    if canUse(14) then
                        useItem(14)
                    end
                end
        -- Draught of Souls
                -- use_item,name=draught_of_souls,if=(spell_targets.whirlwind>1|!raid_event.adds.exists)&((talent.bladestorm.enabled&cooldown.bladestorm.remains=0)|buff.battle_cry.up|target.time_to_die<25)
        -- Potions
                -- potion,name=old_war,if=(target.health.pct<20&buff.battle_cry.up)|target.time_to_die<30
        -- Avatar
                -- avatar,if=buff.battle_cry.up|(target.time_to_die<(cooldown.battle_cry.remains+10))
                if isChecked("Avatar") then
                    if buff.battleCry.exists or (ttd(units.dyn5) < (cd.battleCry + 10)) then
                        if cast.avatar() then return end
                    end
                end
        -- Racials
                -- blood_fury,if=buff.battle_cry.up
                -- berserking,if=buff.battle_cry.up
                -- arcane_torrent,if=rage<rage.max-40
                if isChecked("Racial") then
                    if ((race == "Orc" or race == "Troll") and buff.battleCry.exists) or (race == "BloodElf" and power < powerMax - 40) then
                        if castSpell("target",racial,false,false,false) then return end
                    end
                end
            end 
        end
    -- Action List - Pre-Combat
        function actionList_PreCombat()
        -- Flask
            -- flask,type=greater_draenic_strength_flask
            if isChecked("Str-Pot") then
                if inRaid and canFlask and flaskBuff==0 and not UnitBuffID("player",176151) then
                    useItem(br.player.flask.wod.strengthBig)
                    return true
                end
                if flaskBuff==0 then
                    if br.player.useCrystal() then return end
                end
            end
            -- food,type=pickled_eel
            -- stance,choose=battle
            -- if not buff.battleStance and php > getOptionValue("Defensive Stance") then
            --     if br.player.castBattleStance() then return end
            -- end
            -- snapshot_stats
            -- potion,name=draenic_strength
            if useCDs() and inRaid and isChecked("Str-Pot") and isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then
                if canUse(109219) then
                    useItem(109219)
                end
            end
        end  -- End Action List - Pre-Combat
    -- Action List - Movement
        function actionList_Movement()
            if mode.mover == 1 then
        -- Charge
                -- charge
                if (cd.heroicLeap > 0 and cd.heroicLeap < 43) or level < 26 then
                    if isValidUnit("target") or (UnitIsFriend("target") and level >= 28) then
                        if level < 28 then
                            if cast.charge("target") then return end
                        else
                            if cast.intercept("target") then return end
                        end
                    end
                end
                if isValidUnit("target") then
        -- Heroic Leap
                    -- heroic_leap
                    if isChecked("Heroic Leap") and (getOptionValue("Heroic Leap")==6 or (SpecificToggle("Heroic Leap") and not GetCurrentKeyBoardFocus())) then
                        -- Best Location
                        if getOptionValue("Heroic Leap - Target")==1 then
                            if cast.heroicLeap("best",false,1,8) then return end
                        end
                        -- Target
                        if getOptionValue("Heroic Leap - Target")==2 then
                            if cast.heroicLeap("target","ground") then return end
                        end
                    end
        -- Storm Bolt
                    -- storm_bolt
                    if cast.stormBolt("target") then return end
        -- Heroic Throw
                    -- heroic_throw
                    if ((lastSpell == spell.charge or charges.charge == 0) and level < 28) or ((lastSpell == spell.intercept or charges.intercept == 0) and level >= 28) then
                        if cast.heroicThrow("target") then return end
                    end
                end
            end
        end
    -- Action List - MultiTarget
        function actionList_MultiTarget()
        -- Touch of the Void
            if isChecked("Touch of the Void") and getDistance(units.dyn5) < 5 then
                if hasEquiped(128318) then
                    if GetItemCooldown(128318)==0 then
                        useItem(128318)
                    end
                end
            end
        -- Focused Rage
            -- focused_rage,if=talent.ultimatum.enabled&buff.ultimatum.up&!talent.vengeance.enabled
            if talent.ultimatum and buff.ultimatum.exists and not talent.vengeance then
                if cast.focusedRage() then return end
            end
        -- Battle Cry
            -- battle_cry,if=(talent.vengeance.enabled&talent.ultimatum.enabled&cooldown.shield_slam.remains<=5-gcd.max-0.5)|!talent.vengeance.enabled
            if useCDs() and isChecked("Battle Cry") then
                if (talent.vengeance and talent.ultimatum and cd.shieldSlam <= 5 - gcd - 0.5) or talent.vengeance then
                    if cast.battleCry() then return end
                end
            end
        -- Demoralizing Shout
            -- demoralizing_shout,if=talent.booming_voice.enabled&buff.battle_cry.up
            if useCDs() and isChecked("Demoralizing Shout - CD") then
                if talent.boomingVoice and buff.battleCry.exists then
                    if cast.demoralizingShout() then return end
                end
            end
        -- Ravager
            -- ravager,if=talent.ravager.enabled&buff.battle_cry.up
            if useCDs() and isChecked("Ravager") then
                if talent.ravager and buff.battleCry.exists then
                    if cast.ravager("best",false,1,8) then return end
                end
            end
        -- Neltharion's Fury
            -- neltharions_fury,if=incoming_damage_2500ms>health.max*0.20&!buff.shield_block.up
            if getOptionValue("Artifact") == 1 or (getOptionValue("Artifact") == 2 and useDefensive()) then
                if buff.battleCry.exists then
                    if cast.neltharionsFury("player") then return end
                end
            end
        -- Shield Slam
            -- shield_slam,if=!(cooldown.shield_block.remains<=gcd.max*2&!buff.shield_block.up&talent.heavy_repercussions.enabled)
            if not (cd.shieldBlock <= gcd * 2 and not buff.shieldBlock.exists and talent.heavyRepercussions) then
                if cast.shieldSlam() then return end
            end
        -- Revenge
            -- revenge
            if cast.revenge() then return end
        -- Thunder Clap
            -- thunder_clap,if=spell_targets.thunder_clap>=3
            if #enemies.yards8 >= 3 then
                if cast.thunderClap() then return end
            end
        -- Devastate
            -- devastate
            if cast.devastate() then return end 
        end -- End Action List - MultiTarget
    -- Action List - Main
        function actionList_Main()
        -- Shield Block
            -- shield_block,if=!buff.neltharions_fury.up&((cooldown.shield_slam.remains<6&!buff.shield_block.up)|(cooldown.shield_slam.remains<6+buff.shield_block.remains&buff.shield_block.up))
            if not buff.neltharionsFury.exists and ((cd.shieldSlam < 6 and not buff.shieldBlock.exists) or (cd.shieldSlam < 6 + buff.shieldBlock.remain and buff.shieldBlock.exists)) then
                if cast.shieldBlock() then return end
            end
        -- Ignore Pain
            -- ignore_pain,if=(rage>=60&!talent.vengeance.enabled)|(buff.vengeance_ignore_pain.up&buff.ultimatum.up)|(buff.vengeance_ignore_pain.up&rage>=39)|(talent.vengeance.enabled&!buff.ultimatum.up&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up&rage<30)
            if (rage >= 60 and not talent.vengeance) or (buff.vengeanceIgnorePain.exists and buff.ultimatum.exists) or (buff.vengeanceIgnorePain.exists and rage >= 39) 
                or (talent.vengeance and not buff.ultimatum.exists and not buff.vengeanceIgnorePain.exists and not buff.vengeanceFocusedRage.exists and rage < 30) 
            then 
                if cast.ignorePain() then return end
            end
        -- Focused Rage
            -- focused_rage,if=(buff.vengeance_focused_rage.up&!buff.vengeance_ignore_pain.up)|(buff.ultimatum.up&buff.vengeance_focused_rage.up&!buff.vengeance_ignore_pain.up)|(talent.vengeance.enabled&buff.ultimatum.up&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up)|(talent.vengeance.enabled&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up&rage>=30)|(buff.ultimatum.up&buff.vengeance_ignore_pain.up&cooldown.shield_slam.remains=0&rage<10)|(rage>=100)
            if (buff.vengeanceFocusedRage.exits and not buff.vengeanceIgnorePain.exists) 
                or (buff.ultimatum.exists and buff.vengeanceFocusedRage.exists and not buff.vengeanceIgnorePain.exists) 
                or (talent.vengence and buff.ultimatum.exists and not vengeanceIgnorePain.exists and not vengeanceFocusedRage.exists) 
                or (talent.vengeance and not buff.vengeanceIgnorePain.exists and not buff.vengeanceFocusedRage.exists and rage >= 30) 
                or (buff.ultimatum.exists and buff.vengeanceIgnorePain.exists and cd.shieldSlam == 0 and rage < 10) or rage >= 100 
            then
                if cast.focusedRage() then return end
            end
        -- Demoralizing Shout
            -- demoralizing_shout,if=incoming_damage_2500ms>health.max*0.20
            if useDefensive() and isChecked("Demoralizing Shout") then
                if php < getOptionValue("Demoralizing Shout") and inCombat then
                    if cast.demoralizingShout() then return end
                end
            end
        -- Shield Wall
            -- shield_wall,if=incoming_damage_2500ms>health.max*0.50
            if useDefensive() and isChecked("Shield Wall") then
                if php < getOptionValue("Shield Wall") and inCombat then
                    if cast.shieldWall() then return end
                end
            end
        -- Last Stand
            -- last_stand,if=incoming_damage_2500ms>health.max*0.50&!cooldown.shield_wall.remains=0
            if useDefensive() and isChecked("Last Stand") then
                if php < getOptionValue("Last Stand") and inCombat then
                    if cast.lastStand() then return end
                end
            end
        -- Potion
            -- potion,name=unbending_potion,if=(incoming_damage_2500ms>health.max*0.15&!buff.potion.up)|target.time_to_die<=25
            -- TODO
        -- Call Action List - Multitarget
            -- call_action_list,name=prot_aoe,if=spell_targets.neltharions_fury>=2
            if #enemies.yards8 >= 2 then
                if actionList_MultiTarget() then return end
            end
        -- Focused Rage
            -- focused_rage,if=talent.ultimatum.enabled&buff.ultimatum.up&!talent.vengeance.enabled
            if talent.ultimatum and buff.ultimatum.exists and not talent.vengeance then
                if cast.focusedRage() then return end
            end
        -- Battle Cry
            -- battle_cry,if=(talent.vengeance.enabled&talent.ultimatum.enabled&cooldown.shield_slam.remains<=5-gcd.max-0.5)|!talent.vengeance.enabled
            if useCDs() and isChecked("Battle Cry") then
                if (talent.vengeance and talent.ultimatum and cd.shieldSlam <= 5 - gcd - 0.5) or not talent.vengeance then
                    if cast.battleCry() then return end
                end
            end
        -- Demoralizing Shout
            -- demoralizing_shout,if=talent.booming_voice.enabled&buff.battle_cry.up
            if useCDs() and isChecked("Demoralizing Shout - CD") then
                if talent.boomingVoice and buff.battleCry.exists then
                    if cast.demoralizingShout() then return end
                end
            end
        -- Ravager
            -- ravager,if=talent.ravager.enabled&buff.battle_cry.up
            if useCDs() and isChecked("Ravager") then
                if talent.ravager and buff.battleCry.exists then
                    if cast.ravager("best",false,1,8) then return end
                end
            end
        -- Neltharion's Fury
            -- neltharions_fury,if=incoming_damage_2500ms>health.max*0.20&!buff.shield_block.up
            if getOptionValue("Artifact") == 1 or (getOptionValue("Artifact") == 2 and useDefensive()) then
                if php < getOptionValue("Artifact HP") and inCombat and not buff.shieldBlock.exists then
                    if cast.neltharionsFury("player") then return end
                end
            end
        -- Shield Slam
            -- shield_slam,if=!(cooldown.shield_block.remains<=gcd.max*2&!buff.shield_block.up&talent.heavy_repercussions.enabled)
            if not (cd.shieldBlock <= gcd * 2 and not buff.shieldBlock.exists and talent.heavyRepercussions) then
                if cast.shieldSlam() then return end
            end
        -- Revenge
            -- revenge,if=cooldown.shield_slam.remains<=gcd.max*2
            if cd.shieldSlam <= gcd * 2 then
                if cast.revenge() then return end
            end
        -- Devastate
            -- devastate
            if cast.devastate() then return end 
        end -- End Action List - Single
-----------------
--- Rotations ---
-----------------
        if actionList_Extra() then return end
        if actionList_Defensive() then return end
        -- Pause
        if pause() or (UnitExists("target") and (UnitIsDeadOrGhost("target") or not UnitCanAttack("target", "player"))) or mode.rotation == 4 then
            return true
        else
---------------------------------
--- Out Of Combat - Rotations ---
---------------------------------
            if not inCombat and isValidUnit("target") then
                if actionList_PreCombat() then return end
                if getDistance(units.dyn5)<5 then
                    StartAttack()
                else
            -- Action List - Movement
                    -- run_action_list,name=movement,if=movement.getDistance(units.dyn5)>5
                    if getDistance("target") >= 8 then
                        if actionList_Movement() then return end
                    end
                end
            end
-----------------------------
--- In Combat - Rotations --- 
-----------------------------
            if inCombat and isValidUnit(units.dyn5) then
            -- Auto Attack
                --auto_attack
                if getDistance(units.dyn5) < 5 then
                    StartAttack()
                end
            -- Action List - Movement
                -- run_action_list,name=movement,if=movement.getDistance(units.dyn5)>5
                if getDistance(units.dyn8) > 8 then
                    if actionList_Movement() then return end
                end
            -- Action List - Interrupts
                if actionList_Interrupts() then return end
            -- Action List - Cooldowns
                if actionList_Cooldowns() then return end
            -- Action List - Main
                if actionList_Main() then return end
            end -- End Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation 
local id = 73
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})