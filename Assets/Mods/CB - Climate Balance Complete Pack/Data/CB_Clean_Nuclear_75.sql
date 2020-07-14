-- CB_Cleaner_Nuclear_75
-- Author: JNR
--------------------------------------------------------------

-- Resource_Consumption
--------------------------------------------------------------
UPDATE Resource_Consumption SET CO2perkWh=CO2perkWh/4 WHERE ResourceType='RESOURCE_URANIUM';
--------------------------------------------------------------