-- Map_Editor_UI_Pulldowns
-- Author: Zur13
-- DateCreated: 10/12/2019 7:03:11 PM
-- Last Modified By: Matthew Lonis
-- Last Modified On: 07/12/2020
--------------------------------------------------------------

NIL_INT_REPRESENTATION_FOR_SET_VOIDS = -9999999;
EntriesTer = {};
EntriesFea = {};
EntriesRes = {};
EntriesImp = {};
EntriesRou = {};
EntriesOwn = {};
EntriesEle = {};
EntriesCont = {};
EntriesRiv = {};

mapNaturaWondersPlots = {};	-- key - plotId; val - NW id
mapNaturaWonders = {};		-- key - NW id existing on the map; val - one of NW plots id
plotsPendingForNWUpdate = {};		-- key - table index; val - plot id

include( "Map_Editor_UI_PulldownsHelper" );

--******************************************************************************
function IsTable( instance )
    if instance ~= nil and type(instance) == "table" then
        return true;
    end
    return false;
end

--******************************************************************************
function FindIndexInCbEntriesTable( entries, typeIndex )
    --if typeIndex == nil then
        --return 1;
    --end
    --if typeIndex == -1 then
        --return 2;
    --end
    if entries ~= nil then
        for k, v in pairs( entries ) do
            --print(" FindIndexInCbEntriesTable ", k, v.Type, typeIndex );
            if IsTable(v) and IsTable(v.Type) and v.Type.Index == typeIndex then
                --print(" FindIndexInCbEntriesTable FOUND $$$$$$$$$$$", k, v.Type.Index, typeIndex );
                return k;
            end
        end
        for k, v in pairs( entries ) do
            if IsTable(v) and v.Type == typeIndex then
                return k;
            end
        end
    end
    print(" FindIndexInCbEntriesTable NOT FOUND ################################", #entries, typeIndex );
    return 1;
end

--******************************************************************************
function AddCBEntry( entries, index, pulldown )
    local pdEntry:table = {};
    local entry = entries[ index ];

    --pulldown:BuildEntry( pulldownInstName, pdEntry );
    pulldown:BuildEntry( "InstanceOne", pdEntry );
    entry.pdEntry = pdEntry;
    entry.Button = pdEntry.Button;

    if entry.Text ~= nil then
        pdEntry.Button:SetText( entry.Text );
    else
        pdEntry.Button:SetText( " ??? " );
    end
    if entry.TText ~= nil then
        pdEntry.Button:SetToolTipString( entry.TText );
    end

    if entry.Type == nil then
        pdEntry.Button:SetVoids( index, NIL_INT_REPRESENTATION_FOR_SET_VOIDS );
    elseif type( entry.Type ) == "number" then
        pdEntry.Button:SetVoids( index, entry.Type );
    elseif type( entry.Type ) == "table" then
        pdEntry.Button:SetVoids( index, entry.Type.Index );
    else
        pdEntry.Button:SetVoids( index, NIL_INT_REPRESENTATION_FOR_SET_VOIDS );
    end
    
end

--******************************************************************************
function AddCBEntries( entries, pulldown )
    pulldown:ClearEntries();
    for index = 1, #entries do 
        AddCBEntry( entries, index, pulldown );   
    end
    pulldown:CalculateInternals();
end

--******************************************************************************
function AddCBEntriesStandardPDNaming( entries, pulldownNameSuffix )
    AddCBEntries( entries, Controls[ "Map_Editor_PD" .. pulldownNameSuffix ] );
end

--******************************************************************************
function SelectCBEntries( entries, type, pulldownBtn )
    local entry;
    if entries == nil or #entries == 0 then
        return;
    end
    
    local idx = FindIndexInCbEntriesTable( entries, type );
    entry = entries[ idx ];

    if entry ~= nil and entry.Text ~= nil then
        pulldownBtn:SetText( entry.Text );
    else
        pulldownBtn:SetText( " ??? " );
    end
end

--******************************************************************************
function SelectCBEntriesStandardPDNaming( entries, type, pulldownNameSuffix )
    SelectCBEntries( entries, type, Controls[ "Map_Editor_PD" .. pulldownNameSuffix ]:GetButton() );
end

--************************************************************************************************************************************************************

--******************************************************************************
function UpdateCBSelectionTer( plotId )
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then
            terType = plot:GetTerrainType();
        end
    else
        terType = nil;
    end

    local entries2 = EntriesTer;
    local type2 = terType;
    local pdNameSuffix2 = "TerType";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if terType ~= nil then
        --Controls.Map_Editor_PDTerType:SetSelectedIndex(	terType + 2,   false );
    --else
        --Controls.Map_Editor_PDTerType:SetSelectedIndex(	1,  false );
    --end
end

--******************************************************************************
function InitCBTerType()
    
    local entries2 = EntriesTer;
    local type2 = terType;
    local pdNameSuffix2 = "TerType";

    Controls["Map_Editor_PD" .. pdNameSuffix2]:RegisterSelectionCallback( 
            function ( index1:number, type1:number ) 
                if NIL_INT_REPRESENTATION_FOR_SET_VOIDS == type1 then
                    type1 = nil;
                end
                print("Map_Editor_PD " .. pdNameSuffix2 .. " selection changed to: ", index1, type1 );
                terType = type1;
                SelectCBEntriesStandardPDNaming( EntriesTer, type1, pdNameSuffix2 );
            end
        );
end

--******************************************************************************
function UpdateCBTerType()
    -- Terrains ComboBox
    local entries = BuildListTerType();

    EntriesTer = entries;
    
    local entries2 = EntriesTer;
    local type2 = terType;
    local pdNameSuffix2 = "TerType";

    AddCBEntriesStandardPDNaming( entries2, pdNameSuffix2 );
    
    --Controls.Map_Editor_PDTerType:SetEntries( entries, 1 );
    --Controls.Map_Editor_PDTerType:SetEntrySelectedCallback( 
            --function (entry) 
                --if entry.Type == -1 or entry.Type == nil then
                    --terType = entry.Type
                --else
                    --terType = entry.Type.Index;
                --end
            --end
        --);

    --Controls.Map_Editor_PDTerType:SetSelectedIndex(     terrainType+1,               false );
end

--************************************************************************************************************************************************************

--******************************************************************************
function UpdateCBSelectionFea( plotId )
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then
            featType = plot:GetFeatureType();
        end
    else
        featType = nil;
    end

    local entries2 = EntriesFea;
    local type2 = featType;
    local pdNameSuffix2 = "Feature";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if featType ~= nil then	
        --local idx = FindIndexInCbEntriesTable( EntriesFea, featType );
        --Controls.Map_Editor_PDFeature:SetSelectedIndex(	idx,  false );
    --else
        --Controls.Map_Editor_PDFeature:SetSelectedIndex(	1,  false );
    --end
end

--******************************************************************************
function InitCBFeature()

    local entries2 = EntriesFea;
    local type2 = featType;
    local pdNameSuffix2 = "Feature";

    Controls["Map_Editor_PD" .. pdNameSuffix2]:RegisterSelectionCallback( 
            function ( index1:number, type1:number ) 
                if NIL_INT_REPRESENTATION_FOR_SET_VOIDS == type1 then
                    type1 = nil;
                end
                print("Map_Editor_PD " .. pdNameSuffix2 .. " selection changed to: ", index1, type1 );
                featType = type1; -- !!
                SelectCBEntriesStandardPDNaming( EntriesFea, type1, pdNameSuffix2 ); -- !!
                UpdateNWondersOnPendingPlots();
            end
        );
end

--******************************************************************************
function UpdateCBFeature()
    -- Features ComboBox
    local entries = BuildListFea();
    
    EntriesFea = entries;

    local entries2 = EntriesFea;
    local type2 = featType;
    local pdNameSuffix2 = "Feature";

    AddCBEntriesStandardPDNaming( entries2, pdNameSuffix2 );
    
    Controls.Map_Editor_PDFeature:GetButton():RegisterCallback(	Mouse.eMouseEnter,	function() UpdateNWondersOnPendingPlots(); end);

    --Controls.Map_Editor_PDFeature:SetEntries( entries, 1 );
    --Controls.Map_Editor_PDFeature:SetEntrySelectedCallback( 
            --function (entry) 
                --if entry.Type == -1 or entry.Type == nil then
                    --featType = entry.Type
                --else
                    --featType = entry.Type.Index;
                --end
                --UpdateNWondersOnPendingPlots();
            --end
        --);
    

    --for _, entry in ipairs(entries) do 
        --if entry.Type ~= nil and entry.Type ~= -1 and entry.Type ~= 0 and entry.Type.Index > -1 then
            --local tooltip = entry.TText;
            --if tooltip ~= nil then
                --entry.Button:SetToolTipString( Locale.Lookup( tooltip ) );
            --end
        --end
    --end

    FindNWondersOnMap();
    FindNWonders();
    UpdateFeaWonderExistMark();

    --Controls.Map_Editor_PDFeature:SetSelectedIndex(     featType+1,               false );
end

--******************************************************************************
function CBSelectionNoneFea( plotId )
    featType = -1;

    local entries2 = EntriesFea;
    local type2 = featType;
    local pdNameSuffix2 = "Feature";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if featType ~= nil then	
        --local idx = FindIndexInCbEntriesTable( EntriesFea, featType );
        --Controls.Map_Editor_PDFeature:SetSelectedIndex(	idx,  false );
    --else
        --Controls.Map_Editor_PDFeature:SetSelectedIndex(	1,  false );
    --end
end

--************************************************************************************************************************************************************

--******************************************************************************
function UpdateCBSelectionRes( plotId )
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then
            resType = plot:GetResourceType();

            resCnt = plot:GetResourceCount();
        end
    else
        resType = nil;			
        resCnt = 1;
    end
        
    local entries2 = EntriesRes;
    local type2 = resType;
    local pdNameSuffix2 = "Res";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if resType ~= nil then
        --local idx = FindIndexInCbEntriesTable( EntriesRes, resType );
        --Controls.Map_Editor_PDRes:SetSelectedIndex(		idx,  false );
    --else
        --Controls.Map_Editor_PDRes:SetSelectedIndex(		1,  false );
    --end

    Controls.Map_Editor_EBResValue:SetText( tostring(resCnt) );
end

--******************************************************************************
function InitCBRes()
    
    local entries2 = EntriesRes;
    local type2 = resType;
    local pdNameSuffix2 = "Res";

    Controls["Map_Editor_PD" .. pdNameSuffix2]:RegisterSelectionCallback( 
            function ( index1:number, type1:number ) 
                if NIL_INT_REPRESENTATION_FOR_SET_VOIDS == type1 then
                    type1 = nil;
                end
                print("Map_Editor_PD " .. pdNameSuffix2 .. " selection changed to: ", index1, type1 );
                resType = type1; -- !!
                SelectCBEntriesStandardPDNaming( EntriesRes, type1, pdNameSuffix2 ); -- !!
                -- !! only for resource
                if type1 ~= nil and type1 ~= -1 and Controls.Map_Editor_EBResValue:GetText() == "0" then
                    Controls.Map_Editor_EBResValue:SetText("1");
                    resCnt = 1;
                end
            end
        );
end

--******************************************************************************
function UpdateCBRes()
    -- Resources ComboBox
    local entries = BuildListRes();

    EntriesRes = entries;
    
    local entries2 = EntriesRes;
    local type2 = resType;
    local pdNameSuffix2 = "Res";

    AddCBEntriesStandardPDNaming( entries2, pdNameSuffix2 );

    --Controls.Map_Editor_PDRes:SetEntries( entries, 1 );
    --Controls.Map_Editor_PDRes:SetEntrySelectedCallback( 
            --function (entry) 
                --if entry.Type == -1 or entry.Type == nil then
                    --resType = entry.Type
                --else
                    --resType = entry.Type.Index;
                    --if Controls.Map_Editor_EBResValue:GetText() == "0" then
                        --Controls.Map_Editor_EBResValue:SetText("1");
                        --resCnt = 1;
                    --end
                --end
            --end
        --);
--
    --for _, entry in ipairs(entries) do 
        --if entry.Type ~= nil and entry.Type ~= -1 and entry.Type ~= 0 and entry.Type.Index > -1 and entry.TText ~= nil then
            --local tooltip = entry.TText;
            --if tooltip ~= nil then
                --entry.Button:SetToolTipString( Locale.Lookup( tooltip ) );
            --end
        --end
    --end

    --Controls.Map_Editor_PDRes:SetSelectedIndex(     resType+1,               false );
end

--******************************************************************************
function CBSelectionNoneRes( plotId )
    resType = -1;			
    resCnt = 0;
        
    local entries2 = EntriesRes;
    local type2 = resType;
    local pdNameSuffix2 = "Res";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if resType ~= nil then
        --local idx = FindIndexInCbEntriesTable( EntriesRes, resType );
        --Controls.Map_Editor_PDRes:SetSelectedIndex(		idx,  false );
    --else
        --Controls.Map_Editor_PDRes:SetSelectedIndex(		1,  false );
    --end

    Controls.Map_Editor_EBResValue:SetText( tostring(resCnt) );
end

--************************************************************************************************************************************************************

--******************************************************************************
function UpdateCBSelectionImp( plotId )
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then
            imprType = plot:GetImprovementType();
        end
    else
        imprType = nil;
    end
        
    local entries2 = EntriesImp;
    local type2 = imprType;
    local pdNameSuffix2 = "Impr";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if imprType ~= nil then
        --local idx = FindIndexInCbEntriesTable( EntriesImp, imprType );
        --Controls.Map_Editor_PDImpr:SetSelectedIndex(	idx,  false );
    --else
        --Controls.Map_Editor_PDImpr:SetSelectedIndex(	1,  false );
    --end
end

--******************************************************************************
function InitCBImpr()
    
    local entries2 = EntriesImp;
    local type2 = imprType;
    local pdNameSuffix2 = "Impr";

    Controls["Map_Editor_PD" .. pdNameSuffix2]:RegisterSelectionCallback( 
            function ( index1:number, type1:number ) 
                if NIL_INT_REPRESENTATION_FOR_SET_VOIDS == type1 then
                    type1 = nil;
                end
                print("Map_Editor_PD " .. pdNameSuffix2 .. " selection changed to: ", index1, type1 );
                imprType = type1; -- !!
                SelectCBEntriesStandardPDNaming( EntriesImp, type1, pdNameSuffix2 ); -- !!
            end
        );
end

--******************************************************************************
function UpdateCBImpr()
    -- Improvement ComboBox
    local entries = BuildListImp();

    EntriesImp = entries;
    
    local entries2 = EntriesImp;
    local type2 = imprType;
    local pdNameSuffix2 = "Impr";

    AddCBEntriesStandardPDNaming( entries2, pdNameSuffix2 );

    --Controls.Map_Editor_PDImpr:SetEntries( entries, 1 );
    --Controls.Map_Editor_PDImpr:SetEntrySelectedCallback( 
            --function (entry) 
                --if entry.Type == -1 or entry.Type == nil then
                    --imprType = entry.Type
                --else
                    --imprType = entry.Type.Index;
                --end
            --end
        --);
    
    --for _, entry in ipairs(entries) do 
        --if entry.Type ~= nil and entry.Type ~= -1 and entry.Type ~= 0 and entry.Type.Index > -1 then
            --
            --local imp = GameInfo.Improvements[entry.Type.Index];
            --if imp ~= nil then
                --local tooltip = imp.Description;
                --if tooltip ~= nil then
                    --local locTTip = Locale.Lookup( tooltip );
                    --if imp.ImprovementType == 'IMPROVEMENT_POLDER' or imp.ImprovementType == 'IMPROVEMENT_MEKEWAP' then
                        --locTTip = locTTip .. "[NEWLINE][NEWLINE][COLOR_RED]" .. Locale.Lookup( "LOC_MAP_EDITOR_IMPROVEMENT_BUGGED" ) .. "[ENDCOLOR]";
                    --end
                    --entry.Button:SetToolTipString( locTTip );
                --end
            --end
        --end
    --end

    --Controls.Map_Editor_PDImpr:SetSelectedIndex(     imprType+1,               false );
end

--******************************************************************************
function CBSelectionNoneImp( plotId )
    imprType = -1;
        
    local entries2 = EntriesImp;
    local type2 = imprType;
    local pdNameSuffix2 = "Impr";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if imprType ~= nil then
        --local idx = FindIndexInCbEntriesTable( EntriesImp, imprType );
        --Controls.Map_Editor_PDImpr:SetSelectedIndex(	idx,  false );
    --else
        --Controls.Map_Editor_PDImpr:SetSelectedIndex(	1,  false );
    --end
end

--************************************************************************************************************************************************************

--******************************************************************************
function UpdateCBSelectionRoute( plotId )
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then
            routeType = plot:GetRouteType();
        end
    else
        routeType = nil;
    end
        
    local entries2 = EntriesRou;
    local type2 = routeType;
    local pdNameSuffix2 = "Route";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if routeType ~= nil then
        --Controls.Map_Editor_PDRoute:SetSelectedIndex(	routeType + 3,  false );
    --else
        --Controls.Map_Editor_PDRoute:SetSelectedIndex(	1,  false );
    --end
end

--******************************************************************************
function InitCBRoute()
    local entries2 = EntriesRou;
    local type2 = routeType;
    local pdNameSuffix2 = "Route";

    Controls["Map_Editor_PD" .. pdNameSuffix2]:RegisterSelectionCallback( 
            function ( index1:number, type1:number ) 
                if NIL_INT_REPRESENTATION_FOR_SET_VOIDS == type1 then
                    type1 = nil;
                end
                print("Map_Editor_PD " .. pdNameSuffix2 .. " selection changed to: ", index1, type1 );
                routeType = type1; -- !!
                SelectCBEntriesStandardPDNaming( EntriesRou, type1, pdNameSuffix2 ); -- !!
            end
        );
end

--******************************************************************************
function UpdateCBRoute()
    -- Route ComboBox
    local type;
    local entries = BuildListRoute();

    EntriesRou = entries;
        
    local entries2 = EntriesRou;
    local type2 = routeType;
    local pdNameSuffix2 = "Route";
    
    AddCBEntriesStandardPDNaming( entries2, pdNameSuffix2 );

    --Controls.Map_Editor_PDRoute:SetEntries( entries, 1 );
    --Controls.Map_Editor_PDRoute:SetEntrySelectedCallback( 
            --function (entry) 
                --if entry.Type == -1 or entry.Type == nil then
                    --routeType = entry.Type
                --else
                    --routeType = entry.Type.Index;
                --end
            --end
        --);

    --Controls.Map_Editor_PDRoute:SetSelectedIndex(     routeType+1,               false );
end

--******************************************************************************
function CBSelectionNoneRoute( plotId )
    routeType = -1;
        
    local entries2 = EntriesRou;
    local type2 = routeType;
    local pdNameSuffix2 = "Route";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if routeType ~= nil then
        --Controls.Map_Editor_PDRoute:SetSelectedIndex(	routeType + 3,  false );
    --else
        --Controls.Map_Editor_PDRoute:SetSelectedIndex(	1,  false );
    --end
end

--************************************************************************************************************************************************************

--******************************************************************************
function UpdateCBSelectionOwner( plotId )
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then
            owner = plot:GetOwner();
        end
    else
        owner = nil;
    end
        
    local entries2 = EntriesOwn;
    local type2 = owner;
    local pdNameSuffix2 = "Owner";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if owner ~= nil then
        --Controls.Map_Editor_PDOwner:SetSelectedIndex(	owner + 3,  false );
    --else
        --Controls.Map_Editor_PDOwner:SetSelectedIndex(	1,  false );
    --end
end

--******************************************************************************
function InitCBOwner()
        
    local entries2 = EntriesOwn;
    local type2 = owner;
    local pdNameSuffix2 = "Owner";

    Controls["Map_Editor_PD" .. pdNameSuffix2]:RegisterSelectionCallback( 
            function ( index1:number, type1:number ) 
                if NIL_INT_REPRESENTATION_FOR_SET_VOIDS == type1 then
                    type1 = nil;
                end
                print("Map_Editor_PD " .. pdNameSuffix2 .. " selection changed to: ", index1, type1 );
                owner = type1; -- !!
                SelectCBEntriesStandardPDNaming( EntriesOwn, type1, pdNameSuffix2 ); -- !!
            end
        );
end

--******************************************************************************
function UpdateCBOwner()
    -- Owner ComboBox
    local type;
    local entries = BuildListOwner();

    EntriesOwn = entries;
        
    local entries2 = EntriesOwn;
    local type2 = owner;
    local pdNameSuffix2 = "Owner";
    
    AddCBEntriesStandardPDNaming( entries2, pdNameSuffix2 );

    --Controls.Map_Editor_PDOwner:SetEntries( entries, 1 );
    --Controls.Map_Editor_PDOwner:SetEntrySelectedCallback( 
            --function (entry) 
                --if entry.Type == -1 or entry.Type == nil then
                    --owner = entry.Type
                --else
                    --owner = entry.Type;
                --end
            --end
        --);

    --Controls.Map_Editor_PDOwner:SetSelectedIndex(     routeType+1,               false );
end

--******************************************************************************
function CBSelectionNoneOwner( plotId )
    owner = -1;
        
    local entries2 = EntriesOwn;
    local type2 = owner;
    local pdNameSuffix2 = "Owner";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if owner ~= nil then
        --Controls.Map_Editor_PDOwner:SetSelectedIndex(	owner + 3,  false );
    --else
        --Controls.Map_Editor_PDOwner:SetSelectedIndex(	1,  false );
    --end
end

--************************************************************************************************************************************************************

--******************************************************************************
function UpdateCBSelectionElev( plotId )
    if not IsXP2() then
        Controls.Map_Editor_StackElev:SetHide( true );
    end
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then
            if IsXP2() then
                elevationType = TerrainManager.GetCoastalLowlandType(plot);
            end
        end
    else
        elevationType = nil;
    end
        
    local entries2 = EntriesEle;
    local type2 = elevationType;
    local pdNameSuffix2 = "Elev";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if elevationType ~= nil then
        --Controls.Map_Editor_PDElev:SetSelectedIndex(	elevationType + 3,  false );
    --else
        --Controls.Map_Editor_PDElev:SetSelectedIndex(	1,  false );
    --end
end

--******************************************************************************
function InitCBElev()
        
    local entries2 = EntriesEle;
    local type2 = elevationType;
    local pdNameSuffix2 = "Elev";

    Controls["Map_Editor_PD" .. pdNameSuffix2]:RegisterSelectionCallback( 
            function ( index1:number, type1:number ) 
                if NIL_INT_REPRESENTATION_FOR_SET_VOIDS == type1 then
                    type1 = nil;
                end
                print("Map_Editor_PD " .. pdNameSuffix2 .. " selection changed to: ", index1, type1 );
                elevationType = type1; -- !!
                SelectCBEntriesStandardPDNaming( EntriesEle, type1, pdNameSuffix2 ); -- !!
            end
        );
end

--******************************************************************************
function UpdateCBElev()
    -- Elevation ComboBox
    local type;
    local entries = BuildListElev();

    EntriesEle = entries;
        
    local entries2 = EntriesEle;
    local type2 = elevationType;
    local pdNameSuffix2 = "Elev";
    
    AddCBEntriesStandardPDNaming( entries2, pdNameSuffix2 );

    --Controls.Map_Editor_PDElev:SetEntries( entries, 1 );
    --Controls.Map_Editor_PDElev:SetEntrySelectedCallback( 
            --function (entry) 
                --if entry.Type == -1 or entry.Type == nil then
                    --elevationType = entry.Type
                --else
                    --elevationType = entry.Type;
                --end
            --end
        --);

    --Controls.Map_Editor_PDElev:SetSelectedIndex(     routeType+1,               false );
end

--******************************************************************************
function CBSelectionNoneElev( plotId )
    if not IsXP2() then
        Controls.Map_Editor_StackElev:SetHide( true );
    end
    elevationType = -1;
        
    local entries2 = EntriesEle;
    local type2 = elevationType;
    local pdNameSuffix2 = "Elev";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );

    --if elevationType ~= nil then
        --Controls.Map_Editor_PDElev:SetSelectedIndex(	elevationType + 3,  false );
    --else
        --Controls.Map_Editor_PDElev:SetSelectedIndex(	1,  false );
    --end
