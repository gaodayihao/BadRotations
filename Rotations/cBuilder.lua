br.loader = {}
function br.loader:new(spec,specName)
    br.loader.rotations = {}
    for k, v in pairs(br.rotations) do
        if spec == k then
            for i = 1, #v do
                tinsert(br.loader.rotations, v[i])
            end
        end
    end
    local self = cCharacter:new(tostring(select(1,UnitClass("player"))))
    local player = "player" -- if someone forgets ""

    self.profile = specName
    
    -- Mandatory !
    self.rotations = br.loader.rotations

    -- Spells From Spell Table
    self.spell = mergeIdTables(self.spell)

    -- Spell Range
    self.spellRange             = {}
    self.spellRange.rage        = {["y8"]=8,["y9"]=9,["y10"]=10,["y12"]=12,["y20"]=20}

    -- Add Artifact Ability
    for k,v in pairs(self.spell.artifacts) do
        if not IsPassiveSpell(v) then
            self.spell['abilities'][k] = v
            self.spell[k] = v
            break
        end
    end 

    -- Update Talent Info
    local function getTalentInfo()
        br.activeSpecGroup = GetActiveSpecGroup()
        if self.talent == nil then self.talent = {} end
        local tempTalents = {}
        for r = 1, 7 do --search each talent row
            for c = 1, 3 do -- search each talent column
            -- Cache Talent IDs for talent checks
                local _,_,_,selected,_,talentID = GetTalentInfo(r,c,br.activeSpecGroup)
                table.insert(tempTalents,talentID,selected)
            end
        end

        -- Build Talent Info
        for k,v in pairs(self.spell.talents) do
            -- Add All Matches to Talent List for Boolean Checks
            self.talent[k] = tempTalents[v]
            -- Add All Active Ability Matches to Ability/Spell List for Use Checks
            if not IsPassiveSpell(v) and tempTalents[v] == true then
                self.spell['abilities'][k] = v
                self.spell[k] = v
            end
        end
    end

    -- build SpellRange
    local function buildSpellRange()
        -- Build Unit/Enemies Tables per Spell Range
        for k,v in pairs(self.spell.abilities) do
            local spellCast = v
            local spellName = GetSpellInfo(v)
            local minRange = select(5,GetSpellInfo(spellName))
            local maxRange = select(6,GetSpellInfo(spellName))
            if maxRange == nil or maxRange <= 0 then
                maxRange = 5
            end
            if not self.spellRange.rage["y"..tostring(maxRange)] then
                self.spellRange.rage["y"..tostring(maxRange)] = maxRange
            end
        end
    end

    -- Update Talent Info on Init and Talent Change
    getTalentInfo()
    buildSpellRange()
    AddEventCallback("PLAYER_TALENT_UPDATE",function()
        getTalentInfo()
        buildSpellRange()
    end)

------------------
--- OOC UPDATE ---
------------------

    function self.updateOOC()
        -- Call baseUpdateOOC()
        self.baseUpdateOOC()
    end

--------------
--- UPDATE ---
--------------

    function self.update()
        -- Call baseUpdate()
        self.baseUpdate()
        self.cBuilder()
        if select(2,UnitClass("player")) == "HUNTER" or select(2,UnitClass("player")) == "WARLOCK" then
            self.getPetInfo()
        end
        self.getToggleModes()
        -- Start selected rotation
        self:startRotation()
    end

