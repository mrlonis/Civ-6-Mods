-- AutomatedBuilders_UI
-- Author: MadManCam
-- DateCreated: 4/22/2018 8:51:11 PM
--------------------------------------------------------------

local m_AutoBuilder = {};
local m_AutoArchaeology = {};
local m_AutoBuilderLight = {};

local m_GameMods = Modding.GetActiveMods();
local m_isAutoBuilder_Enabled = false;
local m_isAutoArchaeology_Enabled = false;
local m_isAutoBuilderLight_Enabled = false;
local m_isAutoBuilder_Loaded = false;
local m_isAutoArchaeology_Loaded = false;
local m_isAutoBuilderLight_Loaded = false;
local m_ScriptsLoaded = false;
local m_isOkayToProcess = true;

local m_isMinibarClosed :boolean = true;
local m_isTitleStackClosed :boolean = true;

local m_selectedPlayerId    :number = -1;
local m_UnitId          :number = -1;
local m_defaultUnitStatus = "";
local m_UnitStatus		:string = m_defaultUnitStatus;

local MAX_STATUS_LENGTH = 36;
local MINIBAR_PARENT = "/InGame/UnitPanel/MainPanel";


print( "Active Game Mods: " );
for _, aMod in pairs( m_GameMods ) do
	local printModInfo = true;
	if aMod.Id == "6d80811a-4596-49b5-94ef-dfa68d144e2c" then 
		print( "Mod: Automated Builders + Archaeologists" );
		m_isAutoBuilder_Enabled = true; 
		m_isAutoArchaeology_Enabled = true;
		printModInfo = false;
	end
	if aMod.Id == "e924b89a-5ef8-4fdd-be6d-9acdad9737f7" then
		print( "Mod: Automated Builders (Light Version)" );
		m_isAutoBuilderLight_Enabled = true;
		printModInfo = false;
	end
	if printModInfo then
		print( "Mod: " .. Locale.Lookup( aMod.Name ) );
	end
end

--[[ Logic for mod overrides
if m_isAutoBuilderLight_Enabled then 
	if m_isAutoBuilder_Enabled then print( "Automated Builders is also enabled. Overriding script with light version." ); end
	m_isAutoBuilder_Enabled = false;
end
--]]

-- =========================================================================================================================================
-- AutoBuilders mod
local function InitializeAutoBuilder()
	if ExposedMembers.CNO_AutoBuilder_Initialized then 
        m_AutoBuilder = ExposedMembers.CNO_AutoBuilder;   -- contains local functions from other context
        Events.GameCoreEventPublishComplete.Remove( InitializeAutoBuilder );
        print("AutoBuilder: Exposed Functions from AutoBuilders.lua context added...");
		if ExposedMembers.CNO_AutoBuilder.debug then print ("AutoBuilder: Debug logging is currently enabled.");
		else print ("AutoBuilder: Debug logging is currently disabled."); end
		
		m_isAutoBuilder_Loaded = true;
		-- Check if the other scripts are also loaded
		if m_isAutoArchaeology_Enabled then
			if m_isAutoArchaeology_Loaded then
				if m_isAutoBuilderLight_Enabled then
					if m_isAutoBuilderLight_Loaded then
						m_ScriptsLoaded = true;
					end
				else
					m_ScriptsLoaded = true;
				end
			end
		else -- Automated Archaeologists disabled.
			if m_isAutoBuilderLight_Enabled then
				if m_isAutoBuilderLight_Loaded then
					m_ScriptsLoaded = true;
				end
			else
				m_ScriptsLoaded = true;
			end
		end
		-- Refresh UI if all scripts loaded
		if m_ScriptsLoaded == true then ContextPtr:RequestRefresh(); end
				
    end
end

