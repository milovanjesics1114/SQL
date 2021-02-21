USE Gog;
GO

CREATE OR ALTER TRIGGER Gog.TG_Users_DELETE ON Gog.users
	INSTEAD OF DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @brojObrisanih int;
	SELECT @brojObrisanih = COUNT(*) FROM deleted;
	IF @brojObrisanih > 0
	BEGIN
		RAISERROR ('Nije dozvoljeno brisanje korisnika', 10, 1);
		IF @@TRANCOUNT > 0
			ROLLBACK TRAN;
	END;
END;
GO

DELETE FROM Gog.users
WHERE Gog.users.usersID = 1;
GO