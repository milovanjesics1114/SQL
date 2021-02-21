USE Gog;
GO

CREATE OR ALTER FUNCTION Gog.GetNumOrders ()
RETURNS INT AS 
BEGIN
DECLARE @Cnt int;
SELECT @Cnt = COUNT(*) FROM Gog.orders
RETURN @Cnt;
END
GO

print Gog.GetNumOrders() 
