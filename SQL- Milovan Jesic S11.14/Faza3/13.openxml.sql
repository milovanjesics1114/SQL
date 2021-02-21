USE Gog;

DECLARE @xmlDocHandle INT;
DECLARE @xmlDoc nvarchar(max);

SET @xmlDoc =  (SELECT * FROM Gog.users
FOR XML PATH('User'),ROOT('Users'))

--PRINT @xmlDoc



exec sp_xml_preparedocument @xmlDocHandle OUTPUT, @xmlDoc;
SELECT * FROM OPENXML(@xmlDocHandle, 'Users/User', 2)
WITH Gog.users
go