-- =========================================================================================================================================
-- AutoArchaeology mod
local function InitializeAutoArchaeology()
	if ExposedMembers.CNO_AutoArchaeology_Initialized then 
        m_AutoArchaeology = ExposedMembers.CNO_AutoArchaeology;   -- contains local functions from other context
        Events.GameCoreEventPublishComplete.Remove( InitializeAutoArchaeology );
        print("AutoBuilder: Exposed Functions from AutoArchaeology.lua context added...");
		if ExposedMembers.CNO_AutoArchaeology.debug then print ("AutoArchaeology: Debug logging is currently enabled.");
		else print ("AutoArchaeology: Debug logging is currently disabled."); end

		m_isAutoArchaeology_Loaded = true;
		-- Check if the other scripts are also loaded
		if m_isAutoBuilder_Enabled then
			if m_isAutoBuilder_Loaded then
				if m_isAutoBuilderLight_Enabled then
					if m_isAutoBuilderLight_Loaded then
						m_ScriptsLoaded = true;
					end
				else
					m_ScriptsLoaded = true;
				end
			end
		else -- Automated Builders disabled.
			if m_isAutoBuilderLight_Enabled then
				if m_isAutoBuilderLight_Loaded then
					m_ScriptsLoaded = true;
				end
			else
				m_ScriptsLoaded = true;
			end	
		end
		-- Refresh UI if all scripts loaded
		if m_ScriptsLoaded == true then ContextPtr:RequestRefresh(); end

    end
end

-- =========================================================================================================================================
-- AutoBuilders (Light Version) mod
local function InitializeAutoBuilderLight()
	if ExposedMembers.CNO_AutoBuilderLight_Initialized then 
        m_AutoBuilderLight = ExposedMembers.CNO_AutoBuilderLight;   -- contains local functions from other context
        Events.GameCoreEventPublishComplete.Remove( InitializeAutoBuilderLight );
        print("AutoBuilderLight: Exposed Functions from AutoBuildersLight.lua context added...");
		if ExposedMembers.CNO_AutoBuilderLight.debug then print ("AutoBuilderLight: Debug logging is currently enabled.");
		else print ("AutoBuilderLight: Debug logging is currently disabled."); end

		m_isAutoBuilderLight_Loaded = true;
		-- Check if the other scripts are also loaded
		if m_isAutoArchaeology_Enabled then
			if m_isAutoArchaeology_Loaded then
				if m_isAutoBuilder_Enabled then
					if m_isAutoBuilder_Loaded then
						m_ScriptsLoaded = true;
					end
				else
					m_ScriptsLoaded = true;
				end
			end
		else -- Automated Archaeologists disabled.
			if m_isAutoBuilder_Enabled then
				if m_isAutoBuilder_Loaded then
					m_ScriptsLoaded = true;
				end
			else
				m_ScriptsLoaded = true;
			end
		end
		-- Refresh UI if all scripts loaded
		if m_ScriptsLoaded == true then ContextPtr:RequestRefresh(); end 

    end
end

-- =========================================================================================================================================
-- Returns nothing if the local function is not callable.
local function callIfCallable( f )
    return function( ... )
        error, result = pcall( f, ... );
        if error then -- f exists and is callable
            -- print('ok')
            return result;
        else
			return nil;
		end
        -- nothing to do, as though not called, or print('error', result)
    end
end

-- =========================================================================================================================================
local function UpdateUnitStatus( status_string )
	--print( status_string );
	--status_string = "abcdefghijklmnopqrstuvwxyz12345678"
	local string_length = status_string:len();
	--print( "Status string length: " .. string_length );
	if string_length > MAX_STATUS_LENGTH then -- separate status string into two boxes
		local divider_index = math.ceil( string_length / 2.0 ); -- About halfway through the string
		for i = 0,10 do -- iterate up to 10 more characters to the right to try to find a space.
			local nextChar = status_string:sub( divider_index + 1, divider_index + 1 );
			if nextChar == " " then -- Stop iterating if we found a space.
				divider_index = divider_index + 1;
				break;
			end 
			divider_index = divider_index + 1;
		end
		local string1 = status_string:sub( 1, divider_index );
		local string2 = status_string:sub( divider_index + 1 );
		Controls.UnitStatus:SetText( "" );
		Controls.UnitStatusTop:SetText( string1 );
		Controls.UnitStatusBottom:SetText( string2 );
	else 
		Controls.UnitStatus:SetText( status_string );
		Controls.UnitStatusTop:SetText( "" );
		Controls.UnitStatusBottom:SetText( "" );
	end
end