end

--************************************************************************************************************************************************************

--******************************************************************************
function UpdateCBSelectionCont( plotId )
    if plotId ~= nil then
        local plot = Map.GetPlotByIndex(plotId);
        if plot ~= nil then
            contType = plot:GetContinentType();
        end
    else
        contType = nil;
    end
        
    local entries2 = EntriesCont;
    local type2 = contType;
    local pdNameSuffix2 = "ContType";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );
    
    --print("Plot Continent type is:", contType);
    --if contType ~= nil then
        --local idx = FindIndexInCbEntriesTable( EntriesCont, contType );
        --Controls.Map_Editor_PDContType:SetSelectedIndex(	idx,   false );
    --else
        --Controls.Map_Editor_PDContType:SetSelectedIndex(	1,  false );
    --end
end

--******************************************************************************
function InitCBContType()
        
    local entries2 = EntriesCont;
    local type2 = contType;
    local pdNameSuffix2 = "ContType";

    Controls["Map_Editor_PD" .. pdNameSuffix2]:RegisterSelectionCallback( 
            function ( index1:number, type1:number ) 
                if NIL_INT_REPRESENTATION_FOR_SET_VOIDS == type1 then
                    type1 = nil;
                end
                print("Map_Editor_PD " .. pdNameSuffix2 .. " selection changed to: ", index1, type1 );
                contType = type1; -- !!
                SelectCBEntriesStandardPDNaming( EntriesCont, type1, pdNameSuffix2 ); -- !!
            end
        );
