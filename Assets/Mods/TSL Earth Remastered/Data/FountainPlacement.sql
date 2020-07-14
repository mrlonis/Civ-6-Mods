--TSLEE
INSERT INTO NaturalWonderPosition
SELECT * FROM FountainPosition
WHERE MapName="TSLEE"
ORDER BY RANDOM()
LIMIT 1;

--Cordiform Earth
INSERT INTO NaturalWonderPosition
SELECT * FROM FountainPosition
WHERE MapName="CordEarth"
ORDER BY RANDOM()
LIMIT 1;

--Tiny Earth
INSERT INTO NaturalWonderPosition
SELECT * FROM FountainPosition
WHERE MapName="TinyEarth"
ORDER BY RANDOM()
LIMIT 1;

--Cogitator's Huge Earth
INSERT INTO NaturalWonderPosition
SELECT * FROM FountainPosition
WHERE MapName="CogEarth"
ORDER BY RANDOM()
LIMIT 1;

--VIKING Giant Earth
INSERT INTO NaturalWonderPosition
SELECT * FROM FountainPosition
WHERE MapName="VIKING_GiantEarth"
ORDER BY RANDOM()
LIMIT 1;