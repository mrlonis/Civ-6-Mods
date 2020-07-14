-- UnitCheats_Minibar_Import_DupDlg
-- Author: Zur13
-- DateCreated: 5/8/2019 8:15:15 PM
--------------------------------------------------------------

--******************************************************************************
function HideDup()
	if not Controls.GUI_UnitCheats_SpawnDlgContainer:IsHidden() then
		--Controls.GUI_UnitCheats_SpawnDlg_CollapseAnim:SetToBeginning();
		--Controls.GUI_UnitCheats_SpawnDlg_CollapseAnim:Play();
	end
	Controls.GUI_UnitCheats_SpawnDlgContainer:SetHide( true );

	UILens.ClearLayerHexes( UILens.CreateLensLayerHash("Movement_Path") );
	FixUiMode();
end

--******************************************************************************
function ShowDup()
	playerLBEntries = {};
	targetPlotId = nil;
	targetPlayerId = nil;
	targetUnitType = nil;

	if Controls.GUI_UnitCheats_SpawnDlgContainer:IsHidden() then
		Controls.GUI_UnitCheats_SpawnDlgContainer:SetHide( false );
		Controls.GUI_UnitCheats_SpawnDlg_ExpandAnim:SetToBeginning();
		Controls.GUI_UnitCheats_SpawnDlg_ExpandAnim:Play();
		--Controls.GUI_UnitCheats_SpawnDlg_ExpandAnim:SetToBeginning();	-- This forces a clear of the reverse flag.
		--Controls.GUI_UnitCheats_SpawnDlg_ExpandAnim:SetToEnd();
		--Controls.GUI_UnitCheats_SpawnDlg_ExpandAnim:Reverse();
	else
		Controls.GUI_UnitCheats_SpawnDlg_ExpandAnim:SetToEnd();
		Controls.GUI_UnitCheats_SpawnDlgContainer:SetHide( false );
	end
	RefreshDlg();

	FixUiMode();
end

--******************************************************************************
-- Cancel button was pressed.
function OnDlgCancel()
	HideDup();
	ContextPtr:RequestRefresh(); OnRefresh(); -- Refresh Self, i.e. Unit Cheats Panel
end

--******************************************************************************
-- OK button was pressed.
function OnDlgOK()
	local x = nil;
	local y = nil;

	if targetPlotId ~= nil then 
		local plot = Map.GetPlotByIndex(targetPlotId);
		if plot ~= nil then
			x = plot:GetX();
			y = plot:GetY();
		end
	end

	local pSelectedUnit = UI.GetHeadSelectedUnit();
	if ( pSelectedUnit ~= nil ) then
		-- local units = Players[selPlayerId]:GetUnits();
		-- local unit = units:FindID(selUnitId);
			
		local unit = nil;
		if UnitManager then 
			unit = UnitManager.GetUnit( selPlayerId, selUnitId ); 
		end
		if unit and Players[selPlayerId]:IsHuman() then
			local unitType	:string = GameInfo.Units[unit:GetUnitType()].UnitType;
			local pRelig = nil;
			if Players[selPlayerId]:GetReligion() ~= nil and Players[selPlayerId]:GetReligion():GetReligionTypeCreated() ~= -1 then
				pRelig = Players[selPlayerId]:GetReligion():GetReligionTypeCreated();
				print( " DuplicateUnit player religion type created: ", pRelig );
			end
			ExposedMembers.MOD_UnitCheat.OnDuplicate(selPlayerId, selUnitId, unitType, targetPlayerId, targetUnitType, targetPlotId, x, y, unit:GetUnitType(), Controls.GUI_UnitCheats_ValidLoc:IsChecked(), targetUnitCnt, pRelig );
		end
	end

	HideDup();
	ContextPtr:RequestRefresh(); OnRefresh(); -- Refresh Self, i.e. Unit Cheats Panel
end

--******************************************************************************
-- Show All checkbox was pressed.
function OnDlgShowAllCB()
	--HideDup();
	ContextPtr:RequestRefresh(); OnRefresh(); -- Refresh Self, i.e. Unit Cheats Panel
end

