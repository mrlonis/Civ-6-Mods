-- Tables (TSLEE)
-- Author: totalslacker

CREATE TABLE IF NOT EXISTS TSLEE_UserSettings
	(
	TYPE				TEXT		NOT NULL,
	Value				TEXT		DEFAULT NULL,

	PRIMARY KEY	(TYPE)				
	);
	
CREATE TABLE IF NOT EXISTS FountainPosition
	(	MapName TEXT NOT NULL,
		FeatureType TEXT NOT NULL,
		TerrainType TEXT,
		X INT default 0,
		Y INT default 0);