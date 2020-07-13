-- Cheat_Menu_Units_minibar.lua
-- Author: Zur13
-- DateCreated: 10/31/2018 11:36:42 PM
-- Last Modified By: mrlonis
-- Last Modified On: 07/12/2020
--------------------------------------------------------------

IsBtnAddedUC = false;

selPlayerId = -1;
selUnitId = -1;

isPlayerActive = true;

isMinibarClosed = true;
isMinibarCollapsed = false;

restoreSelectionRequested = nil;
restoreSelectionRequestedBackup = nil;

-- Dup Unit Dialog
playerLBEntries = {};
targetPlotId = nil;
targetPlayerId = nil;
targetUnitType = nil;
targetUnitCnt = nil;

--Refresh; -- func variable to call function before it was defined
--UiRefreshUnitPanel; -- func variable to call function before it was defined
--local RequestDelayedMovementCheat;
--local RequestDelayedReselect;
--RefreshDlg;
--RefreshUnitListPopup;
--local FixUiMode;
--OnRefresh;

--**************************************************************************************************************************************************************************************************
-- BUTTONS
--**************************************************************************************************************************************************************************************************

include( "Cheat_Menu_Units_Minibar_Import_Btns" );

--**************************************************************************************************************************************************************************************************
-- CALLBACKS
--**************************************************************************************************************************************************************************************************

--******************************************************************************
function ShowHideSelectedUnit()
    isPlayerActive = true;
    local pSelectedUnit :table = UI.GetHeadSelectedUnit();

    if pSelectedUnit ~= nil then
        selPlayerId = pSelectedUnit:GetOwner();
        selUnitId = pSelectedUnit:GetID();
        Refresh( selPlayerId, selUnitId );
    else
        Hide();
    end
end

--******************************************************************************
function OnGameConfigChanged_Hotseat_Paused()
    Events.GameConfigChanged.Remove( OnGameConfigChanged_Hotseat_Paused );

    if not GameConfiguration.IsPaused() then
        ShowHideSelectedUnit();
    end
end

--******************************************************************************
function OnPlayerChangeClose( ePlayer:number )
    local isPaused:boolean = GameConfiguration.IsPaused();

    if isPaused then
        Events.GameConfigChanged.Add(OnGameConfigChanged_Hotseat_Paused);
    end
end

--******************************************************************************
function OnPlayerTurnDeactivated( ePlayer:number )
    if ePlayer == Game.GetLocalPlayer() then
        isPlayerActive = false;
    end
end

--******************************************************************************
function OnPlayerTurnActivated( ePlayer:number, isFirstTime:boolean )
    if ePlayer == Game.GetLocalPlayer() then
        ShowHideSelectedUnit();
    end
end

--******************************************************************************
function OnPhaseBegin()
    ContextPtr:RequestRefresh();
    OnRefresh();
end

--******************************************************************************
function OnCitySelectionChanged(owner, ID, i, j, k, bSelected, bEditable)
    Hide();
end

--******************************************************************************
function OnUnitRemovedFromMap( playerID: number, unitID : number )
    if playerID == selPlayerId and unitID == selUnitId then
        Hide();
    end
end

--******************************************************************************
function OnInterfaceModeChanged( eOldMode:number, eNewMode:number )
    if eOldMode == InterfaceModeTypes.CITY_RANGE_ATTACK or eOldMode == InterfaceModeTypes.DISTRICT_RANGE_ATTACK then
        Hide();
    end
end

--******************************************************************************
local function OnEventTest()
    print("Cheat_Menu_Units_Minibar.OnEventTest ############################################");
end


--******************************************************************************
function OnRefresh()
    ContextPtr:ClearRequestRefresh();   -- Clear the refresh request
    --print("OnRefresh() ", 1);
        --local ctx:table = ContextPtr:LookUpControl("/InGame"); -- top panel
        --if ctx ~= nil then
            --print("OnRefresh() ", 2);
            --ctx:RequestRefresh();
        --end
    --print("OnRefresh() ", 3);
    Refresh(selPlayerId, selUnitId);
