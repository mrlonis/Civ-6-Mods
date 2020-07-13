-- Map_Editor_UI
-- Author: Zur13
-- DateCreated: 2/9/2019 9:29:56 PM
-- Last Modified By: mrlonis
-- Last Modified On: 07/12/2020
--------------------------------------------------------------

include( "PopupDialog" );
include( "SupportFunctions" );
-- Shared code between the LoadGameMenu and the SaveGameMenu
include( "LoadSaveMenu_Shared" );

IsBtnAdded = false; -- flag to indicate the button was added to the top panel
local isShown = false;

local isShowBg = false;

selPlotId = nil;

terType = 0;
featType = -1;
resType = -1;
imprType = -1;
routeType = nil;
owner = nil;
elevationType = nil;
contType = nil;
rivId = nil;
resCnt = 1;

local isFixRequired = false;


local EAST = "EAST";
local SEAST = "SEAST";
local SWEST = "SWEST";

local FDIR_EAST = "FDIR_EAST";
local FDIR_SEAST = "FDIR_SEAST";
local FDIR_SWEST = "FDIR_SWEST";

local river = { EAST = nil, SEAST = nil, SWEST = nil, FDIR_EAST = nil, FDIR_SEAST = nil, FDIR_SWEST = nil };

local cliffs = { EAST = false, SEAST = false, SWEST = false };

local RIVER_F_DIR_E = { nil, FlowDirectionTypes.FLOWDIRECTION_NORTH, FlowDirectionTypes.FLOWDIRECTION_SOUTH, FlowDirectionTypes.NO_FLOWDIRECTION };
local RIVER_F_DIR_SE = { nil, FlowDirectionTypes.FLOWDIRECTION_NORTHEAST, FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST, FlowDirectionTypes.NO_FLOWDIRECTION };
local RIVER_F_DIR_SW = { nil, FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST, FlowDirectionTypes.FLOWDIRECTION_NORTHWEST, FlowDirectionTypes.NO_FLOWDIRECTION };

local RIVER_F_DIR_E_IDX = 1;
local RIVER_F_DIR_SE_IDX = 1;
local RIVER_F_DIR_SW_IDX = 1;

local OnInputHandler;
local LateInitialize;

--******************************************************************************
-- is Expansion 2 Gathering Storm active
function IsXP2()
    if ( GameInfo.Units_XP2 ~= nil ) then
        --print("Expansion 2 detected");
        return true;
    end
    --print("Expansion 1/none detected");
    return false;
end

--************************************************************
-- Add the Map_Editor button to the top panel
local function AddButtonToTopPanel()
    if not IsBtnAdded then
        local tPanRightStack:table = ContextPtr:LookUpControl("/InGame/TopPanel/RightContents"); -- top panel right stack where clock civilopedia and menu is
        if tPanRightStack ~= nil then
            Controls.Map_Editor_LaunchBarBtn:ChangeParent(tPanRightStack);

            tPanRightStack:AddChildAtIndex(Controls.Map_Editor_LaunchBarBtn, 3);
            tPanRightStack:CalculateSize();
            tPanRightStack:ReprocessAnchoring();

            IsBtnAdded = true;
        end
    end
end

--************************************************************
-- Add the Map_Editor button to the top panel
local function UnAddButtonToTopPanel()
    if IsBtnAdded then
        local tPanRightStack:table = ContextPtr:LookUpControl("/InGame/TopPanel/RightContents"); -- top panel right stack where clock civilopedia and menu is
        if tPanRightStack ~= nil then
            tPanRightStack:ReleaseChild(Controls.Map_Editor_LaunchBarBtn);
            tPanRightStack:CalculateSize();
            tPanRightStack:ReprocessAnchoring();
            
            Controls.Map_Editor_LaunchBarBtn:ChangeParent(Controls.Map_Editor_LaunchBarBtnCont);

            IsBtnAdded = false;
        end
    end
end

--************************************************************
-- Callaback of the load game UI event
local function OnLoadGameViewStateDone()
    LateInitialize();
    AddButtonToTopPanel();
end

--******************************************************************************
-- Change interface mode to selection
local function FixUiMode( )
    local cMode = UI.GetInterfaceMode();
    if not isShown and cMode ~= InterfaceModeTypes.SELECTION then
        UI.SetInterfaceMode( InterfaceModeTypes.SELECTION );
    elseif isShown then
        UI.SetInterfaceMode( InterfaceModeTypes.SELECTION );
        UI.SetInterfaceMode( InterfaceModeTypes.WB_SELECT_PLOT );
    end
end

--******************************************************************************
-- Change interface mode to selection
local function UpdateWndSizeAndBg( )
    if isShowBg then
        Controls.Map_Editor_DlgContext:ChangeParent(Controls.Map_Editor_DlgContentGridBg);

        Controls.Map_Editor_DlgContentGridBg:SetHide( false );
        Controls.Map_Editor_DlgContentGrid:SetHide( true );
    else
        Controls.Map_Editor_DlgContext:ChangeParent(Controls.Map_Editor_DlgContentGrid);

        Controls.Map_Editor_DlgContentGridBg:SetHide( true );
        Controls.Map_Editor_DlgContentGrid:SetHide( false );
    end

    -- workaround to apply correct size to background grid
    if Controls.Map_Editor_DlgValidationContent:IsHidden() then
        Controls.Map_Editor_DlgValidationContent:SetHide( false );

        Controls.Map_Editor_DlgContext:CalculateSize();
        Controls.Map_Editor_DlgContext:ReprocessAnchoring();
        Controls.Map_Editor_DlgContext:DoAutoSize();

        Controls.Map_Editor_DlgValidationContent:SetHide( true );
    else
        Controls.Map_Editor_DlgValidationContent:SetHide( true );

        Controls.Map_Editor_DlgContext:CalculateSize();
        Controls.Map_Editor_DlgContext:ReprocessAnchoring();
        Controls.Map_Editor_DlgContext:DoAutoSize();

        Controls.Map_Editor_DlgValidationContent:SetHide( false );
    end