end

--******************************************************************************
function UpdateCBContType()
    -- Continents ComboBox
    local type;
    local entries = BuildListContType();

    EntriesCont = entries;
        
    local entries2 = EntriesCont;
    local type2 = contType;
    local pdNameSuffix2 = "ContType";
    
    AddCBEntriesStandardPDNaming( entries2, pdNameSuffix2 );

    --Controls.Map_Editor_PDContType:SetEntries( entries, 1 );
    --Controls.Map_Editor_PDContType:SetEntrySelectedCallback( 
            --function (entry) 
                --if entry.Type == -1 or entry.Type == nil then
                    --contType = entry.Type
                --else
                    --contType = entry.Type.Index;
                --end
            --end
        --);

    --Controls.Map_Editor_PDContType:SetSelectedIndex(     terrainType+1,               false );
end

--******************************************************************************
function CBSelectionNoneCont( plotId )
    contType = -1;
        
    local entries2 = EntriesCont;
    local type2 = contType;
    local pdNameSuffix2 = "ContType";

    SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );
    
    --print("Plot Continent type is:", contType);
    --if contType ~= nil then
        --local idx = FindIndexInCbEntriesTable( EntriesCont, contType );
        --Controls.Map_Editor_PDContType:SetSelectedIndex(	idx,   false );
    --else
        --Controls.Map_Editor_PDContType:SetSelectedIndex(	2,  false );
    --end
