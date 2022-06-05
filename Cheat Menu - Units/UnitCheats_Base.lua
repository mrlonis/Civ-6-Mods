-- UnitCheats_Base.lua
-- Author: Zur13
-- DateCreated: 10/31/2018 11:35:55 PM
--------------------------------------------------------------
local autorestoreAttack : boolean = false;
local autorestoreHealth : boolean = false;
local autorestoreMove   : boolean = false;
local autorestorePromo  : boolean = false;

local targetMovePoints = 400;

local prevCheatMoveUnit = nil;
local prevCheatMovePoints = nil;

--******************************************************************************
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))      
	elseif type(v) == 'userdata' then
		print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end

--local ChangeMovesRemaining = UnitManager.ChangeMovesRemaining;
--local FinishMoves = UnitManager.FinishMoves;
--
--UnitManager.ChangeMovesRemaining = function (unit, MovePoints)
	--if autorestoreMove and MovePoints < 0 then 
		--print("ChangeMovesRemaining ######################### 1");
		--ChangeMovesRemaining(unit, targetMovePoints);
		--print("ChangeMovesRemaining ######################### 2");
	--else
		--ChangeMovesRemaining(unit, MovePoints);
	--end
--end
--
--UnitManager.FinishMoves = function (unit)
	--if autorestoreMove then 
		--print("FinishMoves ######################### 1");
		--ChangeMovesRemaining(unit, targetMovePoints);
		--print("FinishMoves ######################### 2");
	--else
		--FinishMoves(unit);
	--end
--end

--******************************************************************************
local function GetAutorestoreAttack()
	return autorestoreAttack;
end

--******************************************************************************
local function ChangeAutorestoreAttack()
	if autorestoreAttack then
		autorestoreAttack = false;
	else 
		autorestoreAttack = true;
	end
	return autorestoreAttack;
end

--******************************************************************************
local function GetAutorestoreHealth()
	return autorestoreHealth;
end

--******************************************************************************
local function ChangeAutorestoreHealth()
	if autorestoreHealth then
		autorestoreHealth = false;
	else 
		autorestoreHealth = true;
	end
	return autorestoreHealth;
end

--******************************************************************************
local function GetAutorestoreMove()
	return autorestoreMove;
end

--******************************************************************************
local function ChangeAutorestoreMove()
	if autorestoreMove then
		autorestoreMove = false;
	else 
		autorestoreMove = true;
	end
	return autorestoreMove;
end

--******************************************************************************
local function GetAutorestorePromo()
	return autorestorePromo;
end

--******************************************************************************
local function ChangeAutorestorePromo()
	if autorestorePromo then
		autorestorePromo = false;
	else 
		autorestorePromo = true;
	end
	return autorestorePromo;
end

--******************************************************************************
local function RefreshGUI(selectedPlayerId, unitId)
	----print(" OnCheatMovement BASE COUNT -- ", Events.UnitDamageChanged.Count());
	--print(" RefreshGUI BASE 1 -- ", selectedPlayerId, unitId);
	--local unit = nil;
	--if UnitManager then 
		--unit = UnitManager.GetUnit( selectedPlayerId, unitId ); 
		--print(" RefreshGUI BASE 2 -- ", unit);
	--end
	--if unit ~= nil and Players[selectedPlayerId]:IsHuman() then
		--local uDamage = unit:GetDamage();
		--local uMDamage = unit:GetMaxDamage();
		--if uDamage ~= 0 then
			--unit:SetDamage(0);
			--unit:SetDamage(uDamage);
		--elseif uMDamage > 1 then
			--unit:SetDamage(1);
			--unit:SetDamage(uDamage);
		--end
		
		--print(" RefreshGUI BASE 3 -- ", uDamage);
		--Events.UnitDamageChanged(selectedPlayerId, unitId, uDamage, uDamage);
		--Events.UnitPromoted(selectedPlayerId, unitId);
		--LuaEvents.TutorialUIRoot_DisableActions(  "UNITOPERATION_RETRAIN", "UNIT_SETTLER" );	
		--print(" RefreshGUI BASE 4 -- ", uDamage, uMDamage);
	--end
	if ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel ~= nil then
		ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
	end
end