end

--******************************************************************************
local function OnGUI_MoveDelayTimerEnd()
    --print("OnGUI_MoveDelayTimerEnd ##########################################################" );
    if ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestoreMove() then
        ExposedMembers.MOD_Cheat_Menu_Units.ApplyAutorestoreMovementCheat(selPlayerId, selUnitId);
        UiRefreshUnitPanel();
    end
end

--******************************************************************************
local function OnGUI_ReselectDelayTimerEnd()
    --print("OnGUI_ReselectDelayTimerEnd 1 ##########################################################" );
    restoreSelectionRequested = nil;
    restoreSelectionRequestedBackup = nil;
    --print("OnGUI_ReselectDelayTimerEnd 2 ##########################################################" );
end

--******************************************************************************
local function OnUnitPromotionChanged(player, unitId)
    if player == selPlayerId and unitId == selUnitId and Players[player] ~= nil and Players[player]:IsHuman() then
        if ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestorePromo() then
            ExposedMembers.MOD_Cheat_Menu_Units.OnCheatPromote(selPlayerId, selUnitId);
        end

        if  ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestoreAttack() then
            ExposedMembers.MOD_Cheat_Menu_Units.OnCheatAttack(player, unitId);
            ContextPtr:RequestRefresh(); OnRefresh();
            UiRefreshUnitPanel();
        end

        RequestDelayedMovementCheat();
        --if ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestoreMove() then
        --	ExposedMembers.MOD_Cheat_Menu_Units.OnCheatMovement(player, unitId);
        --	ContextPtr:RequestRefresh(); OnRefresh();
        --end
    end
end

--******************************************************************************
local function OnUnitFlagPointerEntered( playerId:number, unitId:number )
    if playerId == selPlayerId and unitId ~= selUnitId and Players[playerId] ~= nil and Players[playerId]:IsHuman() then
        -- disable autorestore selection if any in case user mouse over flag of another owned unit
        --print(" Restore selection disabled 1 #############");
        restoreSelectionRequestedBackup = restoreSelectionRequested;
        restoreSelectionRequested = nil;
        --print(" Restore selection disabled 2 #############");
    end
end

--******************************************************************************
local function OnUnitFlagPointerExited( playerId:number, unitId:number )
    if playerId == selPlayerId and unitId ~= selUnitId and Players[playerId] ~= nil and Players[playerId]:IsHuman() then
        -- disable autorestore selection if any in case user mouse over flag of another owned unit
        --print(" Restore selection enabled 1 #############");
        restoreSelectionRequested = restoreSelectionRequestedBackup;
        restoreSelectionRequestedBackup = nil;
        --print(" Restore selection enabled 2 #############");
    end
end

--******************************************************************************
local function OnUnitSelectionChanged(playerId, unitId, locationX, locationY, locationZ, isSelected, isEditable)
    --print(" UnitSelectionChanged: ", playerId, unitId, isSelected);
    if isSelected and Players[playerId] ~= nil and Players[playerId]:IsHuman() then
        --print(" Unit selected", unitId);
        selPlayerId = playerId;
        selUnitId = unitId;

        if Players[selPlayerId] ~= nil and Players[selPlayerId]:IsHuman() then
            if ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestorePromo() then
                ExposedMembers.MOD_Cheat_Menu_Units.OnCheatPromote(selPlayerId, selUnitId);
            end

            if ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestoreHealth() then
                ExposedMembers.MOD_Cheat_Menu_Units.OnCheatHeal(selPlayerId, selUnitId);
            end

            if ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestoreMove() then
                ExposedMembers.MOD_Cheat_Menu_Units.OnCheatMovement(selPlayerId, selUnitId, true);
            end

            if ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestoreAttack() then
                ExposedMembers.MOD_Cheat_Menu_Units.OnCheatAttack(selPlayerId, selUnitId, true);
            end
            --ContextPtr:RequestRefresh(); OnRefresh();
        end
        Refresh( selPlayerId, selUnitId );
    elseif not isSelected and Players[playerId] ~= nil and Players[playerId]:IsHuman() then
        --print(" Unit deselected", unitId);
        selPlayerId  = nil;
        selUnitId    = nil;

        if UI and ( UI.GetHeadSelectedUnit() == nil ) then
            Hide();
        end
    
    --TODO: disabled restore unit selection
        --if restoreSelectionRequested ~= nil and unitId == restoreSelectionRequested:GetID() then
            ----print(" UiRestoreSelection ", restoreSelectionRequested:GetID(), restoreSelectionRequested);
            --
            ----UI.DeselectUnitID(UnitID);
            --UI.DeselectAllUnits();
            --UI.DeselectAllCities();
            --UI:SelectUnitID(restoreSelectionRequested:GetID());
            --ExposedMembers.MOD_Cheat_Menu_Units.LookAtPlot(playerId, restoreSelectionRequested:GetID());
            --UiRefreshUnitPanel();
            ----UI:SelectUnit( restoreSelectionRequested );
            ----ContextPtr:RequestRefresh(); OnRefresh();
            ----ExposedMembers.MOD_Cheat_Menu_Units.FinishMoves( playerId, unitId );
            ----restoreSelectionRequested = nil;
        --end
    end
