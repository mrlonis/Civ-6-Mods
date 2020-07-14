-------------------
-- Units Changes --
-------------------
-- Ancient Era
UPDATE Units SET MandatoryObsoleteTech = 'TECH_IRON_WORKING'
WHERE UnitType = 'UNIT_WARRIOR';

UPDATE Units SET PromotionClass = 'PROMOTION_CLASS_AUTOMATIC_GUN', MandatoryObsoleteTech = 'TECH_IRON_WORKING'
WHERE UnitType = 'UNIT_SLINGER';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_IRON_WORKING'
WHERE UnitType = 'UNIT_ARCHER';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_IRON_WORKING'
WHERE UnitType = 'UNIT_SPEARMAN';

UPDATE Units SET BaseMoves = 3, StrategicResource= 'RESOURCE_HORSES', MandatoryObsoleteTech = 'TECH_HORSEBACK_RIDING'
WHERE UnitType = 'UNIT_HEAVY_CHARIOT';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_BUTTRESS'
WHERE UnitType = 'UNIT_GALLEY';

-- Classical Era
UPDATE Units SET MandatoryObsoleteTech = 'TECH_APPRENTICESHIP'
WHERE UnitType = 'UNIT_SWORDSMAN';

UPDATE Units SET Combat = 39
WHERE UnitType = 'UNIT_ROMAN_LEGION';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_MILITARY_ENGINEERING'
WHERE UnitType = 'UNIT_CATAPULT';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_EDUCATION'
WHERE UnitType = 'UNIT_QUADRIREME';

UPDATE Units SET PrereqTech = 'TECH_CONSTRUCTION'
WHERE UnitType = 'UNIT_SIEGE_TOWER';

-- Medieval Era
UPDATE Units SET MandatoryObsoleteTech = 'TECH_METAL_CASTING'
WHERE UnitType = 'UNIT_KNIGHT';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_GUNPOWDER'
WHERE UnitType = 'UNIT_PIKEMAN';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_GUNPOWDER'
WHERE UnitType = 'UNIT_CROSSBOWMAN';

UPDATE Units SET Combat = 48
WHERE UnitType = 'UNIT_JAPANESE_SAMURAI';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_BALLISTICS'
WHERE UnitType = 'UNIT_CHINESE_CROUCHING_TIGER';

-- Renaissance Era
UPDATE Units SET Combat = 40, Cost = 220, MandatoryObsoleteTech = 'TECH_SQUARE_RIGGING'
WHERE UnitType = 'UNIT_CARAVEL';

UPDATE Units SET Cost = 230, 	Combat = 52, MandatoryObsoleteTech = 'TECH_RIFLING'
WHERE UnitType = 'UNIT_MUSKETMAN';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_RIFLING'
WHERE UnitType = 'UNIT_BOMBARD';

UPDATE Units SET Maintenance = 4, MandatoryObsoleteTech = 'TECH_STEAM_POWER'
WHERE UnitType = 'UNIT_FRIGATE';

UPDATE Units SET Combat = 52, PrereqTech = 'TECH_GUNPOWDER', MandatoryObsoleteTech = 'TECH_BALLISTICS' 
WHERE UnitType = 'UNIT_PIKE_AND_SHOT';

UPDATE Units SET Cost = 300, Combat = 62, PrereqTech = 'TECH_BALLISTICS', MandatoryObsoleteTech = 'TECH_REPLACEABLE_PARTS' 
WHERE UnitType = 'UNIT_SWEDEN_CAROLEAN';

-- Industrial Era
UPDATE Units SET MandatoryObsoleteTech = 'TECH_ELECTRICITY'
WHERE UnitType = 'UNIT_IRONCLAD';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_REPLACEABLE_PARTS'
WHERE UnitType = 'UNIT_CAVALRY';

UPDATE Units SET MandatoryObsoleteTech = 'TECH_STEEL'
WHERE UnitType = 'UNIT_FIELD_CANNON';

UPDATE Units SET BaseMoves = 4
WHERE UnitType = 'UNIT_AMERICAN_ROUGH_RIDER';

UPDATE Units SET Combat = 66, PrereqTech = 'TECH_RIFLING'
WHERE UnitType = 'UNIT_CUIRASSIER';

-- Modern Era
UPDATE Units SET PrereqTech = 'TECH_SCIENTIFIC_THEORY'
WHERE UnitType = 'UNIT_OBSERVATION_BALLOON';

UPDATE Units SET Cost = 400, Maintenance = 5, Combat = 61, RangedCombat = 65, AntiAirCombat = 50, PrereqTech = 'TECH_REPLACEABLE_PARTS', MandatoryObsoleteTech = 'TECH_ROCKETRY', PromotionClass = 'PROMOTION_CLASS_AUTOMATIC_GUN'
WHERE UnitType = 'UNIT_MACHINE_GUN';