--******************************************************************************
-- Show All checkbox was pressed.
function OnDlgPlayerSelChanged(entry)
	if entry ~= nil then
		
	end
	--HideDup();
	ContextPtr:RequestRefresh(); OnRefresh(); -- Refresh Self, i.e. Unit Cheats Panel
end

--******************************************************************************
-- Populate Combo Box (Pull Down)
function PopulateComboBox(control, values, selected_value, selection_handler)

	control:ClearEntries();
	for i, v in ipairs(values) do
		local instance = {};
		control:BuildEntry( "InstanceOne", instance );
		instance.Button:SetVoid1(i);
        --instance.Button:LocalizeAndSetText(v[1]);
		instance.Button:SetText(v.Text);

		if(v.Key == selected_value) then
			local button = control:GetButton();
            button:SetText(v.Text);
			--button:SetSizeX(control:GetSizeX()-30);	
		end
	end
	control:CalculateInternals();	

	if(selection_handler) then
		control:RegisterSelectionCallback(
			function(voidValue1, voidValue2, control)
				local option = values[voidValue1];

				local button = control:GetButton();
                --button:LocalizeAndSetText(option[1]);
				button:SetText(option.Text);
				--button:SetSizeX(control:GetSizeX()-30);	
				--button:SetSizeY(control:GetSizeY());	
				selection_handler(option.Key);
			end
		);
	end
    	
end

--******************************************************************************
-- Show All checkbox was pressed.
function RefreshDlg()
	playerLBEntries = {};
	unitCntLBEntries = {};
	local iIndex = 1;

	--for k, v in pairs(PlayerManager.GetAliveMajorIDs()) do
	for k, v in pairs(PlayerManager.GetAliveIDs()) do
		--print("Player:", k, v);
		local pID = v;
        local playerConfig:table = PlayerConfigurations[pID];
		local name = Locale.Lookup(playerConfig:GetPlayerName());
        local imgname = Locale.Lookup(playerConfig:GetCivilizationTypeName());
		--print("Player 11:", pID, name, imgname, selPlayerId);

		table.insert(playerLBEntries, { Key = pID, Text = name, Index = iIndex, PlayerConfig = playerConfig });
		iIndex = iIndex + 1;
	end

	for i = 1, 20, 1 do
		--print("Player:", k, v);
		table.insert(unitCntLBEntries, { Key = i, Text = i, Index = i });
	end

    Controls.GUI_UnitCheats_PlayersPD:ClearEntries();
    PopulateComboBox(Controls.GUI_UnitCheats_PlayersPD, playerLBEntries, selPlayerId, 
        function(pID)
	    	targetPlayerId = pID;
			--RefreshUnitListPopup();
	    end
    );

	targetUnitCnt = 1;
	Controls.GUI_UnitCheats_CntPD:ClearEntries();
    PopulateComboBox(Controls.GUI_UnitCheats_CntPD, unitCntLBEntries, 1, 
        function(Key)
	    	targetUnitCnt = Key;
			--RefreshUnitListPopup();
	    end
    );

	RefreshUnitListPopup();
	--UI.SetInterfaceMode( InterfaceModeTypes.WB_SELECT_PLOT );
	FixUiMode();
	--Controls.GUI_UnitCheats_PlayersLB:SetEntries( playerLBEntries, 1 );
	--if Controls.GUI_UnitCheats_PlayersLB:HasEntries() then
		--Controls.GUI_UnitCheats_PlayersLB:SetSelectedIndex( 1, true );
	--end
	
	--local controlEntry = m_ViewingTab.SubTab.CityBuildingsInstance.BuildingsList:GetIndexedEntry( i );

	-- Manually call selection callback since SetEntries does not trigger it
	--OnDlgPlayerSelChanged(playerLBEntries[1]);
end

