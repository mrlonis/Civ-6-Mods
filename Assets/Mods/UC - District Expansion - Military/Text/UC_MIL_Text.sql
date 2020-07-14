-- UC_MIL_Text
-- Author: JNR
--------------------------------------------------------------

-- BaseGameText
--------------------------------------------------------------
INSERT OR IGNORE INTO BaseGameText
		(Tag,															Text)
VALUES	('LOC_BUILDING_JNR_TARGET_RANGE_NAME',							'Target Range'),
		('LOC_BUILDING_JNR_TARGET_RANGE_DESCRIPTION',					'+25% combat experience for all ranged, recon, and siege promotion class units trained in this city.[NEWLINE]Recon units trained in this city start with a free promotion.[NEWLINE]Enables training Military Engineers in this city.'),
		('LOC_BUILDING_BARRACKS_DESCRIPTION_UC_JNR',					'+50% combat experience for all melee and anti-cavalry promotion class units trained in this city.[NEWLINE]Enables training Military Engineers in this city.'),
		('LOC_BUILDING_STABLE_DESCRIPTION_UC_JNR',						'+25% combat experience for all heavy cavalry and light cavalry promotion class units trained in this city.[NEWLINE]Enables training Military Engineers in this city.[NEWLINE]+1 [ICON_Production] Production to all [ICON_RESOURCE_HORSES] Horses in this city.'),
		('LOC_BUILDING_BASILIKOI_PAIDES_DESCRIPTION_UC_JNR',			'A building unique to Macedonia.[NEWLINE]Gain [ICON_SCIENCE] Science equal to 25% of the unit''s cost when a non civilian unit is created in this city.[NEWLINE][NEWLINE]+50% combat experience for all melee and anti-cavalry promotion class units and +25% combat experience for Hetairoi trained in this city.[NEWLINE]Enables training Military Engineers in this city.'),
		('LOC_BUILDING_ORDU_DESCRIPTION_UC_JNR',						'A building unique to Mongolia.[NEWLINE]Grants an ability that gives +1 [ICON_MOVEMENT] Movement to Heavy Cavalry and Light Cavalry trained in this city.[NEWLINE]Provides more [ICON_GreatGeneral] Great General Points.[NEWLINE][NEWLINE]+25% combat experience for all heavy cavalry and light cavalry promotion class units trained in this city.[NEWLINE]Enables training Military Engineers in this city.[NEWLINE]+1 [ICON_Production] Production to all [ICON_RESOURCE_HORSES] Horses in this city.'),
		('LOC_BUILDING_JNR_CAVALIER_NAME',								'Artillery Battery'),
		('LOC_BUILDING_JNR_CAVALIER_DESCRIPTION',						'+25% combat experience for all siege promotion class units trained in this city.[NEWLINE]Siege promotion class units trained in this city start with a free promotion.[NEWLINE]+2 City [ICON_Strength] Defense Strength. +2 City [ICON_Ranged] Ranged Strength per level of Walls.[NEWLINE]Military Engineers trained in this city get +1 build charges.'),
		('LOC_BUILDING_JNR_DEPOT_NAME',									'Supply Depot'),
		('LOC_BUILDING_JNR_DEPOT_DESCRIPTION',							'+25% combat experience for all heavy cavalry and light cavalry promotion class units trained in this city.[NEWLINE]Heavy cavalry and light cavalry promotion class units trained in this city start with a free promotion.[NEWLINE]+50% [ICON_Production] Production towards all support class units in this city.[NEWLINE]Enables training Medics and Supply Convoys in this city.'),
		('LOC_BUILDING_ARMORY_DESCRIPTION_UC_JNR',						'+50% [ICON_Production] Production towards all melee, anti-cavalry, recon, and ranged promotion class units in this city.'),
		('LOC_BUILDING_JNR_ARSENAL_NAME',								'Arsenal'),
		('LOC_BUILDING_JNR_ARSENAL_DESCRIPTION',						'+50% [ICON_Production] Production towards all siege, heavy cavalry, and light cavalry promotion class units in this city.[NEWLINE]Allows Corps and Armies to be trained directly. Corps and Army training costs reduced 25%.'),
		('LOC_BUILDING_JNR_PRISON_NAME',								'Prison'),
		('LOC_BUILDING_JNR_PRISON_DESCRIPTION',							'This Encampment district gets an additional standard adjacency bonus (+1 [ICON_Production] Production) from Quarries.[NEWLINE]Provides +4 Loyalty per turn to this city.[NEWLINE]Enemy Spies operate at 2 levels below normal in this city.[NEWLINE]When displeased, this city gains +15% [ICON_Production] Production. When unhappy, the bonus is doubled. When at unrest, the bonus is tripled. But beware: When in revolt, the bonus is lost.'),
		('LOC_BUILDING_MILITARY_ACADEMY_DESCRIPTION_UC_JNR',			'+25% combat experience for all melee, anti-cavalry, recon, and ranged promotion class units trained in this city.[NEWLINE]Melee, anti-cavalry, and ranged promotion class units trained in this city start with a free promotion. Recon units trained in this city start with the Ambush promotion.[NEWLINE]Allows Corps and Armies to be trained directly. Corps and Army training costs reduced 25%.[NEWLINE]Provides more [ICON_GreatGeneral] Great General Points.'),
		('LOC_BUILDING_SHIPYARD_DESCRIPTION_UC_JNR',					'+50% [ICON_Production] Production towards all naval units in this city.[NEWLINE]+1 [ICON_PRODUCTION] Production on all unimproved Coast tiles for this city.'),
		('LOC_BUILDING_JNR_NAVAL_BASE_NAME',							'Naval Base'),
		('LOC_BUILDING_JNR_NAVAL_BASE_DESCRIPTION',						'+25% combat experience for all naval units trained in this city.[NEWLINE]All naval units trained in this city start with a free promotion.[NEWLINE]Allows Fleets and Armadas to be trained directly. Fleet and Armada training costs reduced 25%.[NEWLINE]Provides more [ICON_GreatAdmiral] Great Admiral Points.'),
		('LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_MIL',					'+2 [ICON_GOLD] Gold on all Coast tiles for this city.'),
		('LOC_BUILDING_HANGAR_DESCRIPTION_UC_JNR_MIL',					'+50% [ICON_Production] Production towards all air units trained in this city.[NEWLINE]+1 air unit slot in Aerodrome district.'),
		('LOC_BUILDING_AIRPORT_NAME_UC_JNR',							'Air Force Base'),
		('LOC_BUILDING_AIRPORT_DESCRIPTION_UC_JNR_MIL',					'+50% combat experience for air units trained in this city.[NEWLINE]Air units trained in this city start with a free promotion.[NEWLINE]+2 air unit slots in Aerodrome district.[NEWLINE]Allows the ability to airlift land units between Aerodrome districts with Air Force Bases after the Rapid Deployment civic is unlocked.'),
		('LOC_ABILITY_JNR_TARGET_RANGE_TRAINED_UNIT_XP_DESCRIPTION',	'+25% Earned experience from Target Range'),
		('LOC_ABILITY_JNR_CAVALIER_TRAINED_UNIT_XP_DESCRIPTION',		'+25% Earned experience from Artillery Battery'),
		('LOC_ABILITY_JNR_DEPOT_TRAINED_UNIT_XP_DESCRIPTION',			'+25% Earned experience from Supply Depot'),
		('LOC_ABILITY_BARRACKS_TRAINED_UNIT_XP_DESCRIPTION_JNR_UC',		'+50% Earned experience from Barracks'),
		('LOC_ABILITY_SEAPORT_TRAINED_UNIT_XP_DESCRIPTION_JNR_UC',		'+25% Earned experience from Naval Base'),
		('LOC_UNIT_MILITARY_ENGINEER_DESCRIPTION_JNR_UC',				'Medieval era support unit. Requires Barracks, a Stable or a Target Range to produce. Can construct Roads, Forts, Airstrips, and Missile Silo improvements.'),
		('LOC_UNIT_MEDIC_DESCRIPTION_JNR_UC',							'Industrial era support unit. Requires a Supply Depot to produce. Can heal adjacent units.'),
		('LOC_UNIT_SUPPLY_CONVOY_DESCRIPTION_JNR_UC',					'Modern era support unit. Requires a Supply Depot to produce. Increases healing for adjacent units. Gives units 1 bonus [ICON_Movement] Movement if move is started adjacent to the Convoy.'),
		('LOC_POLICY_LIMES_DESCRIPTION_JNR_UC',							'+100% Encampment district adjacency bonuses. +100% [ICON_Production] Production toward defensive buildings.'),
		('LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_JNR_UC_MIL',			'+100% Encampment district adjacency bonuses. +2 [ICON_Culture] Culture and +4 [ICON_Gold] Gold from each Research Lab, Military Academy, Arsenal, and Prison.'),
		('LOC_POLICY_MILITARY_RESEARCH_DESCRIPTION_JNR_UC',				'Military Academies, Arsenals, Prisons, Naval Bases, Hangars, and Renaissance Walls generate +2 [ICON_Science] Science.'),
		('LOC_POLICY_INTEGRATED_SPACE_CELL_DESCRIPTION_JNR_UC',			'+15% [ICON_Production] Production toward Space Race projects if a city has either a Military Academy, Arsenal, Prison, Naval Base, or Hangar.'),
		('LOC_BOOST_TRIGGER_GUNPOWDER_JNR_UC',							'Build an Armory or Artillery Battery.'),
		('LOC_BOOST_TRIGGER_LONGDESC_GUNPOWDER_JNR_UC',					'Your weaponsmiths are fashioning a new weapon that will devastate opponents.'),
		('LOC_BOOST_TRIGGER_TOTALITARIANISM_JNR_UC',					'Build 2 Prisons.'),
		('LOC_BOOST_TRIGGER_LONGDESC_TOTALITARIANISM_JNR_UC',			'The obedience instilled by your prisons is now second nature to your citizens.');