end

--******************************************************************************
-- Cheat_Menu_Units mod
function OnSelectPlot( plotId, plotEdge, boolParam )
    if Controls.GUI_Cheat_Menu_Units_SpawnDlgContainer:IsHidden() then
        return;
    end

    targetPlotId = nil;
    local plot = Map.GetPlotByIndex(plotId);

    if plot ~= nil then
        targetPlotId = plotId;
        
        print(" OnSelectPlot", 1);

        UILens.ClearLayerHexes( UILens.CreateLensLayerHash("Movement_Path") );
        UILens.ClearLayerHexes( UILens.CreateLensLayerHash("Numbers") );
        UILens.ClearLayerHexes( UILens.CreateLensLayerHash("Attack_Range") );
        
        print(" OnSelectPlot", 2);

        -- Obtain ordered list of plots.
        local variations	: table = {};	-- 2 to 3 values
        local pathPlots		: table = {};
        local eLocalPlayer	: number = Game.GetLocalPlayer();

        print(" OnSelectPlot", 3);

        --check for unit position swap first
        local startPlotId :number = plotId;
        local endPlotId   :number = plotId;
        local lensNameBase = "MovementGood";

        if not UILens.IsLensActive(lensNameBase) then
            print(" OnSelectPlot", 4);
            UILens.SetActive(lensNameBase);	
        end

        print(" OnSelectPlot", 5);

        table.insert(pathPlots, startPlotId);
        table.insert(pathPlots, endPlotId);
        table.insert(variations, {lensNameBase.."_Destination",startPlotId} );
        table.insert(variations, {lensNameBase.."_Counter", startPlotId} ); -- show counter pip
                --UI.AddNumberToPath( 1, startPlotId);
        table.insert(variations, {lensNameBase.."_Destination",endPlotId} );
        table.insert(variations, {lensNameBase.."_Counter", endPlotId} ); -- show counter pip
                --UI.AddNumberToPath( 1, endPlotId);
        UILens.SetLayerHexesPath(UILens.CreateLensLayerHash("Movement_Path"), eLocalPlayer, pathPlots, variations);

        print(" OnSelectPlot", 6);
    end
end

--******************************************************************************
function OnButtonStackSizeChanged()
    UpdateComponentPanelSizes( Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:GetSizeX(), Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:GetSizeY() );
end

--**************************************************************************************************************************************************************************************************
-- OTHER
--**************************************************************************************************************************************************************************************************