---------------
--- BUILDER ---
---------------
    function self.cBuilder()

        -- local timeStart = debugprofilestop()
        -- Update Power
        -- self.mana           = UnitPower("player", 0)
        -- self.rage           = UnitPower("player", 1)
        -- self.focus          = UnitPower("player", 2)
        -- self.energy         = UnitPower("player", 3)
        -- self.comboPoints    = UnitPower("player", 4)
        -- self.runes          = UnitPower("player", 5)
        -- self.runicPower     = UnitPower("player", 6)
        -- self.soulShards     = UnitPower("player", 7)
        -- self.lunarPower     = UnitPower("player", 8)
        -- self.holyPower      = UnitPower("player", 9)
        -- self.altPower       = UnitPower("player",10)
        -- self.maelstrom      = UnitPower("player",11)
        -- self.chi            = UnitPower("player",12)
        -- self.insanity       = UnitPower("player",13)
        -- self.obsolete       = UnitPower("player",14)
        -- self.obsolete2      = UnitPower("player",15)
        -- self.arcaneCharges  = UnitPower("player",16)
        -- self.fury           = UnitPower("player",17)
        -- self.pain           = UnitPower("player",18)
        -- self.powerRegen     = getRegen("player")
        -- self.timeToMax      = getTimeToMax("player")

        powerList     = {
            mana            = 0,
            rage            = 1,
            focus           = 2,
            energy          = 3,
            comboPoints     = 4,
            runes           = 5,
            runicPower      = 6,
            soulShards      = 7,
            lunarPower      = 8,
            holyPower       = 9,
            altPower        = 10,
            maelstrom       = 11,
            chi             = 12,
            insanity        = 13,
            obsolete        = 14,
            obsolete2       = 15,
            arcaneCharges   = 16,
            fury            = 17,
            pain            = 18,
        }
        local function runeCDPercent(runeIndex)
            if GetRuneCount(runeIndex) == 0 then
                return (GetTime() - select(1,GetRuneCooldown(runeIndex))) / select(2,GetRuneCooldown(runeIndex))
            else
                return 0
            end
        end 
        if self.power == nil then self.power = {} end
        -- for i = 0, #powerList do
        for k, v in pairs(powerList) do
            if UnitPower("player",v) ~= nil then
                if self.power[k] == nil then self.power[k] = {} end
                if self.power.amount == nil then self.power.amount = {} end
                self.power[k].amount    = UnitPower("player",v)
                self.power[k].max       = UnitPowerMax("player",v)
                self.power[k].deficit   = UnitPowerMax("player",v) - UnitPower("player",v)
                self.power[k].percent   = (UnitPower("player",v) / UnitPowerMax("player",v)) * 100
                self.power.amount[k]    = UnitPower("player",v)
                -- DKs are special snowflakes
                if select(2,UnitClass("player")) == "DEATHKNIGHT" and v == 5 then
                    local runeCount = 0
                    for i = 1, 6 do
                        runeCount = runeCount + GetRuneCount(i)
                    end
                    self.power.amount[k]    = runeCount
                    self.power[k].amount    = runeCount
                    self.power[k].frac      = runeCount + math.max(runeCDPercent(1),runeCDPercent(2),runeCDPercent(3),runeCDPercent(4),runeCDPercent(5),runeCDPercent(6))
                end
            end
        end
        self.power.regen     = getRegen("player")
        self.power.ttm       = getTimeToMax("player") 

        self.units.dyn40 = dynamicTarget(40,  true)
        self.units.dyn40AoE = dynamicTarget(40,  false)
        self.enemies.yards40 = getEnemies("player",40)
        self.enemies.yards40t  = getEnemies(self.units.dyn40,40)
        local theseUnits = self.enemies.yards40
        for k,v in pairs(self.spellRange.rage) do
            if v ~= 40 then
                self.units["dyn"..tostring(v)]           = dynamicTarget(v,  true)
                self.units["dyn"..tostring(v).."AoE"]    = dynamicTarget(v,  false)
                self.enemies["yards"..tostring(v)]       = getTableEnemies("player",v,theseUnits)
                self.enemies["yards"..tostring(v).."t"]  = getTableEnemies(self.units["dyn"..tostring(v)],v,theseUnits)
            end
        end

        -- -- Build Best Unit per Range
        -- local typicalRanges = {
        --     40, -- Typical Ranged Limit
        --     35,
        --     30,
        --     25,
        --     20,
        --     15,
        --     13, -- Feral Interrupt
        --     12, 
        --     10, -- Other Typical AoE Effect
        --     9, -- Monk Artifact
        --     8, -- Typical AoE Effect
        --     5, -- Typical Melee
        -- }
        -- for x = 1, #typicalRanges do
        --     local i = typicalRanges[x]
        --     self.units["dyn"..tostring(i)]                  = dynamicTarget(i, true)
        --     self.units["dyn"..tostring(i).."AoE"]           = dynamicTarget(i, false) 
        --     self.enemies["yards"..tostring(i)]              = getTableEnemies("player",i,theseUnits)
        --     self.enemies["yards"..tostring(i).."t"]         = getTableEnemies(self.units["dyn"..tostring(i)],i,theseUnits)
        -- end

        if not UnitAffectingCombat("player") then
            -- Build Artifact Info
            for k,v in pairs(self.spell.artifacts) do
                self.artifact[k] = hasPerk(v) or false
                self.artifact.rank[k] = getPerkRank(v) or 0
            end
        end

        -- Build Buff Info
        for k,v in pairs(self.spell.buffs) do
            -- Build Buff Table
            if self.buff[k] == nil then self.buff[k] = {} end
            if k ~= "rollTheBones" then
                self.buff[k].exists     = UnitBuffID("player",v) ~= nil
                self.buff[k].duration   = getBuffDuration("player",v)
                self.buff[k].remain     = getBuffRemain("player",v)
                self.buff[k].refresh    = self.buff[k].remain <= self.buff[k].duration * 0.3
                self.buff[k].stack      = getBuffStacks("player",v)
            end
        end

        -- Build Debuff Info
        function self.getSnapshotValue(dot)
            -- Feral Bleeds
            if GetSpecializationInfo(GetSpecialization()) == 103 then
                local multiplier        = 1.00
                local Bloodtalons       = 1.30
                local SavageRoar        = 1.40
                local TigersFury        = 1.15
                local RakeMultiplier    = 1
                -- Bloodtalons
                if self.buff.bloodtalons.exists then multiplier = multiplier*Bloodtalons end
                -- Savage Roar
                if self.buff.savageRoar.exists then multiplier = multiplier*SavageRoar end
                -- Tigers Fury
                if self.buff.tigersFury.exists then multiplier = multiplier*TigersFury end
                -- rip
                if dot == self.spell.debuffs.rip then
                    -- -- Versatility
                    -- multiplier = multiplier*(1+Versatility*0.1)
                    -- return rip
                    return 5*multiplier
                end
                -- rake
                if dot == self.spell.debuffs.rake then
                    -- Incarnation/Prowl
                    if self.buff.incarnationKingOfTheJungle.exists or self.buff.prowl.exists then
                        RakeMultiplier = 2
                    end
                    -- return rake
                    return multiplier*RakeMultiplier
                end
                return 0
            end
        end
        for k,v in pairs(self.spell.debuffs) do
            -- Build Debuff Table for all enemy units
            if self.debuff[k] == nil then self.debuff[k] = {} end
                local debufCount = getDebuffCount(v)
                local debuffCalc = self.getSnapshotValue(v)
            -- Setup debuff table per valid unit and per debuff
                if #br.friend > 0 then
                    for i = 1, #br.friend do
                        local thisUnit = br.friend[i].unit
                        if self.debuff[k][thisUnit]             == nil then self.debuff[k][thisUnit]            = {} end
                        if self.debuff[k][thisUnit].applied     == nil then self.debuff[k][thisUnit].applied    = 0 end
                        self.debuff[k][thisUnit].exists         = UnitDebuffID(thisUnit,v,"player") ~= nil
                        self.debuff[k][thisUnit].duration       = getDebuffDuration(thisUnit,v,"player")
                        self.debuff[k][thisUnit].remain         = getDebuffRemain(thisUnit,v,"player")
                        self.debuff[k][thisUnit].refresh        = self.debuff[k][thisUnit].remain <= self.debuff[k][thisUnit].duration * 0.3
                        self.debuff[k][thisUnit].stack          = getDebuffStacks(thisUnit,v,"player")
                        self.debuff[k][thisUnit].calc           = debuffCalc
                        self.debuff[k][thisUnit].count          = debufCount
                        self.debuff[k][thisUnit].start          = getDebuffStart(thisUnit,v,"player")
                    end
                end
                if #self.enemies.yards40 > 0 then
                    for i = 1, #self.enemies.yards40 do
                        local thisUnit = self.enemies.yards40[i]
                        if self.debuff[k][thisUnit]                 == nil then self.debuff[k][thisUnit]            = {} end
                        if self.debuff[k][thisUnit].applied         == nil then self.debuff[k][thisUnit].applied    = 0 end
                        self.debuff[k][thisUnit].exists             = UnitDebuffID(thisUnit,v,"player") ~= nil
                        if self.debuff[k][thisUnit].exists then
                            self.debuff[k][thisUnit].duration       = getDebuffDuration(thisUnit,v,"player")
                            self.debuff[k][thisUnit].remain         = getDebuffRemain(thisUnit,v,"player")
                            self.debuff[k][thisUnit].refresh        = self.debuff[k][thisUnit].remain <= self.debuff[k][thisUnit].duration * 0.3
                            self.debuff[k][thisUnit].stack          = getDebuffStacks(thisUnit,v,"player")
                            self.debuff[k][thisUnit].calc           = debuffCalc
                            self.debuff[k][thisUnit].count          = debufCount
                            self.debuff[k][thisUnit].start          = getDebuffStart(thisUnit,v,"player")
                        else
                            self.debuff[k][thisUnit].duration       = 0
                            self.debuff[k][thisUnit].remain         = 0
                            self.debuff[k][thisUnit].refresh        = true
                            self.debuff[k][thisUnit].stack          = 0
                            self.debuff[k][thisUnit].calc           = 0
                            self.debuff[k][thisUnit].count          = 0
                            self.debuff[k][thisUnit].start          = 0
                        end
                        if UnitIsUnit(thisUnit,"target") then self.debuff[k]["target"] = self.debuff[k][thisUnit] end
                        if self.debuff[k]["target"] == nil then 
                            self.debuff[k]["target"]                = {} 
                            self.debuff[k]["target"].exists         = false
                            self.debuff[k]["target"].duration       = 0
                            self.debuff[k]["target"].remain         = 0
                            self.debuff[k]["target"].refresh        = true
                            self.debuff[k]["target"].stack          = 0
                            self.debuff[k]["target"].calc           = 0
                            self.debuff[k]["target"].count          = 0
                            self.debuff[k]["target"].start          = 0
                        end
                    end
                else
                    if self.debuff[k]["target"]             == nil then self.debuff[k]["target"]            = {} end
                    if self.debuff[k]["target"].applied     == nil then self.debuff[k]["target"].applied    = 0 end
                    self.debuff[k]["target"].exists         = false
                    self.debuff[k]["target"].duration       = 0
                    self.debuff[k]["target"].remain         = 0
                    self.debuff[k]["target"].refresh        = true
                    self.debuff[k]["target"].stack          = 0
                    self.debuff[k]["target"].calc           = 0
                    self.debuff[k]["target"].count          = 0
                    self.debuff[k]["target"].start          = 0
                end
            -- Remove non-valid entries
            for c,v in pairs(self.debuff[k]) do
                local thisUnit = c
                if (not ObjectExists(thisUnit) or UnitIsDeadOrGhost(thisUnit)) and not UnitIsUnit(thisUnit,"target") then self.debuff[k][c] = nil end
            end 
        end
        
        -- Cycle through Abilities List
        for k,v in pairs(self.spell.abilities) do
            if self.cast            == nil then self.cast               = {} end        -- Cast Spell Functions
            if self.cast.debug      == nil then self.cast.debug         = {} end        -- Cast Spell Debugging
            if self.charges.frac    == nil then self.charges.frac       = {} end        -- Charges Fractional
            if self.charges.max     == nil then self.charges.max        = {} end        -- Charges Maximum 

            -- Build Spell Charges
            self.charges[k]     = getCharges(v)
            self.charges.frac[k]= getChargesFrac(v)
            self.charges.max[k] = getChargesFrac(v,true)
            self.recharge[k]    = getRecharge(v)

            -- Build Spell Cooldown
            self.cd[k] = getSpellCD(v)

            -- Build Cast Funcitons
            self.cast[k] = function(thisUnit,debug,minUnits,effectRng)
                local spellCast = v
                local spellName = GetSpellInfo(v)
                local minRange = select(5,GetSpellInfo(spellName))
                local maxRange = select(6,GetSpellInfo(spellName))
                if IsHelpfulSpell(spellName) then
                    if thisUnit == nil or not UnitIsFriend(thisUnit,"player") then 
                        thisUnit = "player"
                    end
                    amIinRange = true 
                elseif thisUnit == nil then
                    if IsUsableSpell(v) and isKnown(v) then
                        if maxRange ~= nil and maxRange > 0 then
                            thisUnit = self.units["dyn"..tostring(maxRange)]
                            amIinRange = getDistance(thisUnit) < maxRange 
                        else
                            thisUnit = self.units.dyn5
                            amIinRange = getDistance(thisUnit) < 5  
                        end
                    end
                elseif thisUnit == "best" then
                    amIinRange = true
                elseif IsSpellInRange(spellName,thisUnit) == nil then
                    amIinRange = true
                else
                    amIinRange = IsSpellInRange(spellName,thisUnit) == 1
                end
                if minUnits == nil then minUnits = 1 end
                if effectRng == nil then effectRng = 8 end
                if not select(2,IsUsableSpell(v)) and getSpellCD(v) == 0 and isKnown(v) and amIinRange then
                    if debug == "debug" then
                        return castSpell(thisUnit,spellCast,false,false,false,false,false,false,false,true)
                    else
                        if thisUnit == "best" then
                            return castGroundAtBestLocation(spellCast,effectRng,minUnits,maxRange,minRange,debug)
                        elseif debug == "ground" then
                            if getLineOfSight(thisUnit) then 
                               return castGround(thisUnit,spellCast,maxRange,minRange)
                            end
                        elseif debug == "dead" then
                            if thisUnit == nil then thisUnit = "player" end
                            return castSpell(thisUnit,spellCast,false,false,false,true,true,true,true,false)
                        else
                            if thisUnit == nil then thisUnit = "player" end
                            return castSpell(thisUnit,spellCast,false,false,false,true,false,true,true,false)
                        end
                    end
                elseif debug == "debug" then
                    return false
                end
            end
            -- Build Cast Debug
            self.cast.debug[k] = self.cast[k](nil,"debug")
        end
    -- local duration = debugprofilestop()-timeStart
    -- local average = duration/1
    -- local cycles = 1
    -- Print(format("Function executed %i time(s) in %f ms (%f average)", cycles, duration, average))
    end

