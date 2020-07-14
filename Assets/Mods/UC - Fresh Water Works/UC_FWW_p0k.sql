-- UC_FWW_p0k
-- Author: JNR
--------------------------------------------------------------

------------------
-- INSTRUCTIONS --
------------------
-- various options for ensuring compatibility of this mod ("FWW") with p0kiehl's Better Aqueduct ("PBA") mod.
-- Mark as comment all lines in this file to make no adjustments and stack bonuses
-- When neither option is marked as comment, option 2 overrides option 1.
-- Option 2 is default.
------------------

-- Option 1: +1 Housing for charming Aqueducts from PBA active until Urbanization, when FWW takes over:
------------------
--UPDATE Modifiers SET SubjectRequirementSetId='JNR_P0K_AQUEDUCT_REQUIREMENTS' WHERE ModifierId='P0K_BA_AQUEDUCT_BREATHTAKING_HOUSING';
------------------

-- Option 2: PBA no longer grants +1 Housing for charming Aqueducts at any time:
------------------
UPDATE ModifierArguments SET Value=0 WHERE ModifierId='P0K_BA_AQUEDUCT_BREATHTAKING_HOUSING' AND Name='Amount';
------------------