end

--******************************************************************************
local function UpdateFixUi()
    --if isFixRequired then 
        --Controls.Map_Editor_FixMeAnim:SetHide( false );
    --else
        --Controls.Map_Editor_FixMeAnim:SetHide( true );
    --end

end

--******************************************************************************
local function HighlightSelection( )
    UILens.ClearLayerHexes( UILens.CreateLensLayerHash("Hex_Coloring_Great_People") );
    if UILens.IsLayerOn( UILens.CreateLensLayerHash("Hex_Coloring_Great_People") ) then
        UILens.ToggleLayerOff( UILens.CreateLensLayerHash("Hex_Coloring_Great_People") );
    end

    if selPlotId ~= nil then
        local activationPlots:table = {};
        local areaHighlightPlots:table = {};
        --print(" HighlightSelection() ", 1, selPlotId);
        table.insert(activationPlots, {"Great_People", selPlotId});
        --print(" HighlightSelection() ", 2, selPlotId);
        UILens.SetLayerHexesArea( UILens.CreateLensLayerHash("Hex_Coloring_Great_People"), Game.GetLocalPlayer(), areaHighlightPlots, activationPlots);
        --print(" HighlightSelection() ", 3, selPlotId);
        UILens.ToggleLayerOn( UILens.CreateLensLayerHash("Hex_Coloring_Great_People") );
        --print(" HighlightSelection() ", 4, selPlotId);
    end
end

--******************************************************************************
function UpdateRiverSelection( plotId, fromBtn )
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then			
            river = {};
            river.EAST = plot:IsWOfRiver();
            river.SEAST = plot:IsNWOfRiver();
            river.SWEST = plot:IsNEOfRiver();

            river.FDIR_EAST =  plot:GetRiverEFlowDirection();
            river.FDIR_SEAST = plot:GetRiverSEFlowDirection();
            river.FDIR_SWEST = plot:GetRiverSWFlowDirection();
            
            RIVER_F_DIR_E_IDX = 1;
            RIVER_F_DIR_SE_IDX = 1;
            RIVER_F_DIR_SW_IDX = 1;

            for idx, v in pairs(RIVER_F_DIR_E) do
                if v == river.FDIR_EAST then
                    RIVER_F_DIR_E_IDX = idx;
                    break;
                end
            end

            for idx, v in pairs(RIVER_F_DIR_SE) do
                if v == river.FDIR_SEAST then
                    RIVER_F_DIR_SE_IDX = idx;
                    break;
                end
            end

            for idx, v in pairs(RIVER_F_DIR_SW) do
                if v == river.FDIR_SWEST then
                    RIVER_F_DIR_SW_IDX = idx;
                    break;
                end
            end
            if not river.EAST then
                RIVER_F_DIR_E_IDX = 1;
            end
            if not river.SEAST then
                RIVER_F_DIR_SE_IDX = 1;
            end
            if not river.SWEST then
                RIVER_F_DIR_SW_IDX = 1;
            end
            --print("River --------- ---", river.EAST, river.SEAST, river.SWEST, river.FDIR_EAST, river.FDIR_SEAST, river.FDIR_SWEST );
        end
    else
        if fromBtn == nil or fromBtn == false then
            river = {};
            river.EAST = nil;
            river.SEAST = nil;
            river.SWEST = nil;

            RIVER_F_DIR_E_IDX = 1;
            RIVER_F_DIR_SE_IDX = 1;
            RIVER_F_DIR_SW_IDX = 1;
        end
    end

    --if river.FDIR_EAST ~= -1 and river.FDIR_EAST ~= RIVER_F_DIR_E[RIVER_F_DIR_E_IDX] then
        --print("Flow Direction East Not matched: ", river.FDIR_EAST, RIVER_F_DIR_E[RIVER_F_DIR_E_IDX]);
    --end
--
    --if river.FDIR_SEAST ~= -1 and river.FDIR_SEAST ~= RIVER_F_DIR_SE[RIVER_F_DIR_SE_IDX] then
        --print("Flow Direction S East Not matched: ", river.FDIR_SEAST, RIVER_F_DIR_SE[RIVER_F_DIR_SE_IDX]);
    --end
--
    --if river.FDIR_SWEST ~= -1 and river.FDIR_SWEST ~= RIVER_F_DIR_SW[RIVER_F_DIR_SW_IDX] then
        --print("Flow Direction S WEST Not matched: ", river.FDIR_SWEST, RIVER_F_DIR_SW[RIVER_F_DIR_SW_IDX]);
    --end
        river.FDIR_EAST = RIVER_F_DIR_E[RIVER_F_DIR_E_IDX];
        river.FDIR_SEAST = RIVER_F_DIR_SE[RIVER_F_DIR_SE_IDX];
        river.FDIR_SWEST = RIVER_F_DIR_SW[RIVER_F_DIR_SW_IDX];

        if river.FDIR_EAST ~= nil then
            river.EAST = true;
        else
            river.EAST = false;
        end

        if river.FDIR_SEAST ~= nil then
            river.SEAST = true;
        else
            river.SEAST = false;
        end

        if river.FDIR_SWEST ~= nil then
            river.SWEST = true;
        else
            river.SWEST = false;
        end

    --print("River update UI ---", river.EAST, river.SEAST, river.SWEST, river.FDIR_EAST, river.FDIR_SEAST, river.FDIR_SWEST );
        