----------------
--- PET INFO ---
----------------
    function self.getPetInfo()
        if self.petType == nil then
            self.petType                    = {
                darkglare                   = 103673,
                doomguard                   = 11859,
                dreadStalkers               = 98035,
                felguard                    = 17252,
                felhunter                   = 417,
                Imp                         = 416,
                infernal                    = 89,
                succubus                    = 1863,
                voidwalker                  = 1860,
                wildImp                     = 55659,
            }
        end

        if self.petVaild == nil then
            self.petVaild                   ={
                [103673]                    = true,     -- darkglare
                [11859]                     = true,     -- doomguard
                [98035]                     = true,     -- dreadStalkers
                [17252]                     = true,     -- felguard
                [417]                       = true,     -- felhunter
                [416]                       = true,     -- Imp
                [89]                        = true,     -- infernal
                [1863]                      = true,     -- succubus
                [1860]                      = true,     -- voidwalker
                [55659]                     = true,     -- wildImp
            }
        end
        
        if self.petDuration == nil then
            self.petDuration                ={
                [103673]                    = 12,     -- darkglare
                [11859]                     = 25,     -- doomguard
                [98035]                     = 12,     -- dreadStalkers
                [17252]                     = -1,     -- felguard
                [417]                       = -1,     -- felhunter
                [416]                       = -1,     -- Imp
                [89]                        = 25,     -- infernal
                [1863]                      = -1,     -- succubus
                [1860]                      = -1,     -- voidwalker
                [55659]                     = 12,     -- wildImp
            }
        end
        if self.petStartTime == nil then
            self.petStartTime = {}
        end

        self.petInfo            = {}
        self.petPool            = {
            count               = {
                wildImp         = 0,
            },
            remain              = {
                wildImp         = 999,
                dreadStalkers   = 999,
            },
            noDEcount           ={
                wildImp         = 0,
                others          = 0,
            },
            useFelstorm         = false,
            demonwrathPet       = false,
        }
        local totalObjects = ObjectCount()
        local player        = GetObjectWithGUID(UnitGUID("player"))
        for i = 1, totalObjects do
            -- define our unit
            --local thisUnit = GetObjectIndex(i)
            local thisUnit = GetObjectWithIndex(i)
            -- check if it a unit first
            if ObjectIsType(thisUnit, ObjectTypes.Unit) then
                local unitID        = GetObjectID(thisUnit)
                local unitCreator   = UnitCreator(thisUnit)
                if unitCreator == player and (self.petVaild[unitID] or false) then
                --------------------
                -- build Pet Info --
                --------------------
                    --local unitName      = UnitName(thisUnit)
                    local unitGUID      = UnitGUID(thisUnit)
                    local demoEmpBuff   = UnitBuffID(thisUnit,self.spell.buffs.demonicEmpowerment) ~= nil
                    --local unitCount     = #getEnemies(tostring(thisUnit),10) or 0
                    
                    local pet = {
                                    name = "-", 
                                    guid = unitGUID, 
                                    id = unitID, 
                                    creator = unitCreator, 
                                    deBuff = demoEmpBuff, 
                                    numEnemies = 0,
                                    duration = self.petDuration[unitID] or -1,
                                    remain = 999,
                                }
                    if self.talent.grimoireOfSupremacy and (unitID == self.petType.doomguard or unitID == self.petType.infernal) then
                        pet.duration = -1
                    end

                    if pet.duration > 0 then
                        if self.petStartTime[pet.guid] == nil then
                            self.petStartTime[pet.guid] = GetTime()
                            pet.remain = pet.duration
                        else
                            pet.remain = pet.duration - (GetTime() - self.petStartTime[pet.guid])
                            if pet.remain < 0 then pet.remain = 0 end
                        end
                    end

                --------------------
                -- build Pet Pool --
                --------------------
                    if pet.id == self.petType.wildImp then
                        self.petPool.count.wildImp = self.petPool.count.wildImp + 1
                        self.petPool.remain.wildImp = math.min(self.petPool.remain.wildImp,pet.remain)
                        if not pet.deBuff then self.petPool.noDEcount.wildImp = self.petPool.noDEcount.wildImp + 1 end
                    elseif pet.id == self.petType.dreadStalkers then
                        self.petPool.remain.dreadStalkers = math.min(self.petPool.remain.dreadStalkers,pet.remain)
                        if not pet.deBuff then self.petPool.noDEcount.others = self.petPool.noDEcount.others + 1 end
                    else
                        if not pet.deBuff then self.petPool.noDEcount.others = self.petPool.noDEcount.others + 1 end
                    end

                    if not self.petPool.useFelstorm and pet.id == self.petType.felguard and (#getEnemies(tostring(thisUnit),10) or 0) > 0 then
                        self.petPool.useFelstorm = true
                    end
                    
                    if not self.petPool.demonwrathPet and (#getEnemies(tostring(thisUnit),10) or 0) >= 3 then
                        self.petPool.demonwrathPet = true
                    end

                    tinsert(self.petInfo,pet)
                end -- End If
            end -- End If
        end -- End for

        -- Clear up the pool
        if br.timer:useTimer("ClearPetStartTime",5) then
            local tempPool = {}
            for i = 1,#self.petInfo do
                local pet = self.petInfo[i]
                if pet.duration > 0 then
                    tempPool[self.petInfo[i].guid] = self.petStartTime[self.petInfo[i].guid]
                end
            end
            table.wipe(self.petStartTime)
            self.petStartTime = tempPool
        end
    end


---------------
--- TOGGLES ---
---------------

    function self.getToggleModes()

        self.mode.rotation      = br.data.settings[br.selectedSpec].toggles["Rotation"]
        self.mode.cooldown      = br.data.settings[br.selectedSpec].toggles["Cooldown"]
        self.mode.defensive     = br.data.settings[br.selectedSpec].toggles["Defensive"]
        self.mode.interrupt     = br.data.settings[br.selectedSpec].toggles["Interrupt"]
    end

    -- Create the toggle defined within rotation files
    function self.createToggles()
        GarbageButtons()
        if self.rotations[br.selectedProfile] ~= nil then
            self.rotations[br.selectedProfile].toggles()
        else
            return
        end
    end

---------------
--- OPTIONS ---
---------------

    -- Class options
    -- Options which every Rogue should have
    -- function self.createClassOptions()
    --     -- Class Wrap
    --     local section = br.ui:createSection(br.ui.window.profile,  "Class Options", "Nothing")
    --     br.ui:checkSectionState(section)
    -- end
     -- Creates the option/profile window
    function self.createOptions()
        -- br.ui:createProfileWindow(self.profile)
        br.ui:createProfileWindow(self.profile)

        -- Get the names of all profiles and create rotation dropdown
        local names = {}
        for i=1,#self.rotations do
            -- if spec == self.rotations[i].spec then
                tinsert(names, self.rotations[i].name)
            -- end
        end
        br.ui:createRotationDropdown(br.ui.window.profile.parent, names)

        -- Create Base and Class option table
        local optionTable = {
            {
                [1] = "Base Options",
                [2] = self.createBaseOptions,
            },
            -- {
            --     [1] = "Class Options",
            --     [2] = self.createClassOptions,
            -- },
        }

        -- Get profile defined options
        local profileTable = profileTable
        if self.rotations[br.selectedProfile] ~= nil then 
            profileTable = self.rotations[br.selectedProfile].options()
        else
            return
        end

        -- Only add profile pages if they are found
        if profileTable then
            insertTableIntoTable(optionTable, profileTable)
        end

        -- Create pages dropdown
        br.ui:createPagesDropdown(br.ui.window.profile, optionTable)
        -- br:checkProfileWindowStatus()
        br.ui:checkWindowStatus("profile")
    end

------------------------
--- CUSTOM FUNCTIONS ---
------------------------

    function useAoE()
        local rotation = self.mode.rotation
        if (rotation == 1 and #getEnemies("player",8) >= 3) or rotation == 2 then
            return true
        else
            return false
        end
    end

    function useCDs()
        local cooldown = self.mode.cooldown
        if (cooldown == 1 and isBoss()) or cooldown == 2 then
            return true
        else
            return false
        end
    end

    function useDefensive()
        if self.mode.defensive == 1 then
            return true
        else
            return false
        end
    end

    function useInterrupts()
        if self.mode.interrupt == 1 then
            return true
        else
            return false
        end
    end

    function useMfD()
        if self.mode.mfd == 1 then
            return true
        else
            return false
        end
    end

    function useRollForTB()
        if self.mode.RerollTB == 1 then
            return true
        else
            return false
        end
    end

     function useRollForOne()
        if self.mode.RollForOne == 1  then
            return true
        else
            return false
        end
    end

-----------------------------
--- CALL CREATE FUNCTIONS ---
-----------------------------
    -- Return
    return self
end --End function