--******************************************************************************
local function LookAtPlot(selectedPlayerId, unitId)
	if ExposedMembers.MOD_UnitCheat.LookAtPlot ~= nil then
		ExposedMembers.MOD_UnitCheat.LookAtPlot(selectedPlayerId, unitId);
	end
end

--******************************************************************************
local function IsDestinationReached(PlayerID, UnitID)
	if PlayerID ~= nil and UnitID ~= nil and Players[PlayerID] ~= nil and Players[PlayerID]:IsHuman() then
		local unit = nil;
		if UnitManager then 
			unit = UnitManager.GetUnit( PlayerID, UnitID ); 
		end

		if unit ~= nil then 
			local unitMovesRem, queuedEndPlotId = ExposedMembers.MOD_UnitCheat.GetUnitMovesFromUI(PlayerID, UnitID);
			if queuedEndPlotId then
				--print( "IsDestinationReached 0: ", queuedEndPlotId );
				--if Map.IsPlot(queuedEndPlotId) then
					--print( "Cheat OnMovementComplete Destination 1: ", queuedEndPlotId );
					local plot :table	= Map.GetPlotByIndex(queuedEndPlotId);
					--print( "Cheat OnMovementComplete Destination 2: ", plot );
					if  plot ~= nil and (plot:GetX()~=unit:GetX() or plot:GetY()~=unit:GetY())  then 
						--print( "Destination was not reached: ", plot );
						-- destination was not reached
						return false;
					else
							
					end
				--end
			end
		end
	end
	return true;
end

--******************************************************************************
local function OnCombat(m_combatResults)
	if autorestoreAttack or autorestoreHealth then 
		--print( "On Combat Event :" );
		local cId = m_combatResults[CombatResultParameters.ATTACKER][CombatResultParameters.ID];
		if cId ~= nil then
			local unitId = cId.id;
			local playerId = cId.player;

			local unit = nil;
			if UnitManager then 
				unit = UnitManager.GetUnit( playerId, unitId ); 
			end
			if unit ~= nil and Players[playerId]:IsHuman() then
				if autorestoreAttack then 
					print( "Cheat Autorestore Unit Attack Executed" );
					UnitManager.RestoreUnitAttacks(unit);
					local unitMovesRem = ExposedMembers.MOD_UnitCheat.GetUnitMovesFromUI(playerId, unitId);
					UnitManager.ChangeMovesRemaining(unit, 1);
					if unitMovesRem < 8 then
						UnitManager.ChangeMovesRemaining(unit, 4);
					end
				end
				--if autorestoreHealth then 
					--print( "Cheat Autorestore Unit Health Executed" );
					--unit:SetDamage(0);
				--end
				if autorestoreMove then
					print( "Cheat Autorestore Unit Movement Executed");
					UnitManager.RestoreMovement(unit);
					UnitManager.ChangeMovesRemaining(unit, targetMovePoints);
				end
				RefreshGUI();
			end
		end
	end
	--tprint(m_combatResults, 8);
end

--******************************************************************************
function OnUnitDamageChanged(PlayerID, UnitID, newDamage, prevDamage)
	if autorestoreHealth and PlayerID ~= nil and PlayerID ~= -1 and newDamage ~= 0 then 
		local unit = nil;
		if UnitManager then 
			unit = UnitManager.GetUnit( PlayerID, UnitID ); 
		end
		if unit ~= nil and Players[PlayerID] ~= nil and Players[PlayerID]:IsHuman() then
			print( "Cheat Autorestore Unit Health Executed" );
			unit:SetDamage(0);
			RefreshGUI();
		end
	end
end

--******************************************************************************
local function OnMovementRestored(PlayerID, UnitID, MovementPoints)
	
end