-- =========================================================================================================================================
local function Hide()
	if not Controls.CNO_AutomatedBuilders_Minibar_Context:IsHidden() then -- play collapse animation.
		Controls.CNO_AutoBuilders_Minibar_CollapseAnim:SetToBeginning();
		Controls.CNO_AutoBuilders_Minibar_CollapseAnim:Play();
	end
	m_isMinibarClosed = true;
	Controls.CNO_AutomatedBuilders_Minibar_Context:SetHide( true );
end

-- =========================================================================================================================================
local function Show()
	if Controls.CNO_AutomatedBuilders_Minibar_Context:IsHidden() then -- play expand animation.
		Controls.CNO_AutomatedBuilders_Minibar_Context:SetHide( false );
		Controls.CNO_AutoBuilders_Minibar_Alpha:SetToBeginning();
		Controls.CNO_AutoBuilders_Minibar_Alpha:Play();
		Controls.CNO_AutoBuilders_Minibar_ExpandAnim:SetToBeginning();
		Controls.CNO_AutoBuilders_Minibar_ExpandAnim:Play();
	else
		Controls.CNO_AutomatedBuilders_Minibar_Context:SetHide( false );
	end
	m_isMinibarClosed = false;
end

-- =========================================================================================================================================
-- Refreshes the Automated Units Minibar.
local function RefreshUnitActions( unit )

	local b_UseMinibar = false; -- Used to determine whether or not to show the Automated Units Minibar.	
	m_UnitStatus = m_defaultUnitStatus;

	-- Is this a Builder?
	if ( m_isAutoBuilder_Enabled and m_isAutoBuilder_Loaded and ( unit:GetUnitType() == GameInfo.Units["UNIT_BUILDER"].Index ) ) then
		
		b_UseMinibar = true; -- Show the Automated Units Minibar
		if not m_AutoBuilder.IsBuilderAutomated( unit ) then -- Builder is not automated by main version
			-- If light version is enabled, check if Builder is automated by light version
			if m_isAutoBuilderLight_Enabled then
				if ( not m_AutoBuilderLight.IsBuilderAutomated( unit ) ) then 
					Controls.StopAutomateButton:SetHide( true ); -- Hide Stop Automation button
					Controls.AutomateButton:SetHide( false ); -- Show Automate Actions button
				else -- Builder is automated by the light version
		 			m_UnitStatus = m_AutoBuilderLight.GetUnitStatus( unit );
					Controls.StopAutomateButton:SetHide( false ); -- Show Stop Automation button
					Controls.AutomateButton:SetHide( true ); -- Hide Automate Actions button
				end
			else -- Light version disabled
				Controls.StopAutomateButton:SetHide( true ); -- Hide Stop Automation button
				Controls.AutomateButton:SetHide( false ); -- Show Automate Actions button	
			end
		else -- Builder automated by main version 
			m_UnitStatus = m_AutoBuilder.GetUnitStatus( unit );
			Controls.StopAutomateButton:SetHide( false ); -- Show Stop Automation button
			Controls.AutomateButton:SetHide( true ); -- Hide Automate Actions button
		end

	end

	-- Is this an Archaeologist?
	if ( m_isAutoArchaeology_Enabled and m_isAutoArchaeology_Loaded and ( unit:GetUnitType() == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index ) ) then
		
		b_UseMinibar = true; -- Show the Automated Units Minibar
		if not m_AutoArchaeology.IsArchaeologistAutomated( unit ) then -- Archaeologist is not automated.
			Controls.StopAutomateButton:SetHide( true ); -- Hide Stop Automation button
			Controls.AutomateButton:SetHide( false ); -- Show Automate Actions button
		else
			m_UnitStatus = m_AutoArchaeology.GetUnitStatus( unit );
			Controls.StopAutomateButton:SetHide( false ); -- Show Stop Automation button
			Controls.AutomateButton:SetHide( true ); -- Hide Automate Actions button
		end

	end

	-- Is this a Builder?
	if ( m_isAutoBuilderLight_Enabled and m_isAutoBuilderLight_Loaded and ( unit:GetUnitType() == GameInfo.Units["UNIT_BUILDER"].Index ) ) then
		
		b_UseMinibar = true; -- Show the Automated Units Minibar
		if not m_AutoBuilderLight.IsBuilderAutomated( unit ) then -- Builder is not automated by light version
			-- If main version is enabled, check if Builder is automated by main version
			if m_isAutoBuilder_Enabled then
				if ( not m_AutoBuilder.IsBuilderAutomated( unit ) ) then 
					Controls.StopAutomateButton:SetHide( true ); -- Hide Stop Automation button
					Controls.AutomateButton:SetHide( false ); -- Show Automate Actions button
				else -- Builder is automated by the main version
		 			m_UnitStatus = m_AutoBuilder.GetUnitStatus( unit );
					Controls.StopAutomateButton:SetHide( false ); -- Show Stop Automation button
					Controls.AutomateButton:SetHide( true ); -- Hide Automate Actions button
				end
			else -- Main version disabled
				Controls.StopAutomateButton:SetHide( true ); -- Hide Stop Automation button
				Controls.AutomateButton:SetHide( false ); -- Show Automate Actions button	
			end
		else -- Builder automated by light version 
			m_UnitStatus = m_AutoBuilderLight.GetUnitStatus( unit );
			Controls.StopAutomateButton:SetHide( false ); -- Show Stop Automation button
			Controls.AutomateButton:SetHide( true ); -- Hide Automate Actions button
		end

	end
	
	UpdateUnitStatus( m_UnitStatus ); -- Set Unit Status text.

	if b_UseMinibar == false then
		Hide();	-- Hide the Automated Units Minibar.
	else
		Show();	-- Show the Automated Units Minibar.
	end