--local RIVER_F_DIR_E = { nil, FlowDirectionTypes.FLOWDIRECTION_NORTH, FlowDirectionTypes.FLOWDIRECTION_SOUTH };
--local RIVER_F_DIR_SE = { nil, FlowDirectionTypes.FLOWDIRECTION_NORTHEAST, FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST };
--local RIVER_F_DIR_SW = { nil, FlowDirectionTypes.FLOWDIRECTION_NORTHWEST, FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST };

    Controls.Map_Editor_RiverHexEBG:SetHide( false );
    Controls.Map_Editor_RiverHexED0:SetHide( true );
    Controls.Map_Editor_RiverHexED1:SetHide( true );
    Controls.Map_Editor_RiverHexED2:SetHide( true );
    if river.EAST == true then
        if river.FDIR_EAST == FlowDirectionTypes.FLOWDIRECTION_NORTH then
            Controls.Map_Editor_RiverHexED1:SetHide( false );
        elseif river.FDIR_EAST == FlowDirectionTypes.NO_FLOWDIRECTION then
            Controls.Map_Editor_RiverHexED0:SetHide( false );
        else
            Controls.Map_Editor_RiverHexED2:SetHide( false );
        end
        Controls.Map_Editor_RiverHexEBG:SetHide( true );
        --print("River EAST show FLOWDIRECTION_NORTH", river.EAST, river.FDIR_EAST, FlowDirectionTypes.FLOWDIRECTION_NORTH );
        --print("River EAST show FLOWDIRECTION_SOUTH", river.EAST, river.FDIR_EAST, FlowDirectionTypes.FLOWDIRECTION_SOUTH );
    end

    Controls.Map_Editor_RiverHexSEBG:SetHide( false );
    Controls.Map_Editor_RiverHexSED0:SetHide( true );
    Controls.Map_Editor_RiverHexSED1:SetHide( true );
    Controls.Map_Editor_RiverHexSED2:SetHide( true );
    if river.SEAST == true then
        if river.FDIR_SEAST == FlowDirectionTypes.FLOWDIRECTION_NORTHEAST then
            Controls.Map_Editor_RiverHexSED1:SetHide( false );
        elseif river.FDIR_SEAST == FlowDirectionTypes.NO_FLOWDIRECTION then
            Controls.Map_Editor_RiverHexSED0:SetHide( false );
        else
            Controls.Map_Editor_RiverHexSED2:SetHide( false );
        end
        Controls.Map_Editor_RiverHexSEBG:SetHide( true );
        --print("River SEAST show FLOWDIRECTION_NORTHEAST", river.SEAST, river.FDIR_SEAST, FlowDirectionTypes.FLOWDIRECTION_NORTHEAST );
        --print("River SEAST show FLOWDIRECTION_SOUTHWEST", river.SEAST, river.FDIR_SEAST, FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST );
    end

    Controls.Map_Editor_RiverHexSWBG:SetHide( false );
    Controls.Map_Editor_RiverHexSWD0:SetHide( true );
    Controls.Map_Editor_RiverHexSWD1:SetHide( true );
    Controls.Map_Editor_RiverHexSWD2:SetHide( true );
    if river.SWEST == true then
        if river.FDIR_SWEST == FlowDirectionTypes.FLOWDIRECTION_NORTHWEST then
            Controls.Map_Editor_RiverHexSWD1:SetHide( false );
        elseif river.FDIR_SWEST == FlowDirectionTypes.NO_FLOWDIRECTION then
            Controls.Map_Editor_RiverHexSWD0:SetHide( false );
        else
            Controls.Map_Editor_RiverHexSWD2:SetHide( false );
        end
        Controls.Map_Editor_RiverHexSWBG:SetHide( true );
        --print("River SWEST show FLOWDIRECTION_NORTHWEST", river.SWEST, river.FDIR_SWEST, FlowDirectionTypes.FLOWDIRECTION_NORTHWEST);
        --print("River SWEST show FLOWDIRECTION_SOUTHEAST", river.SWEST, river.FDIR_SWEST, FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST);
    end
    
    --if	Controls.Map_Editor_CBRiverUnch:IsChecked() then
        --river = nil;
    --end

end

--******************************************************************************
function UpdateCliffsSelection( plotId, fromBtn )
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then			
            if fromBtn == nil or fromBtn == false then
                cliffs.EAST = plot:IsWOfCliff();
                cliffs.SEAST = plot:IsNWOfCliff();
                cliffs.SWEST = plot:IsNEOfCliff();
            end
        end
    else
        if fromBtn == nil or fromBtn == false then
            cliffs.EAST = false;
            cliffs.SEAST = false;
            cliffs.SWEST = false;
        end
    end


    --print("cliffs update UI ---", cliffs.EAST, cliffs.SEAST, cliffs.SWEST );

    if cliffs.EAST == true then
        Controls.Map_Editor_CliffHexEBG:SetHide( false );
        Controls.Map_Editor_CliffHexE:SetHide( false );
    else
        Controls.Map_Editor_CliffHexEBG:SetHide( false );
        Controls.Map_Editor_CliffHexE:SetHide( true );
    end

    if cliffs.SEAST == true then
        Controls.Map_Editor_CliffHexSEBG:SetHide( false );
        Controls.Map_Editor_CliffHexSE:SetHide( false );
    else
        Controls.Map_Editor_CliffHexSEBG:SetHide( false );
        Controls.Map_Editor_CliffHexSE:SetHide( true );
    end

    if cliffs.SWEST == true then
        Controls.Map_Editor_CliffHexSWBG:SetHide( false );
        Controls.Map_Editor_CliffHexSW:SetHide( false );
    else
        Controls.Map_Editor_CliffHexSWBG:SetHide( false );
        Controls.Map_Editor_CliffHexSW:SetHide( true );
    end
end

include( "Map_Editor_UI_Pulldowns" );

--******************************************************************************
local function HideDlg()
    Controls.Map_Editor_DlgContainer:SetHide( true );

    FixUiMode();
    UILens.ClearLayerHexes( UILens.CreateLensLayerHash("Hex_Coloring_Great_People") );
    if UILens.IsLayerOn( UILens.CreateLensLayerHash("Hex_Coloring_Great_People") ) then
        UILens.ToggleLayerOff( UILens.CreateLensLayerHash("Hex_Coloring_Great_People") );
    end

end

