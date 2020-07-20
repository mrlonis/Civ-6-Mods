------------------------------------------------------------------------------
--	FILE:	 Continents.lua
--	AUTHOR:  
--	PURPOSE: Base game script - Produces widely varied continents.
------------------------------------------------------------------------------
--	Copyright (c) 2014 Firaxis Games, Inc. All rights reserved.
------------------------------------------------------------------------------

include "MapEnums"
include "MapUtilities"
include "MountainsCliffs"
include "RiversLakes"
include "FeatureGenerator"
include "TerrainGenerator"
include "NaturalWonderGenerator"
include "ResourceGenerator"
include "AssignStartingPlots"

local g_iW, g_iH;
local g_iFlags = {};
local g_continentsFrac = nil;

------------------------------------------------------------------------------
-- The application side will call GetMapScriptInfo directly to request
-- information about the map script.
-------------------------------------------------------------------------------
function ApplyTerrain(plotTypes, terrainTypes)
	for i = 0, (g_iW * g_iH) - 1, 1 do
		pPlot = Map.GetPlotByIndex(i);
		if (plotTypes[i] == g_PLOT_TYPE_HILLS) then
			terrainTypes[i] = terrainTypes[i] + 1;
		end
		TerrainBuilder.SetTerrainType(pPlot, terrainTypes[i]);
	end
end

-------------------------------------------------------------------------------
function GenerateMap()
	print("Generating Continents Map");
	local pPlot;

	-- Set globals
	g_iW, g_iH = Map.GetGridSize();
	g_iFlags = TerrainBuilder.GetFractalFlags();
	local temperature = MapConfiguration.GetValue("temperature"); -- Default setting is Temperate.
	if temperature == 4 then
		temperature  =  1 + TerrainBuilder.GetRandomNumber(3, "Random Temperature- Lua");
	end
	
	plotTypes = GeneratePlotTypes();
	terrainTypes = GenerateTerrainTypes(plotTypes, g_iW, g_iH, g_iFlags, false, temperature);


	ApplyTerrain(plotTypes, terrainTypes);
	
	-- Temp
	AreaBuilder.Recalculate();
	local biggest_area = Areas.FindBiggestArea(false);
	print("After Adding Hills: ", biggest_area:GetPlotCount());

	-- River generation is affected by plot types, originating from highlands and preferring to traverse lowlands.
	AddRivers();
	
	-- Lakes would interfere with rivers, causing them to stop and not reach the ocean, if placed any sooner.
	local numLargeLakes = GameInfo.Maps[Map.GetMapSize()].Continents;
	AddLakes(numLargeLakes);

	AddFeatures();
	
	print("Adding cliffs");
	AddCliffs(plotTypes, terrainTypes);

	local args = {
		numberToPlace = GameInfo.Maps[Map.GetMapSize()].NumNaturalWonders,
	};
	local nwGen = NaturalWonderGenerator.Create(args);

	AreaBuilder.Recalculate();
	TerrainBuilder.AnalyzeChokepoints();
	TerrainBuilder.StampContinents();
	
--	for i = 0, (g_iW * g_iH) - 1, 1 do
--		pPlot = Map.GetPlotByIndex(i);
--		print ("i: plotType, terrainType, featureType: " .. tostring(i) .. ": " .. tostring(plotTypes[i]) .. ", " .. tostring(terrainTypes[i]) .. ", " .. tostring(pPlot:GetFeatureType(i)));
--	end

	
	resourcesConfig = MapConfiguration.GetValue("resources");
	local startConfig = MapConfiguration.GetValue("start");-- Get the start config
	local args = {
		resources = resourcesConfig,
		START_CONFIG = startConfig,
	};
	local resGen = ResourceGenerator.Create(args);

	print("Creating start plot database.");
	
	-- START_MIN_Y and START_MAX_Y is the percent of the map ignored for major civs' starting positions.
	local args = {
		MIN_MAJOR_CIV_FERTILITY = 150,
		MIN_MINOR_CIV_FERTILITY = 50, 
		MIN_BARBARIAN_FERTILITY = 1,
		START_MIN_Y = 15,
		START_MAX_Y = 15,
		START_CONFIG = startConfig,
	};
	local start_plot_database = AssignStartingPlots.Create(args)

	local GoodyGen = AddGoodies(g_iW, g_iH);
