-- Copyright 2017-2018, Firaxis Games.
-- Leader container list on top of the HUD

include("InstanceManager");
include("LeaderIcon");
include("PlayerSupport");
include("ExtendedRelationship"); -- Separate Extended Relationship file (code shared)

-- ===========================================================================
--	CONSTANTS
-- ===========================================================================
local SCROLL_SPEED			:number = 3;

-- ===========================================================================
--	GLOBALS
-- ===========================================================================
g_maxNumLeaders	= 0; -- Number of leaders that can fit in the ribbon


-- ===========================================================================
--	MEMBERS
-- ===========================================================================
local m_leadersMet		     :number = 0; -- Number of leaders in the ribbon
local m_scrollIndex		     :number = 0; -- Index of leader that is supposed to be on the far right
local m_scrollPercent		   :number = 0; -- Necessary for scroll lerp
local m_isScrolling			   :boolean = false;
local CQUI_IsDiploBannerOn = GameConfiguration.GetValue("CQUI_ShowDiploBanner"); --ARISTOS: controls the display of Diplo Banner
local m_uiLeadersByID		   :table = {};
local m_uiChatIconsVisible :table = {};
local m_kLeaderIM			     :table = CQUI_IsDiploBannerOn and InstanceManager:new("LeaderInstance", "LeaderContainer", Controls.LeaderStack)
                                    or InstanceManager:new("LeaderInstanceNormal", "LeaderContainer", Controls.LeaderStack); --ARISTOS: to make Diplo Banner optional


--CQUI Members
-- ARISTOS: Mouse over leader icon to show relations
local m_isCTRLDown       :boolean= false;
local CQUI_hoveringOverPortrait = false;

-- ===========================================================================
--	Cleanup leaders
-- ===========================================================================
function ResetLeaders()
  m_leadersMet = 0;
  m_uiLeadersByID = {};
  m_kLeaderIM:ResetInstances();
  m_scrollPercent = 0;
  m_scrollIndex = 0;
  RealizeScroll();
end

--ARISTOS: Update Diplo Banner display status
function CQUI_OnSettingsUpdate()
  CQUI_IsDiploBannerOn = GameConfiguration.GetValue("CQUI_ShowDiploBanner");
  ResetLeaders();
  m_kLeaderIM = CQUI_IsDiploBannerOn and InstanceManager:new("LeaderInstance", "LeaderContainer", Controls.LeaderStack)
                    or InstanceManager:new("LeaderInstanceNormal", "LeaderContainer", Controls.LeaderStack); --ARISTOS: to make Diplo Banner optional
  UpdateLeaders();
end
LuaEvents.CQUI_SettingsUpdate.Add( CQUI_OnSettingsUpdate );

-- ===========================================================================
function OnLeaderClicked(playerID : number )
  -- Send an event to open the leader in the diplomacy view (only if they met)

  local localPlayerID:number = Game.GetLocalPlayer();
  if playerID == localPlayerID or Players[localPlayerID]:GetDiplomacy():HasMet(playerID) then
    LuaEvents.DiplomacyRibbon_OpenDiplomacyActionView( playerID );
  end
end

