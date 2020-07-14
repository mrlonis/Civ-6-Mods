include( "InstanceManager" );
include( "SupportFunctions" );

-- Shared code between the LoadGameMenu and the SaveGameMenu
include( "LoadSaveMenu_Shared" );

local RELOAD_CACHE_ID: string = "SaveGameMenu";		-- hotloading
local MIN_SCREEN_Y   : number = 768;
g_IsDeletingFile = false;

----------------------------------------------------------------        
----------------------------------------------------------------        
function OnBack()
    UIManager:DequeuePopup( ContextPtr );
end

----------------------------------------------------------------        
----------------------------------------------------------------
function OnActionButton()
	if (g_iSelectedFileEntry == -1) then
		local fileName = Controls.FileName:GetText();
		for i, v in ipairs(g_FileList) do
			local displayName = GetDisplayName(v); 
			if(Locale.Length(displayName) > 0) then
				if(Locale.ToUpper(fileName) == Locale.ToUpper(displayName)) then
					SetSelected(i);
					break;
				end
			end
		end
	end
	
	if(g_iSelectedFileEntry ~= -1) then
		g_IsDeletingFile = false;

		-- A file is selected, if it is a directory, go into it, else confirm overwrite.
		local selectedFile = g_FileList[ g_iSelectedFileEntry ];
		if selectedFile ~= nil then
			if selectedFile.IsDirectory then
				-- Open the directory
				ChangeDirectoryTo(selectedFile.Path);
				return;
			else
				Controls.DeleteHeader:SetText(Locale.ToUpper( "LOC_CONFIRM_TITLE_TXT" ));
				Controls.Message:LocalizeAndSetText( "LOC_OVERWRITE_TXT" );
				Controls.DeleteConfirm:SetHide(false);
				return;
			end
		end

	else
		local gameFile = {};
		gameFile.Name = Controls.FileName:GetText();
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
		UIManager:SetUICursor( 1 );
		Network.SaveGame(gameFile);
		UIManager:SetUICursor( 0 );
		UI.PlaySound("Confirm_Bed_Positive");
	end
	
	Controls.FileName:ClearString();
	SetupFileList();
	OnBack();
end
 

----------------------------------------------------------------        
function OnFileNameChange( fileNameEntry )
	
	if( g_iSelectedFileEntry ~= -1 ) then
		local kSelectedFile = g_FileList[ g_iSelectedFileEntry ];
		local displayName = GetDisplayName(kSelectedFile); 
		if (fileNameEntry:GetText() ~= displayName) then
			DismissCurrentSelected();
		end
	end
	
	local fileName = "";
	if(fileNameEntry:GetText() ~= nil) then
		fileName = fileNameEntry:GetText();
	end

	g_FilenameIsValid = ValidateFileName(fileName);

	UpdateActionButtonState();
	Controls.Delete:SetHide(true); 
	
end

----------------------------------------------------------------        
----------------------------------------------------------------
function OnCloudCheck( )
	local bWantShowCloudSaves = not g_ShowCloudSaves;

	if (bWantShowCloudSaves) then
		-- Make sure we can switch to it.
		if (not CanShowCloudSaves()) then
			return;
		end
	end

	g_ShowCloudSaves = bWantShowCloudSaves;
	Controls.CloudCheck:SetSelected(g_ShowCloudSaves);
    SetDontUpdateFileName(true);
	SetupDirectoryBrowsePulldown();
	SetupFileList();
	UpdateActionButtonState();
    SetDontUpdateFileName(false);
end