-- ===========================================================================
--	Returns the icon info and shadow icon info for the passed in unit or returns default icons if those can't be found
--	RETURN 1: iconInfo - table containing textureSheet, textureOffsetX, and textureOffsetY
--	RETURN 2: iconShadowInfo - table containing textureSheetShadow, textureOffsetShadowX, and textureOffsetShadowY
-- ===========================================================================
function GetUnitIcon( unitInfo:table, iconSize:number )	
	
	local iconInfo:table = {};
	if unitInfo then

		local unitIcon:string = nil;

		--local individual:number = pUnit:GetGreatPerson():GetIndividual();
		--if individual >= 0 then
			--local individualType:string = GameInfo.GreatPersonIndividuals[individual].GreatPersonIndividualType;
			--local iconModifier:table = GameInfo.GreatPersonIndividualIconModifiers[individualType];
			--if iconModifier then
				--unitIcon = iconModifier.OverrideUnitIcon;
			--end 
		--end

		--if not unitIcon then
			--local unit:table = GameInfo.Units[unitInfo.UnitType];
			unitIcon = "ICON_" .. unitInfo.UnitType;
		--end
		
		iconInfo.textureOffsetX, iconInfo.textureOffsetY, iconInfo.textureSheet = IconManager:FindIconAtlas(unitIcon, iconSize);
		if (iconInfo.textureSheet == nil) then			--Check to see if the unit has an icon atlas index defined
			--print("UIWARNING: Could not find icon for " .. unitIcon);
			iconInfo.textureOffsetX, iconInfo.textureOffsetY, iconInfo.textureSheet = IconManager:FindIconAtlas("ICON_UNIT_UNKNOWN", iconSize);		--If not, resolve the index to be a generic unknown index
		end
	end
	return iconInfo;