-- ===========================================================================
function OnLeaderRightClicked(ms_SelectedPlayerID : number )

  local ms_LocalPlayerID:number = Game.GetLocalPlayer();
  if ms_SelectedPlayerID == ms_LocalPlayerID then
    UpdateLeaders();
  end
  local pPlayer = Players[ms_LocalPlayerID];
  local iPlayerDiploState = pPlayer:GetDiplomaticAI():GetDiplomaticStateIndex(ms_SelectedPlayerID);
  local relationshipHash = GameInfo.DiplomaticStates[iPlayerDiploState].Hash;
  --ARISTOS: to check if Peace Deal is valid
  local bValidAction, tResults = pPlayer:GetDiplomacy():IsDiplomaticActionValid("DIPLOACTION_PROPOSE_PEACE_DEAL", ms_SelectedPlayerID, true); --ARISTOS
  if (not (relationshipHash == DiplomaticStates.WAR)) then
    if (not DealManager.HasPendingDeal(ms_LocalPlayerID, ms_SelectedPlayerID)) then
      DealManager.ClearWorkingDeal(DealDirection.OUTGOING, ms_LocalPlayerID, ms_SelectedPlayerID);
    end
    DiplomacyManager.RequestSession(ms_LocalPlayerID, ms_SelectedPlayerID, "MAKE_DEAL");
  --ARISTOS: To make Right Click on leader go directly to peace deal if Peace Deal is valid
  elseif bValidAction then
    if (not DealManager.HasPendingDeal(ms_LocalPlayerID, ms_SelectedPlayerID)) then
      DealManager.ClearWorkingDeal(DealDirection.OUTGOING, ms_LocalPlayerID, ms_SelectedPlayerID);
      local pDeal = DealManager.GetWorkingDeal(DealDirection.OUTGOING, ms_LocalPlayerID, ms_SelectedPlayerID);
      if (pDeal ~= nil) then
        pDealItem = pDeal:AddItemOfType(DealItemTypes.AGREEMENTS, ms_LocalPlayerID);
        if (pDealItem ~= nil) then
          pDealItem:SetSubType(DealAgreementTypes.MAKE_PEACE);
          pDealItem:SetLocked(true);
        end
        -- Validate the deal, this will make sure peace is on both sides of the deal.
        pDeal:Validate();
      end
    end
    DiplomacyManager.RequestSession(ms_LocalPlayerID, ms_SelectedPlayerID, "MAKE_DEAL");
  end
  LuaEvents.QuickDealModeActivate();
end

-- ===========================================================================
-- ARISTOS: To show relationship icon of other civs on hovering mouse over a given leader
function OnLeaderMouseOver(playerID : number )
  CQUI_hoveringOverPortrait = true;
  local localPlayerID:number = Game.GetLocalPlayer();
  local playerDiplomacy = Players[playerID]:GetDiplomacy();
  if m_isCTRLDown then
    UI.PlaySound("Main_Menu_Mouse_Over");
    for otherPlayerID, instance in pairs(m_uiLeadersByID) do
      local pPlayer:table = Players[otherPlayerID];
      local pPlayerConfig:table = PlayerConfigurations[otherPlayerID];
      local isHuman:boolean = pPlayerConfig:IsHuman();
      -- Set relationship status (for non-local players)
      local diplomaticAI:table = pPlayer:GetDiplomaticAI();
      local relationshipStateID:number = diplomaticAI:GetDiplomaticStateIndex(playerID);
      if relationshipStateID ~= -1 then
        local relationshipState:table = GameInfo.DiplomaticStates[relationshipStateID];
        -- Always show relationship icon for AIs, only show player triggered states for humans
        if not isHuman or Relationship.IsValidWithAI(relationshipState.StateType) then
          --!! ARISTOS: to extend relationship tooltip to include diplo modifiers!
          local relationshipTooltip:string = Locale.Lookup(relationshipState.Name)
          --!! Extend it only of the selected player is the local player!
          .. (localPlayerID == playerID and ("[NEWLINE][NEWLINE]" .. RelationshipGet(otherPlayerID)) or "");
          -- KWG: This is bad, there is a piece of art that is tied to the order of a database entry.  Please fix!
          instance.Relationship:SetVisState(relationshipStateID);
          --ARISTOS: this shows a ? mark instead of leader portrait if player is unknown to the selected leader
          if (otherPlayerID == playerID or otherPlayerID == localPlayerID) then
            instance.Relationship:SetHide(true);
            instance.Portrait:SetIcon("ICON_"..PlayerConfigurations[otherPlayerID]:GetLeaderTypeName());
          elseif playerDiplomacy:HasMet(otherPlayerID) then
            instance.Relationship:SetToolTipString(relationshipTooltip);
            instance.Relationship:SetHide(false);
            instance.Portrait:SetIcon("ICON_"..PlayerConfigurations[otherPlayerID]:GetLeaderTypeName());
          else
            instance.Portrait:SetIcon("ICON_LEADER_DEFAULT");
            instance.Relationship:LocalizeAndSetToolTip("LOC_DIPLOPANEL_UNMET_PLAYER");
            instance.Relationship:SetHide(false);
          end
        end
      end
      if(playerID == otherPlayerID) then
        instance.YouIndicator:SetHide(false);
      else
        instance.YouIndicator:SetHide(true);
      end
    end
  end