end

-- =========================================================================================================================================
-- TO be used every time before an action controlled by this script is clicked.
local function BeforeUnitActionClicked()
	-- Change interface mode back to selection, this prevents old interface modes (such as range attack) sticking around after action is pressed.
	local currentMode = UI.GetInterfaceMode();
	if currentMode ~= InterfaceModeTypes.SELECTION then
		print( "Automated Builders + Archaeologists forcing interface mode back to selection before performing operation/action" ); --Debug
		UI.SetInterfaceMode( InterfaceModeTypes.SELECTION );
	end
end

-- =========================================================================================================================================
-- Automate Actions button was pressed.
local function OnAutomate()
	
	if ( m_isOkayToProcess ) then
		local pSelectedUnit = UI.GetHeadSelectedUnit();
		if ( pSelectedUnit ~= nil ) then

			local units = Players[m_selectedPlayerId]:GetUnits();
			local unit = units:FindID(m_UnitId);

			-- Is this a Builder?
			if ( m_isAutoBuilder_Enabled and m_isAutoBuilder_Loaded and ( unit:GetUnitType() == GameInfo.Units["UNIT_BUILDER"].Index ) ) then
				if not m_AutoBuilder.IsBuilderAutomated( unit ) then -- don't proceed if Builder is already automated by main version
					-- If light version is enabled, check if Builder is automated by light version
					if ( m_isAutoBuilderLight_Enabled and ( not m_AutoBuilderLight.IsBuilderAutomated( unit ) ) ) then 
						BeforeUnitActionClicked();
						m_AutoBuilder.AutomateBuilder( unit );
					-- Only main version is enabled, no need to check light version automation.
					elseif ( not m_isAutoBuilderLight_Enabled ) then 
		 				BeforeUnitActionClicked();
						m_AutoBuilder.AutomateBuilder( unit );
					else
						print( "ERROR: Attempt to Automate Actions for a Builder that is already automated." );
					end
				else
					print( "ERROR: Attempt to Automate Actions for a Builder that is already automated." );
				end
				ContextPtr:RequestRefresh(); -- Refresh UI
			end

			-- Is this an Archaeologist?
			if ( m_isAutoArchaeology_Enabled and m_isAutoArchaeology_Loaded and ( unit:GetUnitType() == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index ) ) then
				if not m_AutoArchaeology.IsArchaeologistAutomated( unit ) then -- don't proceed if Archaeologist is already automated.
					BeforeUnitActionClicked();
					m_AutoArchaeology.AutomateArchaeologist( unit );
				else
					print( "ERROR: Attempt to Automate Actions for an Archaeologist that is already automated." );
				end
				ContextPtr:RequestRefresh(); -- Refresh UI
			end

			-- Is this a Builder?
			if ( m_isAutoBuilderLight_Enabled and m_isAutoBuilderLight_Loaded and ( unit:GetUnitType() == GameInfo.Units["UNIT_BUILDER"].Index ) ) then
				if not m_AutoBuilderLight.IsBuilderAutomated( unit ) then -- don't proceed if Builder is already automated by light version
					-- If main version is enabled, check if Builder is automated by main version
					if ( m_isAutoBuilder_Enabled and ( not m_AutoBuilder.IsBuilderAutomated( unit ) ) ) then 
						BeforeUnitActionClicked();
						m_AutoBuilderLight.AutomateBuilder( unit );
					-- Only light version is enabled, no need to check main version automation.
					elseif ( not m_isAutoBuilder_Enabled ) then 
		 				BeforeUnitActionClicked();
						m_AutoBuilderLight.AutomateBuilder( unit );
					else
						print( "ERROR: Attempt to Automate Actions (Repair Only) for a Builder that is already automated." );
					end
				else
					print( "ERROR: Attempt to Automate Actions (Repair Only) for a Builder that is already automated." );
				end
				ContextPtr:RequestRefresh(); -- Refresh UI
			end

		end
	end

