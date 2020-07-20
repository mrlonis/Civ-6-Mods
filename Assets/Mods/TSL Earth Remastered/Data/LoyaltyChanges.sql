--Loyal Capitals (TSLEE)
--totalslacker 4/20/20

INSERT OR IGNORE INTO Types (Type, Kind)
SELECT ('MODIFIER_PLAYER_CITY_ADJUST_ALWAYS_LOYAL'), ('KIND_MODIFIER')
WHERE EXISTS (SELECT * FROM TSLEE_UserSettings WHERE Type = 'LOYAL_CAPITALS' AND Value = 1);

INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
SELECT ('MODIFIER_PLAYER_CITY_ADJUST_ALWAYS_LOYAL'), ('COLLECTION_OWNER'), ('EFFECT_ADJUST_CITY_ALWAYS_LOYAL')
WHERE EXISTS (SELECT * FROM TSLEE_UserSettings WHERE Type = 'LOYAL_CAPITALS' AND Value = 1);

INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId) 
SELECT ('BUILDING_PALACE'), ('CAPITAL_ALWAYS_LOYAL')
WHERE EXISTS (SELECT * FROM TSLEE_UserSettings WHERE Type = 'LOYAL_CAPITALS' AND Value = 1);

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) 
SELECT ('CAPITAL_ALWAYS_LOYAL'), ('MODIFIER_PLAYER_CITY_ADJUST_ALWAYS_LOYAL'), ('CITY_HAS_PALACE_REQUIREMENTS')
WHERE EXISTS (SELECT * FROM TSLEE_UserSettings WHERE Type = 'LOYAL_CAPITALS' AND Value = 1);

INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) 
SELECT ('CAPITAL_ALWAYS_LOYAL'), ('AlwaysLoyal'), ('true')
WHERE EXISTS (SELECT * FROM TSLEE_UserSettings WHERE Type = 'LOYAL_CAPITALS' AND Value = 1);

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) 
SELECT ('CITY_HAS_PALACE_REQUIREMENTS'), ('REQUIREMENTSET_TEST_ALL')
WHERE EXISTS (SELECT * FROM TSLEE_UserSettings WHERE Type = 'LOYAL_CAPITALS' AND Value = 1);

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
SELECT ('REQUIRES_CITY_HAS_PALACE'), ('BuildingType'), ('BUILDING_PALACE')
WHERE EXISTS (SELECT * FROM TSLEE_UserSettings WHERE Type = 'LOYAL_CAPITALS' AND Value = 1);

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
SELECT ('REQUIRES_CITY_HAS_PALACE'), ('REQUIREMENT_CITY_HAS_BUILDING')
WHERE EXISTS (SELECT * FROM TSLEE_UserSettings WHERE Type = 'LOYAL_CAPITALS' AND Value = 1);

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT ('CITY_HAS_PALACE_REQUIREMENTS'), ('REQUIRES_CITY_HAS_PALACE')
WHERE EXISTS (SELECT * FROM TSLEE_UserSettings WHERE Type = 'LOYAL_CAPITALS' AND Value = 1);