end

function OnLeaderMouseExit()
  CQUI_hoveringOverPortrait = false;
end

-- ===========================================================================
--	Add a leader (from right to left)
-- ===========================================================================
function AddLeader(iconName : string, playerID : number, isUniqueLeader: boolean)
  m_leadersMet = m_leadersMet + 1;

  local pPlayer:table = Players[playerID];
  local pPlayerConfig:table = PlayerConfigurations[playerID];
  local isHuman:boolean = pPlayerConfig:IsHuman();

  -- Create a new leader instance
  local leaderIcon, instance = LeaderIcon:GetInstance(m_kLeaderIM);
  m_uiLeadersByID[playerID] = instance;

  leaderIcon:UpdateIcon(iconName, playerID, isUniqueLeader);
  leaderIcon:RegisterCallback(Mouse.eLClick, function() OnLeaderClicked(playerID); end);
  leaderIcon:RegisterCallback(Mouse.eRClick, function() OnLeaderRightClicked(playerID); end);
  leaderIcon:RegisterCallback( Mouse.eMouseEnter, function() OnLeaderMouseOver(playerID); end ); --ARISTOS
  leaderIcon:RegisterCallback( Mouse.eMouseExit, function() OnLeaderMouseExit(); end );
  leaderIcon:RegisterCallback( Mouse.eMClick, function() OnLeaderMouseOver(playerID); end ); --ARISTOS

  local bShowRelationshipIcon:boolean = false;
  local localPlayerID:number = Game.GetLocalPlayer();

  if(playerID == localPlayerID) then
    instance.YouIndicator:SetHide(false);
  else
    -- Set relationship status (for non-local players)
    local diplomaticAI:table = pPlayer:GetDiplomaticAI();
    local relationshipStateID:number = diplomaticAI:GetDiplomaticStateIndex(localPlayerID);
    if relationshipStateID ~= -1 then
      local relationshipState:table = GameInfo.DiplomaticStates[relationshipStateID];
      -- Always show relationship icon for AIs, only show player triggered states for humans
      if not isHuman or Relationship.IsValidWithAI(relationshipState.StateType) then
        --!! ARISTOS: to extend relationship tooltip to include diplo modifiers!
        local extendedRelationshipTooltip:string = Locale.Lookup(relationshipState.Name)
        .. "[NEWLINE][NEWLINE]" .. RelationshipGet(playerID);
        -- KWG: This is bad, there is a piece of art that is tied to the order of a database entry.  Please fix!
        instance.Relationship:SetVisState(relationshipStateID);
        instance.Relationship:SetToolTipString(extendedRelationshipTooltip);
        bShowRelationshipIcon = true;
      end
    end
    instance.YouIndicator:SetHide(true);
  end

  -- CQUI: Set score values for DRS display
  --ARISTOS: only if Diplo Banner ON
  if CQUI_IsDiploBannerOn then
    instance.CQUI_ScoreOverall:SetText("[ICON_Capital]"..Players[playerID]:GetScore());
    instance.CQUI_ScienceRate:SetText("[ICON_Science]"..Round(Players[playerID]:GetTechs():GetScienceYield(),0));
    instance.CQUI_MilitaryStrength:SetText("[ICON_Strength]"..Players[playerID]:GetStats():GetMilitaryStrength());
  end

  instance.Relationship:SetHide(not bShowRelationshipIcon);
  -- Set the tooltip
  if(pPlayerConfig ~= nil) then
    local leaderTypeName:string = pPlayerConfig:GetLeaderTypeName();
    if(leaderTypeName ~= nil) then
      -- Append GetExtendedTooltip string to the end of the tooltip created by LeaderIcon
      if (not GameConfiguration.IsAnyMultiplayer() or not isHuman) then
        local civData:string = GetExtendedTooltip(playerID);
        local currentTooltipString = instance.Portrait:GetToolTipString();
        instance.Portrait:SetToolTipString(currentTooltipString..civData);
      end
    end
  end

  -- Returning these so mods can override them and modify the icons
  return leaderIcon, instance;
