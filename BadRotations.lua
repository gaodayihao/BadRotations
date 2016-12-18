-- define br global that will hold the bot global background features
br = {}
brdata = {}
br.selectedSpec = "None"
br.selectedProfile = 1
br.dropOptions = {}
br.dropOptions.Toggle = {"LeftCtrl","LeftShift","RightCtrl","RightShift","RightAlt","None"}
br.dropOptions.Toggle2 ={"LeftCtrl","LeftShift","LeftAlt","RightCtrl","RightShift","RightAlt","MMouse","Mouse4","Mouse5","None" }
br.dropOptions.CD = {"Never","CDs","Always" }
br.loadedIn = false
br.rotations = {}

SetCVar("targetnearestuseold", 1)
SetCVar("nameplateMaxDistance", 40)
SetCVar("nameplateOtherTopInset", -1)
SetCVar("nameplateOtherBottomInset", -1)
SetCVar("alwaysCompareItems", "1")

-- developers debug, use /run br.data.settings[br.selectedSpec].toggles["isDebugging"] = true
br.debug = {}
function br.debug:Print(message)
	if br.data.settings[br.selectedSpec].toggles["isDebugging"] == true then
		Print(message)
	end
end
function br:Run()
	if br.selectedSpec == nil then br.selectedSpec = select(2,GetSpecializationInfo(GetSpecialization())) end
	rc = LibStub("LibRangeCheck-2.0")
	minRange, maxRange = rc:GetRange('target')
	-- lets wipe and start up fresh.
	br.data = brdata
	if br.data == nil or brdata == nil or (br.data and br.data.settings and br.data.settings.wiped ~= true) then
		br.data = {}
	end
	--[[Init the readers codes (System/Reader.lua)]]
	-- combat log
	br.read.combatLog()
	-- other readers
	br.read.commonReaders()
	-- Globals
	classColors = {
		[1]				= {class = "Warrior", 		B=0.43,	G=0.61,	R=0.78,	hex="|cffc79c6e"},
		[2]				= {class = "Paladin", 		B=0.73,	G=0.55,	R=0.96,	hex="|cfff58cba"},
		[3]				= {class = "Hunter",		B=0.45,	G=0.83,	R=0.67,	hex="|cffabd473"},
		[4]				= {class = "Rogue",			B=0.41,	G=0.96,	R=1,	hex="|cfffff569"},
		[5]				= {class = "Priest",		B=1,	G=1,	R=1,	hex="|cffffffff"},
		[6]				= {class = "Deathknight",	B=0.23,	G=0.12,	R=0.77,	hex="|cffc41f3b"},
		[7]				= {class = "Shaman",		B=0.87,	G=0.44,	R=0,	hex="|cff0070de"},
		[8]				= {class = "Mage",			B=0.94,	G=0.8,	R=0.41,	hex="|cff69ccf0"},
		[9]				= {class = "Warlock", 		B=0.79,	G=0.51,	R=0.58,	hex="|cff9482c9"},
		[10]			= {class = "Monk",			B=0.59,	G=1,	R=0,	hex="|cff00ff96"},
		[11]			= {class = "Druid", 		B=0.04,	G=0.49,	R=1,	hex="|cffff7d0a"},
		[12] 			= {class = "Demonhunter", 	B=0.79, G=0.19, R=0.64, hex="|cffa330c9"},
		-- ["Training Dummy"] = {B=0.76,  G=0.76,  	R=0.76, hex="|cffC0C0C0"},
		-- ["Black"]		= {B=0.1, 	G=0.1,	R=0.12,	hex="|cff191919"},
		-- ["Hunter"]		= {B=0.45,	G=0.83,	R=0.67,	hex="|cffabd473"},
		-- ["Gray"]		= {B=0.2,	G=0.2,	R=0.2,	hex="|cff333333"},
		-- ["Warrior"]		= {B=0.43,	G=0.61,	R=0.78,	hex="|cffc79c6e"},
		-- ["Paladin"] 	= {B=0.73,	G=0.55,	R=0.96,	hex="|cfff58cba"},
		-- ["Mage"]		= {B=0.94,	G=0.8,	R=0.41,	hex="|cff69ccf0"},
		-- ["Priest"]		= {B=1,		G=1,	R=1,	hex="|cffffffff"},
		-- ["Warlock"]		= {B=0.79,	G=0.51,	R=0.58,	hex="|cff9482c9"},
		-- ["Shaman"]		= {B=0.87,	G=0.44,	R=0,	hex="|cff0070de"},
		-- ["DeathKnight"]	= {B=0.23,	G=0.12,	R=0.77,	hex="|cffc41f3b"},
		-- ["Druid"]		= {B=0.04,	G=0.49,	R=1,	hex="|cffff7d0a"},
		-- ["Monk"]		= {B=0.59,	G=1,	R=0,	hex="|cff00ff96"},
		-- ["Rogue"]		= {B=0.41,	G=0.96,	R=1,	hex="|cfffff569"}
	}
	qualityColors = {
		blue = "0070dd",
		green = "1eff00",
		white = "ffffff",
		grey = "9d9d9d"
	}
	-- load common used stuff on first load
	if br.data.settings == nil then
		br.data.settings = {
			mainButton = {
				pos = {
					anchor = "CENTER",
					x = -75,
					y = -200
				}
			},
			buttonSize = 32,
			font = "Fonts/arialn.ttf",
			fontsize = 16,
			wiped = true,
		}
		br.data.settings[br.selectedSpec] = {
			toggles = {},
		}
	end
	-- settings table that will hold specs subtable
	if br.data.settings == nil then
		br.data.settings = {}
		br.data.settings[br.selectedSpec] = {}
    end
    if br.data.settings[br.selectedSpec] == nil then
        br.data.settings[br.selectedSpec] = {}
    end
    if br.data.settings[br.selectedSpec]["Rotation".."Drop"] == nil then
        br.selectedProfile = 1
    else
        br.selectedProfile = br.data.settings[br.selectedSpec]["Rotation".."Drop"]
    end
    if br.data.settings[br.selectedSpec][br.selectedProfile]  == nil then
        br.data.settings[br.selectedSpec][br.selectedProfile] = {}
    end	
	-- Build up pulse frame (hearth)
	br:Engine()
	-- add minimap fire icon
	br:MinimapButton()
	-- build up UI
	br:StartUI()

    if br.data.settings[br.selectedSpec] == nil then br.data.settings[br.selectedSpec] = {} end
    if br.data.settings[br.selectedSpec][br.selectedProfile] == nil then br.data.settings[br.selectedSpec][br.selectedProfile] = {} end

    -- Creates and Shows the Bot Options Window and Rotation Log Window
    br.ui:createConfigWindow()
    br.ui:createDebugWindow()

	-- start up enemies Engine
	enemiesEngineRange = 55
	EnemiesEngine()
	ChatOverlay("-= BadRotations Loaded =-")
	Print("Loaded")
	br.loadedIn = true
