------------------------------------------------------------------------------
--	FILE:	 TSLEE_Script.lua
--  totalslacker 
------------------------------------------------------------------------------
include "MapUtilities"

print ("loading TSLEE_Script.lua")

local iTurn 				= Game.GetCurrentGameTurn()
local mapName 				= MapConfiguration.GetValue("MapName")
print ("Map Name = " .. tostring(mapName))
local bAddGoodies 			= MapConfiguration.GetValue("ExtraTribes")
print("Extra tribes: " .. tostring(bAddGoodies))
local iAddGoodies 	= 0
local bNoGoodies 			= GameConfiguration.GetValue("GAME_NO_GOODY_HUTS")

function GoodyHuts()
	if iAddGoodies < bAddGoodies then
		print("Adding more tribal villages to map")
		local gridWidth, gridHeight = Map.GetGridSize()
		AddGoodies(gridWidth, gridHeight)
		iAddGoodies = iAddGoodies + 1
		print("iAddGoodies = " .. tostring(iAddGoodies))
	end
end

function SpawnPlayer(iPlayer)
	if Game.GetCurrentGameTurn() > GameConfiguration.GetStartTurn() then -- Stops calling SpawnPlayer after first turn
		print(" --Removing first turn spawns script ")
		GameEvents.PlayerTurnStarted.Remove( SpawnPlayer )
		return
	end
	if iTurn <= 1 then
		if not bNoGoodies then
			print("Checking goody huts")
			GoodyHuts()
		end
	end
end

if iTurn <= 1 then
	if (mapName == "TSLEE" or mapName == "CordEarth" or mapName == "TinyEarth") then
		GameEvents.PlayerTurnStarted.Add( SpawnPlayer )
	end
end