end

--ARISTOS: To display key information in leader tooltip inside Diplo Ribbon
function GetExtendedTooltip(playerID:number)
  local govType:string = "";
  local eSelectePlayerGovernment :number = Players[playerID]:GetCulture():GetCurrentGovernment();
  if eSelectePlayerGovernment ~= -1 then
    govType = Locale.Lookup(GameInfo.Governments[eSelectePlayerGovernment].Name);
  else
    govType = Locale.Lookup("LOC_GOVERNMENT_ANARCHY_NAME" );
  end
  local cities = Players[playerID]:GetCities();
  local numCities = 0;
  for i,city in cities:Members() do
    numCities = numCities + 1;
  end
  --ARISTOS: Add gold to tooltip
  local playerTreasury:table	= Players[playerID]:GetTreasury();
  local goldBalance	:number = math.floor(playerTreasury:GetGoldBalance());
  local goldYield	:number = math.floor((playerTreasury:GetGoldYield() - playerTreasury:GetTotalMaintenance()));

  local civData:string = "[NEWLINE]"..Locale.Lookup("LOC_DIPLOMACY_INTEL_GOVERNMENT").." "..govType
    .."[NEWLINE]"..Locale.Lookup("LOC_PEDIA_CONCEPTS_PAGEGROUP_CITIES_NAME").. ": "..numCities
    .."[NEWLINE][ICON_Capital] "..Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_DOMINATION_SCORE", Players[playerID]:GetScore())
    .."[NEWLINE][ICON_Gold] "..goldBalance.." / " .. (goldYield>0 and "+" or "") .. (goldYield>0 and goldYield or "?")
    .."[NEWLINE]"..Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_SCIENCE_SCIENCE_RATE", Round(Players[playerID]:GetTechs():GetScienceYield(),1))
    .."[NEWLINE][ICON_Science] "..Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_SCIENCE_NUM_TECHS", Players[playerID]:GetStats():GetNumTechsResearched())
    .."[NEWLINE]"..Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_CULTURE_CULTURE_RATE", Round(Players[playerID]:GetCulture():GetCultureYield(),1))
    .."[NEWLINE]"..Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_CULTURE_TOURISM_RATE", Round(Players[playerID]:GetStats():GetTourism(),1))
    .."[NEWLINE]"..Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_RELIGION_FAITH_RATE", Round(Players[playerID]:GetReligion():GetFaithYield(),1))
    .."[NEWLINE][ICON_Strength] "..Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_DOMINATION_MILITARY_STRENGTH", Players[playerID]:GetStats():GetMilitaryStrength())
    ;

  return civData;
end

