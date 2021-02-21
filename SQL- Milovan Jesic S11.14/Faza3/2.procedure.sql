USE Gog;
GO

-- INSERT
CREATE OR ALTER PROCEDURE Gog.InsertUsers
(
	@Username		nvarchar(100),
	@Email			nvarchar(100),
	@Users_Password nvarchar(256),
	@Users_Location nvarchar(100),
	@UsersID		int OUTPUT
)
AS
BEGIN TRY
	INSERT INTO Gog.users(username,email,users_password,users_location)
	VALUES (@Username, @Email, @Users_Password, @Users_Location)
	SET @UsersID = SCOPE_IDENTITY();
END TRY
BEGIN CATCH
print 'Greska pri dodavanju korisnika'
	exec Gog.ErrHandler
END CATCH
GO

CREATE OR ALTER PROCEDURE Gog.DeleteUserOrder
(
	@UsersID int,
	@GameID  int
)
AS
BEGIN TRY
	DELETE FROM Gog.orders
	WHERE Gog.orders.users_usersID = @UsersID AND Gog.orders.game_gameID = @GameID
END TRY
BEGIN CATCH
	print 'Greska pri brisanju narudzbine korisnika'
	exec Gog.ErrHandler
END CATCH
GO


CREATE OR ALTER PROCEDURE Gog.UpdateWallet
(
@UsersID int,
@Value   decimal
)
AS
BEGIN TRY
	IF @Value < 0
	BEGIN
		print 'Vrednost mora biti veca od 0!';
		RETURN 0;
	END
	UPDATE Gog.wallet
	SET Gog.wallet.wallet_funds = @Value
	WHERE Gog.wallet.users_usersID = @UsersID
END TRY
BEGIN CATCH
	print 'Greska pri azuriranju wallet-a korisnika'
	exec Gog.ErrHandler
END CATCH
GO


DROP TABLE IF EXISTS Gog.ProcedureErrorLog;
CREATE TABLE Gog.ProcedureErrorLog(
	ID int IDENTITY(1,1),
	ErrTime DATETIME NOT NULL DEFAULT(GETDATE()),
	ErrNumber int NOT NULL,
	Severity int NOT NULL,
	ErrState int NULL,
	ErrProcedure nvarchar(256) NULL,
	Line int NULL,
	ErrMessage nvarchar(1024) NULL,
	Username nvarchar(100) NULL DEFAULT(SUSER_NAME())
);
GO

CREATE OR ALTER PROCEDURE Gog.ErrHandler
AS
BEGIN
BEGIN TRY
	INSERT INTO Gog.ProcedureErrorLog(ErrNumber, Severity,ErrState, ErrProcedure, Line, ErrMessage)
	VALUES (ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(), ERROR_LINE(), ERROR_MESSAGE());
END TRY
BEGIN CATCH
	print 'Internal error, cannot log procedure error!';
END CATCH
END
GO



-- Insert example
DECLARE @UsersID int
EXEC Gog.InsertUsers N'Insert_user',N'insert@email.com','123','Belgrade, Serbia', @UsersID


-- Update example
EXEC Gog.UpdateWallet 1, -10
GO
-- Delete example
EXEC Gog.DeleteUserOrder 1,1
GO
