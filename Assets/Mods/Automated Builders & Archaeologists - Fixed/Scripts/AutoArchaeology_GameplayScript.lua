-- AutoArchaeology_GameplayScript
-- Author: MadManCam
-- DateCreated: 5/13/2018 4:39:33 PM
--------------------------------------------------------------

-- This is a gameplay script to save the automated Archaeologists table in. This way the data is saved even when the UI is refreshed.
-- This means the mod can support hot seat mode.

local b_HasMembers = false;

 -- Table of builders.
local m_Archaeologist_GP = {};

-- Table of plots.
local m_Archaeologist_Plots_GP = {};

-- Set Automated Archaeologist table data in this gameplay script
local function SetArchaeologists( new_m_Archaeologists )
	print( "AutoArchaeologist Gameplay Script: Saved Automated Archaeologists table in gameplay context." );
	m_Archaeologists_GP = new_m_Archaeologists;
	b_HasMembers = true;
end

-- Set Archaeologist target plot data in this gameplay script
local function SetArchaeologistPlots( new_m_Archaeologist_Plots )
	m_Archaeologist_Plots_GP = new_m_Archaeologist_Plots;
end

-- Get Archaeologist table data
local function GetArchaeologists()
	b_HasMembers = false; -- Reset has members to true, indicating we have already retrieved the most up to date table.
	return m_Archaeologists_GP;
end

-- Get Archaeologist Plots table data
local function GetArchaeologistPlots()
	return m_Archaeologist_Plots_GP;
end

-- Returns true if there are members saved in table.
local function HasMembers()
	return b_HasMembers;
end

ExposedMembers.CNO_AutoArchaeologist_GP_Initialized = false;

function Initialize()

	if ( not ExposedMembers.CNO_AutoArchaeologist_GP ) then ExposedMembers.CNO_AutoArchaeologist_GP = {}; end
	ExposedMembers.CNO_AutoArchaeologist_GP.HasMembers = HasMembers;
	ExposedMembers.CNO_AutoArchaeologist_GP.GetArchaeologists = GetArchaeologists;
	ExposedMembers.CNO_AutoArchaeologist_GP.GetArchaeologistPlots = GetArchaeologistPlots;
	ExposedMembers.CNO_AutoArchaeologist_GP.SetArchaeologists = SetArchaeologists;
	ExposedMembers.CNO_AutoArchaeologist_GP.SetArchaeologistPlots = SetArchaeologistPlots;
	ExposedMembers.CNO_AutoArchaeologist_GP_Initialized = true;

end

Initialize(); 