end

-------------------------------------------------------------------------------
function GeneratePlotTypes()
	print("Generating Plot Types");
	local plotTypes = {};

	local sea_level_low = 57;
	local sea_level_normal = 62;
	local sea_level_high = 66;
	local world_age_new = 5;
	local world_age_normal = 3;
	local world_age_old = 2;

	local extra_mountains = 0;
	local grain_amount = 3;
	local adjust_plates = 1.0;
	local shift_plot_types = true;
	local tectonic_islands = false;
	local hills_ridge_flags = g_iFlags;
	local peaks_ridge_flags = g_iFlags;
	local has_center_rift = true;
	local water_percent;

	--	local world_age
	local world_age = MapConfiguration.GetValue("world_age");
	if (world_age == 1) then
		world_age = world_age_new;
	elseif (world_age == 2) then
		world_age = world_age_normal;
	elseif (world_age == 3) then
		world_age = world_age_old;
	else
		world_age = 2 + TerrainBuilder.GetRandomNumber(4, "Random World Age - Lua");
	end

	--	local sea_level
    	local sea_level = MapConfiguration.GetValue("sea_level");
	if sea_level == 1 then -- Low Sea Level
		water_percent = sea_level_low
	elseif sea_level == 2 then -- Normal Sea Level
		water_percent =sea_level_normal
	elseif sea_level == 3 then -- High Sea Level
		water_percent = sea_level_high
	else
		water_percent = TerrainBuilder.GetRandomNumber(sea_level_high - sea_level_low, "Random Sea Level - Lua") + sea_level_low  + 1;
	end

	-- Set values for hills and mountains according to World Age chosen by user.
	local adjustment = world_age;
	if world_age <= world_age_old  then -- 5 Billion Years
		adjust_plates = adjust_plates * 0.75;
	elseif world_age >= world_age_new then -- 3 Billion Years
		adjust_plates = adjust_plates * 1.5;
	else -- 4 Billion Years
	end

	-- Generate continental fractal layer and examine the largest landmass. Reject
	-- the result until the largest landmass occupies 58% or less of the total land.
	local done = false;
	local iAttempts = 0;
	local iWaterThreshold, biggest_area, iNumTotalLandTiles, iNumBiggestAreaTiles, iBiggestID;
	while done == false do
		local grain_dice = TerrainBuilder.GetRandomNumber(7, "Continental Grain roll - LUA Continents");
		if grain_dice < 4 then
			grain_dice = 2;
		else
			grain_dice = 1;
		end
		local rift_dice = TerrainBuilder.GetRandomNumber(3, "Rift Grain roll - LUA Continents");
		if rift_dice < 1 then
			rift_dice = -1;
		end
		
		InitFractal{continent_grain = grain_dice, rift_grain = rift_dice};
		iWaterThreshold = g_continentsFrac:GetHeight(water_percent);
		local iBuffer = math.floor(g_iH/13.0);
		local iBuffer2 = math.floor(g_iH/13.0/2.0);

		iNumTotalLandTiles = 0;
		for x = 0, g_iW - 1 do
			for y = 0, g_iH - 1 do
				local i = y * g_iW + x;
				local val = g_continentsFrac:GetHeight(x, y);
				local pPlot = Map.GetPlotByIndex(i);

				if(y <= iBuffer or y >= g_iH - iBuffer - 1) then
					plotTypes[i] = g_PLOT_TYPE_OCEAN;
					TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);  -- temporary setting so can calculate areas
				else
					if(val >= iWaterThreshold) then
						if(y <= iBuffer + iBuffer2) then
							local iRandomRoll = y - iBuffer + 1;
							local iRandom = TerrainBuilder.GetRandomNumber(iRandomRoll, "Random Region Edges");
							if(iRandom == 0 and iRandomRoll > 0) then
								plotTypes[i] = g_PLOT_TYPE_LAND;
								TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_DESERT);  -- temporary setting so can calculate areas
								iNumTotalLandTiles = iNumTotalLandTiles + 1;
							else 
								plotTypes[i] = g_PLOT_TYPE_OCEAN;
								TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);  -- temporary setting so can calculate areas
							end
						elseif (y >= g_iH - iBuffer - iBuffer2 - 1) then
							local iRandomRoll = g_iH - y - iBuffer;
							local iRandom = TerrainBuilder.GetRandomNumber(iRandomRoll, "Random Region Edges");
							if(iRandom == 0 and iRandomRoll > 0) then
								plotTypes[i] = g_PLOT_TYPE_LAND;
								TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_DESERT);  -- temporary setting so can calculate areas
								iNumTotalLandTiles = iNumTotalLandTiles + 1;
							else
								plotTypes[i] = g_PLOT_TYPE_OCEAN;
								TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);  -- temporary setting so can calculate areas
							end
						else
							plotTypes[i] = g_PLOT_TYPE_LAND;
							TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_DESERT);  -- temporary setting so can calculate areas
							iNumTotalLandTiles = iNumTotalLandTiles + 1;
						end
					else
						plotTypes[i] = g_PLOT_TYPE_OCEAN;
						TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);  -- temporary setting so can calculate areas
					end
				end
			end
		end

		ShiftPlotTypes(plotTypes);
		GenerateCenterRift(plotTypes);

		AreaBuilder.Recalculate();
		local biggest_area = Areas.FindBiggestArea(false);
		iNumBiggestAreaTiles = biggest_area:GetPlotCount();
		
		-- Now test the biggest landmass to see if it is large enough.
		if iNumBiggestAreaTiles <= iNumTotalLandTiles * 0.64 then
			done = true;
			iBiggestID = biggest_area:GetID();
		end
		iAttempts = iAttempts + 1;
		
		-- Printout for debug use only
		-- print("-"); print("--- Continents landmass generation, Attempt#", iAttempts, "---");
		-- print("- This attempt successful: ", done);
		-- print("- Total Land Plots in world:", iNumTotalLandTiles);
		-- print("- Land Plots belonging to biggest landmass:", iNumBiggestAreaTiles);
		-- print("- Percentage of land belonging to biggest: ", 100 * iNumBiggestAreaTiles / iNumTotalLandTiles);
		-- print("- Continent Grain for this attempt: ", grain_dice);
		-- print("- Rift Grain for this attempt: ", rift_dice);
		-- print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
		-- print(".");
	end
	
	local args = {};
	args.world_age = world_age;
	args.iW = g_iW;
	args.iH = g_iH
	args.iFlags = g_iFlags;
	args.blendRidge = 10;
	args.blendFract = 1;
	args.extra_mountains = 5;
	mountainRatio = 8 + world_age * 3;
	plotTypes = ApplyTectonics(args, plotTypes);
	plotTypes = AddLonelyMountains(plotTypes, mountainRatio);

	return plotTypes;
