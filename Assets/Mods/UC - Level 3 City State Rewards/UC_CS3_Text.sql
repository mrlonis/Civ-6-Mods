-- UC_CS3_Text
-- Author: JNR
--------------------------------------------------------------

-- BaseGameText
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText
		(Tag, Text)
VALUES	-- General Pedia Intro Text
		('LOC_PEDIA_CONCEPTS_PAGEGROUP_JNR_URBANCOMPLEXITY_NAME',
		'Urban Complexity'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_TITLE',
		'Introduction'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_PARA_1',
		'Urban Complexity is a mod series which aims to provide more depth to building and developing your cities while striking a balance between authentic flavor and enjoyable gameplay. With Urban Complexity mods, choosing what to build is no longer just a chore where you tick items of a set build order. Instead, proper consideration of your local environment and factors such as adjacencies, available terrain, other districts present in the city, etc. shall pay off greatly.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_PARA_2',
		'Dear player,'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_PARA_3',
		'The following pages in the Civilopedia shall serve as guidance for you to naviate the complexity introduced by these mods. Use them to learn more about the mods and as a reminder for what features are available and how they work.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_PARA_4',
		'Feedback is always welcome. Please do not hesisate to contact me with your thoughts, ideas, and criticism.[NEWLINE]I hope my mods will add to your enjoyment of Civilization VI and allow you to go about developing your cities in new ways. Have fun and may your empire stand the test of time!'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_PARA_5',
		'Yours sincerely,[NEWLINE]JNR'),

		-- CS3 Text
		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_TITLE',
		'Level 3 City State Rewards'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_PARA_1',
		'City States now provide bonuses to level 3 buildings as well if the proper conditions are met. These bonuses work just like the bonuses to level 1 and level 2 buildings gained at three or six [ICON_Envoy] Envoys, respectively.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_PARA_2',
		'Conditions:[NEWLINE]To get the level 3 bonuses from a City State, a player must either have nine (9) [ICON_Envoy] Envoys in that City State OR be the suzerain of that City State. Meeting both conditions does NOT double the bonus, either is enough.'),
		
		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_PARA_3',
		'Cultural City States: +2 [ICON_Culture] Culture in every Broadcast Center building.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_PARA_4',
		'Industrial City States: +2 [ICON_Production] Production (local) in every city with any power plant building when producing wonders, buildings, and districts.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_PARA_5',
		'Militaristic City States: +2 [ICON_Production] Production in every city with a Military Academy building when producing units.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_PARA_6',
		'Scientific City States: +2 [ICON_Science] Science in every Research Lab building.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_PARA_7',
		'Trade City States: +4 [ICON_Gold] Gold in every Stock Exchange building.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_PARA_8',
		'Worship City States: +2 [ICON_Faith] Faith in every Worship building.'),
		
		--('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3CIVITAS_TITLE',
		--'DLC - Australia'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3CIVITAS_PARA_1',
		'Agricultural City States: +2 [ICON_Food] Food in every Sewers building.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3CIVITAS_PARA_1',
		'Consular City States: +2 [ICON_Faith] Loyalty in every city if you have built a level 3 Government Plaza building.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3CIVITAS_PARA_1',
		'Entertainment City States: +1 [ICON_Amenities] Amenity (local) in every Stadium building.'),

		('LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3CIVITAS_PARA_1',
		'Maritime City States: +1 [ICON_Food] Food and +1 [ICON_Production] Production in every Seaport building.');

INSERT OR REPLACE INTO BaseGameText
		(Tag, Text)
SELECT	'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_PARA_7',
		'Trade City States: +2 [ICON_Gold] Gold in every Stock Exchange and Seaport building.'
		FROM EnglishText WHERE Text='+2 [ICON_Gold] Gold in every Bank and Shipyard building.';
--------------------------------------------------------------