end

--************************************************************************************************************************************************************

--******************************************************************************
function InitCBRivers( )

        local entries2 = EntriesRiv;
        local type2 = 1; -- WARN see if block!!!
        local pdNameSuffix2 = "NewRivId";

        Controls["Map_Editor_PD" .. pdNameSuffix2]:RegisterSelectionCallback( 
                    function ( index1:number, type1:number ) 
                        print("Map_Editor_PD " .. pdNameSuffix2 .. " selection changed to: ", index1, type1 );
                        rivId = type1; -- !!
                        SelectCBEntriesStandardPDNaming( EntriesRiv, type1, pdNameSuffix2 ); -- !!
                    end
                );
end

--******************************************************************************
function UpdateCBRivers( selRiverId )
    if IsXP2() then
        -- RiverID ComboBox
        --print("UpdateCBRivers", 1);

        Controls.Map_Editor_StackNewRivId:SetHide( false );

        local riverNum :number = RiverManager.GetNumRivers();
        local entries = BuildListRivers();

        EntriesRiv = entries;

        local entries2 = EntriesRiv;
        local type2 = 1; -- WARN see if block!!!
        local pdNameSuffix2 = "NewRivId";

        
        rivId = riverNum;

        if selRiverId ~= nil and riverNum+1 >= (selRiverId+2) then
            rivId = selRiverId;
            type2 = selRiverId+2;

            --Controls.Map_Editor_PDNewRivId:SetEntries( entries, selRiverId+2 );
            --print("UpdateCBRivers, rivId==", rivId);
        else
            --Controls.Map_Editor_PDNewRivId:SetEntries( entries, 1 );
            --print("UpdateCBRivers, rivId==", rivId);
        end

        AddCBEntriesStandardPDNaming( entries2, pdNameSuffix2 );
        SelectCBEntriesStandardPDNaming( entries2, type2, pdNameSuffix2 );
        --Controls.Map_Editor_PDNewRivId:SetEntrySelectedCallback( 
                --function (entry) 
                    --rivId = entry.Type;
                --end
            --);
        --print("UpdateCBRivers", 2);
        --Controls.Map_Editor_PDContType:SetSelectedIndex(     terrainType+1,               false );
    else
        Controls.Map_Editor_StackNewRivId:SetHide( true );
    end
end

--************************************************************************************************************************************************************

--******************************************************************************
function UpdateCBSelection( plotId )
    UpdateCBSelectionTer( plotId );
    UpdateCBSelectionFea( plotId );
    UpdateCBSelectionRes( plotId );
    UpdateCBSelectionImp( plotId );
    UpdateCBSelectionRoute( plotId );
    UpdateCBSelectionOwner( plotId );
    UpdateCBSelectionElev( plotId );
    UpdateCBSelectionCont( plotId );

    UpdateRiverSelection( plotId );
    UpdateCliffsSelection( plotId );
end

--******************************************************************************
function UpdateCBAll()
    UpdateCBTerType();
    UpdateCBFeature();
    UpdateCBRes();
    UpdateCBImpr();
    UpdateCBRoute();
    UpdateCBOwner();
    UpdateCBElev();
    UpdateCBContType();
    UpdateCBRivers();
end

--******************************************************************************
function InitCBAll()
    InitCBTerType();
    InitCBFeature();
    InitCBRes();
    InitCBImpr();
    InitCBRoute();
    InitCBOwner();
    InitCBElev();
    InitCBContType();
    InitCBRivers();
end
