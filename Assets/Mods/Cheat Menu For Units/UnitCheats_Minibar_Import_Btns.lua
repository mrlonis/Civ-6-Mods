-- UnitCheats_Minibar_Import_Btns
-- Author: Zur13
-- DateCreated: 5/8/2019 8:01:22 PM
--------------------------------------------------------------

--******************************************************************************
-- Collapse panel button was pressed.
function OnCollapse()
	--print( "Cheat collapse panel" );
	isMinibarCollapsed = true;

	ContextPtr:RequestRefresh(); OnRefresh();

	Controls.GUI_UnitCheats_Minibar_ExpandAnim:SetToEnd();  -- offset 0
	Controls.GUI_UnitCheats_Minibar_CollapseAnim:SetToBeginning();  -- offset 0

	Controls.GUI_UnitCheats_Minibar_CollapseAnim:Play();
	
	HideDup();
end

--******************************************************************************
-- Restore panel button was pressed.
function OnRestore()
	--print( "Cheat restore panel" );
	isMinibarCollapsed = false;

	ContextPtr:RequestRefresh(); OnRefresh();
	
	Controls.GUI_UnitCheats_CheatsButton_Grid:SetHide( false );
	
	Controls.GUI_UnitCheats_Minibar_ExpandAnim:SetToEnd();  -- offset 0
	Controls.GUI_UnitCheats_Minibar_CollapseAnim:SetToBeginning();  -- offset 0

	Controls.GUI_UnitCheats_Minibar_ExpandAnim:SetToBeginning();  -- offset -100
	Controls.GUI_UnitCheats_Minibar_ExpandAnim:Play();
end

--******************************************************************************
-- Promote button was pressed.
function OnPromote()
	--print( "Cheat Promote" );
	if ( isPlayerActive ) then
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
				
				ExposedMembers.MOD_UnitCheat.ChangeAutorestorePromo();
				ExposedMembers.MOD_UnitCheat.OnCheatPromote(selPlayerId, selUnitId);
				
				--UI:DeselectUnitID(selUnitId);
				--UI:SelectUnitID(selUnitId);
				ContextPtr:RequestRefresh(); OnRefresh();
			end

		end
	end

end

--******************************************************************************
-- Duplicate button was pressed.
function OnDuplicate()
	--print( "Cheat Duplicate Unit" );
	if ( isPlayerActive ) then
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
				local unitType	:string = GameInfo.Units[unit:GetUnitType()].UnitType;
				if Controls.GUI_UnitCheats_SpawnDlgContainer:IsHidden() then
					ShowDup();
				else
					HideDup();
				end
				--ExposedMembers.MOD_UnitCheat.OnDuplicate(selPlayerId, selUnitId, unitType );
				
				ContextPtr:RequestRefresh(); OnRefresh();
			end

		end
	end

end

--******************************************************************************
-- Movement button was pressed.
function OnMovement()
	--print( "Cheat Add Movement" );
	if ( isPlayerActive ) then
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
				
				ExposedMembers.MOD_UnitCheat.ChangeAutorestoreMove();
				ExposedMembers.MOD_UnitCheat.OnCheatMovement(selPlayerId, selUnitId, false);
				
				--UI:DeselectUnitID(selUnitId);
				--UI:SelectUnitID(selUnitId);
				ContextPtr:RequestRefresh(); OnRefresh();
			end

		end
	end

end

--******************************************************************************
-- Heal button was pressed.
function OnHeal()
	--print( "Cheat Heal" );
	if ( isPlayerActive ) then
		local pSelectedUnit = UI.GetHeadSelectedUnit();
		if ( pSelectedUnit ~= nil ) then
			--local units = Players[selPlayerId]:GetUnits();
			--local unit = units:FindID(selUnitId);
			
			local unit = nil;
			if UnitManager then 
				unit = UnitManager.GetUnit( selPlayerId, selUnitId ); 
			end
			if unit ~= nil and Players[selPlayerId]:IsHuman() then
				FixUiMode();
				
				ExposedMembers.MOD_UnitCheat.ChangeAutorestoreHealth();
				ExposedMembers.MOD_UnitCheat.OnCheatHeal(selPlayerId, selUnitId);

				--UI:DeselectUnitID(selUnitId);
				--UI:SelectUnitID(selUnitId);
				ContextPtr:RequestRefresh(); OnRefresh();
			end

		end
	end

end

--******************************************************************************
-- Attack button was pressed.
function OnAttack()
	--print( "Cheat Attack" );
	if ( isPlayerActive ) then
		local pSelectedUnit = UI.GetHeadSelectedUnit();
		if ( pSelectedUnit ~= nil ) then
			--local units = Players[selPlayerId]:GetUnits();
			--local unit = units:FindID(selUnitId);
			
			local unit = nil;
			if UnitManager then 
				unit = UnitManager.GetUnit( selPlayerId, selUnitId ); 
			end
			if unit ~= nil and Players[selPlayerId]:IsHuman() then
				FixUiMode();
				
				ExposedMembers.MOD_UnitCheat.ChangeAutorestoreAttack();
				ExposedMembers.MOD_UnitCheat.OnCheatAttack(selPlayerId, selUnitId);

				--UI:DeselectUnitID(selUnitId);
				--UI:SelectUnitID(selUnitId);
				ContextPtr:RequestRefresh(); OnRefresh();
			end

		end
	end

end