end

 --UnitCheats_Minibar: CanTargetAir	false
 --UnitCheats_Minibar: Bombard	0
 --UnitCheats_Minibar: PurchaseYield	YIELD_GOLD
 --UnitCheats_Minibar: MakeTradeRoute	false
 --UnitCheats_Minibar: UnitType	UNIT_AZTEC_EAGLE_WARRIOR
 --UnitCheats_Minibar: BaseUnitCollection	table: 0000000056BC5130
 --UnitCheats_Minibar: PromotionClassReference	table: 000000005637D0E0
 --UnitCheats_Minibar: BuildCharges	0
 --UnitCheats_Minibar: AiInfoCollection	table: 0000000056BC3470
 --UnitCheats_Minibar: RangedCombat	0
 --UnitCheats_Minibar: TraitType	TRAIT_CIVILIZATION_UNIT_AZTEC_EAGLE_WARRIOR
 --UnitCheats_Minibar: CanRetreatWhenCaptured	false
 --UnitCheats_Minibar: Description	LOC_UNIT_AZTEC_EAGLE_WARRIOR_DESCRIPTION
 --UnitCheats_Minibar: TrackReligion	false
 --UnitCheats_Minibar: BaseMoves	2
 --UnitCheats_Minibar: MustPurchase	false
 --UnitCheats_Minibar: LaunchInquisition	false
 --UnitCheats_Minibar: EvangelizeBelief	false
 --UnitCheats_Minibar: WMDCapable	false
 --UnitCheats_Minibar: Index	107
 --UnitCheats_Minibar: ReligionEvictPercent	0
 --UnitCheats_Minibar: Range	0
 --UnitCheats_Minibar: Combat	28
 --UnitCheats_Minibar: CostProgressionModel	NO_COST_PROGRESSION
 --UnitCheats_Minibar: FoundCity	false
 --UnitCheats_Minibar: CostProgressionParam1	0
 --UnitCheats_Minibar: ZoneOfControl	true
 --UnitCheats_Minibar: BaseSightRange	2
 --UnitCheats_Minibar: CaptureCollection	table: 0000000056BC9280
 --UnitCheats_Minibar: YieldReference	table: 0000000056E02AD0
 --UnitCheats_Minibar: Domain	DOMAIN_LAND
 --UnitCheats_Minibar: InitialLevel	1
 --UnitCheats_Minibar: Stackable	false
 --UnitCheats_Minibar: PrimaryKey	UNIT_AZTEC_EAGLE_WARRIOR
 --UnitCheats_Minibar: SpreadCharges	0
 --UnitCheats_Minibar: TraitReference	table: 0000000056515760
 --UnitCheats_Minibar: BonusMinorStartingUnitCollection	table: 0000000056BC7520
 --UnitCheats_Minibar: AntiAirCombat	0
 --UnitCheats_Minibar: CanCapture	true
 --UnitCheats_Minibar: Maintenance	0
 --UnitCheats_Minibar: TeamVisibility	false
 --UnitCheats_Minibar: RequiresInquisition	false
 --UnitCheats_Minibar: ExtractsArtifacts	false
 --UnitCheats_Minibar: MandatoryObsoleteTech	TECH_GUNPOWDER
 --UnitCheats_Minibar: EnabledByReligion	false
 --UnitCheats_Minibar: rowid	108
 --UnitCheats_Minibar: FoundReligion	false
 --UnitCheats_Minibar: UpgradeUnitCollection	table: 0000000056C54DB0
 --UnitCheats_Minibar: NumRandomChoices	0
 --UnitCheats_Minibar: MandatoryObsoleteTechReference	table: 00000000565CDC00
 --UnitCheats_Minibar: ReplacesCollection	table: 0000000056C52650
 --UnitCheats_Minibar: Cost	65
 --UnitCheats_Minibar: RowId	108
 --UnitCheats_Minibar: ReplacedByCollection	table: 0000000056BD0D50
 --UnitCheats_Minibar: MajorStartingUnitCollection	table: 0000000056BCC250
 --UnitCheats_Minibar: Hash	1526148314
 --UnitCheats_Minibar: IgnoreMoves	false
 --UnitCheats_Minibar: PromotionClass	PROMOTION_CLASS_MELEE
 --UnitCheats_Minibar: ParkCharges	0
 --UnitCheats_Minibar: Spy	false
 --UnitCheats_Minibar: AirSlots	0
 --UnitCheats_Minibar: FormationClass	FORMATION_CLASS_LAND_COMBAT
 --UnitCheats_Minibar: PrereqBuildingCollection	table: 0000000056BCE820
 --UnitCheats_Minibar: AllowBarbarians	false
 --UnitCheats_Minibar: Name	LOC_UNIT_AZTEC_EAGLE_WARRIOR_NAME
 --UnitCheats_Minibar: ReligiousHealCharges	0
 --UnitCheats_Minibar: ReligiousStrength	0
 --UnitCheats_Minibar: CanTrain	true

 --******************************************************************************
 local function OnUnitTypeSelected(voidValue1, voidValue2, control)
	--print("OnUnitTypeSelected: ", voidValue1, voidValue2, control);
	--if voidValue1 ~= 0 and voidValue2 ~= 0 then
		--local button = Controls.GUI_UnitCheats_UnitsPD:GetButton();
		local unitInfo = GameInfo.Units[voidValue1];
		targetUnitType = unitInfo.UnitType;

		local suffix:string = "";
		local uniqueName = Locale.Lookup( unitInfo.Name ) .. suffix;
		Controls.GUI_UnitCheats_UnitsPD:GetButton():SetText( uniqueName );
		
		-- Update unit icon
		local iconInfo:table, iconShadowInfo:table = GetUnitIcon(unitInfo, 22, true);
		if iconInfo.textureSheet then
			Controls.UnitTypeIcon1:SetTexture( iconInfo.textureOffsetX, iconInfo.textureOffsetY, iconInfo.textureSheet );
		end
	--end
 end

 --******************************************************************************