-- ===========================================================================
--	Clears leaders and re-adds them to the stack
-- ===========================================================================
function UpdateLeaders()
  local localPlayerID:number = Game.GetLocalPlayer();
  if localPlayerID == -1 then
    Controls.LeaderStack:CalculateSize();
    RealizeSize();
    return;
  end;

  ResetLeaders();

  -- Add entries for everyone we know (Majors only)
  local aPlayers:table = PlayerManager.GetAliveMajors();
  local localPlayer:table = Players[localPlayerID];
  local localDiplomacy:table = localPlayer:GetDiplomacy();

  table.sort(aPlayers, function(a:table,b:table) return localDiplomacy:GetMetTurn(a:GetID()) < localDiplomacy:GetMetTurn(b:GetID()) end);

  --First, add me!
  AddLeader("ICON_"..PlayerConfigurations[localPlayerID]:GetLeaderTypeName(), localPlayerID);

  local kMetPlayers, kUniqueLeaders = GetMetPlayersAndUniqueLeaders();

  --Then, add the leader icons.
  for _, pPlayer in ipairs(aPlayers) do
    local playerID:number = pPlayer:GetID();
    if(playerID ~= localPlayerID) then
      local isMet			:boolean = kMetPlayers[playerID];
      local pPlayerConfig	:table = PlayerConfigurations[playerID];
      if (isMet or (GameConfiguration.IsAnyMultiplayer() and pPlayerConfig:IsHuman())) then
        local leaderName:string = pPlayerConfig:GetLeaderTypeName();
        -- If in an MP game and a player leaves the name returned will be NIL.
        if isMet and (leaderName ~= nil) then	
          AddLeader("ICON_"..leaderName, playerID, kUniqueLeaders[leaderName]);
        else
          AddLeader("ICON_LEADER_DEFAULT", playerID);
        end
      end
    end
  end

  Controls.LeaderStack:CalculateSize();
  RealizeSize();

  if localPlayer:IsTurnActive() then
    OnLocalTurnBegin();
  end
end

-- ===========================================================================
--	Updates size and location of BG and Scroll controls
--	additionalElementsWidth, from MODS that add additional content.
-- ===========================================================================
function RealizeSize(additionalElementsWidth:number)
  if additionalElementsWidth == nil then
    additionalElementsWidth = 0;
  end

  local MIN_LEFT_HOOKS		:number	= 260;
  local RIGHT_HOOKS_INITIAL	:number	= 163;
  local WORLD_TRACKER_OFFSET	:number	= 40;
  local launchBarWidth		:number = MIN_LEFT_HOOKS;
  local partialScreenBarWidth :number = RIGHT_HOOKS_INITIAL;

  -- Obtain controls
  local uiPartialScreenHookBar :table	= ContextPtr:LookUpControl( "/InGame/PartialScreenHooks/ButtonStack" );
  local uiLaunchBar			 :table	= ContextPtr:LookUpControl( "/InGame/LaunchBar/ButtonStack" );

  if (uiLaunchBar ~= nil) then
    launchBarWidth = math.max(uiLaunchBar:GetSizeX() + WORLD_TRACKER_OFFSET, MIN_LEFT_HOOKS);
  end
  if (uiPartialScreenHookBar~=nil) then
    partialScreenBarWidth = uiPartialScreenHookBar:GetSizeX();
  end

  local screenWidth:number, screenHeight:number = UIManager:GetScreenSizeVal(); -- Cache screen dimensions

  local SIZE_LEADER		:number = 51;	-- Size of leader icon and border.
  local PADDING_LEADER	:number = 3;	-- Padding used in stack control.
  local maxSize			:number = screenWidth - launchBarWidth - partialScreenBarWidth;
  local size				:number = maxSize;

  g_maxNumLeaders = math.floor(maxSize / (SIZE_LEADER + PADDING_LEADER));

  Controls.LeaderBG:SetHide( m_leadersMet==0 )
  if m_leadersMet > 0 then
    -- Compute size of the background shadow
    local BG_PADDING_EDGE	:number = 50;		-- Account for the (tons of) alpha on edges of shadow graphic.
    local MINIMUM_BG_SIZE	:number = 100;
    local bgSize			:number = 0;
    if (m_leadersMet > g_maxNumLeaders) then
      bgSize = g_maxNumLeaders * (SIZE_LEADER + PADDING_LEADER) + additionalElementsWidth + BG_PADDING_EDGE;
    else
      bgSize = m_leadersMet * (SIZE_LEADER + PADDING_LEADER) + additionalElementsWidth + BG_PADDING_EDGE;
    end
    bgSize = math.max(bgSize, MINIMUM_BG_SIZE);
    Controls.LeaderBG:SetSizeX( bgSize );
    Controls.RibbonContainer:SetSizeX( bgSize );

    -- Compute actual size of the container
    local PADDING_EDGE		:number = 8;		-- Ensure scroll bar is wide enough
    size = g_maxNumLeaders * (SIZE_LEADER + PADDING_LEADER) + PADDING_EDGE + additionalElementsWidth;
  end
  Controls.ScrollContainer:SetSizeX(size);
  Controls.LeaderScroll:SetSizeX(size);
  Controls.RibbonContainer:SetOffsetX(partialScreenBarWidth);
  Controls.LeaderScroll:CalculateSize();
  RealizeScroll();
