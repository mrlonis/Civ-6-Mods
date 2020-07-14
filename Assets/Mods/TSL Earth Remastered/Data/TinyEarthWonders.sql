--North America
INSERT INTO NaturalWonderPosition
SELECT MapName, FeatureType, TerrainType FROM TinyEarthWonders
WHERE Continent="NorthAm"
ORDER BY RANDOM()
LIMIT 1;

--South America
INSERT INTO NaturalWonderPosition
SELECT MapName, FeatureType, TerrainType FROM TinyEarthWonders
WHERE Continent="SouthAm"
ORDER BY RANDOM()
LIMIT 1;

--Europe
INSERT INTO NaturalWonderPosition
SELECT MapName, FeatureType, TerrainType FROM TinyEarthWonders
WHERE Continent="Europe"
ORDER BY RANDOM()
LIMIT 1;

--Africa
INSERT INTO NaturalWonderPosition
SELECT MapName, FeatureType, TerrainType FROM TinyEarthWonders
WHERE Continent="Africa"
ORDER BY RANDOM()
LIMIT 1;

--Asia
INSERT INTO NaturalWonderPosition
SELECT MapName, FeatureType, TerrainType FROM TinyEarthWonders
WHERE Continent="Asia"
ORDER BY RANDOM()
LIMIT 1;

--Australia
INSERT INTO NaturalWonderPosition
SELECT MapName, FeatureType, TerrainType FROM TinyEarthWonders
WHERE Continent="Australia"
ORDER BY RANDOM()
LIMIT 1;