--******************************************************************************
local function ShowDlg()
    if Controls.Map_Editor_DlgContainer:IsHidden() then
        Controls.Map_Editor_DlgContainer:SetHide( false );
    end

    FixUiMode();

    UpdateCBAll(); -- !!! requires pulldown import
    UpdateCBSelection( selPlotId ); -- !!! requires pulldown import

    HighlightSelection();
    UpdateWndSizeAndBg( );
end

--************************************************************
-- Callaback of the RMT top UI button click
local function OnTopBtnClick()
    if isShown then
        isShown = false;
        HideDlg();
    else
        isShown = true;
        ShowDlg();
    end
    
end

--******************************************************************************
local function ShowConfirmDeleteDialog()
    local popup = PopupDialogInGame:new( "ModPopup" );
    popup:ShowYesNoDialog( Locale.Lookup("LOC_MAP_EDITOR_POPUP_SHOW_CONFIRM_DELETE_DIALOG"), function() ExposedMembers.MOD_Map_Editor.DeleteUnits(selPlotId);  end, function() end);
end

--******************************************************************************
local function OnInterfaceModeChanged( eOldMode:number, eNewMode:number )
    if not isShown then
        return;
    end
    
    if isShown and eNewMode ~= InterfaceModeTypes.WB_SELECT_PLOT then
        OnTopBtnClick();
    end
end

--******************************************************************************
OnInputHandler = function ( pInputStruct:table )
    --print("OnInput ## ", 1 );
    local msg = pInputStruct:GetMessageType();
    --if isShown and btnClick == false then 
        --local msg = pInputStruct:GetMessageType();
        --if msg == MouseEvents.LButtonUp then
            --oldTargetPlotId = targetPlotId;
            --targetPlotId = UI.GetCursorPlotID();
            --print("OnInput ## LButtonUp", pInputStruct:GetX(), pInputStruct:GetY(), oldTargetPlotId, targetPlotId);
            ----CollectData();
            --HighlightMapHexes();
        --end
    --end
    --if btnClick == true then 
        --print("OnInput ## LButtonUp Ignoring Btn Click", targetPlotId);
        ---- ignore click on mod panel btn
        --btnClick = false;
    --end

    --hotkeys
    if msg == KeyEvents.KeyUp then
        --print("OnInput ## KeyUp", 1, isShown, pInputStruct );
        local key = pInputStruct:GetKey();
        if isShown and key == Keys.VK_ESCAPE then
            --print("OnInput ## KeyUp", 2 );
            OnTopBtnClick();
            return true;
        end
        -- Keys.VK_4 ???
        if key == Keys.M  and pInputStruct:IsAltDown() and not pInputStruct:IsShiftDown() and not pInputStruct:IsControlDown() then
            -- 31 == keyboard key [4]
            OnTopBtnClick();
            return true;
        end
        --for i, k in pairs(Keys) do
        --	print(" Key: ", i, k);
        --end
    end


    return false;
end

--******************************************************************************
local function UpdateReasonsMain( terReason, feaReason, resReason, impReason )
    local terReason1 = Locale.Lookup("LOC_MAP_EDITOR_TER_REASON");
    local feaReason1 = Locale.Lookup("LOC_MAP_EDITOR_FEA_REASON");
    local resReason1 = Locale.Lookup("LOC_MAP_EDITOR_RES_REASON");
    local impReason1 = Locale.Lookup("LOC_MAP_EDITOR_IMP_REASON");

    local locOK = Locale.Lookup("LOC_MAP_EDITOR_VALID_OK");
    local colorOk = "[COLOR_GREEN]";
    local colorEr = "[COLOR_RED]";
    local colorEn = "[ENDCOLOR]";

    if terReason ~= nil and terReason ~= "" then
        terReason1 = terReason1 .. " " .. colorEr .. Locale.Lookup(terReason) .. colorEn;
    else
        terReason1 = terReason1 .. colorOk .. locOK .. colorEn;
    end

    if feaReason ~= nil and feaReason ~= "" then
        feaReason1 = feaReason1 .. " " .. colorEr .. Locale.Lookup(feaReason) .. colorEn;
    else
        feaReason1 = feaReason1 .. colorOk .. locOK .. colorEn;
    end
    
    if resReason ~= nil and resReason ~= "" then
        resReason1 = resReason1 .. " " .. colorEr .. Locale.Lookup(resReason) .. colorEn;
    else
        resReason1 = resReason1 .. colorOk .. locOK .. colorEn;
    end

    if impReason ~= nil and impReason ~= "" then
        impReason1 = impReason1 .. " " .. colorEr .. Locale.Lookup(impReason) .. colorEn;
    else
        impReason1 = impReason1 .. colorOk .. locOK .. colorEn;
    end

    Controls.Map_Editor_ValidLbl1:SetText(terReason1);
    Controls.Map_Editor_ValidLbl2:SetText(feaReason1);
    Controls.Map_Editor_ValidLbl3:SetText(resReason1);
    Controls.Map_Editor_ValidLbl4:SetText(impReason1);

    --Controls.Map_Editor_ValidLbl3:SetHide(false);
    --Controls.Map_Editor_ValidLbl4:SetHide(false);

    Controls.Map_Editor_ValidLbl5:SetHide(true);
    Controls.Map_Editor_ValidLbl6:SetHide(true);

    UpdateWndSizeAndBg( );
end

