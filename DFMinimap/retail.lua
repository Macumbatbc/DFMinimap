local garrisonTypeAnchors = {
	["default"] = AnchorUtil.CreateAnchor("TOPLEFT", "MinimapBackdrop", "TOPLEFT", 5, -162),
	[Enum.GarrisonType.Type_9_0] = AnchorUtil.CreateAnchor("TOPLEFT", "MinimapBackdrop", "TOPLEFT", -3, -150),
}

function DFMinimap:GarrisonLandingPageMinimapButton_UpdateIcon()
    self.hooks.GarrisonLandingPageMinimapButton_UpdateIcon(GarrisonLandingPageMinimapButton);
	local garrisonType = C_Garrison.GetLandingPageGarrisonType();
    local anchor = garrisonTypeAnchors[garrisonType or "default"] or garrisonTypeAnchors["default"];
	anchor:SetPoint(GarrisonLandingPageMinimapButton, true);
end

DFMinimap:RawHook("GarrisonLandingPageMinimapButton_UpdateIcon", true);

GarrisonLandingPageMinimapButton:ClearAllPoints();
GarrisonLandingPageMinimapButton:SetPoint("TOPLEFT", -3, -150);
QueueStatusMinimapButton:ClearAllPoints();
QueueStatusMinimapButton:SetPoint("LEFT", -8, 25);
MiniMapTracking:ClearAllPoints();
MiniMapTracking:SetPoint("RIGHT", MinimapZoneTextButton, "LEFT", 10, 1);