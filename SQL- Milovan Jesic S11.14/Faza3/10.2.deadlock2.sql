-- STEP 2
USE Gog;
GO

-- STEP 3
BEGIN TRAN
UPDATE Gog.info
SET Gog.info.hours_played += 10
WHERE Gog.info.users_usersID = 1;

-- STEP 5
SELECT * FROM gog.wallet
WHERE Gog.wallet.users_usersID = 1;

COMMIT TRAN
GO