end

-- ===========================================================================
--	Updates visibility of previous and next buttons
-- ===========================================================================
function RealizeScroll()
  Controls.NextButtonContainer:SetHide(not CanScrollLeft());
  Controls.PreviousButtonContainer:SetHide(not CanScrollRight());
end

-- ===========================================================================
function CanScrollLeft()
  return m_scrollIndex > 0;
end

-- ===========================================================================
function CanScrollRight()
  return m_leadersMet - m_scrollIndex > g_maxNumLeaders;
end

-- ===========================================================================
--	Initialize scroll animation in a particular direction
-- ===========================================================================
function Scroll(direction : number)

  m_scrollPercent = 0;
  m_scrollIndex = m_scrollIndex + direction;

  if(m_scrollIndex < 0) then
    m_scrollIndex = 0;
  end

  if(not m_isScrolling) then
    ContextPtr:SetUpdate( UpdateScroll );
    m_isScrolling = true;
  end

  RealizeScroll();
end

-- ===========================================================================
--	Update scroll animation (only called while animating)
-- ===========================================================================
function UpdateScroll(deltaTime : number)

  local start:number = Controls.LeaderScroll:GetScrollValue();
  local destination:number = 1.0 - (m_scrollIndex / (m_leadersMet - g_maxNumLeaders));

  m_scrollPercent = m_scrollPercent + (SCROLL_SPEED * deltaTime);
  if(m_scrollPercent >= 1) then
    m_scrollPercent = 1
    EndScroll();
  end

  Controls.LeaderScroll:SetScrollValue(start + (destination - start) * m_scrollPercent);
end

-- ===========================================================================
--	Cleans up scroll update callback when done scrollin
-- ===========================================================================
function EndScroll()
  ContextPtr:ClearUpdate();
  m_isScrolling = false;
  RealizeScroll();
end

-- ===========================================================================
--	SystemUpdateUI Callback
-- ===========================================================================
function OnUpdateUI(type:number, tag:string, iData1:number, iData2:number, strData1:string)
  if(type == SystemUpdateUI.ScreenResize) then
    RealizeSize();
  end
end

-- ===========================================================================
--	EVENT
--	Diplomacy Callback
-- ===========================================================================
function OnDiplomacyMeet(player1ID:number, player2ID:number)

  local localPlayerID:number = Game.GetLocalPlayer();
  -- Have a local player?
  if(localPlayerID ~= -1) then
    -- Was the local player involved?
    if (player1ID == localPlayerID or player2ID == localPlayerID) then
      UpdateLeaders();
    end
  end
end

-- ===========================================================================
--	Diplomacy Callback
-- ===========================================================================
function OnDiplomacyWarStateChange(player1ID:number, player2ID:number)

  local localPlayerID:number = Game.GetLocalPlayer();
  -- Have a local player?
  if(localPlayerID ~= -1) then
    -- Was the local player involved?
    if (player1ID == localPlayerID or player2ID == localPlayerID) then
      UpdateLeaders();
    end
  end
end

-- ===========================================================================
--	Diplomacy Callback
-- ===========================================================================
function OnDiplomacySessionClosed(sessionID:number)

  local localPlayerID:number = Game.GetLocalPlayer();
  -- Have a local player?
  if(localPlayerID ~= -1) then
    -- Was the local player involved?
    local diplomacyInfo:table = DiplomacyManager.GetSessionInfo(sessionID);
    if(diplomacyInfo ~= nil and (diplomacyInfo.FromPlayer == localPlayerID or diplomacyInfo.ToPlayer == localPlayerID)) then
      UpdateLeaders();
    end
  end
