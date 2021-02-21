USE Gog;
GO

CREATE OR ALTER PROCEDURE Gog.PlaceOrder
(
      @username NVARCHAR(55)
    , @gameID INT
)
AS
BEGIN
    SAVE TRANSACTION MySavePoint;
   
   DECLARE @gamePrice DECIMAL(10, 2);
   DECLARE @walletFunds DECIMAL(10, 2);
   DECLARE @userID INT;

   SELECT @gamePrice = g.price
   FROM Gog.game AS g
   WHERE g.gameID = @gameID;

   SELECT @walletFunds = w.wallet_funds
   FROM Gog.wallet w
   INNER JOIN Gog.users u
   ON u.username = @username

   SELECT @userID = usersID
   from Gog.users
   WHERE username = @username

    BEGIN TRY
		IF @walletFunds < @gamePrice 
			THROW 5100, 'Insufficient funds!',1;



		UPDATE Gog.wallet
		SET wallet_funds = wallet_funds - @gamePrice
		WHERE users_usersID IN (SELECT username from users where username = @username)

        INSERT INTO Gog.orders(order_date, users_usersID, game_gameID)
		VALUES (SYSDATETIME(), @userID, @gameID);
	
        COMMIT TRANSACTION 
		print 'Transakcija uspesna!'
    END TRY
    BEGIN CATCH
		print 'Transakcija neuspesno zavrsena!'
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION MySavePoint; -- rollback to MySavePoint
        END
    END CATCH
END;
GO

EXEC  Gog.PlaceOrder 1, 14
GO