-- UC_GP_RwF_Tiers
-- Author: JNR
--------------------------------------------------------------

--------------------------------------------------------------
-- Spaces out the government plaza tiers so that future government buildings are still unlocked by future era governments.
-- Also adjusts legacy policies.
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
-- With RwF, modern governments (Democracy, Communism, Fascism) become tier 4, up from tier 3. This ensures that tier 3 Plaza buildings are still unlocked by those governments:
UPDATE Buildings SET GovernmentTierRequirement=(SELECT Tier FROM Governments WHERE GovernmentType='GOVERNMENT_DEMOCRACY')			WHERE BuildingType='BUILDING_GOV_MILITARY';
UPDATE Buildings SET GovernmentTierRequirement=(SELECT Tier FROM Governments WHERE GovernmentType='GOVERNMENT_DEMOCRACY')			WHERE BuildingType='BUILDING_GOV_CULTURE';
UPDATE Buildings SET GovernmentTierRequirement=(SELECT Tier FROM Governments WHERE GovernmentType='GOVERNMENT_DEMOCRACY')			WHERE BuildingType='BUILDING_GOV_SCIENCE';

-- With RwF, future governments become tier 5, up from tier 4. This ensures that the new tier 4 Plaza buildings are still unlocked by those governments:
UPDATE Buildings SET GovernmentTierRequirement=(SELECT Tier FROM Governments WHERE GovernmentType='GOVERNMENT_DIGITAL_DEMOCRACY')	WHERE BuildingType='BUILDING_GOV_JNR_MOCC';
UPDATE Buildings SET GovernmentTierRequirement=(SELECT Tier FROM Governments WHERE GovernmentType='GOVERNMENT_DIGITAL_DEMOCRACY')	WHERE BuildingType='BUILDING_GOV_JNR_PROPAGANDA';
UPDATE Buildings SET GovernmentTierRequirement=(SELECT Tier FROM Governments WHERE GovernmentType='GOVERNMENT_DIGITAL_DEMOCRACY')	WHERE BuildingType='BUILDING_GOV_JNR_DIPLOMACY';
UPDATE Buildings SET GovernmentTierRequirement=(SELECT Tier FROM Governments WHERE GovernmentType='GOVERNMENT_DIGITAL_DEMOCRACY')	WHERE BuildingType='BUILDING_GOV_JNR_DIPLOMACY_US';
--------------------------------------------------------------