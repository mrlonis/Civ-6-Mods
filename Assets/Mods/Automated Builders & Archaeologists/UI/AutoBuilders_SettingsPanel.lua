-- AutoBuilders_SettingsPanel
-- Author: MadManCam
-- DateCreated: 5/27/2018 5:14:33 AM
--------------------------------------------------------------

include( "InstanceManager" );

-- VARIABLES
-- Members
local AutoBuilders 					= {};
local AutoBuilders_Added 			:boolean = false;
local m_isShown						:boolean = false;
local useCaps						:boolean = true;

local m_kPrioritiesIM_MaxUniques_PerCity	= InstanceManager:new( "PriorityInstance_MaxUniques_PerCity",	"Top",	Controls.PrioritiesStack_MaxUniques 		);
local m_kPrioritiesIM_MaxUniques_Ever		= InstanceManager:new( "PriorityInstance_MaxUniques_Ever",		"Top",	Controls.PrioritiesStack_MaxUniques 		);
local m_kPrioritiesIM_Distance				= InstanceManager:new( "PriorityInstance_Distance",				"Top",	Controls.PrioritiesStack_Distance 			);
local m_kPrioritiesIM_Scoring				= InstanceManager:new( "PriorityInstance", 						"Top",	Controls.PrioritiesStack_Scoring 			);
local m_kPrioritiesIM_Priorities			= InstanceManager:new( "PriorityInstance",						"Top",	Controls.PlotPrioritiesStack 				);
local m_kPrioritiesIM_ImprovementScoring	= InstanceManager:new( "PriorityInstance",						"Top",	Controls.PrioritiesStack_ImprovementScoring );

-- Objects (Static)
-- Table of settings (static object)
local m_Settings = {
	members = {};
	count = 0;		
};
function m_Settings:flush()
	self.members = {};
	self.count = 0;
end

-- Objects (Classes)
-- Setting
local SettingClass = {
	name = "none"; -- The variable name of the setting
	control = {}; -- General control object, for now only used for checkboxes.
	slider = {}; -- Slider control object
	ui_text = {}; -- UI Text control (used if it is separate from the main control).
	converter = {}; -- Converter object
	value = false; -- The value of the setting
	ID = 0; -- The setting ID number
	type = 0; -- Type: 0=Value, 1=Boolean, 2=Float
	priority = false; -- Priority type setting.
};

-- Converters
-- =========================================================================================================================================
local MAX_Uniques_PerCity_Converter = {
	N_STEPS = 10,
	ToSteps = function( input )
		local value = input;
		if value < 0 then value = 0; end
		if value > 10 then value = 10; end
		return math.floor( value );
	end,
	ToValue = function( step )
		return step;
	end,
	ToString = function( input )
		return tostring( input );
	end,
	FromSetting = function( input )
		local value = input;
		if value < 0 then value = 0; end
		if value > 10 then value = 10; end
		return value;
	end,
	ToSetting = function( input )
		local value = input;
		if value < 0 then value = 0; end
		if value > 10 then value = 10; end
		return math.floor( value );
	end
};
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
local MAX_Uniques_Ever_Converter = {
	N_STEPS = 40,
	ToSteps = function( input )
		local value = input / 5.0; -- Scale to 0-40
		return math.floor( value );
	end,
	ToValue = function( step )
		return math.floor( step * 5.0 ); -- Scale to 0-200
	end,
	ToString = function( input )
		return tostring( input );
	end,
	FromSetting = function( input )
		local value = input;
		if value < 0 then value = 0; end
		if value > 200 then value = 200; end
		return value;
	end,
	ToSetting = function( input )
		local value = input;
		if value < 0 then value = 0; end
		if value > 200 then value = 200; end
		return math.floor( value );
	end
 };
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
local PriorityConverter = {
	N_STEPS = 100,
	ToSteps = function( input )
		local value = (input + 100) / 5.0; -- Shift to 0-500 and scale down.
		return math.floor( value );
	end,
	ToValue = function( step )
		local value = (step * 5.0) - 100; -- Scale back up and shift down to -100 to 400 scale. 
		return value;
	end,
	ToString = function( input )
		if input < -99 then return "Disabled";
		else return tostring( input ); end
	end,
	FromSetting = function( input )
		local value = input;
		if value < -99 then value = -100; end
		if value > 400 then value = 400; end
		return math.floor( value );
	end,
	ToSetting = function( input )
		local value = input;
		if value < -99 then value = -100; end
		if value > 400 then value = 400; end
		return math.floor( value );
	end
 };
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
local PriorityDistanceConverter = {
	N_STEPS = 20,
	ToSteps = function( input )
		local value = -1 * input; -- Switch to positive step value.
		if value < 0 then value = 0; end
		if value > 20 then value = 20; end
		return math.floor( value );
	end,
	ToValue = function( step )
		return -1 * step; -- Return negative score from positive slider step value.
	end,
	ToString = function( input )
		return tostring( input );
	end,
	FromSetting = function( input )
		local value = input;
		if value > 0 then value = 0; end
		if value < -20 then value = -20; end
		return math.floor( value );
	end,
	ToSetting = function( input )
		local value = input;
		if value > 0 then value = 0; end
		if value < -20 then value = -20; end
		return math.floor( value );
	end
 };
