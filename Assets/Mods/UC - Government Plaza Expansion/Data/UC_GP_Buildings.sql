-- UC_GP_Buildings
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,								Kind)
VALUES	('BUILDING_GOV_JNR_MOCC',			'KIND_BUILDING'),
		('BUILDING_GOV_JNR_PROPAGANDA',		'KIND_BUILDING'),
		('BUILDING_GOV_JNR_DIPLOMACY',		'KIND_BUILDING'),
		('BUILDING_GOV_JNR_DIPLOMACY_US',	'KIND_BUILDING');
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
INSERT OR IGNORE INTO Buildings
		(BuildingType,
		Name,
		Description,
		PrereqDistrict,
		Cost,
		AdvisorType,
		Maintenance,
		UnlocksGovernmentPolicy,
		GovernmentTierRequirement,
		TraitType)

VALUES	('BUILDING_GOV_JNR_MOCC',							--BuildingType
		'LOC_BUILDING_GOV_JNR_MOCC_NAME',					--Name,
		'LOC_BUILDING_GOV_JNR_MOCC_DESCRIPTION',			--Description,
		'DISTRICT_GOVERNMENT',								--PrereqDistrict,
		1160,												--Cost,
		'ADVISOR_GENERIC',									--AdvisorType
		4,													--Maintenance
		1,													--UnlocksGovernmentPolicy
		'Tier4',											--GovernmentTierRequirement
		NULL),												--TraitType

		('BUILDING_GOV_JNR_PROPAGANDA',						--BuildingType
		'LOC_BUILDING_GOV_JNR_PROPAGANDA_NAME',				--Name,
		'LOC_BUILDING_GOV_JNR_PROPAGANDA_DESCRIPTION',		--Description,
		'DISTRICT_GOVERNMENT',								--PrereqDistrict,
		1160,												--Cost,
		'ADVISOR_GENERIC',									--AdvisorType
		4,													--Maintenance
		1,													--UnlocksGovernmentPolicy
		'Tier4',											--GovernmentTierRequirement
		NULL),												--TraitType

		('BUILDING_GOV_JNR_DIPLOMACY',						--BuildingType
		'LOC_BUILDING_GOV_JNR_DIPLOMACY_NAME',				--Name,
		'LOC_BUILDING_GOV_JNR_DIPLOMACY_DESCRIPTION',		--Description,
		'DISTRICT_GOVERNMENT',								--PrereqDistrict,
		1160,												--Cost,
		'ADVISOR_GENERIC',									--AdvisorType
		4,													--Maintenance
		1,													--UnlocksGovernmentPolicy
		'Tier4',											--GovernmentTierRequirement
		NULL),												--TraitType

		('BUILDING_GOV_JNR_DIPLOMACY_US',					--BuildingType
		'LOC_BUILDING_GOV_JNR_DIPLOMACY_US_NAME',			--Name,
		'LOC_BUILDING_GOV_JNR_DIPLOMACY_US_DESCRIPTION',	--Description,
		'DISTRICT_GOVERNMENT',								--PrereqDistrict,
		1160,												--Cost,
		'ADVISOR_GENERIC',									--AdvisorType
		4,													--Maintenance
		1,													--UnlocksGovernmentPolicy
		'Tier4',											--GovernmentTierRequirement
		'TRAIT_CIVILIZATION_FOUNDING_FATHERS');				--TraitType
--------------------------------------------------------------