--******************************************************************************
local function UpdateReasonsRiver( rivReason )
    local rivReason1 = Locale.Lookup("LOC_MAP_EDITOR_RIV_REASON1");
    local rivReason2 = Locale.Lookup("LOC_MAP_EDITOR_RIV_REASON2");
    local rivReason3 = Locale.Lookup("LOC_MAP_EDITOR_RIV_REASON3");

    local NC = Locale.Lookup("LOC_MAP_EDITOR_NC");
    local locOK = Locale.Lookup("LOC_MAP_EDITOR_VALID_OK");
    local colorOk = "[COLOR_GREEN]";
    local colorEr = "[COLOR_RED]";
    local colorEn = "[ENDCOLOR]";

    if rivReason ~= nil then
        --rivReasonRem = rivReasonRem .. colorEr .. rivReason .. colorEn;
        if rivReason.EAST ~= nil and rivReason.EAST ~= "" then
            rivReason1 = rivReason1 .. " " .. colorEr .. Locale.Lookup(rivReason.EAST) .. colorEn;
        else
            rivReason1 = rivReason1 .. colorOk .. locOK .. colorEn;
        end

        if rivReason.SEAST ~= nil and rivReason.SEAST ~= "" then
            rivReason2 = rivReason2 .. " " .. colorEr .. Locale.Lookup(rivReason.SEAST) .. colorEn;
        else
            rivReason2 = rivReason2 .. colorOk .. locOK .. colorEn;
        end

        if rivReason.SWEST ~= nil and rivReason.SWEST ~= "" then
            rivReason3 = rivReason3 .. " " .. colorEr .. Locale.Lookup(rivReason.SWEST) .. colorEn;
        else
            rivReason3 = rivReason3 .. colorOk .. locOK .. colorEn;
        end
    elseif rivReason == nil then
        rivReason1 = rivReason1 .. colorOk .. NC .. colorEn;
        rivReason2 = rivReason2 .. colorOk .. NC .. colorEn;
        rivReason3 = rivReason3 .. colorOk .. NC .. colorEn;
    else
        rivReasonRem = rivReasonRem .. colorOk .. locOK .. colorEn;
    end

    Controls.Map_Editor_ValidLbl1:SetText( rivReason1 );
    Controls.Map_Editor_ValidLbl2:SetText( rivReason2 );
    Controls.Map_Editor_ValidLbl3:SetText( rivReason3 );

    --Controls.Map_Editor_ValidLbl3:SetHide(true);
    Controls.Map_Editor_ValidLbl4:SetHide(true);
    Controls.Map_Editor_ValidLbl5:SetHide(true);
    Controls.Map_Editor_ValidLbl6:SetHide(true);

    UpdateWndSizeAndBg( );
end

--******************************************************************************
local function UpdateReasonsCliff( cliReason )
    local clifReason1 = Locale.Lookup("LOC_MAP_EDITOR_CLIF_REASON1");
    local clifReason2 = Locale.Lookup("LOC_MAP_EDITOR_CLIF_REASON2");
    local clifReason3 = Locale.Lookup("LOC_MAP_EDITOR_CLIF_REASON3");

    local NC = Locale.Lookup("LOC_MAP_EDITOR_NC");
    local locOK = Locale.Lookup("LOC_MAP_EDITOR_VALID_OK");
    local colorOk = "[COLOR_GREEN]";
    local colorEr = "[COLOR_RED]";
    local colorEn = "[ENDCOLOR]";


    if cliReason ~= nil and cliReason ~= "" then
        if cliReason.EAST ~= nil and cliReason.EAST ~= "" then
            clifReason1 = clifReason1 .. " " .. colorEr .. Locale.Lookup(cliReason.EAST) .. colorEn;
        else
            clifReason1 = clifReason1 .. colorOk .. locOK .. colorEn;
        end

        if cliReason.SEAST ~= nil and cliReason.SEAST ~= "" then
            clifReason2 = clifReason2 .. " " .. colorEr .. Locale.Lookup(cliReason.SEAST) .. colorEn;
        else
            clifReason2 = clifReason2 .. colorOk .. locOK .. colorEn;
        end

        if cliReason.SWEST ~= nil and cliReason.SWEST ~= "" then
            clifReason3 = clifReason3 .. " " .. colorEr .. Locale.Lookup(cliReason.SWEST) .. colorEn;
        else
            clifReason3 = clifReason3 .. colorOk .. locOK .. colorEn;
        end
    else
        clifReason1 = clifReason1 .. colorOk .. NC .. colorEn;
        clifReason2 = clifReason2 .. colorOk .. NC .. colorEn;
        clifReason3 = clifReason3 .. colorOk .. NC .. colorEn;
    end

    Controls.Map_Editor_ValidLbl1:SetText( clifReason1 );
    Controls.Map_Editor_ValidLbl2:SetText( clifReason2 );
    Controls.Map_Editor_ValidLbl3:SetText( clifReason3 );

    --Controls.Map_Editor_ValidLbl3:SetHide(true);
    Controls.Map_Editor_ValidLbl4:SetHide(true);
    Controls.Map_Editor_ValidLbl5:SetHide(true);
    Controls.Map_Editor_ValidLbl6:SetHide(true);

    UpdateWndSizeAndBg( );
end

--******************************************************************************
local function RequestDelayedNMProcess( )
    
    Controls.Map_Editor_PendingNWMetaTimer:SetPauseTime(3);
    Controls.Map_Editor_PendingNWMetaTimer:SetToBeginning();
    Controls.Map_Editor_PendingNWMetaTimer:Play();
    print("Requested pending timer ####");
end