--------------------------------------------------------------------------------------------------------------------------------------------


-- CONSTANTS
local pref = "AutoBuilders_";
-- Menu tabs
local m_tabs = {
	-- Tab							Tab button						Reset button to use	
	{ Controls.GeneralTab,			Controls.GeneralOptions,		Controls.ResetButton			},
	{ Controls.PrioritiesTab,		Controls.PrioritiesOptions,		Controls.ResetPrioritiesButton	},
	{ Controls.PlotPrioritiesTab,	Controls.PlotPrioritiesOptions,	Controls.ResetPrioritiesButton	},
	{ Controls.AdvancedTab,			Controls.AdvancedOptions,		Controls.ResetButton			},
	{ Controls.HiddenTab,			Controls.HiddenOptions,			"none"							}
};
-- Tables pointing to and associating all setting/binding names, controls, sliders, text boxes, and converters. 
local AutoBuilders_Settings_Constants = {
	-- Setting name,										Type	Control														Slider	Text	Converter
	-- General Options
	{ "RemoveFeatures",							1,		Controls.RemoveFeatures_Checkbox,							{},		{},		{} },
	{ "HarvestResources",						1,		Controls.HarvestResources_Checkbox,							{},		{},		{} },
	{ "FarmsIn4Tiles",							1,		Controls.FarmsIn4Tiles_Checkbox,							{},		{},		{} },
	{ "ArchaeologistsExplore",					1,		Controls.ArchaeologistsExplore_Checkbox,					{},		{},		{} },
	{ "ArchaeologistsExcavateInOtherBorders",	1,		Controls.ArchaeologistsExcavateInOtherBorders_Checkbox,		{},		{},		{} },

	{ "MAX_Uniques_PerCity",		2,	{},	Controls.MAX_Uniques_PerCity_Slider,	Controls.MAX_Uniques_PerCity_Text,	MAX_Uniques_PerCity_Converter	},
	{ "MAX_Uniques_Ever",			2,	{},	Controls.MAX_Uniques_Ever_Slider,		Controls.MAX_Uniques_Ever_Text,		MAX_Uniques_Ever_Converter		};
};

local AutoBuilders_Priorities_Constants = {};

m_kPrioritiesIM_MaxUniques_PerCity:ResetInstances();
m_kPrioritiesIM_MaxUniques_Ever:ResetInstances();
m_kPrioritiesIM_Distance:ResetInstances();
m_kPrioritiesIM_Scoring:ResetInstances();
m_kPrioritiesIM_Priorities:ResetInstances();
m_kPrioritiesIM_ImprovementScoring:ResetInstances();

