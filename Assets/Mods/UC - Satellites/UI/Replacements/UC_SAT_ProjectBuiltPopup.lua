-- UC_SAT_ProjectBuiltPopup
-- Author: JNR
-- ===========================================================================

-- ===========================================================================
-- Base File
-- ===========================================================================
include("ProjectBuiltPopup");

-- ===========================================================================
--	OVERRIDE 
-- ===========================================================================
function ShowPopup( kData:table )

	if(UI.GetInterfaceMode() ~= InterfaceModeTypes.CINEMATIC) then
		UILens.SaveActiveLens();
		UILens.SetActive("Cinematic");
		UI.SetInterfaceMode(InterfaceModeTypes.CINEMATIC);
	end

	UI.PlaySound("Mute_Narrator_Advisor_All");

	Controls.ProjectName:SetText( Locale.ToUpper(kData.Name) );
	Controls.ProjectIcon:SetIcon( kData.Icon );
	if Locale.Lookup(kData.projectPopupText) ~= nil then
		Controls.ProjectQuote:SetText(Locale.Lookup(kData.projectPopupText));
	end

	-- Hide all the UI if in marketing mode.
	if UI.IsInMarketingMode() then
		ContextPtr:SetHide( true );
		Controls.ForceAutoCloseMarketingMode:SetToBeginning();
		Controls.ForceAutoCloseMarketingMode:Play();
		Controls.ForceAutoCloseMarketingMode:RegisterEndCallback( OnClose );
	else
		ContextPtr:SetHide( false );
	end			
end