UPDATE Units SET Cost = 450, Combat = 63, Bombard = 75, MandatoryObsoleteTech = 'TECH_ADVANCED_BALLISTICS', StrategicResource = 'RESOURCE_IRON'
WHERE UnitType = 'UNIT_ARTILLERY';

UPDATE Units SET BaseMoves = 5, Range = 5, Combat = 85, RangedCombat = 70, MandatoryObsoleteTech = 'TECH_ADVANCED_FLIGHT' 
WHERE UnitType = 'UNIT_BIPLANE';

UPDATE Units SET BaseMoves = 4, Cost = 520, Bombard = 82, RangedCombat = 0, PromotionClass = 'PROMOTION_CLASS_NAVAL_BOMBARD' 
WHERE UnitType = 'UNIT_BRAZILIAN_MINAS_GERAES';

-- Atomic Era
UPDATE Units SET Cost = 500, Combat = 80, PrereqTech = 'TECH_PLASTICS', MandatoryObsoleteTech = 'TECH_LASERS', StrategicResource = null 
WHERE UnitType = 'UNIT_INFANTRY';

UPDATE Units SET Cost = 530, Combat = 88, PrereqTech = 'TECH_COMBINED_ARMS', MandatoryObsoleteTech = 'TECH_COMPOSITES'
WHERE UnitType = 'UNIT_TANK';

UPDATE Units SET Cost = 490, Maintenance = 6, Combat = 68, RangedCombat = 72, Range = 1, AntiAirCombat = 60, PromotionClass = 'PROMOTION_CLASS_AUTOMATIC_GUN', PrereqTech = 'TECH_ROCKETRY', MandatoryObsoleteTech = 'TECH_COMPOSITES' 
WHERE UnitType = 'UNIT_AT_CREW';

UPDATE Units SET BaseMoves = 8, Range = 8, Combat = 105, RangedCombat = 95, MandatoryObsoleteTech = 'TECH_LASERS' 
WHERE UnitType = 'UNIT_FIGHTER';

UPDATE Units SET BaseMoves = 8, Range = 8, Combat = 110, RangedCombat = 100, MandatoryObsoleteTech = 'TECH_LASERS' 
WHERE UnitType = 'UNIT_AMERICAN_P51';

UPDATE Units SET BaseMoves = 4, AirSlots = 3, MandatoryObsoleteTech = 'TECH_STEALTH_TECHNOLOGY', StrategicResource = 'RESOURCE_OIL' 
WHERE UnitType = 'UNIT_AIRCRAFT_CARRIER';

UPDATE Units SET BaseMoves = 5, PrereqTech = 'TECH_COMPUTERS', MandatoryObsoleteTech = 'TECH_ROBOTICS' 
WHERE UnitType = 'UNIT_DESTROYER';

UPDATE Units SET BaseMoves = 4, Cost = 600, Combat = 80, Bombard = 90, RangedCombat = 0, Maintenance = 7, PromotionClass = 'PROMOTION_CLASS_NAVAL_BOMBARD', PrereqTech = 'TECH_SYNTHETIC_MATERIALS', StrategicResource = 'RESOURCE_OIL' 
WHERE UnitType = 'UNIT_BATTLESHIP';

-- Information Era
UPDATE Units SET BaseMoves = 5, Combat = 90, PromotionClass = 'PROMOTION_CLASS_LIGHT_CAVALRY'
WHERE UnitType = 'UNIT_MECHANIZED_INFANTRY';

UPDATE Units SET Combat = 75, RangedCombat = 85, Range = 1, PromotionClass = 'PROMOTION_CLASS_ANTI_CAVALRY', PrereqTech = 'TECH_STEALTH_TECHNOLOGY'
WHERE UnitType = 'UNIT_HELICOPTER';

UPDATE Units SET Maintenance = 7, Combat = 78, RangedCombat = 82, Range = 1, AntiAirCombat = 70, PromotionClass = 'PROMOTION_CLASS_AUTOMATIC_GUN'
WHERE UnitType = 'UNIT_MODERN_AT';

UPDATE Units SET BaseMoves = 4, Combat = 83, Bombard = 95
WHERE UnitType = 'UNIT_ROCKET_ARTILLERY';

UPDATE Units SET Combat = 98
WHERE UnitType = 'UNIT_MODERN_ARMOR';

UPDATE Units SET PrereqTech = 'TECH_NANOTECHNOLOGY'
WHERE UnitType = 'UNIT_DRONE';

UPDATE Units SET BaseMoves = 10, Range = 10, Combat = 115, RangedCombat = 105
WHERE UnitType = 'UNIT_JET_FIGHTER';