--******************************************************************************
function Hide( fromRefresh )
    Controls.GUI_Cheat_Menu_Units_Minibar_ExpandAnim:SetToEnd();  -- offset 0
    Controls.GUI_Cheat_Menu_Units_Minibar_CollapseAnim:SetToBeginning();  -- offset 0

    if not Controls.GUI_Cheat_Menu_Units_Minibar_Context:IsHidden() then
        Controls.GUI_Cheat_Menu_Units_Minibar_CollapseAnim:Play();  -- offset 150
    end

    isMinibarClosed = true;
    Controls.GUI_Cheat_Menu_Units_Minibar_Context:SetHide( true );

    HideDup();
    Controls.GUI_Cheat_Menu_Units_Minibar_Context:SetHide( true );
end

--******************************************************************************
function Show()
    Controls.GUI_Cheat_Menu_Units_Minibar_ExpandAnim:SetToEnd(); -- offset 0
    Controls.GUI_Cheat_Menu_Units_Minibar_CollapseAnim:SetToBeginning();  -- offset 0

    if Controls.GUI_Cheat_Menu_Units_Minibar_Context:IsHidden() then
        Controls.GUI_Cheat_Menu_Units_Minibar_ExpandAnim:SetToBeginning();  -- offset -100

        Controls.GUI_Cheat_Menu_Units_Minibar_Context:SetHide( false );
        Controls.GUI_Cheat_Menu_Units_Minibar_ExpandAnim:Play();  -- offset 0
    else
        Controls.GUI_Cheat_Menu_Units_Minibar_Context:SetHide( false );
    end

    isMinibarClosed = false;
    FixUiMode();
end

--******************************************************************************
-- Change interface mode to selection
function FixUiMode()
    local cMode = UI.GetInterfaceMode();

    if Controls.GUI_Cheat_Menu_Units_SpawnDlgContainer:IsHidden() and not Controls.GUI_Cheat_Menu_Units_Minibar_Context:IsHidden() and not isMinibarClosed and cMode ~= InterfaceModeTypes.SELECTION then
        UI.SetInterfaceMode( InterfaceModeTypes.SELECTION );
    elseif not Controls.GUI_Cheat_Menu_Units_SpawnDlgContainer:IsHidden() then
        UI.SetInterfaceMode( InterfaceModeTypes.WB_SELECT_PLOT );
    end
end

--******************************************************************************
function UiRefreshSelection(PlayerID, UnitID)
    -- TODO: restore selection
    return;

    --if UnitID ~= nil then
        --if UnitManager then 
            --unit = UnitManager.GetUnit( PlayerID, UnitID ); 
        --end
        --if unit  and Players[PlayerID] ~= nil and Players[PlayerID]:IsHuman() then
            ----print(" UiRefreshSelection requested", unit);
            ----UI:SelectUnit( unit );
            --restoreSelectionRequestedBackup = nil;
            --restoreSelectionRequested = unit;
            ----UI.DeselectAllCities();
            ----UI.DeselectAllUnits();
--
            ----UI:SelectUnitID(UnitID);
            ----ContextPtr:RequestRefresh(); OnRefresh();
            --UiRefreshUnitPanel();
            ----RequestDelayedReselect();
        --end
    --end 
end

--******************************************************************************
function UiRefreshUnitPanel()
    --UI.DeselectAllCities();
    --UI.DeselectAllUnits();
    if selUnitId ~= nil then
        --print(" UiRefreshUnitPanel 1", selUnitId);
        --UI.DeselectUnitID(selUnitId);
        --UI.SelectUnitID(selUnitId);
        local UPContextPtr :table = ContextPtr:LookUpControl("/InGame/UnitPanel");

        if UPContextPtr ~= nil then
            --print(" UiRefreshUnitPanel 2 ", selUnitId, UPContextPtr);
            UPContextPtr:RequestRefresh(); OnRefresh(); -- Refresh Unit Panel
            --pContext:SetHide(true);
            --pContext:SetHide(false);
            --for k,v in pairs(Events.UnitOperationDeactivated) do print ("Events.OnUnitOperationDeactivated",k,v) end
        end
    end

    ContextPtr:RequestRefresh(); OnRefresh(); -- Refresh Self, i.e. Unit Cheats Panel
end

