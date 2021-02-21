USE Gog;
GO

SELECT * FROM Gog.users
FOR XML PATH('User'),ROOT('Users')
GO