---------------------------------------------------------------- 
-- Show/Hide Handlers
---------------------------------------------------------------- 
function OnShow()

	g_ShowCloudSaves = false;
	g_ShowAutoSaves = false;

	LoadSaveMenu_OnShow();

	g_MenuType = SAVE_GAME;
	UpdateGameType();
	Controls.Delete:SetHide( true );
	Controls.ActionButton:SetDisabled( true );
	Controls.ActionButton:SetToolTipString( nil );

	InitializeDirectoryBrowsing();
	RefreshSortPulldown();
	SetupDirectoryBrowsePulldown();
	SetupFileList();
		
	Controls.CloudCheck:SetSelected(false);

	g_FilenameIsValid = ValidateFileName( Controls.FileName:GetText() );

	UpdateActionButtonState();

	local cloudServicesEnabled,cloudServicesResult = UI.AreCloudSavesEnabled("SAVE");
	local cloudEnabled = UI.AreCloudSavesEnabled() and not GameConfiguration.IsAnyMultiplayer() and g_FileType ~= SaveFileTypes.GAME_CONFIGURATION and g_GameType ~= SaveTypes.WORLDBUILDER_MAP;
	Controls.CloudCheck:SetHide(false);
	Controls.CloudCheck:SetEnabled(cloudEnabled);

    local isNew = Options.GetAppOption("Misc", "UserSawCloudNew");
	Controls.CheckNewIndicator:SetHide(true);
	Controls.DummyNewIndicator:SetHide(true);

	if cloudEnabled == false then
		if cloudServicesResult ~= nil then
			if cloudServicesResult == DB.MakeHash("REQUIRES_LINKED_ACCOUNT") then
				Controls.CloudCheck:LocalizeAndSetToolTip("LOC_CLOUD_SAVES_REQUIRE_LINKED_ACCOUNT");
			else
				Controls.CloudCheck:LocalizeAndSetToolTip("LOC_CLOUD_SAVES_SERVICE_NOT_CONNECTED");
			end
		end
        if (isNew == 0) then
            Controls.CheckNewIndicator:SetHide(false);
        end

		if g_GameType == SaveTypes.WORLDBUILDER_MAP or g_FileType == SaveFileTypes.GAME_CONFIGURATION then
			Controls.CloudCheck:SetHide(true);
		else
			Controls.CloudCheck:SetHide(false);
		end
	else
		if UI.Is2KCloudAvailable() then
			Controls.CloudCheck:SetToolTipString(Locale.Lookup("LOC_2K_CLOUD_SAVES_HELP"));
			Controls.CloudCheck:SetText(Locale.Lookup("LOC_2K_CLOUD"));
			Controls.CloudDummy:SetHide(true);
			if (isNew == 0) then
				Controls.CheckNewIndicator:SetHide(false);
			end
		else
			Controls.CloudDummy:SetHide(false);
			Controls.CloudDummy:SetDisabled(true);
			Controls.CloudDummy:SetToolTipString(Locale.Lookup("LOC_2K_CLOUD_SAVES_HELP"));
			Controls.CloudCheck:SetToolTipString(Locale.Lookup("LOC_STANDARD_CLOUD_SAVES_HELP"));
			if (isNew == 0) then
				Controls.DummyNewIndicator:SetHide(false);
			end
		end
	end

    if (isNew == 0) then
        Options.SetAppOption("Misc", "UserSawCloudNew", 1);
    end

	local cloudSavesVisible = Controls.CloudCheck:IsVisible();
	local sortByVisible = Controls.SortByPullDown:IsVisible();
	local directoryVisible = Controls.DirectoryPullDown:IsVisible();
    local dummyCloudVisible = Controls.CloudDummy:IsVisible();

	local count:number = 0;
	if(cloudSavesVisible) then
		count = count + 1;
	end
	if(sortByVisible) then
		count = count + 1;
	end
	if(directoryVisible) then
		count = count + 1;
	end
	if(dummyCloudVisible) then
		count = count + 1;
	end		
	
	Controls.FileName:TakeFocus();
	
	local decoSize:number = Controls.InspectorArea:GetSizeY();

	Controls.DecoContainer:SetSizeY(decoSize - (count * 25) - count);	

	if g_GameType == SaveTypes.WORLDBUILDER_MAP then
		Controls.GameDetailIconsArea:SetHide(true);
	else
		Controls.GameDetailIconsArea:SetHide(false);
	end
end
----------------------------------------------------------------        
function OnHide()
	LoadSaveMenu_OnHide();
end

function OnDelete()
	g_IsDeletingFile = true;
	Controls.DeleteHeader:SetText( Locale.ToUpper(Locale.Lookup("LOC_CONFIRM_DELETE_TITLE_TXT")));
	Controls.Message:LocalizeAndSetText( "LOC_CONFIRM_TXT" );
	Controls.DeleteConfirm:SetHide(false);
	Controls.DeleteConfirmAlpha:SetToBeginning();
	Controls.DeleteConfirmAlpha:Play();
	Controls.DeleteConfirmSlide:SetToBeginning();
	Controls.DeleteConfirmSlide:Play();
end    
----------------------------------------------------------------
function OnYes()
	Controls.DeleteConfirm:SetHide(true);

	if (g_iSelectedFileEntry ~= -1) then
		local kSelectedFile = g_FileList[ g_iSelectedFileEntry ];		
		if(g_IsDeletingFile) then
			UI.DeleteSavedGame( kSelectedFile );
		else
			UI.PlaySound("Confirm_Bed_Positive");

			if(g_ShowCloudSaves) then
				local gameFile = {};
				gameFile.Name = Controls.FileName:GetText();
				gameFile.Location = UI.GetDefaultCloudSaveLocation();
				gameFile.LocationIndex = g_iSelectedFileEntry;
				gameFile.Type = g_GameType;
				gameFile.FileType = g_FileType;
				UIManager:SetUICursor( 1 );
				Network.SaveGame(gameFile);
				UIManager:SetUICursor( 0 );
			else
				Network.SaveGame( kSelectedFile );
			end

			OnBack();
		end
	end
	
	SetupFileList();
	Controls.FileName:ClearString();
	Controls.ActionButton:SetDisabled(true);