UPDATE Units SET BaseMoves = 4, Cost = 690, PromotionClass = 'PROMOTION_CLASS_NAVAL_BOMBARD', Range = 4, Combat = 90, Bombard = 100, RangedCombat = 0, AntiAirCombat = 88, PrereqTech = 'TECH_NUCLEAR_FUSION'
WHERE UnitType = 'UNIT_MISSILE_CRUISER';

-- Civilization & Scenario Pack Compatibility
UPDATE Units SET Combat = 80
WHERE UnitType = 'UNIT_DIGGER' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_DIGGER');

UPDATE Units SET Cost = 120, Combat = 40, MandatoryObsoleteTech = 'TECH_METAL_CASTING'
WHERE UnitType = 'UNIT_MACEDONIAN_HETAIROI' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_MACEDONIAN_HETAIROI');

-----------------------
-- Units_XP2 Changes --
-----------------------
UPDATE Units_XP2 SET ResourceMaintenanceType = 'RESOURCE_OIL'
WHERE UnitType ='UNIT_BATTLESHIP';

UPDATE Units_XP2 SET ResourceMaintenanceType = 'RESOURCE_IRON'
WHERE UnitType = 'UNIT_ARTILLERY';

---------------------------
-- Unit Upgrades Changes --
---------------------------
-- Land Units
UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_WW1_INFANTRY'
WHERE Unit = 'UNIT_ENGLISH_REDCOAT';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_WW1_INFANTRY'
WHERE Unit = 'UNIT_FRENCH_GARDE_IMPERIALE';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_MODERN_INFANTRY'
WHERE Unit = 'UNIT_INFANTRY';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_COMPOSITE_BOWMAN'
WHERE Unit = 'UNIT_ARCHER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_CULVERIN'
WHERE Unit = 'UNIT_CROSSBOWMAN';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_CULVERIN'
WHERE Unit = 'UNIT_CHINESE_CROUCHING_TIGER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_FIELD_GUN'
WHERE Unit = 'UNIT_FIELD_CANNON';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_HEAVY_INFANTRY'
WHERE Unit = 'UNIT_SPEARMAN';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_MOUNTED_RIFLES'
WHERE Unit = 'UNIT_CAVALRY';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_ARMORED_INFANTRY'
WHERE Unit = 'UNIT_RUSSIAN_COSSACK';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_ARMORED_HORSEMAN'
WHERE Unit = 'UNIT_HEAVY_CHARIOT';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_ARMORED_HORSEMAN'
WHERE Unit = 'UNIT_SUMERIAN_WAR_CART';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_REITER'
WHERE Unit = 'UNIT_KNIGHT';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_LANDSHIP'
WHERE Unit = 'UNIT_AMERICAN_ROUGH_RIDER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_RIFLED_CANNON'
WHERE Unit = 'UNIT_BOMBARD';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_HEAVY_HOWITZER'
WHERE Unit = 'UNIT_ARTILLERY';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_PELTAST'
WHERE Unit = 'UNIT_SLINGER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_LANDSHIP'
WHERE Unit = 'UNIT_INDIAN_VARU';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_RIFLEMAN'
WHERE Unit = 'UNIT_JAPANESE_SAMURAI';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_TREBUCHET'
WHERE Unit = 'UNIT_CATAPULT';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_RIFLEMAN'
WHERE Unit = 'UNIT_MUSKETMAN';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_WW1_INFANTRY'
WHERE Unit = 'UNIT_SPANISH_CONQUISTADOR';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_LONGSWORDSMAN'
WHERE Unit = 'UNIT_SWORDSMAN';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_LONGSWORDSMAN'
WHERE Unit = 'UNIT_ROMAN_LEGION';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_LONGSWORDSMAN'
WHERE Unit = 'UNIT_KONGO_SHIELD_BEARER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_LINE_INFANTRY'
WHERE Unit = 'UNIT_PIKE_AND_SHOT';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_FIELD_GUN'
WHERE Unit = 'UNIT_KOREAN_HWACHA';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_MOUNTED_RIFLES'
WHERE Unit = 'UNIT_MAPUCHE_MALON_RAIDER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_RIFLEMAN'
WHERE Unit = 'UNIT_GEORGIAN_KHEVSURETI';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_STRADIOT'
WHERE Unit = 'UNIT_COURSER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_LANDSHIP'
WHERE Unit = 'UNIT_CUIRASSIER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_CUIRASSIER'
WHERE Unit = 'UNIT_ARABIAN_MAMLUK';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_ARMORED_INFANTRY'
WHERE Unit = 'UNIT_HUNGARY_HUSZAR';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_WW1_INFANTRY'
WHERE Unit = 'UNIT_SULEIMAN_JANISSARY';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_ANTI_TANK_RIFLE'
WHERE Unit = 'UNIT_SWEDEN_CAROLEAN';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_RECON_HELICOPTER'
WHERE Unit = 'UNIT_OBSERVATION_BALLOON';