end

-- =========================================================================================================================================
-- Stop Automation button was pressed.
local function OnStopAutomate()
	
	if ( m_isOkayToProcess ) then
		local pSelectedUnit = UI.GetHeadSelectedUnit();
		if ( pSelectedUnit ~= nil ) then

			local units = Players[m_selectedPlayerId]:GetUnits();
			local unit = units:FindID(m_UnitId);

			-- Is this a Builder?
			if ( m_isAutoBuilder_Enabled and m_isAutoBuilder_Loaded and ( unit:GetUnitType() == GameInfo.Units["UNIT_BUILDER"].Index ) ) then
				-- No need to check if builder is automated by light version, that mod will handle the Stop Automation on its own.
				BeforeUnitActionClicked();
				m_AutoBuilder.StopAutomateBuilder( unit );
				ContextPtr:RequestRefresh(); -- Refresh UI
			end

			-- Is this an Archaeologist?
			if ( m_isAutoArchaeology_Enabled and m_isAutoArchaeology_Loaded and ( unit:GetUnitType() == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index ) ) then
				BeforeUnitActionClicked();
				m_AutoArchaeology.StopAutomateArchaeologist( unit );
				ContextPtr:RequestRefresh(); -- Refresh UI
			end

			-- Is this a Builder?
			if ( m_isAutoBuilderLight_Enabled and m_isAutoBuilderLight_Loaded and ( unit:GetUnitType() == GameInfo.Units["UNIT_BUILDER"].Index ) ) then
				-- No need to check if builder is automated by main version, that mod will handle the Stop Automation on its own.
				BeforeUnitActionClicked();
				m_AutoBuilderLight.StopAutomateBuilder( unit );
				ContextPtr:RequestRefresh(); -- Refresh UI
			end

		end
	end

end


-- =========================================================================================================================================
local function Refresh(player, unitId)
	if( Players and Players[player] and player ~= nil and player ~= -1 and unitId ~= nil and unitId ~= -1) then
		local units = Players[player]:GetUnits();
		local unit = units:FindID(unitId);
		if(unit ~= nil) then
			RefreshUnitActions( unit );
		else
			Hide();
		end
	else
		Hide();
	end
end

-- =========================================================================================================================================
local function OnRefresh()
	ContextPtr:ClearRequestRefresh();   -- Clear the refresh request, in case we got here from some other means.  This cuts down on redundant updates.
	Refresh(m_selectedPlayerId, m_UnitId);
end

-- =========================================================================================================================================
local function OnBeginWonderReveal()
  Hide();
end

-------------------------------------------------------------------------------
local function OnUnitSelectionChanged(player, unitId, locationX, locationY, locationZ, isSelected, isEditable)
  --print("UnitPanel::OnUnitSelectionChanged(): ",player,unitId,isSelected);
  if (isSelected) then
    m_selectedPlayerId = player;
    m_UnitId = unitId;
    Refresh(m_selectedPlayerId, m_UnitId);
  else
    m_selectedPlayerId  = nil;
    m_UnitId      = nil;
    -- This event is raised on deselected units too; only hide if there
    -- is no selected units left.
    if UI and (UI.GetHeadSelectedUnit()== nil) then
      Hide();
    end
  end

