USE Gog;
GO

DECLARE @json NVARCHAR(MAX)

SET @json=(SELECT * FROM Gog.users FOR JSON AUTO)


PRINT @json

SELECT Users.*
FROM OPENJSON(@json)
WITH (
	usersID INT,
	username nvarchar(55),
	email nvarchar(255),
	users_password nvarchar(255),
	birthday date,
	users_location nvarchar(56)
)
AS Users
go