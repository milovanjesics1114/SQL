USE Gog;
GO

DROP TABLE IF EXISTS Gog.index_logs;
CREATE TABLE Gog.index_logs (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    event_data XML NOT NULL,
    changed_by SYSNAME NOT NULL
);
GO



CREATE OR ALTER TRIGGER trg_index_changes
ON DATABASE
FOR 
    CREATE_INDEX,
    ALTER_INDEX, 
    DROP_INDEX,
	CREATE_TABLE
AS
BEGIN
    SET NOCOUNT ON;
 
    INSERT INTO Gog.index_logs (event_data, changed_by)
    VALUES (EVENTDATA(), USER);
END;
GO


DROP TABLE IF EXISTS ddl_test_table;
CREATE TABLE ddl_test_table(
ID int PRIMARY KEY
);
GO

SELECT * FROM Gog.index_logs
GO