end

-- ===========================================================================
--	EVENT
-- ===========================================================================
function OnInterfaceModeChanged(eOldMode:number, eNewMode:number)
  if eNewMode == InterfaceModeTypes.VIEW_MODAL_LENS then
    ContextPtr:SetHide(true);
  end
  if eOldMode == InterfaceModeTypes.VIEW_MODAL_LENS then
    ContextPtr:SetHide(false);
  end
end

-- ===========================================================================
--	EVENT
-- ===========================================================================
function OnTurnBegin( playerID:number )
  local uiLeader	:table = m_uiLeadersByID[playerID];
  if(uiLeader ~= nil) then
    uiLeader.LeaderContainer:SetToBeginning();
    uiLeader.LeaderContainer:Play();
  end
end

-- ===========================================================================
--	EVENT
-- ===========================================================================
function OnTurnEnd( playerID:number )
  local uiLeader :table = m_uiLeadersByID[playerID];
  if(uiLeader ~= nil) then
    uiLeader.LeaderContainer:Reverse();
  end
  UpdateLeaders();
end

-- ===========================================================================
--	EVENT
-- ===========================================================================
function OnLocalTurnBegin()
  local playerID	:number = Game.GetLocalPlayer();
  if playerID == -1 then return; end;
  OnTurnBegin( playerID );
end

-- ===========================================================================
--	EVENT
-- ===========================================================================
function OnLocalTurnEnd()
  local playerID	:number = Game.GetLocalPlayer();
  if playerID == -1 then return; end;
  OnTurnEnd( playerID );
end


-- ===========================================================================
--	LUAEvent
-- ===========================================================================
function OnLaunchBarResized( width:number )
  RealizeSize();
end

-- ===========================================================================
--	UI Callback
-- ===========================================================================
function OnScrollLeft()
  if CanScrollLeft() then
    Scroll(-1);
  end
end

-- ===========================================================================
--	DRS Mod Functions
-- ===========================================================================
function Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end


-- ===========================================================================
--	UI Callback
-- ===========================================================================
function OnScrollRight()
  if CanScrollRight() then
    Scroll(1);
  end
end

-- ===========================================================================
function OnChatReceived(fromPlayer:number, stayOnScreen:boolean)
  local instance:table= m_uiLeadersByID[fromPlayer];
  if instance == nil then return; end
  if stayOnScreen then
    Controls.ChatIndicatorWaitTimer:Stop();
    instance.ChatIndicatorFade:RegisterEndCallback(function() end);
    table.insert(m_uiChatIconsVisible, instance.ChatIndicatorFade);
  else
    Controls.ChatIndicatorWaitTimer:Stop();

    instance.ChatIndicatorFade:RegisterEndCallback(function()
      Controls.ChatIndicatorWaitTimer:RegisterEndCallback(function()
        instance.ChatIndicatorFade:RegisterEndCallback(function() instance.ChatIndicatorFade:SetToBeginning(); end);
        instance.ChatIndicatorFade:Reverse();
      end);
      Controls.ChatIndicatorWaitTimer:SetToBeginning();
      Controls.ChatIndicatorWaitTimer:Play();
    end);
  end
  instance.ChatIndicatorFade:Play();
end

-- ===========================================================================
function OnChatPanelShown(fromPlayer:number, stayOnScreen:boolean)
  for _, chatIndicatorFade in ipairs(m_uiChatIconsVisible) do
    chatIndicatorFade:RegisterEndCallback(function() chatIndicatorFade:SetToBeginning(); end);
    chatIndicatorFade:Reverse();
  end
  chatIndicatorFade = {};
end