--******************************************************************************
local function ApplyChanges( isAutoApply )
    
    local res = false;
    
    local safeMod = Controls.Map_Editor_CBSafeMode:IsChecked();
    local safeAdvMod = Controls.Map_Editor_CBSafeAdvMode:IsChecked();

    if not Controls.Map_Editor_StackTerrainBody:IsHidden() then
        local terReason = "";
        local feaReason = "";
        local resReason = "";
        local impReason = "";

        resCnt = tonumber(Controls.Map_Editor_EBResValue:GetText() or 1);

        local ownerReason = ExposedMembers.MOD_Map_Editor.ChangePlotOwner(selPlotId, owner, safeMod, safeAdvMod ); 

        res, terReason, feaReason, resReason, impReason = ExposedMembers.MOD_Map_Editor.ChangePlot(selPlotId, terType, featType, resType, resCnt, imprType, routeType, owner, elevationType, contType, safeMod, safeAdvMod ); 
        --print( "Reasons 3: ", terReason, feaReason, resReason, impReason );

        UpdateReasonsMain( terReason, feaReason, resReason, impReason );

        --print("Apply", 1);
        --FindNWondersOnMap( selPlotId );
        --print("Apply", 2);
        --FindNWonders();
        --print("Apply", 3);
        --UpdateFeaWonderExistMark();
        --print("Apply", 4);
        UpdateNWondersOnPendingPlots();
        table.insert(plotsPendingForNWUpdate, selPlotId);
        RequestDelayedNMProcess( );
    elseif not Controls.Map_Editor_StackRiverBody:IsHidden() then
        local riverNum				:number = -99;
        if IsXP2() then
            riverNum = RiverManager.GetNumRivers();
        end

        local river1 = river;
        if	Controls.Map_Editor_CBRiverUnch:IsChecked() then
            river1 = nil;
        end
            
        cliffs1 = nil;

        local rivReason = "";
        local cliReason = "";

        local resRivAdd = false;
        resRivAdd, rivReason = ExposedMembers.MOD_Map_Editor.ChangePlotRiver(selPlotId, river1, rivId, safeMod, safeAdvMod );
        res = res or resRivAdd;
        print("Apply River Changes ###### ", resRivAdd, rivReason, rivId );

        UpdateReasonsRiver( rivReason );

        if rivId == riverNum then
            -- new river was created
            UpdateCBRivers( riverNum );
        end

    elseif not Controls.Map_Editor_StackCliBody:IsHidden() then
        local river1 = river;
        river1 = nil;
            
        local cliffs1 = cliffs;
        if	Controls.Map_Editor_CBCliffUnch:IsChecked() then
            cliffs1 = nil;
        end

        local rivReason = "";
        local cliReason = "";

        local resRivAdd = false;
        --res = res or resRivAdd;

        local resCli;
        resCli, cliReason = ExposedMembers.MOD_Map_Editor.ChangePlotCliff(selPlotId, cliffs1, safeMod, safeAdvMod ); 
        print("Apply Cli Changes ###### ", resCli, cliReason );
        res = res or resCli; 

        UpdateReasonsCliff( cliReason );
    end

    isFixRequired = isFixRequired or res;
    UpdateFixUi();
    
    if not isAutoApply then
        --UpdateCliffsSelection( selPlotId );
        --UpdateRiverSelection( selPlotId, true );
    end;
end

--******************************************************************************
local function OnSelectPlot(plotId, plotEdge, boolParam)
    if not isShown then
        return;
    end
    --print(" Selected plot: ", 1, plotId, Game.GetLocalPlayer() );
    
    local plot = Map.GetPlotByIndex(plotId);
    if plot ~= nil then
        selPlotId = plotId;

        HighlightSelection();

        if not Controls.Map_Editor_CBPaintMode:IsChecked() then
            UpdateCBSelection(plotId);

            --print(" Selected plot (res copy): ", 2, plotId, terType, featType, resType, imprType, routeType);
        else
            ApplyChanges( true );
        end
    end
    --print(" Selected plot: ", 4, plotId);
end

--************************************************************
function OnInit(isReload:boolean)
    if isReload then
        AddButtonToTopPanel();
        

        --ContextPtr:SetInputHandler( OnInputHandler, true );
            --local tPan:table = ContextPtr:LookUpControl("/InGame/TopOptionsMenu"); -- top panel
            --if tPan ~= nil and tPan.SetInputHandler ~= nil then
                --print( " ################ Registered Input handler" );
                --tPan:SetInputHandler( OnInputHandler, true );
            --end
    end
end

--************************************************************
function OnShutdown()
    UnAddButtonToTopPanel();
end

--************************************************************
function OnSaveComplete()
    Events.SaveComplete.Remove( OnSaveComplete );

    local defaultFileName = "Map_Editor Mod Autosave";
    local gameFile = {};
    gameFile.Name = defaultFileName;
    if(g_ShowCloudSaves) then
        gameFile.Location = UI.GetDefaultCloudSaveLocation();
    else
        gameFile.Location = SaveLocations.LOCAL_STORAGE;
        -- If it is a WorldBuilder map, allow for a specific path.
        if g_GameType == SaveTypes.WORLDBUILDER_MAP then
            gameFile.Path = g_CurrentDirectoryPath .. "/" .. gameFile.Name ;
        end
    end
    gameFile.Type = g_GameType;
    gameFile.FileType = g_FileType;

    Network.LeaveGame();
    Network.LoadGame(gameFile, ServerType.SERVER_TYPE_NONE); -- single player only
end

--************************************************************
function SaveLoad()
    local defaultFileName = "Map_Editor Mod Autosave";
    local gameFile = {};
    gameFile.Name = defaultFileName;
    if(g_ShowCloudSaves) then
        gameFile.Location = UI.GetDefaultCloudSaveLocation();
    else
        gameFile.Location = SaveLocations.LOCAL_STORAGE;
        -- If it is a WorldBuilder map, allow for a specific path.
        if g_GameType == SaveTypes.WORLDBUILDER_MAP then
            gameFile.Path = g_CurrentDirectoryPath .. "/" .. gameFile.Name ;
        end
    end
    gameFile.Type = g_GameType;
    gameFile.FileType = g_FileType;
    --UIManager:SetUICursor( 1 );

    -- Saves are not immediate, wait for the completion event.
    Events.SaveComplete.Add( OnSaveComplete );

    Network.SaveGame(gameFile);
    --UIManager:SetUICursor( 0 );
    UI.PlaySound("Confirm_Bed_Positive");
end

