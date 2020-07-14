-- Resourceful_Edit
-- Author: MadManCam
-- DateCreated: 12/25/2017 1:22:03 AM
--------------------------------------------------------------

-- This is a bit of a change for the resources added by the Resourceful Mod. 
-- The Lumbermill improvements don't actually require feature removal, I guess.
-- So update the tables accordingly so that Builders will keep the forests/jungles for the plot.
--/*
UPDATE Improvement_ValidResources SET MustRemoveFeature=0 WHERE ImprovementType='IMPROVEMENT_LUMBER_MILL';
--*/