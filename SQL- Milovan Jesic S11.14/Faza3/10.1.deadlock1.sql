-- STEP 0
USE Gog;
GO
-- STEP 1
BEGIN TRAN
UPDATE Gog.wallet
SET Gog.wallet.wallet_funds += 10
WHERE Gog.wallet.users_usersID = 1;

-- STEP 4
SELECT * 
FROM Gog.info
WHERE Gog.info.users_usersID = 1;

COMMIT TRAN
GO