--************************************************************
LateInitialize = function ()
    print( " ################ Start Initializing Mod Map_Editor UI Script... ################ " );
    
    Events.InterfaceModeChanged.Add( OnInterfaceModeChanged );

    LuaEvents.WorldInput_WBSelectPlot.Add( OnSelectPlot );
    Controls.Map_Editor_LaunchBarBtnTimer:RegisterEndCallback( OnTopBtnClick );
    Controls.Map_Editor_LaunchBarBtn:RegisterCallback( Mouse.eLClick, function() Controls.Map_Editor_LaunchBarBtnTimer:SetToBeginning(); Controls.Map_Editor_LaunchBarBtnTimer:Play(); end );
    
    Controls.Map_Editor_BtnTabRiv:RegisterCallback( Mouse.eLClick, function() 
            Controls.Map_Editor_StackTerrainBody:SetHide( true );
            Controls.Map_Editor_StackRiverBody:SetHide( false );
            Controls.Map_Editor_StackCliBody:SetHide( true );
            UpdateWndSizeAndBg( );
        end 
    );
    Controls.Map_Editor_BtnTabRiv:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
    
    Controls.Map_Editor_BtnTabCliff:RegisterCallback( Mouse.eLClick, function() 
            Controls.Map_Editor_StackTerrainBody:SetHide( true );
            Controls.Map_Editor_StackRiverBody:SetHide( true );
            Controls.Map_Editor_StackCliBody:SetHide( false );

            UpdateWndSizeAndBg( );
        end 
    );
    Controls.Map_Editor_BtnTabCliff:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnTabTer:RegisterCallback( Mouse.eLClick, function() 
            Controls.Map_Editor_StackTerrainBody:SetHide( false );
            Controls.Map_Editor_StackRiverBody:SetHide( true );
            Controls.Map_Editor_StackCliBody:SetHide( true );
            
            UpdateWndSizeAndBg( );
        end 
    );
    Controls.Map_Editor_BtnTabTer:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_PendingNWMetaTimer:RegisterEndCallback(UpdateNWondersOnPendingPlots);
    --Controls.Map_Editor_PDFeature:GetButton():RegisterCallback(	Mouse.eMouseEnter,	function() UpdateNWondersOnPendingPlots(); end);
    --Controls.Map_Editor_PDFeature:RegisterCallback(	Mouse.eMouseEnter,	function() UpdateNWondersOnPendingPlots(); end);

    -- FIX GAME DATA BTN ----------------------------------------------------------------------------------
    Controls.Map_Editor_Fix:RegisterCallback( Mouse.eLClick, function() 
            local safeMod = Controls.Map_Editor_CBSafeMode:IsChecked();
            local safeAdvMod = Controls.Map_Editor_CBSafeAdvMode:IsChecked();
            
            ExposedMembers.MOD_Map_Editor.FixAreaData(); 

            if not safeAdvMod then
                local popup = PopupDialogInGame:new( "ModPopup" );
                popup:ShowYesNoDialog( Locale.Lookup("LOC_MAP_EDITOR_POPUP_Map_Editor_FIX"), 
                        function() 
                            print(" $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ Fix game data unsafe");
                            ExposedMembers.MOD_Map_Editor.FixGameData(); 
                        end, 
                        function() 
                        end);
            end
            isFixRequired = false;
            UpdateFixUi();
        end 
    );
    Controls.Map_Editor_Fix:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_OK:RegisterCallback( Mouse.eLClick, function() 
            ApplyChanges( false );
        end 
    );
    Controls.Map_Editor_OK:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_CANCEL:RegisterCallback( Mouse.eLClick, function() UpdateCBSelection( selPlotId ); end );
    Controls.Map_Editor_CANCEL:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
    
    Controls.Map_Editor_Unch:RegisterCallback( Mouse.eLClick, function() UpdateCBSelection( nil ); end );
    Controls.Map_Editor_Unch:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRiverE:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click River E "); 
            RIVER_F_DIR_E_IDX = RIVER_F_DIR_E_IDX + 1;
            if RIVER_F_DIR_E_IDX > #RIVER_F_DIR_E then
                RIVER_F_DIR_E_IDX = 1;
            end
            UpdateRiverSelection( nil, true );
        end 
    );
    Controls.Map_Editor_BtnRiverE:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRiverSE:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click River SE "); 
            RIVER_F_DIR_SE_IDX = RIVER_F_DIR_SE_IDX + 1;
            if RIVER_F_DIR_SE_IDX > #RIVER_F_DIR_SE then
                RIVER_F_DIR_SE_IDX = 1;
            end
            UpdateRiverSelection( nil, true );
        end 
    );
    Controls.Map_Editor_BtnRiverSE:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRiverSW:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click River SW "); 
            RIVER_F_DIR_SW_IDX = RIVER_F_DIR_SW_IDX + 1;
            if RIVER_F_DIR_SW_IDX > #RIVER_F_DIR_SW then
                RIVER_F_DIR_SW_IDX = 1;
            end
            UpdateRiverSelection( nil, true );
        end 
    );
    Controls.Map_Editor_BtnRiverSW:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    
    
    Controls.Map_Editor_BtnCliffE:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click Cliff E "); 
            cliffs.EAST = not cliffs.EAST;
            UpdateCliffsSelection( nil, true );
        end 
    );
    Controls.Map_Editor_BtnCliffE:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnCliffSE:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click Cliff SE "); 
            cliffs.SEAST = not cliffs.SEAST;
            UpdateCliffsSelection( nil, true );
        end 
    );
    Controls.Map_Editor_BtnCliffSE:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnCliffSW:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click Cliff SW "); 
            cliffs.SWEST = not cliffs.SWEST ;
            UpdateCliffsSelection( nil, true );
        end 
    );
    Controls.Map_Editor_BtnRiverSW:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
    
    Controls.Map_Editor_RemoveUnits:RegisterCallback( Mouse.eLClick, function() ShowConfirmDeleteDialog(); end );
    Controls.Map_Editor_RemoveUnits:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    
    Controls.Map_Editor_BtnResValueLeft:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click Cliff SW "); 
            resCnt = tonumber(Controls.Map_Editor_EBResValue:GetText() or 1);
            if resCnt > 0 then
                resCnt = resCnt - 1;
            else
                resCnt = 0;
            end
            Controls.Map_Editor_EBResValue:SetText(tostring(resCnt));
        end 
    );
    Controls.Map_Editor_BtnResValueRight:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click Cliff SW "); 
            resCnt = tonumber(Controls.Map_Editor_EBResValue:GetText() or 1);
            if resCnt < 99 then
                resCnt = resCnt + 1;
            else
                resCnt = 99;
            end
            Controls.Map_Editor_EBResValue:SetText(tostring(resCnt));
        end 
    );
    
    Controls.Map_Editor_CBSafeAdvMode:RegisterCallback(	Mouse.eLClick, function() 
            local newVal = Controls.Map_Editor_CBSafeAdvMode:IsChecked();
            print(" Click CBSafeAdvMode", newVal); 
            if not newVal then
                -- deselected
                local popup = PopupDialogInGame:new( "ModPopup" );
                popup:ShowYesNoDialog( Locale.Lookup("LOC_MAP_EDITOR_POPUP_Map_Editor_CB_SAFE_ADV_MODE"), function() Controls.Map_Editor_Fix:SetHide( false ); end, function() Controls.Map_Editor_CBSafeAdvMode:SetCheck(true); end);
            else
                --Controls.Map_Editor_Fix:SetHide( true );
            end
        end 
    );

    if GameConfiguration.IsAnyMultiplayer() then
        Controls.Map_Editor_ShowStatus:SetHide( true );
    end
    Controls.Map_Editor_ShowStatus:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click Cliff SW "); 
            --if Controls.Map_Editor_DlgValidationContent:IsHidden() then
                --Controls.Map_Editor_DlgValidationContent:SetHide( false );
            --else
                --Controls.Map_Editor_DlgValidationContent:SetHide( true );
            --end
            SaveLoad();
            
        end 
    );

    Controls.Map_Editor_CBBg:RegisterCallback( Mouse.eLClick, function() 
            --print(" Click Cliff SW "); 
            if Controls.Map_Editor_CBBg:IsChecked() then
                isShowBg = true;
            else
                isShowBg = false;
            end
            UpdateWndSizeAndBg( );
        end 
    );

    Controls.Map_Editor_BtnRefTerType:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionTer(selPlotId); end );
    Controls.Map_Editor_BtnRefTerType:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRefFea:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionFea(selPlotId); end );
    Controls.Map_Editor_BtnRefFea:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRefRes:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionRes(selPlotId); end );
    Controls.Map_Editor_BtnRefRes:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRefImp:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionImp(selPlotId); end );
    Controls.Map_Editor_BtnRefImp:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRefRoute:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionRoute(selPlotId); end );
    Controls.Map_Editor_BtnRefRoute:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRefOwner:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionOwner(selPlotId); end );
    Controls.Map_Editor_BtnRefOwner:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRefElev:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionElev(selPlotId); end );
    Controls.Map_Editor_BtnRefElev:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnRefCont:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionCont(selPlotId); end );
    Controls.Map_Editor_BtnRefCont:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
    

    Controls.Map_Editor_BtnNonFea:RegisterCallback( Mouse.eLClick, function() CBSelectionNoneFea(selPlotId); end );
    Controls.Map_Editor_BtnNonFea:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnNonRes:RegisterCallback( Mouse.eLClick, function() CBSelectionNoneRes(selPlotId); end );
    Controls.Map_Editor_BtnNonRes:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnNonImp:RegisterCallback( Mouse.eLClick, function() CBSelectionNoneImp(selPlotId); end );
    Controls.Map_Editor_BtnNonImp:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnNonRoute:RegisterCallback( Mouse.eLClick, function() CBSelectionNoneRoute(selPlotId); end );
    Controls.Map_Editor_BtnNonRoute:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnNonOwner:RegisterCallback( Mouse.eLClick, function() CBSelectionNoneOwner(selPlotId); end );
    Controls.Map_Editor_BtnNonOwner:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnNonElev:RegisterCallback( Mouse.eLClick, function() CBSelectionNoneElev(selPlotId); end );
    Controls.Map_Editor_BtnNonElev:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnNonCont:RegisterCallback( Mouse.eLClick, function() CBSelectionNoneCont(selPlotId); end );
    Controls.Map_Editor_BtnNonCont:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );
    

    Controls.Map_Editor_BtnUnTer:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionTer(nil); end );
    Controls.Map_Editor_BtnUnTer:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnUnFea:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionFea(nil); end );
    Controls.Map_Editor_BtnUnFea:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnUnRes:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionRes(nil); end );
    Controls.Map_Editor_BtnUnRes:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnUnImp:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionImp(nil); end );
    Controls.Map_Editor_BtnUnImp:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnUnRoute:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionRoute(nil); end );
    Controls.Map_Editor_BtnUnRoute:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnUnOwner:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionOwner(nil); end );
    Controls.Map_Editor_BtnUnOwner:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnUnElev:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionElev(nil); end );
    Controls.Map_Editor_BtnUnElev:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_BtnUnCont:RegisterCallback( Mouse.eLClick, function() UpdateCBSelectionCont(nil); end );
    Controls.Map_Editor_BtnUnCont:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    Controls.Map_Editor_None:RegisterCallback( Mouse.eLClick, 
        function() 
            CBSelectionNoneFea(selPlotId); 
            CBSelectionNoneRes(selPlotId);
            CBSelectionNoneImp(selPlotId);
            CBSelectionNoneRoute(selPlotId); 
            CBSelectionNoneOwner(selPlotId); 
            CBSelectionNoneElev(selPlotId);
            CBSelectionNoneCont(selPlotId);
        end 
    );
    Controls.Map_Editor_None:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end );

    InitCBAll();

    ContextPtr:SetInputHandler( OnInputHandler, true );

    ContextPtr:SetHide(false);

    LuaEvents.Mod_Map_Editor_UiInit(); -- notify listeners
    print( " ################ End Initializing Mod Map_Editor UI Script... ################ " );

end

--************************************************************
local function Initialize()
    ContextPtr:SetInitHandler( OnInit );
    --ContextPtr:SetShutdown( OnShutdown );
    Events.LoadGameViewStateDone.Add( OnLoadGameViewStateDone );
end

Initialize();