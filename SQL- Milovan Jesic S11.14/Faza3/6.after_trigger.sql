USE Gog;
GO

DROP TRIGGER IF EXISTS Gog.TR_Orders_Insert;
GO
-- pa tek onda kreiranje
CREATE TRIGGER Gog.TR_Orders_Insert
	ON Gog.orders
	AFTER INSERT 
AS 
BEGIN
	SET NOCOUNT ON;
	IF EXISTS( SELECT * FROM inserted AS i WHERE i.order_date > SYSDATETIME() ) 
	BEGIN
		PRINT 'Datum kupovine mora biti jednak ili manji trenutnom datumu';
 		if @@TRANCOUNT > 0 ROLLBACK TRAN
	END;

	DELETE FROM Gog.wishlist
	WHERE EXISTS(SELECT i.users_usersID, i.game_gameID 
	             FROM inserted AS i
				 WHERE i.users_usersID = users_usersID AND 
				       i.game_gameID = game_gameID)
END;
GO


INSERT INTO Gog.Orders
VALUES ('2022', 1, 3)
GO