for row in GameInfo.CNO_AutoBuilders_PrioritySettings() do
	if row.mTable == "MaxUniques_PerCity" then
		local kInstance :table = m_kPrioritiesIM_MaxUniques_PerCity:GetInstance();
		kInstance.PriorityName:SetText( Locale.Lookup( "LOC_" .. row.Setting .. "_NAME" ) .. " " .. Locale.Lookup( "LOC_CNO_AUTOBUILDER_SETTINGS_PRIORITIES_MAX_UNIQUES_PER_CITY" ) .. ": " );
		kInstance.PrioritySlider:SetToolTipString( Locale.Lookup( "LOC_CNO_AUTOBUILDER_SETTINGS_PRIORITIES_MAX_UNIQUES_TOOLTIP" ) );
		table.insert( AutoBuilders_Priorities_Constants, 
			{ ( row.mTable .. "_" .. row.Setting ), kInstance.PrioritySlider,	kInstance.PriorityText,	MAX_Uniques_PerCity_Converter }
		);		
	elseif row.mTable == "MaxUniques_Ever" then
		local kInstance :table = m_kPrioritiesIM_MaxUniques_Ever:GetInstance();
		kInstance.PriorityName:SetText( Locale.Lookup( "LOC_" .. row.Setting .. "_NAME" ) .. " " .. Locale.Lookup( "LOC_CNO_AUTOBUILDER_SETTINGS_PRIORITIES_MAX_UNIQUES_EVER" ) .. ": " );
		kInstance.PrioritySlider:SetToolTipString( Locale.Lookup( "LOC_CNO_AUTOBUILDER_SETTINGS_PRIORITIES_MAX_UNIQUES_TOOLTIP" ) );
		table.insert( AutoBuilders_Priorities_Constants, 
			{ ( row.mTable .. "_" .. row.Setting ), kInstance.PrioritySlider,	kInstance.PriorityText,	MAX_Uniques_Ever_Converter }
		);
	elseif row.mTable == "Scoring" then
		if row.Setting == "BUILDER_DISTANCE" then
			local kInstance :table = m_kPrioritiesIM_Distance:GetInstance();
			kInstance.PriorityName:SetText( "Builder Distance: " );
			kInstance.PrioritySlider:SetToolTipString( Locale.Lookup( "LOC_CNO_AUTOBUILDER_SETTINGS_PRIORITIES_DISTANCE_TOOLTIP" ) );
			table.insert( AutoBuilders_Priorities_Constants, 
				{ ( row.mTable .. "_" .. row.Setting ), kInstance.PrioritySlider,	kInstance.PriorityText,	PriorityDistanceConverter }
			);
		else
			local kInstance :table = m_kPrioritiesIM_Scoring:GetInstance();
			if Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_" .. row.Setting .. "_NAME" ) == "LOC_CNO_AUTOBUILDERS_STATUS_" .. row.Setting .. "_NAME" then
				kInstance.PriorityName:SetText( row.Setting .. "(Unknown action): " );
			else
				kInstance.PriorityName:SetText( Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_" .. row.Setting .. "_NAME" ) .. " " );
			end
			kInstance.PrioritySlider:SetToolTipString( Locale.Lookup( "LOC_CNO_AUTOBUILDER_SETTINGS_PRIORITIES_SCORING_TOOLTIP" ) );
			table.insert( AutoBuilders_Priorities_Constants, 
				{ ( row.mTable .. "_" .. row.Setting ), kInstance.PrioritySlider,	kInstance.PriorityText,	PriorityConverter }
			);
		end
	elseif row.mTable == "Priorities" then
		local kInstance :table = m_kPrioritiesIM_Priorities:GetInstance();
		if Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_" .. row.Setting .. "_NAME" ) == "LOC_CNO_AUTOBUILDERS_STATUS_" .. row.Setting .. "_NAME" then
			kInstance.PriorityName:SetText( row.Setting .. "(Unknown action): " );
		else
			kInstance.PriorityName:SetText( Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_" .. row.Setting .. "_NAME" ) .. " " );
		end
		kInstance.PrioritySlider:SetToolTipString( Locale.Lookup( "LOC_CNO_AUTOBUILDER_SETTINGS_PRIORITIES_PRIORITIES_TOOLTIP" ) );
		kInstance.PrioritySlider:SetSizeX( 500 );
		table.insert( AutoBuilders_Priorities_Constants, 
			{ ( row.mTable .. "_" .. row.Setting ), kInstance.PrioritySlider,	kInstance.PriorityText,	PriorityConverter }
		);
	elseif row.mTable == "Improvement_Scoring" then
		local kInstance :table = m_kPrioritiesIM_ImprovementScoring:GetInstance();
		kInstance.PriorityName:SetText( Locale.Lookup( "LOC_" .. row.Setting .. "_NAME" ) .. ": " );
		kInstance.PrioritySlider:SetToolTipString( Locale.Lookup( "LOC_CNO_AUTOBUILDER_SETTINGS_PRIORITIES_IMPROVEMENT_SCORING_TOOLTIP" ) );
		table.insert( AutoBuilders_Priorities_Constants, 
			{ ( row.mTable .. "_" .. row.Setting ), kInstance.PrioritySlider,	kInstance.PriorityText,	PriorityConverter }
		);	
	end
end

-- Setting class methods
function SettingClass:getName() return self.name; end
function SettingClass:getControl() return self.control; end
function SettingClass:getUIText() return self.ui_text; end
function SettingClass:getSlider() return self.slider; end
function SettingClass:getValue() return self.value; end
function SettingClass:getID() return self.ID; end
function SettingClass:getType() return self.type; end
function SettingClass:getTypeString( useCaps:boolean ) 
	local text = "";
	local useCaps = useCaps or false;
	if self.type == 0 then if useCaps == true then text = "Value"; else text = "value"; end
	elseif self.type == 1 then if useCaps == true then text = "Boolean"; else text = "boolean"; end
	elseif self.tpye == 2 then if useCaps == true then text = "Float"; else text = "float"; end
	end
	return text;
end
-- Resets the binding to default.
function SettingClass:reset()
	if ( ( self.type == 1 ) and ( self.priority == false ) ) then -- Boolean
		local newSetting = GameInfo.CNO_AutoBuilders_Settings[ self.name ]; -- Default setting object from the database.
		if newSetting == nil then return; end
		self.value = newSetting.mBoolean == 1 or newSetting.mBoolean == true;
		GameConfiguration.SetValue( pref .. self.name .. "_Boolean", self.value );
		self.control:SetSelected( self.value ); -- Set Checkbox value.
	elseif ( ( self.type == 2 ) and ( self.priority == false ) ) then -- int slider
		local newSetting = GameInfo.CNO_AutoBuilders_Settings[ self.name ]; -- Default setting object from the database.
		if newSetting == nil then return; end
		self.value = self.converter.FromSetting( newSetting.mValue ); -- overwrite from default database values.
		GameConfiguration.SetValue( pref .. self.name .. "_Value", self.converter.ToSetting( self.value ) ); -- Set game configuration value
		self.slider:SetStep( self.converter.ToSteps( self.value ) ); -- Set slider
		self.ui_text:SetText( self.converter.ToString( self.value ) ); -- Set slider value text
	elseif self.priority == true then
		local newSetting = GameInfo.AutoBuilders_Settings_Value[ pref .. self.name .. "_Value" ]; -- Default setting object from the database.
		if newSetting == nil then return; end
		self.value = self.converter.FromSetting( newSetting.Value ); -- overwrite from default database values.
		GameConfiguration.SetValue( pref .. self.name .. "_Value", self.converter.ToSetting( self.value ) ); -- Set game configuration value
		self.slider:SetStep( self.converter.ToSteps( self.value ) ); -- Set slider
		self.ui_text:SetText( self.converter.ToString( self.value ) ); -- Set slider value text
	end
end
-- Object Constructor
function SettingClass:new ( o )
	o = o or {};
	setmetatable( o, self );
	self.__index = self;
	return o;
end

-- Table methods
function m_Settings:get( id ) -- Returns a binding from the table.
	if ( type(id) ~= "string" ) and ( not ( id > 0 ) ) then 
		if id then print( "ERROR: Nil data passed to m_Settings' function: 'get( " .. tostring( id ) .. ")' is not a valid input." ); end 
		return nil; 
	end
	for _, aSetting in pairs( self.members ) do 
		if aSetting.ID == id then return aSetting; end
		if aSetting.name == id then return aSetting; end -- Alternatively, return the object if the input is a string matching its name.
	end 
	return nil;
end
function m_Settings:save( o ) -- Overwrites updated setting object data into the table.
	for key, aSetting in pairs( self.members ) do if aSetting.ID == o.ID then self.members[key] = o; end end
end
function m_Settings:reset()
	for key, setting in pairs( self.members ) do 
		if setting.priority == false then
			setting:reset();
			self.members[ key ] = setting; -- Save the setting back to the table.
		end
	end
end
function m_Settings:resetPriorities()
	for key, setting in pairs( self.members ) do 
		if setting.priority == true then -- only reset the setting if it is marked as a priority.
			setting:reset();
			self.members[ key ] = setting; -- Save the setting back to the table.
		end
	end
end

function m_Settings:add( o ) -- Adds a new object to the table.
	if not o then print( "ERROR: Nil data passed to mSettings' add function! No data was added." ); end
	self.count = self.count + 1; -- Add to the setting count.
	o.ID = self.count; -- Assign it an ID based on the order it was added in.
	
	-- Set game configuration values and register control callbacks. 
	-- Only populate game configuration if the object has these members (assumes correctly created controls)
	--if o.type and o.value and o.converter and o.control and o.slider and o.ui_text then
	if ( ( o.type == 1 ) and ( o.priority == false ) ) then -- boolean
		
		local current_value = GameConfiguration.GetValue( pref .. o.name .. "_Boolean" );
		if ( current_value == nil ) then
			if ( GameInfo.CNO_AutoBuilders_Settings[ o.name ] ) then --Checks if this setting has a default state defined in the database
				current_value = GameInfo.CNO_AutoBuilders_Settings[ o.name ].mBoolean == 1 or 
					GameInfo.CNO_AutoBuilders_Settings[ o.name ].mBoolean == true;
			else 
				print( "ERROR: Attempt to populate Checkbox with no default value in the database." );
				current_value = false;
			end
			GameConfiguration.SetValue( pref .. o.name .. "_Boolean", current_value );
		end
		o.value = current_value;
		if ( current_value == false ) then o.control:SetSelected(false); else o.control:SetSelected(true); end
		o.control:RegisterCallback( Mouse.eLClick, -- 
			function()
				local selected = not o.control:IsSelected();
				o.control:SetSelected( selected );
				local current_setting = self:get( o.name );
				current_setting.value = selected;
				self:save( current_setting );
				GameConfiguration.SetValue( pref .. o.name .. "_Boolean", selected );
				LuaEvents.CNO_AutoBuilder_SettingsUpdate();
			end
		);
		o.control:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

	elseif o.type == 2 or o.priority == true then -- integer slider
		
		local hasScrolled = false; --Necessary because RegisterSliderCallback fires twice when releasing the mouse cursor for some reason
		local current_value = GameConfiguration.GetValue( pref .. o.name .. "_Value" );
		if( current_value == nil ) then
			if ( GameInfo.CNO_AutoBuilders_Settings[ o.name ] ) then --LY Checks if this setting has a default state defined in the database
				current_value = o.converter.FromSetting( GameInfo.CNO_AutoBuilders_Settings[ o.name ].mValue );
				--print( "Checked setting for " .. o.name .. " and found value: " .. tostring( current_value ) );
			elseif ( GameInfo.AutoBuilders_Settings_Value[ pref .. o.name .. "_Value" ] ) then
				current_value = o.converter.FromSetting( GameInfo.AutoBuilders_Settings_Value[ pref .. o.name .. "_Value" ].Value );
				--print( "Checked setting for " .. o.name .. " and found value: " .. tostring( current_value ) ); 
			else
				print( "ERROR: Attempt to populate Integer Slider with no default value in the database." );
				current_value = 0; 
			end
			GameConfiguration.SetValue( pref .. o.name .. "_Value", o.converter.ToSetting( current_value ) );
		else -- The value was there (saved as an integer, so convert it).
			current_value = o.converter.FromSetting( current_value );
		end
		o.value = current_value;
		o.slider:SetStep(o.converter.ToSteps( current_value ));
		if ( o.converter.ToString ) then o.ui_text:SetText( o.converter.ToString( current_value )) ; else o.ui_text:SetText( current_value ); end
		o.slider:RegisterSliderCallback(
			function()
				local value = o.converter.ToValue( o.slider:GetStep() );
				if ( o.converter.ToString ) then o.ui_text:SetText( o.converter.ToString(value) ); else o.ui_text:SetText( value ); end
				if ( not o.slider:IsTrackingLeftMouseButton() and hasScrolled == true ) then
					GameConfiguration.SetValue( pref .. o.name .. "_Value", o.converter.ToSetting( value ) );
					local current_setting = self:get( o.name );
					current_setting.value = value;
					self:save( current_setting );
					if o.priority == true then
						LuaEvents.CNO_AutoBuilder_PrioritySettingsUpdate();
					else
						LuaEvents.CNO_AutoBuilder_SettingsUpdate();
					end
					UI.PlaySound("Main_Menu_Mouse_Over");
					hasScrolled = false;
				else hasScrolled = true; end
			end
		);
		o.slider:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

	end
				
	table.insert( self.members, o );
end

-- Reset all settings to default (defined in database).
-- =========================================================================================================================================
local function RestoreDefaultSettings()
	m_Settings:reset();
	LuaEvents.CNO_AutoBuilder_SettingsUpdate();
end
--------------------------------------------------------------------------------------------------------------------------------------------

-- Reset all key bindings to default (defined in database).
-- =========================================================================================================================================
local function RestoreDefaultPriorities()
	m_Settings:resetPriorities();
	LuaEvents.CNO_AutoBuilder_PrioritySettingsUpdate();
end
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
function Close()
  UI.PlaySound("UI_Pause_Menu_On");
  ContextPtr:SetHide(true);
  m_isShown = false;
end
--------------------------------------------------------------------------------------------------------------------------------------------

--  Input UI Event Handler
-- =========================================================================================================================================
local function KeyDownHandler( key:number )
	return true; -- absorb all key input when settings window is open.
end
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
local function KeyUpHandler( key:number )
	if ( key == Keys.VK_ESCAPE ) then -- User pressed escape and we are not in keybind change mode.
		Close();
		return true; -- absorb input.
	end
	return true; -- Absorb all key input when settings window is open
end
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
local function OnInputHandler( pInputStruct:table )
  local uiMsg = pInputStruct:GetMessageType();
  if uiMsg == KeyEvents.KeyDown then return KeyDownHandler( pInputStruct:GetKey() ); end
  if uiMsg == KeyEvents.KeyUp then return KeyUpHandler( pInputStruct:GetKey() ); end
  return false;
end
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
local function OnShow()
	UI.PlaySound("UI_Pause_Menu_On");
	-- From Civ6_styles: FullScreenVignetteConsumer
	Controls.ScreenAnimIn:SetToBeginning();
	Controls.ScreenAnimIn:Play();
	Controls.ScreenAnimInMenu:SetToBeginning();
	Controls.ScreenAnimInMenu:Play();
	LuaEvents.CNO_FreeCamera_Settings_OnShow(); -- Tell WorldInput.lua from Free Camera mod the settings were brought up and clear current input for that script.
	m_isShown = true;
end
--------------------------------------------------------------------------------------------------------------------------------------------

--Used to switch active panels/tabs in the settings panel
-- =========================================================================================================================================
local function ShowTab(button, panel, reset_button)
  -- Unfocus all tabs and hide panels
  for i, v in ipairs(m_tabs) do
	v[1]:SetSelected(false);
	v[2]:SetHide(true);
    if v[3] ~= "none" then v[3]:SetHide(true); end
  end
  button:SetSelected(true);
  panel:SetHide(false);
  if reset_button ~= "none" then reset_button:SetHide(false); end
  Controls.WindowTitle:SetText( Locale.Lookup("LOC_CNO_AUTOBUILDER_NAME" ) .. " :   " .. Locale.ToUpper( button:GetText() ) );
end
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
local function PopulateAutoBuildersSettings()
	for row, setting in pairs( AutoBuilders_Settings_Constants ) do -- Go through the table that connects setting names with converters and XML controls.
		local setting_name = setting [1];
		local setting_type = setting [2];
		local setting_control = setting [3];
		local setting_slider = setting [4];
		local setting_text = setting [5];
		local setting_converter = setting[6];
		local oldSetting = m_Settings:get( setting_name );
		if not oldSetting then -- no current setting with this name.
			if setting_type == 1 then -- boolean (general)
				local newSetting = SettingClass:new{
					name = setting_name;
					control = setting_control;
					type = setting_type;
				};
				m_Settings:add( newSetting ); -- Add to the table of settings.

			elseif setting_type == 2 then -- integer slider
				local newSetting = SettingClass:new{
					name = setting_name;
					slider = setting_slider;
					converter = setting_converter;
					ui_text = setting_text;
					type = setting_type;
				};
				m_Settings:add( newSetting ); -- Add to the table of settings.
			end
		end		
	end
	-- Go though priorities.
	for row, setting in pairs( AutoBuilders_Priorities_Constants ) do
		local setting_name = setting [1];
		local setting_slider = setting [2];
		local setting_text = setting [3];
		local setting_converter = setting[4];
		local oldSetting = m_Settings:get( setting_name );
		if not oldSetting then -- no current setting with this name.
			local newSetting = SettingClass:new{
				name = setting_name;
				slider = setting_slider;
				converter = setting_converter;
				ui_text = setting_text;
				type = 3;
				priority = true;
			};
			m_Settings:add( newSetting ); -- Add to the table of settings.
		end		
	end	
	
	Controls.PrioritiesStack_MaxUniques:CalculateSize();
	Controls.PrioritiesStack_MaxUniques:ReprocessAnchoring();
	Controls.PrioritiesStack_Distance:CalculateSize();
	Controls.PrioritiesStack_Distance:ReprocessAnchoring();
	Controls.PrioritiesStack_Scoring:CalculateSize();
	Controls.PrioritiesStack_Scoring:ReprocessAnchoring();
	Controls.PrioritiesStack_ImprovementScoring:CalculateSize();
	Controls.PrioritiesStack_ImprovementScoring:ReprocessAnchoring();
	
	Controls.PrioritiesStack_1:CalculateSize();
	Controls.PrioritiesStack_1:ReprocessAnchoring();
	Controls.PrioritiesStack_2:CalculateSize();
	Controls.PrioritiesStack_2:ReprocessAnchoring();
	
	Controls.PlotPrioritiesStack:CalculateSize();
	Controls.PlotPrioritiesStack:ReprocessAnchoring();
	print( "Populated Auto Builders Settings." );
end
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
-- Add the manipulatable Auto Builders Settings object from AutoBuilders_Settings.lua
local function InitializeAutoBuildersUtilities()
	if ExposedMembers.CNO_AutoBuilder_Initialized then 
		AutoBuilders = ExposedMembers.CNO_AutoBuilder;
		Events.GameCoreEventPublishComplete.Remove( InitializeAutoBuildersUtilities );
		print ("Added Auto Builders utilities from ExposedMembers table.");
		AutoBuilders_Added = true;
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------

-- =========================================================================================================================================
local function Initialize()
	
	ContextPtr:SetHide( true ); -- Settings window starts out hidden.

	for i, tab in ipairs(m_tabs) do
		local button = tab [1];
		local panel = tab [2];
		local reset_button = "none";
		if tab [3] ~= "none" then reset_button = tab [3]; end
		button:RegisterCallback( Mouse.eLClick, function() ShowTab( button, panel, reset_button ); end) ;
	end
	ShowTab( m_tabs [1][1], m_tabs [1][2], m_tabs [1][3] ); --Show General Settings on start

	-- Confirm/Restore Default Buttons
	Controls.ConfirmButton:RegisterCallback( Mouse.eLClick, Close );
	Controls.ConfirmButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	Controls.ResetButton:RegisterCallback( Mouse.eLClick, RestoreDefaultSettings );
	Controls.ResetButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	Controls.ResetPrioritiesButton:RegisterCallback( Mouse.eLClick, RestoreDefaultPriorities );
	Controls.ResetPrioritiesButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	-- Register all of the settings and bindings options.
	PopulateAutoBuildersSettings();

	ContextPtr:SetShowHandler( OnShow );
	ContextPtr:SetInputHandler( OnInputHandler, true );

	-- Events
	LuaEvents.CNO_AutoBuilders_ToggleSettings.Add( function() ContextPtr:SetHide( not ContextPtr:IsHidden() ); end );
	LuaEvents.CNO_AutoBuilders_SettingsInitialized(); --Tell other elements that the settings have been initialized and it's safe to try accessing settings now
	Events.GameCoreEventPublishComplete.Add( InitializeAutoBuildersUtilities ); -- Add Auto Builders object.
end

Initialize();