--******************************************************************************
local function OnMovementComplete(PlayerID, UnitID, x, y)
	if autorestoreMove and PlayerID ~= nil and UnitID ~= nil and Players[PlayerID] ~= nil and Players[PlayerID]:IsHuman() then
		local unit = nil;
		if UnitManager then 
			unit = UnitManager.GetUnit( PlayerID, UnitID ); 
		end

		if unit ~= nil then 
				UnitManager.RestoreMovement(unit);
				--ExposedMembers.MOD_UnitCheat.RequestDelayedMovementCheat();
				UnitManager.ChangeMovesRemaining(unit, targetMovePoints);

				if not IsDestinationReached(PlayerID, UnitID) then 
					-- destination was not reached
					LookAtPlot(PlayerID, UnitID);
					ExposedMembers.MOD_UnitCheat.UiRefreshSelection( PlayerID, UnitID );
				end
				--if queuedEndPlotId then
					--print( "Cheat OnMovementComplete Destination 0: ", queuedEndPlotId );
					----if Map.IsPlot(queuedEndPlotId) then
						----print( "Cheat OnMovementComplete Destination 1: ", queuedEndPlotId );
						--local plot :table	= Map.GetPlotByIndex(queuedEndPlotId);
						----print( "Cheat OnMovementComplete Destination 2: ", plot );
						--if  plot ~= nil and (plot:GetX()~=x or plot:GetY()~=y)  then 
							--print( "Destination was not reached: ", plot );
							---- destination was not reached
							--LookAtPlot(PlayerID, UnitID);
							--ExposedMembers.MOD_UnitCheat.UiRefreshSelection( PlayerID, UnitID );
							----ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
						--else
							--
						--end
					----end
				--end

				-- Look at unit position
				--plot = Map.GetPlot( unit:GetX(), unit:GetY() );
				--UI.LookAtPlot( plot );
				--LookAtPlot(PlayerID, UnitID);
				--UnitManager.FinishMoves(unit);
			--end
		end
	end
end

--******************************************************************************
local function OnMovementChange(PlayerID, UnitID, MovementPoints)
	if autorestoreMove and  PlayerID ~= nil and UnitID ~= nil and Players[PlayerID] ~= nil and Players[PlayerID]:IsHuman() then
		
		local unit = nil;
		if UnitManager then 
			unit = UnitManager.GetUnit( PlayerID, UnitID ); 
		end

		if unit ~= nil and MovementPoints ~= nil and MovementPoints < 3.25 then 
			--local moveDiff = math.floor(targetMovePoints - MovementPoints);
			--local unitMovesRem = ExposedMembers.MOD_UnitCheat.GetUnitMovesFromUI(PlayerID, UnitID);
			--print( "Cheat OnMovementChange Executed 11: ", MovementPoints, moveDiff );
			
			--UnitManager.RestoreMovement(unit);
			--UnitManager.FinishMoves(unit);
			--UnitManager.ChangeMovesRemaining(unit, targetMovePoints);
			--UnitManager.ChangeMovesRemaining(unit, 8);
			--UnitManager.FinishMoves(unit);
		elseif unit ~= nil and MovementPoints == nil then
			-- On clear movement points
			--UnitManager.ChangeMovesRemaining(unit, targetMovePoints+1);
			--print( "Cheat OnMovementChange Executed 22: ", MovementPoints );
			UnitManager.RestoreMovement(unit);
			ExposedMembers.MOD_UnitCheat.RequestDelayedMovementCheat();
			--UnitManager.ChangeMovesRemaining(unit, targetMovePoints);

			--if unit:GetExperience():GetExperienceForNextLevel() == 0 then
				-- due to promotion
				--ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
			--end
			--UnitManager.FinishMoves(unit);
			RefreshGUI();
		end
		ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
	end
end

--******************************************************************************
local function ApplyAutorestoreMovementCheat(PlayerID, UnitID, MovementPoints)
	if autorestoreMove and  PlayerID ~= nil and UnitID ~= nil and Players[PlayerID] ~= nil and Players[PlayerID]:IsHuman() then
		
		local unit = nil;
		if UnitManager then 
			unit = UnitManager.GetUnit( PlayerID, UnitID ); 
		end

		if unit ~= nil and MovementPoints ~= nil then 
			--local moveDiff = math.floor(targetMovePoints - MovementPoints);
			--local unitMovesRem = ExposedMembers.MOD_UnitCheat.GetUnitMovesFromUI(PlayerID, UnitID);
			--print( "Cheat ApplyAutorestoreMovementCheat Executed: ", MovementPoints );
			
			--UnitManager.RestoreMovement(unit);
			--UnitManager.FinishMoves(unit);
			UnitManager.ChangeMovesRemaining(unit, MovementPoints);
			--UnitManager.ChangeMovesRemaining(unit, 8);
			--UnitManager.FinishMoves(unit);
		elseif unit ~= nil and MovementPoints == nil then
			-- On clear movement points
			--UnitManager.ChangeMovesRemaining(unit, targetMovePoints+1);
			--print( "Cheat ApplyAutorestoreMovementCheat Executed: ", MovementPoints );
			--UnitManager.RestoreMovement(unit);
			--ExposedMembers.MOD_UnitCheat.RequestDelayedMovementCheat();
			UnitManager.ChangeMovesRemaining(unit, targetMovePoints);

			--if unit:GetExperience():GetExperienceForNextLevel() == 0 then
				-- due to promotion
				--ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
			--end
			--UnitManager.FinishMoves(unit);
			--RefreshGUI();
		end
		--ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
	end
