local rotationName = "Ellis"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.demonwrath},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.demonwrath},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.shadowbolt},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.drainLife}
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
        section = br.ui:createSection(br.ui.window.profile, LC_GENERAL)
        -- Auto Target
            br.ui:createCheckbox(section, LC_AUTO_TARGET, LC_AUTO_TARGET_DESCRIPTION)
        -- Auto Facing
            br.ui:createCheckbox(section, LC_AUTO_FACING, LC_AUTO_FACING_DESCRIPTION)
        -- Artifact
            br.ui:createDropdown(section, LC_ARTIFACT, {LC_ARTIFACT_EVERY_TIME,LC_ARTIFACT_CD}, 1)
        -- Summon Pet
            br.ui:createDropdownWithout(section, 
                                        LC_SUMMON_PET, 
                                        {
                                            LC_SUMMON_PET_AUTO,
                                            LC_SUMMON_PET_IMP,
                                            LC_SUMMON_PET_VOIDWALKER,
                                            LC_SUMMON_PET_FELHUNTER,
                                            LC_SUMMON_PET_SUCCUBUS,
                                            LC_SUMMON_PET_FELGUARD
                                        }, 1, LC_SUMMON_PET_DESCRIPTION)
        -- Grimoire of Service
            br.ui:createDropdownWithout(section, LC_GRIMOIRE_OF_SERVICE,
                                        {
                                            LC_GRIMOIRE_OF_SERVICE_FELGUARD,
                                            LC_GRIMOIRE_OF_SERVICE_IMP,
                                            LC_GRIMOIRE_OF_SERVICE_FELHUNTER,
                                            LC_GRIMOIRE_OF_SERVICE_VOIDWALKER,
                                            LC_GRIMOIRE_OF_SERVICE_SUCCUBUS,
                                        }, 1, LC_GRIMOIRE_OF_SERVICE_DESCRIPTION)
        -- Grimoire of Supremacy
            br.ui:createDropdownWithout(section, LC_GRIMOIRE_OF_SUPREMACY, {LC_GRIMOIRE_OF_SUPREMACY_DOOMGUARD,LC_GRIMOIRE_OF_SUPREMACY_INFERNAL}, 1, LC_GRIMOIRE_OF_SUPREMACY_DESCRIPTION)
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, LC_COOLDOWNS)
        -- Racial
            br.ui:createCheckbox(section,LC_RACIAL,LC_RACIAL_DESCRIPTION)
        -- Trinkets
            br.ui:createCheckbox(section,LC_TRINKETS,LC_TRINKETS_DESCRIPTION)
        -- Soul Harvest
            br.ui:createCheckbox(section,LC_SOUL_HARVEST,LC_SOUL_HARVEST_DESCRIPTION)
        -- Doomguard
            br.ui:createCheckbox(section,LC_COOLDOWN_DOOMGUARD)
        -- Infernal
            br.ui:createCheckbox(section,LC_COOLDOWN_INFERNAL)
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, LC_DEFENSIVE)
        -- Healthstone
            br.ui:createSpinner(section, LC_POT_STONED,  60,  0,  100,  5,  LC_POT_STONED_DESCRIPTION)
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, LC_GIFT_OF_THE_NAARU,  50,  0,  100,  5,  LC_GIFT_OF_THE_NAARU_DESCRIPTION)
            end
        -- Dark Pact
            br.ui:createSpinner(section, LC_DARK_PACT, 50, 0, 100, 5, LC_DARK_PACT_DESCRIPTION)
        -- Drain Life
            br.ui:createSpinner(section, LC_DRAIN_LIFE, 30, 0, 100, 5, LC_DRAIN_LIFE_DESCRIPTION)
        -- Health Funnel
            br.ui:createSpinner(section, LC_HEALTH_FUNNEL, 30, 0, 100, 5, LC_HEALTH_FUNNEL_DESCRIPTION)
        -- Unending Resolve
            br.ui:createSpinner(section, LC_UNENDING_RESOLVE, 40, 0, 100, 5, LC_UNENDING_RESOLVE_DESCRIPTION)
        -- Soulstone
            br.ui:createCheckbox(section, LC_SOULSTONE)
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, LC_INTERRUPTS)
        -- Shadow Lock
            br.ui:createCheckbox(section,LC_SHADOW_LOCK)
        -- Spell Lock
            br.ui:createCheckbox(section,LC_SPELL_LOCK)
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
-------------------
--- Pet Manager ---
-------------------
        if br.player.petInfo == nil then
            br.player.petInfo = {}
            br.player.petType                    = {
                        [103673]                    = "darkglare",
                        [11859]                     = "doomguard",
                        [17252]                     = "felguard",
                        [1860]                      = "voidwalker",
                        [1863]                      = "succubus",
                        [416]                       = "Imp",
                        [417]                       = "felhunter",
                        [55659]                     = "wildImp",
                        [78158]                     = "doomguard",
                        [78217]                     = "infernal",
                        [89]                        = "infernal",
                        [98035]                     = "dreadStalkers",
                        [99737]                     = "wildImp",
                    }
            br.player.petDuration                ={
                        [103673]                    = 12,     -- darkglare
                        [11859]                     = 25,     -- doomguard
                        -- [17252]                     = -1,     -- felguard
                        -- [1860]                      = -1,     -- voidwalker
                        -- [1863]                      = -1,     -- succubus
                        -- [416]                       = -1,     -- Imp
                        -- [417]                       = -1,     -- felhunter
                        [55659]                     = 12,     -- wildImp
                        [89]                        = 25,     -- infernal
                        [98035]                     = 12,     -- dreadStalkers
                        [99737]                     = 12,     -- wildImp
                    }
            local function buildPetPool(...)
                local self = br.player
                local _, combatEvent, _, _, _, _, _, destGUID, destName, _, _, spellId, _, _ = ...
                if combatEvent == "SPELL_SUMMON" then
                    local _, _, _, _, _, _, _, unitID, _ = destGUID:find('(%S+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)-(%S+)')
                    unitID = tonumber(unitID)
                    local pet = {
                                    name = destName, 
                                    guid = destGUID, 
                                    id = unitID, 
                                    deBuff = false, 
                                    numEnemies = 0,
                                    duration = self.petDuration[unitID] or -1,
                                    remain = 999,
                                    start = GetTime(),
                                    unit = nil
                                }
                    if pet.duration == -1 and (spellId == self.spell.grimoireImp or (spellId >= self.spell.grimoireVoidwalker and spellId <= self.spell.grimoireFelguard)) then
                        pet.duration = 25
                    end
                    tinsert(self.petInfo,pet)
                elseif combatEvent == "SPELL_INSTAKILL" then
                    for i,_ in pairs(self.petInfo) do
                        if self.petInfo[i].guid == destGUID then
                            self.petInfo[i] = nil
                        end
                    end
                end
            end

            -- buildPetPool()
            addEventCallbackBR("COMBAT_LOG_EVENT_UNFILTERED",function(...)
                local _, _, _, sourceGUID = ...
                if sourceGUID ~= UnitGUID("player") then
                    return
                end
                buildPetPool(...)
            end, "Demonology")

            addEventCallbackBR("PLAYER_SPECIALIZATION_CHANGED",function(source)
                if source ~= "player" then
                    return
                end
                RemoveEventCallback("COMBAT_LOG_EVENT_UNFILTERED","Demonology")
                RemoveEventCallback("PLAYER_SPECIALIZATION_CHANGED","Demonology")
            end,"Demonology")
        end

        local function refreshPetPool()
            local self = br.player
            self.petPool                = {
                    count               = {},
                    remain              = {},
                    noDEcount           = {
                        wildImp         = 0,
                        others          = 0,
                    },
                    useFelstorm         = false,
                    demonwrathPet       = false,
                }
            for k,v in pairs(self.petType) do
                self.petPool.count[v] = 0
                self.petPool.remain[v] = 999
            end
            
            if #self.petInfo == 0 and self.pet ~= "None" then
                local objectId = GetObjectID("pet")
                tinsert(self.petInfo,
                {
                    name = UnitName("pet"),
                    guid = UnitGUID("pet"),
                    id = objectId, 
                    deBuff = false, 
                    numEnemies = 0,
                    duration = self.petDuration[objectId] or -1,
                    remain = 999,
                    start = GetTime(),
                    unit = "pet",
                })
            end

            for i,v in pairs(self.petInfo) do
                local pet = v

                if pet.unit == nil then
                    local sucess,thisUnit = pcall(GetObjectWithGUID,pet.guid)
                    if sucess == true then
                        pet.unit = thisUnit
                    end
                end

                if (pet.duration ~= -1 and GetTime() - pet.start >= pet.duration) or (pet.unit ~= nil and not ObjectExists(pet.unit)) then
                    self.petInfo[i] = nil
                end

                if self.petInfo[i] ~= nil and self.petInfo[i].unit ~= nil then
                    if pet.duration ~= -1 then
                        pet.remain = math.max(pet.duration - (GetTime() - pet.start),0)
                    end

                    local petType = self.petType[pet.id]
                    if petType ~= nil then
                        self.petPool.count[petType] = self.petPool.count[petType] + 1

                        self.petPool.remain[petType] = math.min(self.petPool.remain[petType],pet.remain)
                        
                        local noDE = UnitBuffID(pet.unit,self.spell.buffs.demonicEmpowerment) == nil
                        if noDE then
                            if petType == "wildImp" then
                                self.petPool.noDEcount.wildImp = self.petPool.noDEcount.wildImp + 1
                            else
                                self.petPool.noDEcount.others = self.petPool.noDEcount.others + 1
                            end
                        end
                        
                        if not self.petPool.useFelstorm and petType == "felguard" and (#getEnemies(pet.unit,8) or 0) > 0 and pet.duration == -1 then
                            self.petPool.useFelstorm = true
                        end

                        if not self.petPool.demonwrathPet and (#getEnemies(pet.unit,10) or 0) >= 3 then
                            self.petPool.demonwrathPet = true
                        end
                    else
                        Print("Pet Type is null:"..tostring(pet.id))
                    end
                end
            end
            -- Print("Active Pet:"..self.petId)
            -- Print("Pet Count:"..tostring(#self.petInfo))
            -- Print("Felguard Count:"..tostring(self.petPool.count.felguard))
        end
        refreshPetPool()
    --if br.timer:useTimer("debugDemonology", math.random(0.15,0.3)) then
        --print("Running: "..rotationName)
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
        local activePet                                     = br.player.pet
        local activePetId                                   = br.player.petId
        local artifact                                      = br.player.artifact
        local autoFacing                                    = isChecked(LC_AUTO_FACING)
        local autoTarget                                    = isChecked(LC_AUTO_TARGET)
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local castable                                      = br.player.cast.debug
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local combatTime                                    = getCombatTime()
        local debuff                                        = br.player.debuff
        local enemies                                       = br.player.enemies
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.agilityBig)
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
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
        local petInfo                                       = br.player.petInfo
        local petPool                                       = br.player.petPool
        local php                                           = br.player.health
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen, br.player.power.mana.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local resable                                       = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
        local shards                                        = br.player.power.amount.soulShards
        local solo                                          = GetNumGroupMembers() == 0
        local spell                                         = br.player.spell
        local summonPet                                     = getOptionValue(LC_SUMMON_PET)
        local talent                                        = br.player.talent
        local travelTime                                    = getDistance("target")/16
        local ttd                                           = getTTD
        local units                                         = br.player.units
        local useArtifact                                   = false

        if isChecked(LC_ARTIFACT) then
            if getOptionValue(LC_ARTIFACT) == 1 then
                useArtifact = artifact.thalkielsConsumption
            else
                useArtifact = useCDs() and artifact.thalkielsConsumption
            end
        end

        -- Doom
        local doom              = debuff.doom[units.dyn40]
        local nextShard         = 999
        local doomRemain        = 20 / (1+hasteAmount)
        
        if doom ~= nil and doom.exists then
            if doom.trick == 0 or doom.trick == nil then
                doom.trick = doom.start + doomRemain
            end
            if doom.trick <= GetTime() then
                if doom.remain >= doomRemain then
                    doom.trick = doom.trick + doomRemain
                else
                    doom.trick = doom.trick + doom.remain
                end
            end
            nextShard = math.max(0,doom.trick-GetTime()+0.05)
        elseif doom ~= nil then
            doom.trick = 0
        end

        if demonboltHack == nil then demonboltHack = 0 end
-----------------------
--- Custom Function ---
-----------------------
    -- Build Spell
        local function buildSpells()
            local self = br.player
            -- summonDarkglare
            self.cast.summonDarkglare = function(thisUnit,debug)
                local spellCast = self.spell.summonDarkglare
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonDarkglare == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,false,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,false)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonDoomguard
            self.cast.summonDoomguard = function(thisUnit,debug)
                local spellCast = self.spell.summonDoomguard
                local thisUnit = thisUnit
                local moveCheck = true
                if thisUnit == nil then
                    if self.talent.grimoireOfSupremacy then
                        thisUnit = "player"
                        moveCheck = true
                    else
                        thisUnit = "target"
                        moveCheck = false
                    end
                end
                if debug == nil then debug = false end

                if self.cd.summonDoomguard == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,moveCheck,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,moveCheck)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonFelguard
            self.cast.summonFelguard = function(thisUnit,debug)
                local spellCast = self.spell.summonFelguard
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonFelguard == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonFelhunter
            self.cast.summonFelhunter = function(thisUnit,debug)
                local spellCast = self.spell.summonFelhunter
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonFelhunter == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonFelImp
            self.cast.summonFelImp = function(thisUnit,debug)
                local spellCast = self.spell.summonFelImp
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonFelImp == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonImp
            self.cast.summonImp = function(thisUnit,debug)
                local spellCast = self.spell.summonImp
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonImp == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonInfernal
            self.cast.summonInfernal = function(thisUnit,debug)
                local spellCast = self.spell.summonInfernal
                local thisUnit = thisUnit
                local moveCheck = true
                if thisUnit == nil then
                    if self.talent.grimoireOfSupremacy then
                        thisUnit = "player"
                        moveCheck = true
                    else
                        thisUnit = "target"
                        moveCheck = false
                    end
                end
                if debug == nil then debug = false end

                if self.cd.summonInfernal == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,moveCheck,false,false,false,false,false,true)
                    elseif self.talent.grimoireOfSupremacy then
                        return castSpell(thisUnit,spellCast,false,moveCheck)
                    else
                        return castSpell(thisUnit,spellCast,true,moveCheck)
                        --return castGroundAtBestLocation(spellCast,10,1,30)
                    end 
                elseif debug then
                    return false
                end
            end

            -- summonSuccubus
            self.cast.summonSuccubus = function(thisUnit,debug)
                local spellCast = self.spell.summonSuccubus
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonSuccubus == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end

            -- summonVoidwalker
            self.cast.summonVoidwalker = function(thisUnit,debug)
                local spellCast = self.spell.summonVoidwalker
                local thisUnit = thisUnit
                if thisUnit == nil then thisUnit = "player" end
                if debug == nil then debug = false end

                if self.cd.summonVoidwalker == 0 and self.power.amount.soulShards >= 1 then
                    if debug then
                        return castSpell(thisUnit,spellCast,false,true,false,false,false,false,false,true)
                    else
                        return castSpell(thisUnit,spellCast,false,true)
                    end
                elseif debug then
                    return false
                end
            end
        end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
        end -- End Action List - Extras
    -- Action List - Defensive
        local function actionList_Defensive()
            if useDefensive() then
        -- Pot/Stoned
                if inCombat and isChecked(LC_POT_STONED) and php <= getOptionValue(LC_POT_STONED) 
                    and (hasHealthPot() or hasItem(5512)) 
                then
                    if canUse(5512) and useItem(5512) then return true end
                    if canUse(healPot) and useItem(healPot) then return true end
                end
        -- Gift of the Naaru
                if isChecked(LC_GIFT_OF_THE_NAARU) and getSpellCD(racial)==0 and php <= getOptionValue(LC_GIFT_OF_THE_NAARU) and php > 0 and race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return true end
                end
        -- Dark Pact
                if talent.darkPact and isChecked(LC_DARK_PACT) and php <= getOptionValue(LC_DARK_PACT) and getHP("pet") * 0.8 > getOptionValue(LC_HEALTH_FUNNEL) then
                    if cast.darkPact() then return true end
                end
        -- Unending Resolve
                if isChecked(LC_UNENDING_RESOLVE) and php <= getOptionValue(LC_UNENDING_RESOLVE) then
                    if cast.unendingResolve() then return true end
                end
        -- Health Funnel
                if not inRaid and isChecked(LC_HEALTH_FUNNEL) and activePet ~= "None" and getHP("pet") <= getOptionValue(LC_HEALTH_FUNNEL) and php >= 30 then
                    if cast.healthFunnel() then return true end
                end
        -- Soulstone
                if inCombat and isChecked(LC_SOULSTONE) and resable then
                    if cast.soulstone("target") then return true end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() and br.timer:useTimer("Interrupts",1.5) then
                local dist = 8
                local source = "player"
                if petId == 78158 or petId == 417 then
                    dist = 40
                    source = "pet"
                end
                local theEnemies = getEnemies(source,dist)
                for i=1, #theEnemies do
                    thisUnit = theEnemies[i]
                    if canInterrupt(thisUnit,getOptionValue(LC_INTERRUPTS_AT)) then
                        if petId == 78158 and isChecked(LC_SHADOW_LOCK) then
                    -- Shadow Lock
                            if cast.shadowLock(thisUnit) then return true end
                        elseif petId == 417 and isChecked(LC_SPELL_LOCK) then
                    -- Spell Lock
                            if cast.spellLock(thisUnit) then return true end
                        end
                    -- Arcane Torrent
                        if isChecked(LC_ARCANE_TORRENT) and getSpellCD(racial) == 0 and getDistance(thisUnit) <=8 then
                            if castSpell("player",racial,false,false,false) then return true end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance(units.dyn40) < 40 then
            -- Trinkets
                if isChecked(LC_TRINKETS) then
                    if canUse(13) and useItem(13) then return true end
                    if canUse(14) and useItem(14) then return true end
                end
            -- Racial
                if isChecked(LC_RACIAL) 
                    and (br.player.race == "Orc" or br.player.race == "Troll")
                    and getSpellCD(racial) == 0
                then
                    if castSpell("player",racial,false,false,false) then return true end
                end
            -- Soul Harvest
                if talent.soulHarvest and isChecked(LC_SOUL_HARVEST) then
                    if cast.soulHarvest() then return true end
                end
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
           
        end -- End Action List - PreCombat
        local function actionList_Opener()
          
        end
    -- Action List - Summon Pet
        local function actionList_SummonPet()
            --print(activePet)
            if not IsMounted() and activePet == "None" and br.timer:useTimer("Summon Pet",1.5) then
                if summonPetDelay == nil then summonPetDelay = 0 end
                if summonPetDelay == 0 then summonPetDelay = 1 return end
                summonPetDelay = 0
                if summonPet == 1 then
                    if talent.grimoireOfSupremacy then
                        if solo then
                            if cast.summonInfernal() then return true end
                        elseif getOptionValue(LC_GRIMOIRE_OF_SUPREMACY) == 1 then
                            if cast.summonDoomguard() then return true end
                        elseif getOptionValue(LC_GRIMOIRE_OF_SUPREMACY) == 2 then
                            if cast.summonInfernal() then return true end
                        end
                    else
                        if cast.summonFelguard() then return true end
                    end
                elseif summonPet == 2 then
                    if isKnown(spell.summonFelImp) then
                        if cast.summonFelImp() then return true end
                    else  
                        if cast.summonImp() then return true end
                    end
                elseif summonPet == 3 then
                    if cast.summonVoidwalker() then return true end
                elseif summonPet == 4 then
                    if cast.summonFelhunter() then return true end
                elseif summonPet == 5 then
                    if cast.summonSuccubus() then return true end
                elseif summonPet == 6 then
                    if cast.summonFelguard() then return true end
                end
            end
        end 
    -- Action List - Auto Target
        local function actionList_AutoTarget()
            if autoTarget == false then return end
            if friendly or isValidUnit("target") then return end
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
    -- Pet Attack
            if activePet ~= "None" and not UnitIsUnit("pettarget","target") then
                PetAttack()
            end
    -- Implosion
        -- implosion,if=wild_imp_remaining_duration<=action.shadow_bolt.execute_time&buff.demonic_synergy.remains
        -- implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=3&buff.demonic_synergy.remains
        -- implosion,if=wild_imp_count<=4&wild_imp_remaining_duration<=action.shadow_bolt.execute_time&spell_targets.implosion>1
        -- implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=4&spell_targets.implosion>2
            if talent.implosion and petPool.count.wildImp > 0 and ((petPool.remain.wildImp < getCastTime(spell.shadowbolt) and buff.demonicSynergy.exists)
                or (lastSpell == spell.handOfGuldan and petPool.remain.wildImp <=3 and buff.demonicSynergy.exists)
                or (petPool.count.wildImp <=4 and petPool.remain.wildImp <= getCastTime(spell.shadowbolt) and #enemies.yards8t > 1)
                or (lastSpell == spell.handOfGuldan and petPool.remain.wildImp <= 4 and #enemies.yards8t > 2)) 
            then
                if cast.implosion() then return end
            end
    -- Shadowflame
        -- shadowflame,if=debuff.shadowflame.stack>0&remains<action.shadow_bolt.cast_time+travel_time
            if talent.shadowflame and debuff.shadowflame[units.dyn40] ~= nil then
                if debuff.shadowflame[units.dyn40].stack > 0 and debuff.shadowflame[units.dyn40].remain < getCastTime(spell.shadowbolt) + travelTime then
                    if cast.shadowflame() then return end
                end
            end
    -- Service Pet
            if talent.grimoireOfService and useCDs() and br.timer:useTimer("castGrim", gcd) then
                local grimoirePet = getOptionValue(LC_GRIMOIRE_OF_SERVICE)
                if grimoirePet == 1 then
                    if cast.grimoireFelguard() then return end
                end
                if grimoirePet == 2 then
                    if cast.grimoireImp() then return end
                end
                if grimoirePet == 3 then
                    if cast.grimoireFelhunter() then return end
                end
                if grimoirePet == 4 then
                    if cast.grimoireVoidwalker() then return end
                end
                if grimoirePet == 5 then
                    if cast.grimoireSuccubus() then return end
                end
            end
    -- Summon Doomguard
        --summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<3&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
            if useCDs() and isChecked(LC_COOLDOWN_DOOMGUARD) and not talent.grimoireOfSupremacy and (ttd("target") > 180 or getHP("target") <=20 or ttd("target") < 30) and #enemies.yards10t < 3 then
                if cast.summonDoomguard() then return end
            end
    -- Summon Infernal
        --summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>=3
            if useCDs() and isChecked(LC_COOLDOWN_INFERNAL) and not talent.grimoireOfSupremacy and #enemies.yards10t >= 3 then
                if cast.summonInfernal() then return end
            end
    -- Summon Doomguard
        -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<3&equipped.132379&!cooldown.sindorei_spite_icd.remains
    -- Summon Infernal
        -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>=3&equipped.132379&!cooldown.sindorei_spite_icd.remains
    -- Call Dreadstalkers
        -- call_dreadstalkers,if=!talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)
            if (not (hasEquiped(132393) and buff.demonicCalling.exists and (shards >= 4 or shards >= 3 and getCastTime(spell.callDreadstalkers) > nextShard)))
                and not talent.summonDarkglare 
                and (not talent.implosion or #enemies.yards10t < 3)
                and not (hasEquiped(132393) and (shards == 3 or shards == 2 and getCastTime(spell.demonbolt) > nextShard))
            then
                if cast.callDreadstalkers() then return end
            end
    -- Hand of Guldan
        -- hand_of_guldan,if=soul_shard>=4&!talent.summon_darkglare.enabled
            if (lastSpell ~= spell.handOfGuldan 
                and (shards >= 4 or shards >= 3 and getCastTime(spell.handOfGuldan) > nextShard) 
                and not talent.summonDarkglare)
            then
                if cast.handOfGuldan() then return end
            end
    -- Summon Darkglare
        -- summon_darkglare,if=prev_gcd.hand_of_guldan
        -- summon_darkglare,if=prev_gcd.call_dreadstalkers
        -- summon_darkglare,if=cooldown.call_dreadstalkers.remains>5&soul_shard<3
        -- summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=3
        -- summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=1&buff.demonic_calling.react
            if talent.summonDarkglare and (lastSpell == spell.callDreadstalkers 
                or lastSpell == spell.handOfGuldan 
                or (cd.callDreadstalkers > 5 and shards < 3)
                or (cd.callDreadstalkers <= getCastTime(spell.summonDarkglare) and shards >=3)
                or (cd.callDreadstalkers <= getCastTime(spell.summonDarkglare) and shards >=1 and buff.demonicCalling.exists))
            then
                if cast.summonDarkglare() then return end
            end
    -- Call Dreadstalkers
        -- call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains>2
        -- call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&prev_gcd.summon_darkglare
        -- call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=3
        -- call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=1&buff.demonic_calling.react
            if talent.summonDarkglare and not (hasEquiped(132393) and buff.demonicCalling.exists and (shards >= 4 or shards >= 3 and getCastTime(spell.callDreadstalkers) > nextShard)) and (#enemies.yards10t < 3 or not talent.implosion) and (
                cd.summonDarkglare >2
                or lastSpell == spell.summonDarkglare
                or cd.summonDarkglare <= getCastTime(spell.callDreadstalkers) and shards == 3
                or cd.summonDarkglare <= getCastTime(spell.callDreadstalkers) and shards >=1 and buff.demonicCalling.exists)
            then
                if cast.callDreadstalkers() then return end
            end
    -- Hand of Guldan
        -- hand_of_guldan,if=soul_shard>=3&prev_gcd.call_dreadstalkers
        -- hand_of_guldan,if=soul_shard>=5&cooldown.summon_darkglare.remains<=action.hand_of_guldan.cast_time
        -- hand_of_guldan,if=soul_shard>=4&cooldown.summon_darkglare.remains>2
            if lastSpell ~= spell.handOfGuldan and talent.summonDarkglare and (shards >= 3 and lastSpell == spell.callDreadstalkers 
                or shards >= 5 and cd.summonDarkglare < getCastTime(spell.handOfGuldan)
                or (shards >= 4 or shards >= 3 and getCastTime(spell.handOfGuldan) > nextShard) and cd.summonDarkglare > 2)
            then
                if cast.handOfGuldan() then return end
            end
    -- demonic_empowerment
        -- demonic_empowerment,if=wild_imp_no_de>3|prev_gcd.hand_of_guldan
        -- demonic_empowerment,if=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0
            if lastSpell ~= spell.demonicEmpowerment 
                and (cd.callDreadstalkers > getCastTime(spell.demonbolt) and (shards >= 2 or buff.demonicCalling))
                and (petPool.noDEcount.wildImp > 3 or lastSpell == spell.handOfGuldan or petPool.noDEcount.others > 0) 
            then
                if cast.demonicEmpowerment() then return end
            end
    -- Felstorm
        -- felguard:felstorm
            if cd.Felstorm == 0 and petPool.useFelstorm then
                if cast.commandDemon() then return end
            end
    -- Doom
        -- doom,cycle_targets=1,if=!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3)
            for i = 1, #enemies.yards40 do
                local thisUnit = enemies.yards40[i]
                local doom = debuff.doom[thisUnit]
                local unitTTD = ttd(thisUnit)
                if doom ~= nil then
                    if (not talent.handOfGuldan or getDistance("target",thisUnits) > 8) 
                        and ((not doom.exists and unitTTD > 20 / (1+hasteAmount)) or (unitTTD > doom.duration and doom.refresh))
                    then
                        if cast.doom(thisUnit) then return end
                    end
                end
            end
    -- Cooldowms
            if actionList_Cooldowns() then return end
    -- Shadowflame
        -- shadowflame,if=charges=2
            if charges.shadowflame == 2 then 
                if cast.shadowflame() then return end
            end
    -- Thal'kiel's Consumption
        -- thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&wild_imp_count>3&wild_imp_remaining_duration>execute_time
            if (petPool.remain.dreadStalkers > getCastTime(spell.thalkielsConsumption) or (talent.implosion and #enemies.yards8t >= 3)) 
                and petPool.count.wildImp > 3 and petPool.remain.wildImp > getCastTime(spell.thalkielsConsumption) 
                and petPool.noDEcount.others + petPool.noDEcount.wildImp == 0
            then
                if useArtifact and cast.thalkielsConsumption() then return end
            end
    -- Drain Life
            if useDefensive() and isChecked(LC_DRAIN_LIFE) and php <= getOptionValue(LC_DRAIN_LIFE) then
                if cast.drainLife() then return end
            end
    -- Life Tap
        -- life_tap,if=mana.pct<=30
            if manaPercent <= 30 then
                if cast.lifeTap() then return end
            end
    -- Demonwrath
        -- demonwrath,chain=1,interrupt=1,if=spell_targets.demonwrath>=3
        -- demonwrath,moving=1,chain=1,interrupt=1
            if petPool.demonwrathPet or moving and #petInfo > 0 then
                if cast.demonwrath() then return end
            end
    -- Demonbolt/Shadow Bolt
        -- demonbolt
        -- shadow_bolt
            if talent.demonbolt then
                if cast.demonbolt() then demonboltHack = 1 return end
            else 
                if cast.shadowbolt() then demonboltHack = 1 return end
            end
    -- Life Tap
        -- life_tap
            if manaPercent < 70 then
                if cast.lifeTap() then return end
            end
        end
---------------------
--- Begin Profile ---
---------------------
    -- Stop Demon Wrath
        if isCastingSpell(spell.demonwrath) and not petPool.demonwrathPet and not moving then
            SpellStopCasting()
        end
        if isCastingSpell(spell.healthFunnel) and getHP("pet") >= 98 then
            SpellStopCasting()
        end
    -- Profile Stop | Pause
        local isPause = pause()
        if isPause or mode.rotation==4 or IsMounted() or demonboltHack > 0 then
            if (mode.rotation==4 or IsMounted()) and activePet ~= "None" then
                PetFollow()
            end
            if not isPause and demonboltHack > 0 then
                demonboltHack = demonboltHack - 1
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
-------------------------
--- Extras Summon Pet ---
-------------------------
            if actionList_SummonPet() then return end
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
    ---------------------------
    --- In Combat - Default ---
    ---------------------------
                if actionList_Default() then return end
            end --End In Combat
        end --End Rotation Logic
    --end -- End Timer
end -- End runRotation
local id = 266
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})