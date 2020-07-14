-- CB_Severe_Weather_NFP
-- Author: JNR
--------------------------------------------------------------

-- RandomEvent_Damages
--------------------------------------------------------------
-- Jungle Fires
UPDATE RandomEvent_Damages SET Percentage=101						WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE'	AND DamageType='IMPROVEMENT_PILLAGED';	-- was 101
UPDATE RandomEvent_Damages SET Percentage=101						WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE'	AND DamageType='DISTRICT_PILLAGED';		-- was 101
UPDATE RandomEvent_Damages SET Percentage=30						WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE'	AND DamageType='POPULATION_LOSS';		-- was 101
UPDATE RandomEvent_Damages SET Percentage=101						WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE'	AND DamageType='UNIT_KILLED_CIVILIAN';	-- was 101
UPDATE RandomEvent_Damages SET Percentage=101, MinHP=50, MaxHP=101	WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE'	AND DamageType='UNIT_DAMAGE_LAND';		-- was 101,50,101
UPDATE RandomEvent_Damages SET Percentage=30						WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE'	AND DamageType='SPREAD';				-- was 50

-- Forest Fires
UPDATE RandomEvent_Damages SET Percentage=101						WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE'	AND DamageType='IMPROVEMENT_PILLAGED';	-- was 101
UPDATE RandomEvent_Damages SET Percentage=101						WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE'	AND DamageType='DISTRICT_PILLAGED';		-- was 101
UPDATE RandomEvent_Damages SET Percentage=50						WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE'	AND DamageType='POPULATION_LOSS';		-- was 101
UPDATE RandomEvent_Damages SET Percentage=101						WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE'	AND DamageType='UNIT_KILLED_CIVILIAN';	-- was 101
UPDATE RandomEvent_Damages SET Percentage=101, MinHP=50, MaxHP=101	WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE'	AND DamageType='UNIT_DAMAGE_LAND';		-- was 101,50,101
UPDATE RandomEvent_Damages SET Percentage=40						WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE'	AND DamageType='SPREAD';				-- was 50
--------------------------------------------------------------

-- RandomEvent_Yields
--------------------------------------------------------------
UPDATE RandomEvent_Yields SET Amount=0 WHERE RandomEventType='RANDOM_EVENT_JUNGLE_FIRE'	AND ReplaceFeature=1;	-- was 1
UPDATE RandomEvent_Yields SET Amount=0 WHERE RandomEventType='RANDOM_EVENT_FOREST_FIRE'	AND ReplaceFeature=1;	-- was 1

INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,	YieldType,			FeatureType,		Percentage,	Turn)
SELECT	RandomEventType,	'YIELD_FOOD',		'FEATURE_JUNGLE',	35,			6
FROM	RandomEvents
WHERE	RandomEventType='RANDOM_EVENT_JUNGLE_FIRE';

INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,	YieldType,			FeatureType,		Percentage,	Turn)
SELECT	RandomEventType,	'YIELD_FOOD',		'FEATURE_FOREST',	20,			6
FROM	RandomEvents
WHERE	RandomEventType='RANDOM_EVENT_FOREST_FIRE';

INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,	YieldType,			FeatureType,		Percentage,	Turn)
SELECT	RandomEventType,	'YIELD_PRODUCTION',	'FEATURE_JUNGLE',	10,			6
FROM	RandomEvents
WHERE	RandomEventType='RANDOM_EVENT_JUNGLE_FIRE';

INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,	YieldType,			FeatureType,		Percentage,	Turn)
SELECT	RandomEventType,	'YIELD_PRODUCTION',	'FEATURE_FOREST',	20,			6
FROM	RandomEvents
WHERE	RandomEventType='RANDOM_EVENT_FOREST_FIRE';

INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,	YieldType,		FeatureType,			Percentage,	Turn)
SELECT	RandomEventType,	'YIELD_FAITH',	'FEATURE_JUNGLE',		10,			2
FROM	RandomEvents
WHERE	RandomEventType='RANDOM_EVENT_JUNGLE_FIRE';

INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,	YieldType,		FeatureType,			Percentage,	Turn)
SELECT	RandomEventType,	'YIELD_FAITH',	'FEATURE_FOREST',		10,			2
FROM	RandomEvents
WHERE	RandomEventType='RANDOM_EVENT_FOREST_FIRE';
--------------------------------------------------------------

-- Feature_YieldChanges
--------------------------------------------------------------
INSERT OR IGNORE INTO Feature_YieldChanges
		(FeatureType,	YieldType,			YieldChange)
SELECT	FeatureType,	'YIELD_FOOD',		1
FROM	Features
WHERE	FeatureType='FEATURE_BURNT_FOREST';

INSERT OR IGNORE INTO Feature_YieldChanges
		(FeatureType,	YieldType,			YieldChange)
SELECT	FeatureType,	'YIELD_FOOD',		1
FROM	Features
WHERE	FeatureType='FEATURE_BURNT_JUNGLE';

INSERT OR IGNORE INTO Feature_YieldChanges
		(FeatureType,	YieldType,			YieldChange)
SELECT	FeatureType,	'YIELD_SCIENCE',	1
FROM	Features
WHERE	FeatureType='FEATURE_BURNT_FOREST';

INSERT OR IGNORE INTO Feature_YieldChanges
		(FeatureType,	YieldType,			YieldChange)
SELECT	FeatureType,	'YIELD_SCIENCE',	1
FROM	Features
WHERE	FeatureType='FEATURE_BURNT_JUNGLE';
--------------------------------------------------------------