end

--******************************************************************************
local function OnUnitEmbarkedStateChanged( PlayerID: number, UnitID : number, EmbarkedState : boolean )
	if autorestoreMove and PlayerID ~= nil and UnitID ~= nil and Players[PlayerID] ~= nil and Players[PlayerID]:IsHuman() then
	
		local unit = nil;
		if UnitManager then 
			unit = UnitManager.GetUnit( PlayerID, UnitID ); 
		end

		if unit ~= nil then
			--print( "Cheat OnUnitEmbarkedStateChanged 11: ", MovementPoints );
			UnitManager.RestoreMovement(unit);
			UnitManager.ChangeMovesRemaining(unit, targetMovePoints);
			if not IsDestinationReached(PlayerID, UnitID) then 
				-- destination was not reached
				LookAtPlot(PlayerID, UnitID);
				ExposedMembers.MOD_UnitCheat.UiRefreshSelection( PlayerID, UnitID );
			end
		end
	end
end

--******************************************************************************
local function OnCheatHeal(selectedPlayerId, unitId)
	-- local units = Players[selectedPlayerId]:GetUnits();
	-- local unit = units:FindID(unitId);
	
	local unit = nil;
	if UnitManager then 
		unit = UnitManager.GetUnit( selectedPlayerId, unitId ); 
	end
	if unit ~= nil and Players[selectedPlayerId]:IsHuman() and autorestoreHealth then
		if unit:GetDamage() then 
			print( "Cheat Heal Exposed Executed" );
			unit:SetDamage(0);
			--ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
			RefreshGUI();
		end
	end
end

--******************************************************************************
local function OnDuplicate(selectedPlayerId, unitId, unitType, overridePlayer, overrideType, overrideDestPlotId, overrideDestPlotX, overrideDestPlotY, ttype, useValidLoc, count, pRelig )
	-- local units = Players[selectedPlayerId]:GetUnits();
	-- local unit = units:FindID(unitId);
	
	local unit = nil;
	local newUnit = nil;
	if UnitManager then 
		unit = UnitManager.GetUnit( selectedPlayerId, unitId ); 
	end
	if unit ~= nil and Players[selectedPlayerId]:IsHuman() then
		--print( "Cheat Duplicate Exposed Executed" );
		local x = unit:GetX();
		local y = unit:GetY();
		if overrideDestPlotId ~= nil and overrideDestPlotX ~= nil and overrideDestPlotY ~= nil and overrideDestPlotX ~= 0 and overrideDestPlotY ~= 0 then
			--print( "Cheat Duplicate Exposed Plot Override 11", x, y, unitType, newUnit, overrideDestPlotId );
			x = overrideDestPlotX;
			y = overrideDestPlotY;
			--local plot = Map.GetPlotByIndex(overrideDestPlotId);
			--if plot ~= nil then
				
				--x = plot:GetX();
				--y = plot:GetY();
			--end
		end
		if overridePlayer ~= nil then
			--print( "Cheat Duplicate Exposed Player Override 22 ", x, y, unitType, selectedPlayerId );
			selectedPlayerId = overridePlayer;
		end		
		if overrideType ~= nil then
			--print( "Cheat Duplicate Exposed Type Override 33 ", x, y, unitType, selectedPlayerId );
			unitType = overrideType;
		end
		-- local typeName = UnitManager.GetTypeName(unit);
		--print( "Cheat Duplicate Exposed Executed ", x, y, unitType );
		--print( "Cheat Duplicate Exposed Executed 44", x, y, unitType, selectedPlayerId, ttype );
		local dupRepeat = 1;
		if count ~= nil and count > 1 then
			dupRepeat = count;
		end
		for i = dupRepeat, 1, -1 do
			if useValidLoc then 
				newUnit = UnitManager.InitUnitValidAdjacentHex(selectedPlayerId, unitType, x, y, 40);
			else
				newUnit = UnitManager.InitUnit(selectedPlayerId, unitType, x, y);
			end
		end
		print( "Cheat Duplicate Exposed Executed", x, y, unitType, newUnit, selectedPlayerId, useValidLoc, count );
		--newUnit:GetExperience():ChangeExperience(unit:GetExperience():GetExperiencePoints());
		if unit:GetReligion() ~= nil and newUnit:GetReligion() ~= nil and unit:GetReligion():GetReligionType() ~= -1 then
			print( "Cheat Duplicate Exposed Executed Set Religion from unit", x, y, unitType, unit:GetReligion():GetReligionType(), newUnit:GetReligion():GetReligionType() );
			newUnit:GetReligion():SetReligionType(unit:GetReligion():GetReligionType());
		elseif pRelig ~= nil and newUnit:GetReligion() ~= nil and pRelig ~= -1 then
			print( "Cheat Duplicate Exposed Executed Set Religion from player", x, y, unitType, pRelig, newUnit:GetReligion():GetReligionType() );
			newUnit:GetReligion():SetReligionType( pRelig );
		end

		--ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
		--local ttype = unit:GetUnitType();
		--local unitt = GameInfo.Units[ttype];
		--tprint( unitt , 8 );
		--for k,v in pairs(unitt) do print (k,v) end
		RefreshGUI();
	end