--******************************************************************************
function UpdateComponentPanelSizes( x, y )
    print( "UpdateComponentPanelSizes()", x, y );
    Controls.GUI_Cheat_Menu_Units_CheatsButton_Container:SetSizeX( x );
    Controls.GUI_Cheat_Menu_Units_CheatsButton_Container:SetSizeY( y );

    Controls.GUI_Cheat_Menu_Units_CheatsButton_Grid:SetSizeX( x + 40 );
    Controls.GUI_Cheat_Menu_Units_CheatsButton_Grid:SetSizeY( y );

    Controls.GUI_Cheat_Menu_Units_CheatsButton_Box:SetSizeX( x );
    Controls.GUI_Cheat_Menu_Units_CheatsButton_Box:SetSizeY( y );

    Controls.GUI_Cheat_Menu_Units_Minibar_Container:SetSizeX( x );
    Controls.GUI_Cheat_Menu_Units_Minibar_Container:SetSizeY( y );
end

--******************************************************************************
-- Refresh GUI unit cheats panel
function Refresh( playerId, unitId )
    Controls.GUI_Cheat_Menu_UnitsButtonCollapse:SetTextureOffsetVal(0,29);
    print( "Refresh()", isMinibarCollapsed );

    if isMinibarCollapsed then
        Controls.GUI_Cheat_Menu_UnitsButtonCollapse:SetHide( true );
        Controls.GUI_Cheat_Menu_UnitsButtonHeal:SetHide( true );
        Controls.GUI_Cheat_Menu_UnitsButtonPromote:SetHide( true );
        Controls.GUI_Cheat_Menu_UnitsButtonAttack:SetHide( true );
        Controls.GUI_Cheat_Menu_UnitsButtonAddMovement:SetHide( true );
        Controls.GUI_Cheat_Menu_UnitsButtonDuplicate:SetHide( true );

        Controls.GUI_Cheat_Menu_UnitsButtonOffset1:SetHide( true );
        Controls.GUI_Cheat_Menu_UnitsButtonOffset2:SetHide( true );
        Controls.GUI_Cheat_Menu_UnitsButtonOffset3:SetHide( true );
        Controls.GUI_Cheat_Menu_UnitsButtonOffset4:SetHide( true );

        Controls.GUI_Cheat_Menu_UnitsButtonRestore:SetHide( false );

        Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:CalculateSize();
        Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:ReprocessAnchoring();

        UpdateComponentPanelSizes( Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:GetSizeX(), Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:GetSizeY() );

        Controls.GUI_Cheat_Menu_Units_Minibar_Container:SetAlpha( 0.6 );
        Controls.GUI_Cheat_Menu_Units_CheatsButton_Box:SetAlpha( 0.0 );
        Controls.GUI_Cheat_Menu_Units_CheatsButton_Grid:SetHide( true );

        Controls.GUI_Cheat_Menu_UnitsButtonRestore:SetAlpha( 0.5 );
    else
        if ExposedMembers.MOD_Cheat_Menu_Units_Initialized ~= nil and ExposedMembers.MOD_Cheat_Menu_Units_Initialized then
            Controls.GUI_Cheat_Menu_UnitsButtonAttack:SetSelected( ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestoreAttack() );
            Controls.GUI_Cheat_Menu_UnitsButtonHeal:SetSelected( ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestoreHealth() );
            Controls.GUI_Cheat_Menu_UnitsButtonAddMovement:SetSelected( ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestoreMove() );
            Controls.GUI_Cheat_Menu_UnitsButtonPromote:SetSelected( ExposedMembers.MOD_Cheat_Menu_Units.GetAutorestorePromo() );
            Controls.GUI_Cheat_Menu_UnitsButtonDuplicate:SetSelected( not Controls.GUI_Cheat_Menu_Units_SpawnDlgContainer:IsHidden() );
        end

        Controls.GUI_Cheat_Menu_UnitsButtonCollapse:SetHide( false );
        Controls.GUI_Cheat_Menu_UnitsButtonHeal:SetHide( false );
        Controls.GUI_Cheat_Menu_UnitsButtonPromote:SetHide( false );
        Controls.GUI_Cheat_Menu_UnitsButtonAttack:SetHide( false );
        Controls.GUI_Cheat_Menu_UnitsButtonAddMovement:SetHide( false );
        Controls.GUI_Cheat_Menu_UnitsButtonDuplicate:SetHide( false );

        Controls.GUI_Cheat_Menu_UnitsButtonOffset1:SetHide( false );
        Controls.GUI_Cheat_Menu_UnitsButtonOffset2:SetHide( false );
        Controls.GUI_Cheat_Menu_UnitsButtonOffset3:SetHide( false );
        Controls.GUI_Cheat_Menu_UnitsButtonOffset4:SetHide( false );

        Controls.GUI_Cheat_Menu_UnitsButtonRestore:SetHide( true );

        
        Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:CalculateSize();
        Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:ReprocessAnchoring();

        UpdateComponentPanelSizes( Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:GetSizeX(), Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:GetSizeY() );

        Controls.GUI_Cheat_Menu_Units_Minibar_Container:SetAlpha( 1 );
        Controls.GUI_Cheat_Menu_Units_CheatsButton_Box:SetAlpha( 1 );

        Controls.GUI_Cheat_Menu_Units_CheatsButton_Grid:SetHide(false);
    end

    if Players and Players[ playerId ] and playerId ~= nil and playerId ~= -1 and unitId ~= nil and unitId ~= -1 then
        local units = Players[playerId]:GetUnits();
        local unit = units:FindID(unitId);

        if unit ~= nil then
            Show();
        else
            Hide(true);
        end

        --print(" OnCheatMovement BASE COUNT -- ", Events.UnitDamageChanged.Count());
        --print(" RefreshGUI BASE 1 -- ", playerId, unitId);
        ----local unit = nil;
        ----if UnitManager then 
            ----unit = UnitManager.GetUnit( playerId, unitId ); 
            ----print(" RefreshGUI BASE 2 -- ", unit);
        ----end
        --if unit ~= nil and Players[playerId]:IsHuman() then
            --local uDamage = unit:GetDamage();
            ----ExposedMembers.MOD_Cheat_Menu_Units.UiRefreshUnitPanel();
            --print(" RefreshGUI BASE 3 -- ", uDamage);
            --Events.UnitDamageChanged(playerId, unitId, uDamage, uDamage);
            --print(" RefreshGUI BASE 4 -- ");
        --end
    else
        Hide( true );
    end
    --if Controls.GUI_Cheat_Menu_Units_Minibar_Context:IsHidden() then
    --	Controls.GUI_Cheat_Menu_Units_Minibar_Context:SetHide( true );
    --	Controls.GUI_Cheat_Menu_Units_Minibar_Context:SetHide( false );
    --end
