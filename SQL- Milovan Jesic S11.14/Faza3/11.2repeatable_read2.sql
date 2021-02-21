-- STEP 2
USE Gog;
GO

-- Step 3
-- BEGIN TRANSACTION


UPDATE Gog.users
SET Gog.users.users_password = '123'
WHERE Gog.users.usersID=4

SELECT * FROM Gog.users
WHERE Gog.users.usersID=4;

-- COMMIT TRANSACTION
go