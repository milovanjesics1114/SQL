USE Gog;
GO

CREATE OR ALTER FUNCTION Gog.GetBoughtGames
(
	@StartDate DATE,
	@EndDate   DATE
)
RETURNS TABLE AS
RETURN (
	SELECT g.game_name, g.price, g.game_description, p.publisher_name, COUNT(*) as num_orders
	FROM Gog.game g
	INNER JOIN Gog.publisher p
	ON g.publisher_publisherID = p.publisherID
	INNER JOIN Gog.orders o
	ON g.gameID = o.game_gameID
	WHERE o.order_date BETWEEN @StartDate AND @EndDate
	GROUP BY g.game_name, g.price, g.game_description, p.publisher_name
);
GO

select * from Gog.GetBoughtGames('2015', '2020')