end

function InitFractal(args)

	if(args == nil) then args = {}; end

	local continent_grain = args.continent_grain or 2;
	local rift_grain = args.rift_grain or -1; -- Default no rifts. Set grain to between 1 and 3 to add rifts. - Bob
	local invert_heights = args.invert_heights or false;
	local polar = args.polar or true;
	local ridge_flags = args.ridge_flags or g_iFlags;

	local fracFlags = {};
	
	if(invert_heights) then
		fracFlags.FRAC_INVERT_HEIGHTS = true;
	end
	
	if(polar) then
		fracFlags.FRAC_POLAR = true;
	end
	
	if(rift_grain > 0 and rift_grain < 4) then
		local riftsFrac = Fractal.Create(g_iW, g_iH, rift_grain, {}, 6, 5);
		g_continentsFrac = Fractal.CreateRifts(g_iW, g_iH, continent_grain, fracFlags, riftsFrac, 6, 5);
	else
		g_continentsFrac = Fractal.Create(g_iW, g_iH, continent_grain, fracFlags, 6, 5);	
	end

	-- Use Brian's tectonics method to weave ridgelines in to the continental fractal.
	-- Without fractal variation, the tectonics come out too regular.
	--
	--[[ "The principle of the RidgeBuilder code is a modified Voronoi diagram. I 
	added some minor randomness and the slope might be a little tricky. It was 
	intended as a 'whole world' modifier to the fractal class. You can modify 
	the number of plates, but that is about it." ]]-- Brian Wade - May 23, 2009
	--
	local MapSizeTypes = {};
	for row in GameInfo.Maps() do
		MapSizeTypes[row.MapSizeType] = row.PlateValue;
	end
	local sizekey = Map.GetMapSize();

	local numPlates = MapSizeTypes[sizekey] or 4

	-- Blend a bit of ridge into the fractal.
	-- This will do things like roughen the coastlines and build inland seas. - Brian

	g_continentsFrac:BuildRidges(numPlates, {}, 1, 2);
end

function AddFeatures()
	print("Adding Features");

	-- Get Rainfall setting input by user.
	local rainfall = MapConfiguration.GetValue("rainfall");
	if rainfall == 4 then
		rainfall = 1 + TerrainBuilder.GetRandomNumber(3, "Random Rainfall - Lua");
	end
	
	local args = {rainfall = rainfall}
	local featuregen = FeatureGenerator.Create(args);

	featuregen:AddFeatures();
end

function GenerateCenterRift(plotTypes)
	-- Causes a rift to break apart and separate any landmasses overlaying the map center.
	-- Rift runs south to north ala the Atlantic Ocean.
	-- Any land plots in the first or last map columns will be lost, overwritten.
	-- This rift function is hex-dependent. It would have to be adapted to work with squares tiles.
	-- Center rift not recommended for non-oceanic worlds or with continent grains higher than 2.
	-- 
	-- First determine the rift "lean". 0 = Starts west, leans east. 1 = Starts east, leans west.
	local riftLean = TerrainBuilder.GetRandomNumber(2, "FractalWorld Center Rift Lean - Lua");
	
	-- Set up tables recording the rift line and the edge plots to each side of the rift line.
	local riftLine = {};
	local westOfRift = {};
	local eastOfRift = {};
	-- Determine minimum and maximum length of line segments for each possible direction.
	local primaryMaxLength = math.max(1, math.floor(g_iH / 8));
	local secondaryMaxLength = math.max(1, math.floor(g_iH / 11));
	local tertiaryMaxLength = math.max(1, math.floor(g_iH / 14));
	
	-- Set rift line starting plot and direction.
	local startDistanceFromCenterColumn = math.floor(g_iH / 8);
	if riftLean == 0 then
		startDistanceFromCenterColumn = -(startDistanceFromCenterColumn);
	end
	local startX = math.floor(g_iW / 2) + startDistanceFromCenterColumn;
	local startY = 0;
	local startingDirection = DirectionTypes.DIRECTION_NORTHWEST;
	if riftLean == 0 then
		startingDirection = DirectionTypes.DIRECTION_NORTHEAST;
	end
	-- Set rift X boundary.
	local riftXBoundary = math.floor(g_iW / 2) - startDistanceFromCenterColumn;
	
	-- Rift line is defined by a series of line segments traveling in one of three directions.
	-- East-leaning lines move NE primarily, NW secondarily, and E tertiary.
	-- West-leaning lines move NW primarily, NE secondarily, and W tertiary.
	-- Any E or W segments cause a wider gap on that row, requiring independent storage of data regarding west or east of rift.
	--
	-- Key variables need to be defined here so they persist outside of the various loops that follow.
	-- This requires that the starting plot be processed outside of those loops.
	local currentDirection = startingDirection;
	local currentX = startX;
	local currentY = startY;
	table.insert(riftLine, {currentX, currentY});
	-- Record west and east of the rift for this row.
	local rowIndex = currentY + 1;
	westOfRift[rowIndex] = currentX - 1;
	eastOfRift[rowIndex] = currentX + 1;
	-- Set this rift plot as type Ocean.
	local plotIndex = currentX + 1; -- Lua arrays starting at 1 sure makes for a lot of extra work and chances for bugs.
	plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN; -- Tiles crossed by the rift all turn in to water.
	
	-- Generate the rift line.
	if riftLean == 0 then -- Leans east
		while currentY < g_iH - 1 do
			-- Generate a line segment
			local nextDirection = 0;

			if currentDirection == DirectionTypes.DIRECTION_EAST then
				local segmentLength = TerrainBuilder.GetRandomNumber(tertiaryMaxLength + 1, "FractalWorld Center Rift Segment Length - Lua");
				-- Choose next direction
				if currentX >= riftXBoundary then -- Gone as far east as allowed, must turn back west.
					nextDirection = DirectionTypes.DIRECTION_NORTHWEST;
				else
					local dice = TerrainBuilder.GetRandomNumber(3, "FractalWorld Center Rift Direction - Lua");
					if dice == 1 then
						nextDirection = DirectionTypes.DIRECTION_NORTHWEST;
					else
						nextDirection = DirectionTypes.DIRECTION_NORTHEAST;
					end
				end
				-- Process the line segment
				local plotsToDo = segmentLength;
				while plotsToDo > 0 do
					currentX = currentX + 1; -- Moving east, no change to Y.
					rowIndex = currentY;
					-- westOfRift[rowIndex] does not change.
					eastOfRift[rowIndex] = currentX + 1;
					plotIndex = currentY * g_iW + currentX + 1;
					plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
					plotsToDo = plotsToDo - 1;
				end

			elseif currentDirection == DirectionTypes.DIRECTION_NORTHWEST then
				local segmentLength = TerrainBuilder.GetRandomNumber(secondaryMaxLength + 1, "FractalWorld Center Rift Segment Length - Lua");
				-- Choose next direction
				if currentX >= riftXBoundary then -- Gone as far east as allowed, must turn back west.
					nextDirection = DirectionTypes.DIRECTION_NORTHWEST;
				else
					local dice = TerrainBuilder.GetRandomNumber(4, "FractalWorld Center Rift Direction - Lua");
					if dice == 2 then
						nextDirection = DirectionTypes.DIRECTION_EAST;
					else
						nextDirection = DirectionTypes.DIRECTION_NORTHEAST;
					end
				end
				-- Process the line segment
				local plotsToDo = segmentLength;
				while plotsToDo > 0 and currentY < g_iH - 1 do
					local nextPlot = Map.GetAdjacentPlot(currentX, currentY, currentDirection);
					currentX = nextPlot:GetX();
					currentY = currentY + 1;
					rowIndex = currentY;
					westOfRift[rowIndex] = currentX - 1;
					eastOfRift[rowIndex] = currentX + 1;
					plotIndex = currentY * g_iW + currentX + 1;
					plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
					plotsToDo = plotsToDo - 1;
				end
				
			else -- NORTHEAST
				local segmentLength = TerrainBuilder.GetRandomNumber(primaryMaxLength + 1, "FractalWorld Center Rift Segment Length - Lua");
				-- Choose next direction
				if currentX >= riftXBoundary then -- Gone as far east as allowed, must turn back west.
					nextDirection = DirectionTypes.DIRECTION_NORTHWEST;
				else
					local dice = TerrainBuilder.GetRandomNumber(2, "FractalWorld Center Rift Direction - Lua");
					if dice == 1 and currentY > g_iH * 0.28 then
						nextDirection = DirectionTypes.DIRECTION_EAST;
					else
						nextDirection = DirectionTypes.DIRECTION_NORTHWEST;
					end
				end
				-- Process the line segment
				local plotsToDo = segmentLength;
				while plotsToDo > 0 and currentY < g_iH - 1 do
					local nextPlot = Map.GetAdjacentPlot(currentX, currentY, currentDirection);
					currentX = nextPlot:GetX();
					currentY = currentY + 1;
					rowIndex = currentY;
					westOfRift[rowIndex] = currentX - 1;
					eastOfRift[rowIndex] = currentX + 1;
					plotIndex = currentY * g_iW + currentX + 1;
					plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
					plotsToDo = plotsToDo - 1;
				end
			end
			
			-- Line segment is done, set next direction.
			currentDirection = nextDirection;
		end

	else -- Leans west
		while currentY < g_iH - 1 do
			-- Generate a line segment
			local nextDirection = 0;

			if currentDirection == DirectionTypes.DIRECTION_WEST then
				local segmentLength = TerrainBuilder.GetRandomNumber(tertiaryMaxLength + 1, "FractalWorld Center Rift Segment Length - Lua");
				-- Choose next direction
				if currentX <= riftXBoundary then -- Gone as far west as allowed, must turn back east.
					nextDirection = DirectionTypes.DIRECTION_NORTHEAST;
				else
					local dice = TerrainBuilder.GetRandomNumber(3, "FractalWorld Center Rift Direction - Lua");
					if dice == 1 then
						nextDirection = DirectionTypes.DIRECTION_NORTHEAST;
					else
						nextDirection = DirectionTypes.DIRECTION_NORTHWEST;
					end
				end
				-- Process the line segment
				local plotsToDo = segmentLength;
				while plotsToDo > 0 do
					currentX = currentX - 1; -- Moving west, no change to Y.
					rowIndex = currentY;
					westOfRift[rowIndex] = currentX - 1;
					-- eastOfRift[rowIndex] does not change.
					plotIndex = currentY * g_iW + currentX + 1;
					plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
					plotsToDo = plotsToDo - 1;
				end

			elseif currentDirection == DirectionTypes.DIRECTION_NORTHEAST then
				local segmentLength = TerrainBuilder.GetRandomNumber(secondaryMaxLength + 1, "FractalWorld Center Rift Segment Length - Lua");
				-- Choose next direction
				if currentX <= riftXBoundary then -- Gone as far west as allowed, must turn back east.
					nextDirection = DirectionTypes.DIRECTION_NORTHEAST;
				else
					local dice = TerrainBuilder.GetRandomNumber(4, "FractalWorld Center Rift Direction - Lua");
					if dice == 2 then
						nextDirection = DirectionTypes.DIRECTION_WEST;
					else
						nextDirection = DirectionTypes.DIRECTION_NORTHWEST;
					end
				end
				-- Process the line segment
				local plotsToDo = segmentLength;
				while plotsToDo > 0 and currentY < g_iH - 1 do
					local nextPlot = Map.GetAdjacentPlot(currentX, currentY, currentDirection);
					currentX = nextPlot:GetX();
					currentY = currentY + 1;
					rowIndex = currentY;
					westOfRift[rowIndex] = currentX - 1;
					eastOfRift[rowIndex] = currentX + 1;
					plotIndex = currentY * g_iW + currentX + 1;
					plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
					plotsToDo = plotsToDo - 1;
				end
				
			else -- NORTHWEST
				local segmentLength = TerrainBuilder.GetRandomNumber(primaryMaxLength + 1, "FractalWorld Center Rift Segment Length - Lua");
				-- Choose next direction
				if currentX <= riftXBoundary then -- Gone as far west as allowed, must turn back east.
					nextDirection = DirectionTypes.DIRECTION_NORTHEAST;
				else
					local dice = TerrainBuilder.GetRandomNumber(2, "FractalWorld Center Rift Direction - Lua");
					if dice == 1 and currentY > g_iH * 0.28 then
						nextDirection = DirectionTypes.DIRECTION_WEST;
					else
						nextDirection = DirectionTypes.DIRECTION_NORTHEAST;
					end
				end
				-- Process the line segment
				local plotsToDo = segmentLength;
				while plotsToDo > 0 and currentY < g_iH - 1 do
					local nextPlot = Map.GetAdjacentPlot(currentX, currentY, currentDirection);
					currentX = nextPlot:GetX();
					currentY = currentY + 1;
					rowIndex = currentY;
					westOfRift[rowIndex] = currentX - 1;
					eastOfRift[rowIndex] = currentX + 1;
					plotIndex = currentY * g_iW + currentX + 1;
					plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
					plotsToDo = plotsToDo - 1;
				end
			end
			
			-- Line segment is done, set next direction.
			currentDirection = nextDirection;
		end
	end
	-- Process the final plot in the rift.
	westOfRift[g_iH] = currentX - 1;
	eastOfRift[g_iH] = currentX + 1;
	plotIndex = (g_iH - 1) * g_iW + currentX + 1;
	plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;

	-- Now force the rift to widen, causing land on either side of the rift to drift apart.
	local horizontalDrift = 3;
	local verticalDrift = 2;
	--
	if riftLean == 0 then
		-- Process Western side from top down.
		for y = g_iH - 1 - verticalDrift, 0, -1 do
			local thisRowX = westOfRift[y+1];
			for x = horizontalDrift, thisRowX do
				local sourcePlotIndex = y * g_iW + x + 1;
				local destPlotIndex = (y + verticalDrift) * g_iW + (x - horizontalDrift) + 1;
				plotTypes[destPlotIndex] = plotTypes[sourcePlotIndex]
			end
		end
		-- Process Eastern side from bottom up.
		for y = verticalDrift, g_iH - 1 do
			local thisRowX = eastOfRift[y+1];
			for x = thisRowX, g_iW - horizontalDrift - 1 do
				local sourcePlotIndex = y * g_iW + x + 1;
				local destPlotIndex = (y - verticalDrift) * g_iW + (x + horizontalDrift) + 1;
				plotTypes[destPlotIndex] = plotTypes[sourcePlotIndex]
			end
		end
		-- Clean up remainder of tiles (by turning them all to Ocean).
		-- Clean up bottom left.
		for y = 0, verticalDrift - 1 do
			local thisRowX = westOfRift[y+1];
			for x = 0, thisRowX do
				local plotIndex = y * g_iW + x + 1;
				plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
			end
		end
		-- Clean up top right.
		for y = g_iH - verticalDrift, g_iH - 1 do
			local thisRowX = eastOfRift[y+1];
			for x = thisRowX, g_iW - 1 do
				local plotIndex = y * g_iW + x + 1;
				plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
			end
		end
		-- Clean up the rift.
		for y = verticalDrift, g_iH - 1 - verticalDrift do
			local westX = westOfRift[y-verticalDrift+1] - horizontalDrift + 1;
			local eastX = eastOfRift[y+verticalDrift+1] + horizontalDrift - 1;
			for x = westX, eastX do
				local plotIndex = y * g_iW + x + 1;
				plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
			end
		end

	else -- riftLean = 1
		-- Process Western side from bottom up.
		for y = verticalDrift, g_iH - 1 do
			local thisRowX = westOfRift[y+1];
			for x = horizontalDrift, thisRowX do
				local sourcePlotIndex = y * g_iW + x + 1;
				local destPlotIndex = (y - verticalDrift) * g_iW + (x - horizontalDrift) + 1;
				plotTypes[destPlotIndex] = plotTypes[sourcePlotIndex]
			end
		end
		-- Process Eastern side from top down.
		for y = g_iH - 1 - verticalDrift, 0, -1 do
			local thisRowX = eastOfRift[y+1];
			for x = thisRowX, g_iW - horizontalDrift - 1 do
				local sourcePlotIndex = y * g_iW + x + 1;
				local destPlotIndex = (y + verticalDrift) * g_iW + (x + horizontalDrift) + 1;
				plotTypes[destPlotIndex] = plotTypes[sourcePlotIndex]
			end
		end
		-- Clean up remainder of tiles (by turning them all to Ocean).
		-- Clean up top left.
		for y = g_iH - verticalDrift, g_iH - 1 do
			local thisRowX = westOfRift[y+1];
			for x = 0, thisRowX do
				local plotIndex = y * g_iW + x + 1;
				plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
			end
		end
		-- Clean up bottom right.
		for y = 0, verticalDrift - 1 do
			local thisRowX = eastOfRift[y+1];
			for x = thisRowX, g_iW - 1 do
				local plotIndex = y * g_iW + x + 1;
				plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
			end
		end
		-- Clean up the rift.
		for y = verticalDrift, g_iH - 1 - verticalDrift do
			local westX = westOfRift[y+verticalDrift+1] - horizontalDrift + 1;
			local eastX = eastOfRift[y-verticalDrift+1] + horizontalDrift - 1;
			for x = westX, eastX do
				local plotIndex = y * g_iW + x + 1;
				plotTypes[plotIndex] = g_PLOT_TYPE_OCEAN;
			end
		end
	end


end