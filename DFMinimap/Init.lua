DFMinimap = LibStub("AceAddon-3.0"):NewAddon("DFMinimap", "AceEvent-3.0", "AceHook-3.0");

local level = GetExpansionLevel();
if (level == 1) then -- vanila
    DFMinimap.GameTimeFramePosition = {0, -30};
else
    DFMinimap.GameTimeFramePosition = {-4, 0};
end

local function ZoomButtonsInit()
    MinimapZoomIn:ClearAllPoints();
    MinimapZoomOut:ClearAllPoints();

    MinimapZoomIn:SetPoint("CENTER", 88, -68);
    MinimapZoomOut:SetPoint("CENTER", 72, -84);

    MinimapZoomIn:SetSize(20, 20);
    MinimapZoomOut:SetSize(20, 20);

    local newNormalPlus = MinimapZoomIn:CreateTexture();
    local newHighlightPlus = MinimapZoomIn:CreateTexture();
    local newPushedPlus = MinimapZoomIn:CreateTexture();
    local newDisabledPlus = MinimapZoomIn:CreateTexture();

    newNormalPlus:SetTexture("Interface\\AddOns\\DFMinimap\\res\\uiminimap");
    newHighlightPlus:SetTexture("Interface\\AddOns\\DFMinimap\\res\\uiminimap");
    newPushedPlus:SetTexture("Interface\\AddOns\\DFMinimap\\res\\zoomInNormal");
    newDisabledPlus:SetTexture("Interface\\AddOns\\DFMinimap\\res\\uiminimap");

    newNormalPlus:SetTexCoord(0.007, 0.064, 0.55, 0.58);
    newHighlightPlus:SetTexCoord(0.007, 0.064, 0.55, 0.58);
    newDisabledPlus:SetTexCoord(0.007, 0.064, 0.55, 0.58);

    newHighlightPlus:SetAlpha(0.2);
    newDisabledPlus:SetDesaturated(true);

    MinimapZoomIn:SetNormalTexture(newNormalPlus);
    MinimapZoomIn:SetHighlightTexture(newHighlightPlus);
    MinimapZoomIn:SetPushedTexture(newPushedPlus);
    MinimapZoomIn:SetDisabledTexture(newDisabledPlus);

    local newNormalMin = MinimapZoomOut:CreateTexture();
    local newHighlightMin = MinimapZoomOut:CreateTexture();
    local newPushedMin = MinimapZoomOut:CreateTexture();
    local newDisabledMin = MinimapZoomOut:CreateTexture();

    newNormalMin:SetTexture("Interface\\AddOns\\DFMinimap\\res\\uiminimap");
    newHighlightMin:SetTexture("Interface\\AddOns\\DFMinimap\\res\\uiminimap");
    newPushedMin:SetTexture("Interface\\AddOns\\DFMinimap\\res\\zoomOutNormal");
    newDisabledMin:SetTexture("Interface\\AddOns\\DFMinimap\\res\\uiminimap");

    newNormalMin:SetTexCoord(0.40, 0.46, 0.51, 0.54);
    newHighlightMin:SetTexCoord(0.40, 0.46, 0.51, 0.54);
    newDisabledMin:SetTexCoord(0.40, 0.46, 0.51, 0.54);

    newHighlightMin:SetAlpha(0.2);
    newDisabledMin:SetDesaturated(true);

    MinimapZoomOut:SetNormalTexture(newNormalMin);
    MinimapZoomOut:SetHighlightTexture(newHighlightMin);
    MinimapZoomOut:SetPushedTexture(newPushedMin);
    MinimapZoomOut:SetDisabledTexture(newDisabledMin);
end


function DFMinimap:Minimap_UpdateRotationSetting()
    MinimapNorthTag:Hide();
    MinimapCompassTexture:Hide();
end

function DFMinimap:OnInitialize()
    print("Dragonflight Minimap!");
	self:RegisterEvent("ADDON_LOADED", function (arg1, addonName)
        if (addonName == "Blizzard_TimeManager") then
            TimeManagerClockButton:SetParent(MinimapCluster);
            TimeManagerClockButton:ClearAllPoints();
            TimeManagerClockButton:SetPoint("TOPRIGHT", MinimapBorderTop, -47, -235);
            TimeManagerClockButton:DisableDrawLayer("BORDER")

            GameTimeFrame:SetParent(MinimapCluster);
            GameTimeFrame:ClearAllPoints();
            GameTimeFrame:SetPoint("TOPRIGHT", DFMinimap.GameTimeFramePosition[1], DFMinimap.GameTimeFramePosition[2]);
        end
    end);

    self:RawHook("Minimap_UpdateRotationSetting", true);

    MinimapCluster:SetSize(256, 256);
    Minimap:SetPoint("CENTER", MinimapCluster, "TOP", 10, -140);
    Minimap:SetSize(198, 198);
    Minimap:SetMaskTexture("Interface\\Characterframe\\tempportraitalphamask");
    MinimapBackdrop:SetPoint("CENTER", Minimap, 0, 0);
    MinimapBackdrop:SetSize(215, 226);
    MinimapBorder:SetDrawLayer("OVERLAY");
    MinimapBorder:SetTexCoord(0.0, 0.84, 0.068, 0.51);
    MinimapBorder:ClearAllPoints();
    MinimapBorder:SetSize(215, 226);
    MinimapBorder:SetTexture("Interface\\AddOns\\DFMinimap\\res\\uiminimap");
    MinimapBorder:SetPoint("CENTER", Minimap, 0, 0);

    ZoomButtonsInit();

    MinimapBorderTop:SetSize(175, 32);
    MinimapBorderTop:SetPoint("TOPRIGHT", -39, -4);
    MinimapZoneTextButton:SetSize(135, 12);
    MinimapZoneTextButton:SetPoint("LEFT", MinimapBorderTop, 8, 0);
    MinimapZoneTextButton:SetScript("OnClick", function ()
        ToggleWorldMap();
    end);
    MinimapZoneTextButton:SetScript("OnEnter", function (self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		local pvpType, _, factionName = GetZonePVPInfo();
		Minimap_SetTooltip(pvpType, factionName);
        GameTooltip:AddLine(MiniMapWorldMapButton.tooltipText);
		GameTooltip:Show();
    end);
    MiniMapWorldMapButton:Hide();
    MinimapZoneText:SetSize(150, 12);
    MinimapZoneText:SetPoint("LEFT", 16, 2);
    MinimapZoneText:SetJustifyH("LEFT");
    MinimapZoneText:SetJustifyV("MIDDLE");
	MinimapZoneText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
end