-- Naval Units
UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_CORVETTE'
WHERE Unit = 'UNIT_CARAVEL';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_GALLEASS'
WHERE Unit = 'UNIT_QUADRIREME';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_ARMORED_CRUISER'
WHERE Unit = 'UNIT_FRIGATE';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_TORPEDO_GUNBOAT'
WHERE Unit = 'UNIT_IRONCLAD';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_RAIDER'
WHERE Unit = 'UNIT_PRIVATEER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_COG'
WHERE Unit = 'UNIT_GALLEY';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_COG'
WHERE Unit = 'UNIT_NORWEGIAN_LONGSHIP';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_RAIDER'
WHERE Unit = 'UNIT_OTTOMAN_BARBARY_CORSAIR';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_COG'
WHERE Unit = 'UNIT_PHOENICIA_BIREME';

-- Civilization & Scenario Pack Compatibility
UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_LANDSHIP'
WHERE Unit = 'UNIT_POLISH_HUSSAR' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_POLISH_HUSSAR');

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_MODERN_INFANTRY'
WHERE Unit = 'UNIT_DIGGER' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_DIGGER');

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_RIFLED_CANNON'
WHERE Unit = 'UNIT_KHMER_DOMREY' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_KHMER_DOMREY');

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_ARMORED_CRUISER'
WHERE Unit = 'UNIT_INDONESIAN_JONG' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_INDONESIAN_JONG');

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_ARMORED_CRUISER'
WHERE Unit = 'UNIT_DE_ZEVEN_PROVINCIEN' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_DE_ZEVEN_PROVINCIEN');

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_REITER'
WHERE Unit = 'UNIT_MACEDONIAN_HETAIROI' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_MACEDONIAN_HETAIROI');

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_LONGSWORDSMAN'
WHERE Unit = 'UNIT_MACEDONIAN_HYPASPIST' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_MACEDONIAN_HYPASPIST');

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_MOUNTED_RIFLES'
WHERE Unit = 'UNIT_COLOMBIAN_LLANERO' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_COLOMBIAN_LLANERO');

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_COMPOSITE_BOWMAN'
WHERE Unit = 'UNIT_MAYAN_HULCHE' AND EXISTS (SELECT UnitType FROM Units WHERE UnitType = 'UNIT_MAYAN_HULCHE');

------------------
-- UnitReplaces --
------------------
UPDATE UnitReplaces SET ReplacesUnitType = 'UNIT_DREADNOUGHT'
WHERE CivUniqueUnitType = 'UNIT_BRAZILIAN_MINAS_GERAES';

UPDATE UnitReplaces SET ReplacesUnitType = 'UNIT_CULVERIN'
WHERE CivUniqueUnitType = 'UNIT_KOREAN_HWACHA';

UPDATE UnitReplaces SET ReplacesUnitType = 'UNIT_LINE_INFANTRY'
WHERE CivUniqueUnitType = 'UNIT_SWEDEN_CAROLEAN';

-- Civilization & Scenario Pack Compatibility
UPDATE UnitReplaces SET ReplacesUnitType = 'UNIT_WW1_INFANTRY'
WHERE CivUniqueUnitType = 'UNIT_DIGGER' AND EXISTS (SELECT 1 FROM Units WHERE UnitType = 'UNIT_DIGGER');

UPDATE UnitReplaces SET ReplacesUnitType = 'UNIT_ARMORED_HORSEMAN'
WHERE CivUniqueUnitType = 'UNIT_MACEDONIAN_HETAIROI' AND EXISTS (SELECT 1 FROM Units WHERE UnitType = 'UNIT_MACEDONIAN_HETAIROI');

---------------------
-- Unit Promotions --
---------------------
UPDATE UnitPromotions SET PromotionClass = 'PROMOTION_CLASS_AIR_ATTACK'
WHERE UnitPromotionType = 'PROMOTION_CLOSE_AIR_SUPPORT';

UPDATE UnitPromotions SET PromotionClass = 'PROMOTION_CLASS_AIR_ATTACK'
WHERE UnitPromotionType = 'PROMOTION_TORPEDO_BOMBER';

UPDATE UnitPromotions SET PromotionClass = 'PROMOTION_CLASS_AIR_ATTACK'
WHERE UnitPromotionType = 'PROMOTION_TANK_BUSTER';

------------------------
-- Tech Boost Changes --
------------------------
UPDATE Boosts SET TriggerDescription = 'LOC_BOOST_TRIGGER_BOWMAN', TriggerLongDescription = 'LOC_BOOST_TRIGGER_LONGDESC_BOWMAN', Unit1Type = 'UNIT_COMPOSITE_BOWMAN' 
WHERE TechnologyType = 'TECH_MACHINERY';