RefreshUnitListPopup = function()
	--local unitType	:string = GameInfo.Units[unit:GetUnitType()].UnitType; -- ##################################################

	Controls.GUI_UnitCheats_UnitsPD:ClearEntries();
	
	local pPlayer:table = Players[Game.GetLocalPlayer()];
	--local pPlayerUnits:table = pPlayer:GetUnits();

	-- Sort units
	local militaryUnits:table = {};
	local navalUnits:table = {};
	local airUnits:table = {};
	local aAirUnits:table = {};
	local supportUnits:table = {};
	local civilianUnits:table = {};
	local tradeUnits:table = {};

	for unitInfo in GameInfo.Units() do
		--local unitInfo:table = GameInfo.Units[pUnit:GetUnitType()];
		--print("GameInfo.Units: ", i, unitInfo);
		if unitInfo.MakeTradeRoute == true or unitInfo.UnitType == 'UNIT_BUILDER' or unitInfo.FoundCity then
			table.insert(tradeUnits, unitInfo);
		elseif unitInfo.ReligiousStrength > 0 or unitInfo.ReligiousHealCharges > 0 or unitInfo.SpreadCharges > 0 or unitInfo.LaunchInquisition then
			table.insert(supportUnits, unitInfo);
		elseif unitInfo.AntiAirCombat > 0 then
			table.insert(aAirUnits, unitInfo);
		elseif unitInfo.Combat == 0 and unitInfo.RangedCombat == 0 then
			-- if we have no attack strength we must be civilian
			table.insert(civilianUnits, unitInfo);
		elseif unitInfo.Domain == "DOMAIN_LAND" then
			table.insert(militaryUnits, unitInfo);
		elseif unitInfo.Domain == "DOMAIN_SEA" then
			table.insert(navalUnits, unitInfo);
		elseif unitInfo.Domain == "DOMAIN_AIR" then
			table.insert(airUnits, unitInfo);
		end
	end

	-- Alphabetize groups
	local sortFunc = function(a, b) 
		local aType:string = a.UnitType;
		local bType:string = b.UnitType;
		return aType < bType;
	end
	table.sort(militaryUnits, sortFunc);
	table.sort(navalUnits, sortFunc);
	table.sort(aAirUnits, sortFunc);
	table.sort(airUnits, sortFunc);
	table.sort(supportUnits, sortFunc);
	table.sort(civilianUnits, sortFunc);
	table.sort(tradeUnits, sortFunc);

	-- Add units by sorted groups
	for _, unitInfo in ipairs(tradeUnits) do	AddUnitToUnitList( unitInfo );	end
	for _, unitInfo in ipairs(militaryUnits) do	AddUnitToUnitList( unitInfo );	end
	for _, unitInfo in ipairs(navalUnits) do 	AddUnitToUnitList( unitInfo );	end
	for _, unitInfo in ipairs(aAirUnits) do		AddUnitToUnitList( unitInfo );	end	
	for _, unitInfo in ipairs(airUnits) do		AddUnitToUnitList( unitInfo );	end	
	for _, unitInfo in ipairs(supportUnits) do	AddUnitToUnitList( unitInfo );	end
	for _, unitInfo in ipairs(civilianUnits) do	AddUnitToUnitList( unitInfo );	end

	Controls.GUI_UnitCheats_UnitsPD:CalculateInternals();
end

 --******************************************************************************