--------------------------------------------------------------

-- City-State UI
-- BaseGameText
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText
		(Tag,															Text)
VALUES	('LOC_MINOR_CIV_MILITARISTIC_TRAIT_MEDIUM_INFLUENCE_BONUS',		'+2 [ICON_Production] Production in every city with a Barracks, Stable, or Target Range building when producing units.'),
		('LOC_MINOR_CIV_MILITARISTIC_TRAIT_LARGE_INFLUENCE_BONUS',		'+2 [ICON_Production] Production in every city with an Armory, Artillery Battery, or Supply Depot building when producing units.');
-------------------------------------------------------------

-- City-State UI CSE
-- LocalizedText
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText
		(Tag,															Text)
VALUES	('LOC_CSE_MILITARISTIC_TRAIT_MEDIUM_INFLUENCE_BONUS',			'+2 [ICON_PRODUCTION] Production towards units in every city with a Barracks, Stable, or Target Range.'),	
		('LOC_CSE_MILITARISTIC_TRAIT_LARGE_INFLUENCE_BONUS',			'+2 [ICON_PRODUCTION] Production towards units in every city with an Armory, Artillery Battery, or Supply Depot.'),	
		('LOC_CSE_MILITARISTIC_TRAIT_LARGEST_INFLUENCE_BONUS',			'+2 [ICON_PRODUCTION] Production towards units in every city with a Military Academy, Arsenal, or Prison.'),	
		('LOC_CSE_MILITARISTIC_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS',	'+1 [ICON_PRODUCTION] Production towards units in every city with a Barracks, Stable, or Target Range.'),
		('LOC_CSE_MILITARISTIC_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS',	'+3 [ICON_PRODUCTION] Production towards units in every city with a Military Academy, Arsenal, or Prison.');
--------------------------------------------------------------