end

--******************************************************************************
local function GetUnitMoves(playerId, unitId)
    -- local units = Players[selectedPlayerId]:GetUnits();
    -- local unit = units:FindID(unitId);
    local movesRemaining = 0;
    local queuedEndPlotId:number = nil;
    local unit = nil;

    if UnitManager then 
        unit = UnitManager.GetUnit( playerId, unitId ); 
    end

    if unit ~= nil then
        movesRemaining = unit:GetMovesRemaining();
        queuedEndPlotId = UnitManager.GetQueuedDestination( unit );
        --print( "Get Unit Moves From UI ", movesRemaining, unit:GetMovementMovesRemaining() );
    end

    return movesRemaining, queuedEndPlotId;
end

--******************************************************************************
local function LookAtPlot( PlayerID, UnitID )
    if UnitID ~= nil and PlayerID ~= nil then
        if UnitManager then 
            unit = UnitManager.GetUnit( PlayerID, UnitID ); 
        end

        if unit and Players[ PlayerID ] ~= nil and Players[ PlayerID ]:IsHuman() then
            -- Look at unit position
            local plot = Map.GetPlot( unit:GetX(), unit:GetY() );

            if plot ~= nil then
                UI.LookAtPlot( plot );
            end
        end
    end 
end

--******************************************************************************
function RequestDelayedMovementCheat()
    Controls.GUI_MoveDelayTimer:Stop();
    Controls.GUI_MoveDelayTimer:SetToBeginning();
    Controls.GUI_MoveDelayTimer:Play();