end
--[[Startup UI]]
function br:StartUI()
	TogglesFrame()
end

br.pulse = {}
br.pulse.makeTable = true
br.pulse.gathering = true
-- debug
function br.pulse:getDist()
    targetDistance = getDistance("target") or 0
end
function br.pulse:dispDist()
    displayDistance = math.ceil(targetDistance)
end
function br.pulse:makeEnTable()
    if br.pulse.makeTable then
        makeEnemiesTable(40)
    end
end
function br.pulse:ttd()
    TTDRefresh()
end
function br.pulse:queue()
	-- Queue Casting
	if isChecked("Queue Casting") and not UnitChannelInfo("player") then
		-- Catch for spells not registering on Combat log
		if br.player ~= nil then
			if br.player.queue ~= nil then
				if #br.player.queue > 0 and br.player.queue[1].id ~= lastSpellCast then
				    castQueue();
				    return
				end
			end
		end
	end
end
--[[Updating UI]]
function br:PulseUI()
	-- distance on main icon
    br.pulse:getDist()
    br.pulse:dispDist()

	mainText:SetText(displayDistance)
	-- enemies
    br.pulse:makeEnTable()
	-- ttd
    br.pulse:ttd()
    -- queue
    br.pulse:queue()
	-- allies
    if isChecked("HE Active") then
	    br.friend:Update()
    end
	-- Pulse other features
	-- PokeEngine()
	-- ProfessionHelper()
	-- SalvageHelper()	
end