end

-- =========================================================================================================================================
local function ShowHideSelectedUnit()
  m_isOkayToProcess = true;
  local pSelectedUnit :table = UI.GetHeadSelectedUnit();
  if pSelectedUnit ~= nil then
    m_selectedPlayerId        = pSelectedUnit:GetOwner();
    m_UnitId            = pSelectedUnit:GetID();
    Refresh( m_selectedPlayerId, m_UnitId );
  else
    Hide();
  end
end

-- =========================================================================================================================================
local function OnGameConfigChanged_Hotseat_Paused()
  Events.GameConfigChanged.Remove(OnGameConfigChanged_Hotseat_Paused);
  if(not GameConfiguration.IsPaused()) then
    ShowHideSelectedUnit();
  end
end

-- =========================================================================================================================================
local function OnPlayerChangeClose( ePlayer:number )
	local isPaused:boolean = GameConfiguration.IsPaused();
	--print("OnPlayerChangeClose: " .. ePlayer .. ", GameConfiguration.IsPaused()=" .. tostring(isPaused));
	if(isPaused) then
		Events.GameConfigChanged.Add(OnGameConfigChanged_Hotseat_Paused);
	end
end

-- =========================================================================================================================================
local function OnPlayerTurnDeactivated( ePlayer:number )
  if ePlayer == Game.GetLocalPlayer() then
    m_isOkayToProcess = false;
  end
end

-- =========================================================================================================================================
local function OnPlayerTurnActivated( ePlayer:number, isFirstTime:boolean )
  if ePlayer == Game.GetLocalPlayer() then
    ShowHideSelectedUnit();
  end
end

-- =========================================================================================================================================
local function OnPhaseBegin()
  ContextPtr:RequestRefresh();
end

-- =========================================================================================================================================
local function OnContextInitialize( isHotload : boolean)
  if isHotload then
    -- OnPlayerTurnActivated( Game.GetLocalPlayer(), true ) ;  -- Fake player activated call.
  end
end

-- =========================================================================================================================================
local function OnCitySelectionChanged(owner, ID, i, j, k, bSelected, bEditable)
  Hide();
end

-- =========================================================================================================================================
local function OnUnitRemovedFromMap( playerID: number, unitID : number )
  if(playerID == m_selectedPlayerId and unitID == m_UnitId) then
    Hide();
  end
end

-- =========================================================================================================================================
local function OnInterfaceModeChanged( eOldMode:number, eNewMode:number )
	if (eNewMode == InterfaceModeTypes.CITY_RANGE_ATTACK) then
		Show();
	elseif (eNewMode == InterfaceModeTypes.DISTRICT_RANGE_ATTACK) then
		Show();
	end
	if (eOldMode == InterfaceModeTypes.CITY_RANGE_ATTACK or eOldMode == InterfaceModeTypes.DISTRICT_RANGE_ATTACK) then
		Hide();
	end
end

-- =========================================================================================================================================
local function OnTitleStackMouseExit() -- Hide the title stack.
	if not ( Controls.TitleStack:IsHidden() ) then
		UI.PlaySound("Main_Menu_Mouse_Over");
		Controls.TitleStack:SetHide( true );
	end
	m_isTitleStackClosed = true;
end

-- =========================================================================================================================================
local function OnTitleStackMouseEnter() -- Show the title stack.
	if not ( m_isMinibarClosed ) then -- Only show if Minibar itself is open.
		if ( Controls.TitleStack:IsHidden() ) then
			UI.PlaySound("Main_Menu_Mouse_Over");
			Controls.TitleStack:SetHide( false );
			Controls.CNO_AutoBuilders_Minibar_TitleStack_Alpha:SetToBeginning();
			Controls.CNO_AutoBuilders_Minibar_TitleStack_Alpha:Play();
		end
		m_isTitleStackClosed = false;
	end
end

-- =========================================================================================================================================
local function OnToggleSettings()
	-- if FreeCamSettings.Enter then FreeCamSettings.Enter(); end
	LuaEvents.CNO_AutoBuilders_ToggleSettings();
	--if debug then print( "Opened Free Camera Settings Panel." ); end