end

--******************************************************************************
function RequestDelayedReselect()
    Controls.GUI_ReselectDelayTimer:Stop();
    Controls.GUI_ReselectDelayTimer:SetToBeginning();
    Controls.GUI_ReselectDelayTimer:Play();
end

--**************************************************************************************************************************************************************************************************
-- Create (duplicate) unit dialog
--**************************************************************************************************************************************************************************************************

include( "Cheat_Menu_Units_Minibar_Import_DupDlg" );

--******************************************************************************
-- Init buttons
local function InitializeControls()
    Controls.GUI_Cheat_Menu_UnitsButtonPromote:RegisterCallback( Mouse.eLClick, OnPromote );
    Controls.GUI_Cheat_Menu_UnitsButtonPromote:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);	

    Controls.GUI_Cheat_Menu_UnitsButtonDuplicate:RegisterCallback( Mouse.eLClick, OnDuplicate );
    Controls.GUI_Cheat_Menu_UnitsButtonDuplicate:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
    
    Controls.GUI_Cheat_Menu_UnitsButtonAddMovement:RegisterCallback( Mouse.eLClick, OnMovement );
    Controls.GUI_Cheat_Menu_UnitsButtonAddMovement:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

    Controls.GUI_Cheat_Menu_UnitsButtonHeal:RegisterCallback( Mouse.eLClick, OnHeal );
    Controls.GUI_Cheat_Menu_UnitsButtonHeal:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

    Controls.GUI_Cheat_Menu_UnitsButtonAttack:RegisterCallback( Mouse.eLClick, OnAttack );
    Controls.GUI_Cheat_Menu_UnitsButtonAttack:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

    Controls.GUI_Cheat_Menu_UnitsButtonAttack:RegisterCallback( Mouse.eLClick, OnAttack );
    Controls.GUI_Cheat_Menu_UnitsButtonAttack:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

    Controls.GUI_Cheat_Menu_UnitsButtonCollapse:RegisterCallback( Mouse.eLClick, OnCollapse );
    Controls.GUI_Cheat_Menu_UnitsButtonCollapse:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

    Controls.GUI_Cheat_Menu_UnitsButtonRestore:RegisterCallback( Mouse.eLClick, OnRestore );
    Controls.GUI_Cheat_Menu_UnitsButtonRestore:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

    -- Dialog
    
    --Controls.GUI_Cheat_Menu_Units_UnitsPD:RegisterSelectionCallback( OnUnitTypeSelected );

    --Controls.GUI_Cheat_Menu_Units_PlayersLB:RegisterCallback( Mouse.eLClick, OnAttack );
    --Controls.GUI_Cheat_Menu_Units_PlayersLB:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
    --Controls.GUI_Cheat_Menu_Units_PlayersPD:SetEntrySelectedCallback( OnDlgPlayerSelChanged );

    --Controls.GUI_Cheat_Menu_Units_UnitsLB:RegisterCallback( Mouse.eLClick, OnAttack );
    --Controls.GUI_Cheat_Menu_Units_UnitsLB:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
    
    --Controls.GUI_Cheat_Menu_Units_ShowAll:RegisterCallback( Mouse.eLClick, OnDlgShowAllCB );
    --Controls.GUI_Cheat_Menu_Units_ShowAll:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

    Controls.GUI_Cheat_Menu_Units_SpawnDlgContainerOK:RegisterCallback( Mouse.eLClick, OnDlgOK );
    Controls.GUI_Cheat_Menu_Units_SpawnDlgContainerOK:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

    Controls.GUI_Cheat_Menu_Units_SpawnDlgContainerCANCEL:RegisterCallback( Mouse.eLClick, OnDlgCancel );
    Controls.GUI_Cheat_Menu_Units_SpawnDlgContainerCANCEL:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

    Controls.GUI_MoveDelayTimer:RegisterEndCallback( OnGUI_MoveDelayTimerEnd );
    Controls.GUI_ReselectDelayTimer:RegisterEndCallback( OnGUI_ReselectDelayTimerEnd );
    
    Controls.GUI_Cheat_Menu_Units_Minibar_CollapseAnim:SetToBeginning();  -- offset 0
    Controls.GUI_Cheat_Menu_Units_Minibar_ExpandAnim:SetToEnd(); -- offset 0

    Controls.GUI_Cheat_Menu_Units_Horizontal_Stack:RegisterSizeChanged( OnButtonStackSizeChanged );