function AddUnitToUnitList(unitInfo:table)
	local unitIndex = nil;
	local pSelectedUnit = UI.GetHeadSelectedUnit();
	if ( pSelectedUnit ~= nil ) then
		-- local units = Players[selPlayerId]:GetUnits();
		-- local unit = units:FindID(selUnitId);
			
		local unit = nil;
		if UnitManager then 
			unit = UnitManager.GetUnit( selPlayerId, selUnitId ); 
		end
		if unit and Players[selPlayerId]:IsHuman() then
			FixUiMode();
			unitIndex = GameInfo.Units[unit:GetUnitType()].Index;
		end
	end

	-- Create entry
	local unitEntry:table = {};
	Controls.GUI_UnitCheats_UnitsPD:BuildEntry( "UnitTypeListEntry", unitEntry );
	local suffix:string = "";

	local uniqueName = Locale.Lookup( unitInfo.Name ) .. suffix;
	unitEntry.Button:SetText( uniqueName );
	unitEntry.Button:SetVoids(unitInfo.Index, unitInfo.RowId);

	unitEntry.Button:RegisterCallback( Mouse.eLClick, OnUnitTypeSelected );

	-- Update unit icon
	local iconInfo:table, iconShadowInfo:table = GetUnitIcon(unitInfo, 22, true);
	if iconInfo.textureSheet then
		unitEntry.UnitTypeIcon:SetTexture( iconInfo.textureOffsetX, iconInfo.textureOffsetY, iconInfo.textureSheet );
	end

	if unitIndex ~= nil and unitInfo.Index == unitIndex then
		-- refresh selection
		--print("Select unit type", unitIndex, unitInfo.Index);
		OnUnitTypeSelected(unitInfo.Index, unitInfo.RowId);
	end
	-- Update entry color if unit cannot take any action
	--if pUnit:IsReadyToMove() then
		--unitEntry.Button:GetTextControl():SetColorByName("UnitPanelTextCS");
		--unitEntry.UnitTypeIcon:SetColorByName("UnitPanelTextCS");
	--else
		--unitEntry.Button:GetTextControl():SetColorByName("UnitPanelTextDisabledCS");
		--unitEntry.UnitTypeIcon:SetColorByName("UnitPanelTextDisabledCS");
	--end

	if unitInfo.MakeTradeRoute == true or unitInfo.UnitType == 'UNIT_BUILDER' or unitInfo.FoundCity then
		unitEntry.Button:GetTextControl():SetColorByName("UnitPanelTextDisabledCS");
		unitEntry.UnitTypeIcon:SetColorByName("UnitPanelTextDisabledCS");
	elseif unitInfo.ReligiousStrength ~= 0 then
		unitEntry.Button:GetTextControl():SetColorByName("OperationChance_Yellow");
		unitEntry.UnitTypeIcon:SetColorByName("OperationChance_Yellow");
	elseif unitInfo.AntiAirCombat ~= 0 then
		unitEntry.Button:GetTextControl():SetColorByName("OperationChance_YellowGreen");
		unitEntry.UnitTypeIcon:SetColorByName("OperationChance_YellowGreen");
	elseif unitInfo.Combat == 0 and unitInfo.RangedCombat == 0 then
		-- if we have no attack strength we must be civilian
		--table.insert(civilianUnits, unitInfo);
		--unitEntry.Button:GetTextControl():SetColorByName("UnitPanelTextDisabledCS");
		--unitEntry.UnitTypeIcon:SetColorByName("UnitPanelTextDisabledCS");
	elseif unitInfo.Domain == "DOMAIN_LAND" then
		if unitInfo.RangedCombat == 0 then 
			--unitEntry.Button:GetTextControl():SetColor(0xFF2222);
			--unitEntry.UnitTypeIcon:SetColor(0xFF0000);
			unitEntry.Button:GetTextControl():SetColorByName("OperationChance_Red");
			unitEntry.UnitTypeIcon:SetColorByName("OperationChance_Red");
		else
			--unitEntry.Button:GetTextControl():SetColor(0xFF7700);
			--unitEntry.UnitTypeIcon:SetColor(0xFF9933)
			unitEntry.Button:GetTextControl():SetColorByName("OperationChance_Orange");
			unitEntry.UnitTypeIcon:SetColorByName("OperationChance_Orange");
		end
	elseif unitInfo.Domain == "DOMAIN_SEA" then
		--table.insert(navalUnits, unitInfo);
		--unitEntry.Button:GetTextControl():SetColorByName("LightBlue");
		--unitEntry.UnitTypeIcon:SetColorByName("Blue");
		if unitInfo.RangedCombat == 0 then 
			--unitEntry.Button:GetTextControl():SetColor(0x2222FF);
			--unitEntry.UnitTypeIcon:SetColor(0x2222FF);
			unitEntry.Button:GetTextControl():SetColorByName("BodyTextBlueAlt");
			unitEntry.UnitTypeIcon:SetColorByName("BodyTextBlueAlt");
		else
			--unitEntry.Button:GetTextControl():SetColor(0x0077FF);
			--unitEntry.UnitTypeIcon:SetColor(0x0077FF)
			unitEntry.Button:GetTextControl():SetColorByName("BodyTextBlue");
			unitEntry.UnitTypeIcon:SetColorByName("BodyTextBlueAlt");
		end
	elseif unitInfo.Domain == "DOMAIN_AIR" then
		--table.insert(airUnits, unitInfo);
		--unitEntry.Button:GetTextControl():SetColor(0x33FFFF);
		--unitEntry.UnitTypeIcon:SetColor(0x33FFFF);

		unitEntry.Button:GetTextControl():SetColorByName("OperationChance_Green");
		unitEntry.UnitTypeIcon:SetColorByName("OperationChance_Green");
	end
end