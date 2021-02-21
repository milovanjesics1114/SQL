Use Gog;
GO
-- Procedura za stranicenje
CREATE OR ALTER PROCEDURE Gog.GetPagedGames @Page INT, @RowNum INT
AS SELECT g.game_name, g.release_date, g.price, g.on_sale, g.game_description, p.publisher_name
FROM Gog.game g
INNER JOIN Gog.publisher p
ON p.publisherID = g.publisher_publisherID
ORDER BY g.game_name
OFFSET (@Page - 1)*@RowNum ROWS FETCH NEXT @RowNum ROWS ONLY;
GO

EXEC Gog.GetPagedGames 1, 2