end

--******************************************************************************
-- Cheat_Menu_Units mod
local function InitializeCheat_Menu_Units()
    Events.GameCoreEventPublishComplete.Remove( InitializeCheat_Menu_Units );
    ContextPtr:RequestRefresh(); OnRefresh();
end

--************************************************************
-- Callaback of the load game UI event
local function OnLoadGameViewStateDone()
    ContextPtr:RequestRefresh(); OnRefresh();
end

--******************************************************************************
function Initialize()
    print("Unit Cheats UI Initialization started");
    
    InitializeControls();

    ContextPtr:SetRefreshHandler( OnRefresh );
    ContextPtr:SetHide( false );

    --Events.BeginWonderReveal.Add( OnEventHidePanel );
    --Events.DiplomacyMeet.Add( Hide );
    --Events.CitySelectionChanged.Add( OnEventHidePanel );
    
    LuaEvents.EndGameMenu_Shown.Add( Hide );
    LuaEvents.EndGameMenu_Closed.Add( Show );
    LuaEvents.DiplomacyActionView_HideIngameUI.Add( Hide );
    LuaEvents.DiplomacyActionView_ShowIngameUI.Add( Show );
    LuaEvents.WonderRevealPopup_Shown.Add( Hide );
    LuaEvents.WonderRevealPopup_Closed.Add(	Show );
    LuaEvents.NaturalWonderPopup_Shown.Add( Hide );
    LuaEvents.NaturalWonderPopup_Closed.Add( Show );

    Events.PlayerTurnActivated.Add( OnPlayerTurnActivated );
    Events.PlayerTurnDeactivated.Add( OnPlayerTurnDeactivated );

    --Events.UnitOperationDeactivated.Add( OnEventTest );

    Events.GameCoreEventPublishComplete.Add( InitializeCheat_Menu_Units );
    Events.InterfaceModeChanged.Add( OnInterfaceModeChanged );
    Events.PhaseBegin.Add( OnPhaseBegin );
    Events.UnitRemovedFromMap.Add( OnUnitRemovedFromMap );
    Events.UnitSelectionChanged.Add( OnUnitSelectionChanged );
    Events.UnitPromoted.Add( OnUnitPromotionChanged );

    LuaEvents.PlayerChange_Close.Add( OnPlayerChangeClose );
    
    --TODO: disabled restore unit selection
    --LuaEvents.UnitFlagManager_PointerEntered.Add( OnUnitFlagPointerEntered );
    --LuaEvents.UnitFlagManager_PointerExited.Add( OnUnitFlagPointerExited );
    
    LuaEvents.WorldInput_WBSelectPlot.Add( OnSelectPlot );

    ExposedMembers.MOD_Cheat_Menu_Units.GetUnitMovesFromUI = GetUnitMoves;
    ExposedMembers.MOD_Cheat_Menu_Units.UiRefreshSelection = UiRefreshSelection;
    ExposedMembers.MOD_Cheat_Menu_Units.UiRefreshUnitPanel = UiRefreshUnitPanel;
    ExposedMembers.MOD_Cheat_Menu_Units.LookAtPlot = LookAtPlot;
    ExposedMembers.MOD_Cheat_Menu_Units.RequestDelayedMovementCheat = RequestDelayedMovementCheat;

    print("Unit Cheats UI Initialization finished");

    Events.LoadGameViewStateDone.Add( OnLoadGameViewStateDone );
end

Initialize();