-- ===========================================================================
function OnLoadGameViewStateDone()
  if(GameConfiguration.IsAnyMultiplayer()) then
    for leaderID, uiLeader in pairs(m_uiLeadersByID) do
      if Players[leaderID]:IsTurnActive() then
        uiLeader.LeaderContainer:SetToBeginning();
        uiLeader.LeaderContainer:Play();
      end
    end
  end
end

--ARISTOS: to manage mouse over leader icons to show relations
function OnInputHandler( pInputStruct:table )
  local uiKey :number = pInputStruct:GetKey();
  local uiMsg :number = pInputStruct:GetMessageType();
  if uiMsg == KeyEvents.KeyDown then
    if uiKey == Keys.VK_CONTROL then
      if m_isCTRLDown == false then
        m_isCTRLDown = true;
      end
    end
  end
  if uiMsg == KeyEvents.KeyUp then
    if uiKey == Keys.VK_CONTROL then
      if m_isCTRLDown == true then
        m_isCTRLDown = false;
      end
    end
  end
  if uiMsg == MouseEvents.MButtonDown then
    if m_isCTRLDown == false then
      m_isCTRLDown = true;
    end
    if(CQUI_hoveringOverPortrait) then
      return true;
    end
  end
  if uiMsg == MouseEvents.MButtonUp then
    if m_isCTRLDown == true then
      m_isCTRLDown = false;
    end
    if(CQUI_hoveringOverPortrait) then
      return true;
    end
  end

end
ContextPtr:SetInputHandler( OnInputHandler, true );
--ARISTOS: End

-- ===========================================================================
function LateInitialize()
  Controls.NextButton:RegisterCallback( Mouse.eLClick, OnScrollLeft );
  Controls.PreviousButton:RegisterCallback( Mouse.eLClick, OnScrollRight );
  Controls.LeaderScroll:SetScrollValue(1);

  Events.SystemUpdateUI.Add( OnUpdateUI );
  Events.DiplomacyMeet.Add( OnDiplomacyMeet );
  Events.DiplomacySessionClosed.Add( OnDiplomacySessionClosed );
  Events.DiplomacyDeclareWar.Add( OnDiplomacyWarStateChange );
  Events.DiplomacyMakePeace.Add( OnDiplomacyWarStateChange );
  Events.DiplomacyRelationshipChanged.Add( UpdateLeaders );
  Events.InterfaceModeChanged.Add( OnInterfaceModeChanged );
  Events.RemotePlayerTurnBegin.Add( OnTurnBegin );
  Events.RemotePlayerTurnEnd.Add( OnTurnEnd );
  Events.LocalPlayerTurnBegin.Add( OnLocalTurnBegin );
	Events.LocalPlayerTurnEnd.Add( OnLocalTurnEnd );
  Events.MultiplayerPlayerConnected.Add(UpdateLeaders);
  Events.MultiplayerPostPlayerDisconnected.Add(UpdateLeaders);
  Events.LocalPlayerChanged.Add(UpdateLeaders);
  Events.PlayerInfoChanged.Add(UpdateLeaders);
  Events.PlayerDefeat.Add(UpdateLeaders);
  Events.PlayerRestored.Add(UpdateLeaders);
  Events.LoadGameViewStateDone.Add( OnLoadGameViewStateDone );

  LuaEvents.ChatPanel_OnChatReceived.Add(OnChatReceived);
  LuaEvents.WorldTracker_OnChatShown.Add(OnChatPanelShown);
  LuaEvents.LaunchBar_Resize.Add(OnLaunchBarResized);
  LuaEvents.PartialScreenHooks_Realize.Add(RealizeSize);
  LuaEvents.CQUI_SettingsInitialized.Add(CQUI_OnSettingsUpdate);

  if not BASE_LateInitialize then	-- Only update leaders if this is the last in the call chain.
    UpdateLeaders();
  end
end

-- ===========================================================================
function OnInit(isReload:boolean)
  LateInitialize();
end

-- ===========================================================================
--	Main Initialize
-- ===========================================================================
function Initialize()
  -- UI Events
  ContextPtr:SetInitHandler(OnInit);
end
Initialize();