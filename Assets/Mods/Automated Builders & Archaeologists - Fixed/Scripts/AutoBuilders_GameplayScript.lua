-- AutoBuilders_GameplayScript
-- Author: MadManCam
-- DateCreated: 5/6/2018 6:26:36 PM
--------------------------------------------------------------

-- This is a gameplay script to save the automated Builders table in. This way the data is saved even when the UI is refreshed.
-- This means the mod can support hot seat mode.

local b_HasMembers = false;

 -- Table of builders.
local m_Builders_GP = {};

-- Table of plots.
local m_Builder_Plots_GP = {};

-- Set Automated Builder table data in this gameplay script
local function SetBuilders( new_m_Builders )
	print( "AutoBuilder Gameplay Script: Saved Automated Builders table in gameplay context." );
	m_Builders_GP = new_m_Builders;
	b_HasMembers = true;
end

-- Set Builder target plot data in this gameplay script
local function SetBuilderPlots( new_m_Builder_Plots )
	m_Builder_Plots_GP = new_m_Builder_Plots;
end

-- Get Builder table data
local function GetBuilders()
	b_HasMembers = false; -- Reset has members to true, indicating we have already retrieved the most up to date table.
	return m_Builders_GP;
end

-- Get Builder Plots table data
local function GetBuilderPlots()
	return m_Builder_Plots_GP;
end

-- Returns true if there are members saved in table.
local function HasMembers()
	return b_HasMembers;
end

ExposedMembers.CNO_AutoBuilder_GP_Initialized = false;

function Initialize()

	if ( not ExposedMembers.CNO_AutoBuilder_GP ) then ExposedMembers.CNO_AutoBuilder_GP = {}; end
	ExposedMembers.CNO_AutoBuilder_GP.HasMembers = HasMembers;
	ExposedMembers.CNO_AutoBuilder_GP.GetBuilders = GetBuilders;
	ExposedMembers.CNO_AutoBuilder_GP.GetBuilderPlots = GetBuilderPlots;
	ExposedMembers.CNO_AutoBuilder_GP.SetBuilders = SetBuilders;
	ExposedMembers.CNO_AutoBuilder_GP.SetBuilderPlots = SetBuilderPlots;
	ExposedMembers.CNO_AutoBuilder_GP_Initialized = true;

end

Initialize(); 