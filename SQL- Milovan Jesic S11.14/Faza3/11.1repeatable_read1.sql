-- STEP 0
USE Gog;
GO


UPDATE Gog.Users
SET Gog.Users.users_password = 'ABC'
WHERE Gog.users.usersID=4

-- STEP 1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
GO
BEGIN TRANSACTION

SELECT * FROM Gog.users
WHERE Gog.users.usersID=4;

-- STEP 4
SELECT * FROM Gog.users
WHERE Gog.users.usersID=4;

COMMIT TRANSACTION