end

--******************************************************************************
local function OnCheatMovement(selectedPlayerId, unitId, disableRefreshRequest)
	-- local units = Players[selectedPlayerId]:GetUnits();
	-- local unit = units:FindID(unitId);
	
	local unit = nil;
	if UnitManager then 
		unit = UnitManager.GetUnit( selectedPlayerId, unitId ); 
	end
	
	if unit ~= nil and Players[selectedPlayerId]:IsHuman() then
		local unitMovesRem = ExposedMembers.MOD_UnitCheat.GetUnitMovesFromUI(selectedPlayerId, unitId);
		if (unitMovesRem+10) < targetMovePoints then
			print( "Cheat Movement Exposed Executed" );
			UnitManager.ChangeMovesRemaining(unit, 10);
			
			if prevCheatMoveUnit == nil then 
				prevCheatMoveUnit = unitId;
				prevCheatMovePoints = unitMovesRem+10;
			end
			if autorestoreMove and (unitMovesRem+10) < targetMovePoints then
				UnitManager.RestoreMovement(unit);
				UnitManager.ChangeMovesRemaining(unit, targetMovePoints);
				--UnitManager.ChangeMovesRemaining(unit, (targetMovePoints-(unitMovesRem+10)) );
			end
			--if not disableRefreshRequest then
				--ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
			--end
		elseif not autorestoreMove and prevCheatMoveUnit ~= nil and prevCheatMovePoints ~= nil then
			unit = UnitManager.GetUnit( selectedPlayerId, prevCheatMoveUnit ); 
			unitMovesRem = ExposedMembers.MOD_UnitCheat.GetUnitMovesFromUI(selectedPlayerId, prevCheatMoveUnit);
			if unit and unitMovesRem > prevCheatMovePoints then
				-- decrease move points to initial value after it was toggled off
				UnitManager.ChangeMovesRemaining(unit, (prevCheatMovePoints-unitMovesRem) );
				--if not disableRefreshRequest then
					--ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
				--end
			end
			prevCheatMoveUnit = nil;
			prevCheatMovePoints = nil;
		end
	end
	RefreshGUI(selectedPlayerId, unitId);
end