end

-- =========================================================================================================================================
local function OnUnitStatusUpdate()
	ContextPtr:RequestRefresh(); -- Refresh selected unit status info.	
end

-- =========================================================================================================================================
local function InitializeControls()
	-- Register button callbacks.
	Controls.AutomateButton:RegisterCallback( Mouse.eLClick, OnAutomate );
	Controls.AutomateButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);	
	Controls.StopAutomateButton:RegisterCallback( Mouse.eLClick, OnStopAutomate );
	Controls.StopAutomateButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	
	-- Settings Button
	Controls.ToggleSettingsButton:RegisterCallback( Mouse.eLClick, OnToggleSettings );
	Controls.ToggleSettingsButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end) ;
	
	Controls.CNO_AutomatedBuilders_Main_Container:RegisterMouseEnterCallback( OnTitleStackMouseEnter );
	Controls.TitleStack_Container:RegisterMouseEnterCallback( OnTitleStackMouseEnter );
	Controls.CNO_AutomatedBuilders_Minibar_Container:RegisterMouseEnterCallback( OnTitleStackMouseEnter );
	Controls.CNO_AutomatedBuilders_Minibar_Container:RegisterMouseExitCallback( OnTitleStackMouseExit );
end

-- =========================================================================================================================================
local function AttachMinibarToPanel()
	Controls.CNO_AutomatedBuilders_Minibar_Container:ChangeParent( ContextPtr:LookUpControl( MINIBAR_PARENT ) );
end

-- =========================================================================================================================================
function Initialize()

	ContextPtr:SetInitHandler( OnContextInitialize );
	ContextPtr:SetRefreshHandler( OnRefresh );

	-- Automated Units, initialize scripts if mod is loaded.
	if m_isAutoBuilder_Enabled then 
		Events.GameCoreEventPublishComplete.Add( InitializeAutoBuilder );
	end
	if m_isAutoArchaeology_Enabled then 
		Events.GameCoreEventPublishComplete.Add( InitializeAutoArchaeology );
	end
	if m_isAutoBuilderLight_Enabled then 
		Events.GameCoreEventPublishComplete.Add( InitializeAutoBuilderLight );
	end

	Events.BeginWonderReveal.Add( OnBeginWonderReveal );
	Events.CitySelectionChanged.Add( OnCitySelectionChanged );
	Events.InterfaceModeChanged.Add( OnInterfaceModeChanged );
	Events.PhaseBegin.Add( OnPhaseBegin );
	Events.PlayerTurnActivated.Add( OnPlayerTurnActivated );
	Events.PlayerTurnDeactivated.Add( OnPlayerTurnDeactivated );
	Events.UnitRemovedFromMap.Add( OnUnitRemovedFromMap );
	Events.UnitSelectionChanged.Add( OnUnitSelectionChanged );

	LuaEvents.PlayerChange_Close.Add( OnPlayerChangeClose );
	LuaEvents.CNO_AutoBuilder_OnBuilderActionsUpdate.Add( OnUnitStatusUpdate );
	LuaEvents.CNO_AutoBuilder_OnArchaeologistActionsUpdate.Add( OnUnitStatusUpdate );
	
	InitializeControls();
	
	if ContextPtr:LookUpControl( MINIBAR_PARENT ) then 
		--AttachMinibarToPanel();
		Controls.CNO_AutomatedBuilders_Minibar_Container:SetAnchor( "R,B" );
		Controls.CNO_AutomatedBuilders_Minibar_Container:SetOffsetX( 120 );
		Controls.CNO_AutomatedBuilders_Minibar_Container:SetOffsetY( 220 );
		print( "Anchored Minibar panel to Unit Panel." );
	else
		Controls.CNO_AutomatedBuilders_Minibar_Container:SetAnchor( "R,B" );
		Controls.CNO_AutomatedBuilders_Minibar_Container:SetOffsetX( 120 );
		Controls.CNO_AutomatedBuilders_Minibar_Container:SetOffsetY( 220 );
	end
	
end

--Events.LoadScreenClose.Add( Initialize );
Initialize();