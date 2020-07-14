-- AutoBuilders_Schema
-- Author: MadManCam
-- DateCreated: 5/27/2018 6:02:45 AM
--------------------------------------------------------------


-- Main database tables.
CREATE TABLE CNO_AutoBuilders_Settings (
  Setting TEXT NOT NULL,
  mValue INTEGER NOT NULL DEFAULT 0,
  mFloat REAL NOT NULL DEFAULT 0.0,
  mBoolean BOOLEAN NOT NULL CHECK (mBoolean IN (0,1)) DEFAULT 0,
  PRIMARY KEY(Setting)
);

CREATE TABLE CNO_AutoBuilders_PrioritySettings (
  mTable TEXT NOT NULL,
  Setting TEXT NOT NULL,
  mValue INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY(mTable, Setting)
);

-- Small tables used to easily set game configuration values.
CREATE TABLE AutoBuilders_Settings_Value (
	Setting TEXT NOT NULL,
	Value INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY(Setting)
);
CREATE TABLE AutoBuilders_Settings_Float (
	Setting TEXT NOT NULL,
	Value REAL NOT NULL DEFAULT 0.0,
	PRIMARY KEY(Setting)
);
CREATE TABLE AutoBuilders_Settings_Boolean (
	Setting TEXT NOT NULL,
	Value BOOLEAN NOT NULL CHECK (Value IN (0,1)) DEFAULT 0,
	PRIMARY KEY(Setting)
);

-- Insert into small tables after insert on main tables
CREATE TRIGGER CNO_AutoBuilders_Settings_Cascade AFTER INSERT ON CNO_AutoBuilders_Settings
BEGIN
	INSERT INTO AutoBuilders_Settings_Value(Setting, 'Value') VALUES ( 'AutoBuilders_' || NEW.Setting || '_Value', NEW.mValue );
	INSERT INTO AutoBuilders_Settings_Float(Setting, 'Value') VALUES ( 'AutoBuilders_' || NEW.Setting || '_Float', NEW.mFloat );
	INSERT INTO AutoBuilders_Settings_Boolean(Setting, 'Value') VALUES ( 'AutoBuilders_' || NEW.Setting || '_Boolean', NEW.mBoolean );
END;

CREATE TRIGGER CNO_AutoBuilders_PrioritySettings_Cascade AFTER INSERT ON CNO_AutoBuilders_PrioritySettings
BEGIN
	INSERT INTO AutoBuilders_Settings_Value(Setting, 'Value') VALUES ( 'AutoBuilders_' || NEW.mTable || '_' || NEW.Setting || '_Value', NEW.mValue );
END;