--******************************************************************************
local function OnCheatPromote(selectedPlayerId, unitId)
	-- local units = Players[selectedPlayerId]:GetUnits();
	-- local unit = units:FindID(unitId);
	
	local unit = nil;
	if UnitManager then 
		unit = UnitManager.GetUnit( selectedPlayerId, unitId ); 
	end
	if unit ~= nil and Players[selectedPlayerId]:IsHuman() and autorestorePromo then
		local reqExp = unit:GetExperience():GetExperienceForNextLevel();
		if reqExp > 0 then
			print( "Cheat Promotion Exposed Executed" );
			unit:GetExperience():ChangeExperience(reqExp);
			UnitManager.ChangeMovesRemaining(unit, 1);

			--#################################################################################################################################################################
			--PlayersVisibility[selectedPlayerId]:RevealAllPlots();
			--local x = unit:GetX();
			--local y = unit:GetY()-15;
			--PlayersVisibility[selectedPlayerId]:Reveal( x, y );
			--for k,v in pairs(PlayersVisibility[selectedPlayerId]) do print ("PlayersVisibility: ", k,v) end
		end
		--ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
		RefreshGUI();
	end
end

--******************************************************************************
local function OnCheatAttack(selectedPlayerId, unitId, isSilent)
	-- local units = Players[selectedPlayerId]:GetUnits();
	-- local unit = units:FindID(unitId);
	
	local unit = nil;
	if UnitManager then 
		unit = UnitManager.GetUnit( selectedPlayerId, unitId ); 
	end
	if unit ~= nil and Players[selectedPlayerId]:IsHuman() and autorestoreAttack then
		if isSilent == nil or not isSilent then
			print( "Cheat Attack Exposed Executed" );
		end
		UnitManager.RestoreUnitAttacks(unit);
		local unitMovesRem = ExposedMembers.MOD_UnitCheat.GetUnitMovesFromUI(selectedPlayerId, unitId);
		UnitManager.ChangeMovesRemaining(unit, 1);
		if unitMovesRem < 8 then
			UnitManager.ChangeMovesRemaining(unit, 4);
		end
		--ExposedMembers.MOD_UnitCheat.UiRefreshUnitPanel();
		RefreshGUI();
	end
end

--******************************************************************************
function Initialize()
	print( " ###################################### Initializing Mod Unit Cheat Base Script... ################################################ " );
	Events.Combat.Add(OnCombat);
	Events.UnitDamageChanged.Add( OnUnitDamageChanged );

	Events.UnitMovementPointsChanged.Add(OnMovementChange);
	Events.UnitMovementPointsCleared.Add(OnMovementChange);
	Events.UnitMovementPointsRestored.Add(OnMovementRestored);
	Events.UnitMoveComplete.Add(OnMovementComplete);

	Events.UnitEmbarkedStateChanged.Add( OnUnitEmbarkedStateChanged );

	-- Gedemon's method for sharing functions between different contexts using the ExposedMembers table.
	if ( not ExposedMembers.MOD_UnitCheat) then ExposedMembers.MOD_UnitCheat = {}; end
	ExposedMembers.MOD_UnitCheat.OnCheatHeal = OnCheatHeal;
	ExposedMembers.MOD_UnitCheat.OnDuplicate = OnDuplicate;
	ExposedMembers.MOD_UnitCheat.OnCheatMovement = OnCheatMovement;
	ExposedMembers.MOD_UnitCheat.OnCheatPromote = OnCheatPromote;
	ExposedMembers.MOD_UnitCheat.OnCheatAttack = OnCheatAttack;
		
	ExposedMembers.MOD_UnitCheat.GetAutorestoreAttack = GetAutorestoreAttack;
	ExposedMembers.MOD_UnitCheat.ChangeAutorestoreAttack = ChangeAutorestoreAttack;
	ExposedMembers.MOD_UnitCheat.GetAutorestoreHealth = GetAutorestoreHealth;
	ExposedMembers.MOD_UnitCheat.ChangeAutorestoreHealth = ChangeAutorestoreHealth;
	ExposedMembers.MOD_UnitCheat.GetAutorestoreMove = GetAutorestoreMove;
	ExposedMembers.MOD_UnitCheat.ChangeAutorestoreMove = ChangeAutorestoreMove;
	ExposedMembers.MOD_UnitCheat.GetAutorestorePromo = GetAutorestorePromo;
	ExposedMembers.MOD_UnitCheat.ChangeAutorestorePromo = ChangeAutorestorePromo;
	ExposedMembers.MOD_UnitCheat.ApplyAutorestoreMovementCheat = ApplyAutorestoreMovementCheat;
	ExposedMembers.MOD_UnitCheat_Initialized = true;
	
end

Initialize();