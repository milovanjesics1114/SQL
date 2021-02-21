use Gog
GO

UPDATE Gog.info 
SET Gog.info.hours_played += 1, Gog.info.info_state = 'Proffessional'
WHERE Gog.info.infoID = 1
GO

SELECT * from Gog.Info
GO


DELETE from Gog.wishlist
WHERE Gog.wishlist.users_usersID = 1
GO

SELECT * from Gog.wishlist
WHERE Gog.wishlist.users_usersID = 1
GO