end       
----------------------------------------------------------------
function OnNo( )
	Controls.DeleteConfirm:SetHide(true);
	Controls.MainGrid:SetHide(false);
end


-- ===========================================================================
--	Input Processing
-- ===========================================================================
function KeyHandler( key:number )
	if (key == Keys.VK_ESCAPE) then
		if(not Controls.DeleteConfirm:IsHidden()) then
			OnNo();
		else
			OnBack(); 
		end
		return true;
	end	
	if key == Keys.VK_RETURN then
        if(not Controls.ActionButton:IsHidden() and not Controls.ActionButton:IsDisabled()) then
            OnActionButton();
        end
        return true;
	end
	return false;
end
function OnInputHandler( pInputStruct:table )
	local uiMsg = pInputStruct:GetMessageType();
	if uiMsg == KeyEvents.KeyUp then KeyHandler( pInputStruct:GetKey() ); end;
    return true;
end


-- ===========================================================================
function OnInit(isReload:boolean)
	if isReload then
		LuaEvents.GameDebug_GetValues( RELOAD_CACHE_ID );
	end
end

-- ===========================================================================
function OnShutdown()
	-- Cache values for hotloading...
	LuaEvents.GameDebug_AddValue(RELOAD_CACHE_ID, "isHidden", ContextPtr:IsHidden());
end

-- ===========================================================================
function OnGameDebugReturn( context:string, contextTable:table )
	if context == RELOAD_CACHE_ID and contextTable["isHidden"] == false then
		UIManager:QueuePopup(ContextPtr, PopupPriority.Current);
	end	
end

-- ===========================================================================
--	Handle Window Sizing
-- ===========================================================================

function Resize()
	local screenX, screenY:number  = UIManager:GetScreenSizeVal();
	local hideLogo        :boolean = true;
	
	if(screenY >= MIN_SCREEN_Y + (Controls.LogoContainer:GetSizeY()+ Controls.LogoContainer:GetOffsetY() * 2)) then
		Controls.MainWindow:SetSizeY(screenY-(Controls.LogoContainer:GetSizeY() + Controls.LogoContainer:GetOffsetY() * 2));
		hideLogo = false;
	else
		Controls.MainWindow:SetSizeY(screenY);
	end
	
	Controls.LogoContainer:SetHide(hideLogo);
	Controls.DeleteConfirm:SetSizeVal(screenX,screenY);
	Controls.DeleteConfirm:ReprocessAnchoring();
end

-- ===========================================================================
function OnUpdateUI( type:number, tag:string, iData1:number, iData2:number, strData1:string )   
  if type == SystemUpdateUI.ScreenResize then
    Resize();
  end
end

-- ===========================================================================
function OnFileListQueryComplete()
	UpdateActionButtonState();
end

-- ===========================================================================
function OnRefresh()
	SetupDirectoryBrowsePulldown();
	SetupFileList();
end

-- ===========================================================================
function OnSelectedFileStackSizeChanged()
	ResizeGameInfoScrollPanel();
end

-- ===========================================================================
function Initialize()
	ContextPtr:SetInitHandler(OnInit);
	ContextPtr:SetShutdown(OnShutdown);
	LuaEvents.GameDebug_Return.Add(OnGameDebugReturn);
	SetupSortPulldown();
	InitializeDirectoryBrowsing();
	Resize();

	LuaEvents.FileListQueryComplete.Add( OnFileListQueryComplete );

	Controls.ActionButton:RegisterCallback( Mouse.eLClick, OnActionButton );
	Controls.ActionButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	Controls.BackButton:RegisterCallback( Mouse.eLClick, OnBack );
	Controls.BackButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	Controls.CloudCheck:RegisterCallback( Mouse.eLClick, OnCloudCheck );
	Controls.FileName:RegisterStringChangedCallback( OnFileNameChange )
	Controls.No:RegisterCallback( Mouse.eLClick, OnNo );
	Controls.No:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	Controls.Yes:RegisterCallback( Mouse.eLClick, OnYes );
	Controls.Yes:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	Controls.Delete:RegisterCallback( Mouse.eLClick, OnDelete );
	Controls.Delete:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	Controls.SelectedFileStack:RegisterSizeChanged( OnSelectedFileStackSizeChanged );

	Events.SystemUpdateUI.Add( OnUpdateUI );

	-- UI Events
	ContextPtr:SetShowHandler( OnShow );
	ContextPtr:SetHideHandler( OnHide );
	ContextPtr:SetInputHandler( OnInputHandler, true );
	ContextPtr:SetRefreshHandler( OnRefresh );

end
Initialize();

