-- Function to create and populate table of enemies within a distance from player.
function EnemiesEngine()
	-- Todo: So i think the prioritisation should be large by determined by threat or burn prio and then hp.
	-- So design should be,
	-- Check if the unit is on doNotTouchUnitCandidates list which means we should not attack them at all
	-- Check towards doNotTouchUnitCandidatesBuffs (buffs/debuff), ie target we are not allowed to attack due to them having
	-- a (de)buff that hurts us or not. Example http://www.wowhead.com/spell=163689
	-- Is the unit on burn list, set high prio, burn list is a list of mobs that we specify for burn, is highest dps and prio.
	-- We should then look at the threat situation, for tanks the this is of high prio if we are below 3 but all below 3
	-- should have the same prio coefficent. For dps its not that important
	-- Then we should check HP of the targets and set highest prio on low targets, this is also something we need to think
	-- about if the target have a dot so it will die regardless or not. Should have a timetodie?
	-- Stack: Interface\AddOns\BadRotations\System\EnemiesEngine.lua:224: in function `castInterrupt'
	-- isBurnTarget(unit) - Bool - True if we should burn that target according to burnUnitCandidates
	-- isSafeToAttack(unit) - Bool - True if we can attack target according to doNotTouchUnitCandidates
	-- getEnemies(unit,Radius) - Number - Returns number of valid units within radius of unit
	-- castInterrupt(spell,percent) - Multi-Target Interupts - for facing/in movements spells of all ranges.
	-- makeEnemiesTable(55) - Triggered in badboy.lua - generate the br.enemy
	--[[------------------------------------------------------------------------------------------------------------------]]
	--[[------------------------------------------------------------------------------------------------------------------]]
	--[[------------------------------------------------------------------------------------------------------------------]]
	--[[------------------------------------------------------------------------------------------------------------------]]
	local varDir = br.data.settings[br.selectedSpec]
	br.enemy = {}
	br.enemyGUID = {}
	br.namePlateUnit = {}
	br.namePlateUnitCount = 0
	br.EventInited = false
	-- brEnemyCount = 0
	br.debug.cpu.enemiesEngine.sanityTargets = 0
	br.debug.cpu.enemiesEngine.unitTargets = 0

	function addEnemiesTableEvents()
		if not FireHack or br.EventInited then
			return
		end

		AddEventCallback("COMBAT_LOG_EVENT_UNFILTERED",function(...)
			local _, _, _, sourceGUID, _, _, _, destGUID, destName, _, _, spellId, _, _ = ...

			if br.enemyGUID[sourceGUID] == nil then
				local sucess,thisUnit = pcall(GetObjectWithGUID,sourceGUID)
				if sucess and isValidUnit(thisUnit) then
					br.enemy[thisUnit] = {}
					br.enemyGUID[sourceGUID] = thisUnit
					br.debug.cpu.enemiesEngine.sanityTargets = br.debug.cpu.enemiesEngine.sanityTargets + 1
				end
			end

			if br.enemyGUID[destGUID] == nil then
				local sucess,thisUnit = pcall(GetObjectWithGUID,destGUID)
				if sucess and isValidUnit(thisUnit) then
					br.enemy[thisUnit] = {}
					br.enemyGUID[destGUID] = thisUnit
					br.debug.cpu.enemiesEngine.sanityTargets = br.debug.cpu.enemiesEngine.sanityTargets + 1
				end
			end
		end)

		AddEventCallback("NAME_PLATE_UNIT_ADDED",function(...)
			if br.namePlateUnitCount >= 30 then
				table.wipe(br.namePlateUnit)
				br.namePlateUnitCount = 0
			end
			local sucess,thisUnit = pcall(GetObjectWithGUID,UnitGUID(...))
			if sucess and br.namePlateUnit[thisUnit] == nil then
				br.namePlateUnit[thisUnit] = UnitGUID(...)
				br.namePlateUnitCount = br.namePlateUnitCount + 1
			end
		end)

		br.EventInited = true
	end

	function makeEnemiesTable(maxDistance)
		--local LibDraw = LibStub("LibDraw-1.0")
		local  maxDistance = maxDistance or 40
		if br.enemy then cleanupEngine(maxDistance) end
		local startTime
		if br.data.settings[br.selectedSpec].toggles["isDebugging"] == true then
			startTime = debugprofilestop()
		end
		
		if isValidUnit("target") then
			local targetGUID = UnitGUID("target")
			if br.enemyGUID[targetGUID] == nil then
				local thisUnit = GetObjectWithGUID(UnitGUID("target"))
				br.enemy[thisUnit] 	= { }
				br.enemyGUID[targetGUID] = thisUnit
				br.debug.cpu.enemiesEngine.sanityTargets = br.debug.cpu.enemiesEngine.sanityTargets + 1
			end
		end
		
		for k,v in pairs(br.namePlateUnit) do
			local thisUnit = k
			local unitGUID = v
			if br.enemyGUID[unitGUID] == nil and isValidUnit(thisUnit) then
				br.enemy[thisUnit] 	= { }
				br.enemyGUID[unitGUID] = thisUnit
				br.debug.cpu.enemiesEngine.sanityTargets = br.debug.cpu.enemiesEngine.sanityTargets + 1
			end
		end

		-- update infos
		if br.enemy ~= nil then
			for k, v in pairs(br.enemy) do
				local thisUnit 				= k
				local burnValue 			= isBurnTarget(thisUnit) or 0
				local shieldValue 			= isShieldedTarget(thisUnit) or 0
				local unitThreat 			= UnitThreatSituation("player",thisUnit) or -1
				br.enemy[k].name 			= UnitName(thisUnit)
				br.enemy[k].guid 			= UnitGUID(thisUnit)
				br.enemy[k].id 				= GetObjectID(thisUnit)
				br.enemy[k].coeficient 		= getUnitCoeficient(thisUnit,unitDistance,unitThreat,burnValue,shieldValue) or 0
				br.enemy[k].cc 				= isCrowdControlCandidates(thisUnit)
				if getOptionCheck("Don't break CCs") then
					br.enemy[k].isCC 		= isLongTimeCCed(thisUnit)
				else
					br.enemy[k].isCC 		= false
				end
				br.enemy[k].facing 			= getFacing("player",thisUnit)
				br.enemy[k].threat 			= UnitThreatSituation("player",thisUnit) or -1
				br.enemy[k].unit 			= thisUnit
				-- distance = unitDistance,
				br.enemy[k].hp 				= getHP(thisUnit)
				br.enemy[k].hpabs 			= UnitHealth(thisUnit)
				br.enemy[k].safe 			= isSafeToAttack(thisUnit)
				br.enemy[k].burn 			= isBurnTarget(thisUnit) or 0
				br.enemy[k].offensiveBuff 	= getOffensiveBuffs(thisUnit,unitGUID)
			end
		end
		if br.data.settings[br.selectedSpec].toggles["isDebugging"] == true then
			br.debug.cpu.enemiesEngine.makeEnemiesTableCount = br.debug.cpu.enemiesEngine.makeEnemiesTableCount + 1
			br.debug.cpu.enemiesEngine.makeEnemiesTableCurrent = debugprofilestop()-startTime
			br.debug.cpu.enemiesEngine.makeEnemiesTable = br.debug.cpu.enemiesEngine.makeEnemiesTable + debugprofilestop()-startTime
			br.debug.cpu.enemiesEngine.makeEnemiesTableAverage = br.debug.cpu.enemiesEngine.makeEnemiesTable / br.debug.cpu.enemiesEngine.makeEnemiesTableCount
		end
		-- Print("EnemyCount:"..tostring(br.debug.cpu.enemiesEngine.sanityTargets))
	end

	-- remove invalid units on pulse
	function cleanupEngine(maxDistance)
		local  maxDistance = maxDistance or 40
		for thisUnit,_ in pairs(br.enemy) do
			-- here i want to scan the enemies table and find any occurances of invalid units
			if not ObjectExists(thisUnit) or not isValidUnit(thisUnit) then
				-- i will remove such units from table
				br.enemy[thisUnit] = nil
				br.debug.cpu.enemiesEngine.sanityTargets = br.debug.cpu.enemiesEngine.sanityTargets - 1
			end
		end

		if br.debug.cpu.enemiesEngine.sanityTargets == 0 then
			br.enemyGUID = {}
		end

		for thisUnit,_ in pairs(br.namePlateUnit) do
			if thisUnit == nil or not ObjectExists(thisUnit) or UnitIsDeadOrGhost(thisUnit) then
				br.namePlateUnit[thisUnit] = nil
				br.namePlateUnitCount = br.namePlateUnitCount - 1
			end
		end
	end

	-- returns prefered target for diferent spells
	function dynamicTarget(range,facing)
		if getOptionCheck("Dynamic Targetting") then
			local bestUnitCoef = 0
			local bestUnit = "target"
			for k, v in pairs(br.enemy) do
				local thisUnit = br.enemy[k]
				local thisDistance = getDistance("player",thisUnit.unit)
				if GetObjectExists(thisUnit.unit) then
					if (not getOptionCheck("Safe Damage Check") or thisUnit.safe) and thisUnit.isCC == false and thisDistance < range and (facing == false or thisUnit.facing == true) then
						if thisUnit.coeficient >= 0 and thisUnit.coeficient >= bestUnitCoef then
							bestUnitCoef = thisUnit.coeficient
							bestUnit = thisUnit.unit
						end
					end
				end
			end
			return bestUnit
		else
			return "target"
		end
		return "target"
	end
	-- get the best aoe interupt unit for a given range
	function getBestAoEInterupt(Range)
		-- pulse our function that add casters around to castersTable
		findCastersAround(Range)
		-- dummy var
		local bestAoEInteruptAmount = 0
		local bestAoEInteruptTarget = "target"
		-- cycle spellCasters to find best case
		local spellCastersTable = br.im.casters
		for i = 1, #spellCastersTable do
			-- check if unit is valid
			if GetObjectExists(spellCastersTable[i].unit) then
				-- if dummy beat old dummy, update
				if spellCastersTable[i].castersAround > bestAoEInteruptAmount then
					bestAoEInteruptAmount = spellCastersTable[i].castersAround
					bestAoEInteruptTarget = spellCastersTable[i].unit
				end
			end
		end
		-- return best case
		return bestAoEInteruptTarget
	end
	function getDebuffCount(spellID)
		local counter = 0
		for k, v in pairs(br.enemy) do
			local thisUnit = br.enemy[k].unit
			-- check if unit is valid
			if GetObjectExists(thisUnit) then
				-- increase counter for each occurences
				if UnitDebuffID(thisUnit,spellID,"player") then
					counter = counter + 1
				end
			end
		end
		return counter
	end
	-- to enlight redundant checks in getDistance within getEnemies
	function getDistanceXYZ(unit1,unit2)
		return GetDistanceBetweenObjects(unit1,unit2)
	end
	-- /dump UnitGUID("target")
	-- /dump getEnemies("target",10)
	function getEnemies(unit,Radius,InCombat,precise)
		if GetObjectExists(unit) and UnitIsVisible(unit) then
			local getEnemiesTable = { }
			for k, v in pairs(br.enemy) do
				local thisUnit = br.enemy[k].unit
				-- check if unit is valid
				if GetObjectExists(thisUnit) and (not InCombat) then
					if unit == "player" and not precise then
						if getDistance("player",thisUnit) <= Radius then
							tinsert(getEnemiesTable,thisUnit)
						end
					else
						if getDistance(unit,thisUnit) <= Radius then
							tinsert(getEnemiesTable,thisUnit)
						end
					end
				end
			end
			return getEnemiesTable
		else
			return { }
		end
	end
	function getTableEnemies(unit,Range,table)
		local getTableEnemies = { }
		if table == nil then return getTableEnemies end
		for i = 1, #table do
			local thisUnit = table[i]
			if getDistance(unit,thisUnit) <= Range then
				tinsert(getTableEnemies,thisUnit)
			end
		end
		return getTableEnemies
	end

	function getEnemiesInRect(width,length)
		local LibDraw = LibStub("LibDraw-1.0")
		local playerX, playerY, playerZ = GetObjectPosition("player")
		local facing = ObjectFacing("player")

		-- Near Left
		local nlX, nlY, nlZ = GetPositionFromPosition(playerX, playerY, playerZ, width/2, facing + math.rad(90), 0)
		LibDraw.Line(nlX, nlY, nlZ, playerX, playerY, playerZ)

		-- Near Right
		local nrX, nrY, nrZ = GetPositionFromPosition(playerX, playerY, playerZ, width/2, facing + math.rad(270), 0)
		LibDraw.Line(nrX, nrY, nrZ, playerX, playerY, playerZ)

		-- Far Left
		local flX, flY, flZ = GetPositionFromPosition(nlX, nlY, nlZ, length, facing + math.rad(0), 0)
		LibDraw.Line(flX, flY, flZ, nlX, nlY, nlZ)

		-- Far Right
		local frX, frY, frZ = GetPositionFromPosition(nrX, nrY, nrZ, length, facing + math.rad(0), 0)
		LibDraw.Line(frX, frY, frZ, nrX, nrY, nrZ)

		-- Box Complete
		LibDraw.Line(frX, frY, frZ, flX, flY, flZ)

		local enemiesTable = getEnemies("player",length)
		local enemyCounter = 0
		local maxX = math.max(nrX,nlX,frX,flX)
		local minX = math.min(nrX,nlX,frX,flX)
		local maxY = math.max(nrY,nlY,frY,flY)
		local minY = math.min(nrY,nlY,frY,flY)
		for i = 1, ObjectCount() do
			local thisUnit = GetObjectWithIndex(i)
			if ObjectIsType(thisUnit, ObjectTypes.Unit) and isDummy(thisUnit) then
				local tX, tY, tZ = GetObjectPosition(thisUnit)
				if tX < maxX and tX > minX and tY < maxY and tY > minY then
					LibDraw.Circle(tX, tY, tZ, UnitBoundingRadius(thisUnit))
					enemyCounter = enemyCounter + 1
				end
			end
		end
		return enemyCounter
	end

		local function isObjectInRectangle(tX,tY,aX,aY,bX,bY,cX,cY,dX,dY)
			local areaRectangle = 0.5 * math.abs((aY - cY) * (dX - bX) + (bY - dY) * (aX - cX))
			local abt = 0.5 * (aX * (bY - tY) + bX * (tY - aY) + tX * (aY - bY))
			local bct = 0.5 * (bX * (cY - tY) + cX * (tY - bY) + tX * (bY - cY))
			local cdt = 0.5 * (cX * (dY - tY) + dX * (tY - cY) + tX * (cY - dY))
			local dat = 0.5 * (dX * (aY - tY) + aX * (tY - dY) + tX * (dY - aY))
			return areaRectangle == (abt + bct + cdt + dat)
		end

		-- local function intersects(circle, rect)
		local function intersects(tX,tY,tR,aX,aY,cX,cY)
			-- if circle ~= nil then
				local circleDistance_x = math.abs(tX + tR - aX - (aX - cX)/2)
				local circleDistance_y = math.abs(tY + tR - aY - (aY - cY)/2)

				if (circleDistance_x > ((aX - cX)/2 + tR)) then 
					return false
				end
				if (circleDistance_y > ((aY - cY)/2 + tR)) then  
					return false
				end

				if (circleDistance_x <= ((aX - cX)/2)) then
					return true
				end

				if (circleDistance_y <= ((aY - cY)/2)) then
					return true
				end

				cornerDistance_sq = (circleDistance_x - (aX - cX)/2)^2 + (circleDistance_y - (aY - cY)/2)^2

				return (cornerDistance_sq <= (tR^2));
				-- else
				--	 return false
			-- end
		end

	-- returns true if unit have an Offensive Buff that we should dispel
	function getOffensiveBuffs(unit,guid)
		if GetObjectExists(unit) then
			local targets = br.read.enraged
			for i = 1,#targets do
				if guid == targets[i].guid then
					return targets[i].spellType
				end
			end
		end
		return false
	end
	-- returns true if Unit is a valid enemy
	function getSanity(unit)
		if  UnitIsVisible(unit) == true and getCreatureType(unit) == true
			and ((UnitCanAttack(unit, "player") == true or not UnitIsFriend(unit,"player") or isDummy(unit)) and getLineOfSight(unit, "player")) 
			and UnitIsDeadOrGhost(unit) == false
		then
			return true
		else
			return false
		end
	end
	-- This function will set the prioritisation of the units, ie which target should i attack
	function getUnitCoeficient(unit,distance,threat,burnValue,shieldValue)
		local coef = 0
		if distance == nil then distance = getDistance("player",unit) end
		-- check if unit is valid
		if GetObjectExists(unit) then
			-- if unit is out of range, bad prio(0)
			if distance < 40 then
				local unitHP = getHP(unit)
				-- if its our actual target we give it a bonus
				if UnitIsUnit("target",unit) == true then
					coef = coef + 1
				end
				-- if wise target checked, we look for best target by looking to the lowest or highest hp, otherwise we look for target
				if getOptionCheck("Wise Target") == true then
					if getOptionValue("Wise Target") == 1 then
						-- if highest is selected
						coef = unitHP
					elseif getOptionValue("Wise Target") == 3 then
						coef = UnitHealth(unit)
					else
						-- if lowest is selected
						coef = 100 - unitHP
					end
				end
				-- raid target management
				-- if the unit have the skull and we have param for it add 50
				if getOptionCheck("Skull First") and GetRaidTargetIndex(unit) == 8 then
					coef = coef + 50
				end
				-- if threat is checked, add 100 points of prio if we lost aggro on that target
				if getOptionCheck("Tank Threat") == true then
					if select(6, GetSpecializationInfo(GetSpecialization())) == "TANK" and threat < 3 and unitHP > 10 then
						coef = coef + 100
					end
				end
				-- if user checked burn target then we add the value otherwise will be 0
				coef = coef + burnValue
				-- if user checked avoid shielded, we add the % this shield remove to coef
				coef = coef + shieldValue
				-- local displayCoef = math.floor(coef*10)/10
				-- local displayName = UnitName(unit) or "invalid"
				-- -- Print("Unit "..displayName.." - "..displayCoef)
			end
		end
		return coef
	end
	-- function to see if our unit is a blacklisted unit
	function isBlackListed(Unit)
		-- check if unit is valid
		if GetObjectExists(Unit) then
			for i = 1, #castersBlackList do
				-- check if unit is valid
				if GetObjectExists(castersBlackList[i].unit) then
					if castersBlackList[i].unit == Unit then
						return true
					end
				end
			end
		end
	end
	-- returns true if target should be burnt
	function isBurnTarget(unit)
		local coef = 0
		-- check if unit is valid
		if GetObjectExists(unit) then
			if getOptionCheck("Forced Burn") then
				local unitID = GetObjectID(unit)
				local burnUnit = burnUnitCandidates[unitID]
				-- check if unit is valid
				if GetObjectExists(burnUnit) then
					-- if unit have selected debuff
					if burnUnit and burnUnit.buff and UnitBuffID(unit,burnUnit.buff) then
						coef = burnUnit.coef
					end
				end
			end
		end
		return coef
	end
	-- check for a unit see if its a cc candidate
	function isCrowdControlCandidates(Unit)
		-- check if unit is valid
		if GetObjectExists(Unit) then
			local unitID = GetObjectID(Unit)
		end
		-- cycle list of candidates
		local crowdControlUnit = crowdControlCandidates[unitID]
		if crowdControlUnit then
			-- check if unit is valid
			if GetObjectExists(crowdControlUnit.unit) then
				-- is in the list of candidates
				if (crowdControlUnit.buff == nil or UnitBuffID(Unit,crowdControlUnit.buff))
					and (crowdControlUnit.spell == nil or getCastingInfo(Unit) == GetSpellInfo(crowdControlUnit.spell))
				then -- doesnt have more requirements or requirements are met
					return true
				end
			end
		end
		return false
	end
	--if isLongTimeCCed("target") then
	-- CCs with >=20 seconds
	function isLongTimeCCed(Unit)
		if Unit == nil then return false end
		-- check if unit is valid
		if GetObjectExists(Unit) then
			for i = 1, #longTimeCC do
				--local checkCC=longTimeCC[i]
				if UnitDebuffID(Unit,longTimeCC[i]) ~= nil then
					return true
				end
			end
		end
		return false
	end
	-- returns true if we can safely attack this target
	function isSafeToAttack(unit)
		if getOptionCheck("Safe Damage Check") == true then
			-- check if unit is valid
			if GetObjectExists(unit) then
				local unitID = GetObjectID(unit)
			end
			for i = 1, #doNotTouchUnitCandidates do
				if doNotTouchUnitCandidates[i].unitID == 1 or doNotTouchUnitCandidates[i].unitID == unitID then
					if UnitBuffID(unit,doNotTouchUnitCandidates[i].buff) or UnitDebuffID(unit,doNotTouchUnitCandidates[i].buff) then
						return false
					end
				end
			end
		end
		-- if all went fine return true
		return true
	end
	-- returns true if target is shielded or should be avoided
	function isShieldedTarget(unit)
		local coef = 0
		if getOptionCheck("Avoid Shields") then
			-- check if unit is valid
			if GetObjectExists(unit) then
				local unitID = GetObjectID(unit)
				local shieldedUnit = shieldedUnitCandidates[unitID]
				-- check if unit is valid
				if GetObjectExists(shieldedUnit) then
					-- if unit have selected debuff
					if shieldedUnit and shieldedUnit.buff and UnitBuffID(unit,shieldedUnit.buff) then
						-- if it's a frontal buff, see if we are in front of it
						if shieldedUnit.frontal ~= true or getFacing(unit,"player") == true then
							coef = shieldedUnit.coef
						end
					end
				end
			end
		end
		return coef
	end
end

-- ToDo: We need to think about if the target have a dot so it will die regardless or not. Should have a timetodie.
