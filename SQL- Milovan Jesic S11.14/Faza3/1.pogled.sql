USE Gog;
GO

-- Pogleda koji vraca podatke o igrici kao sto su id, naziv, cena, datum izdavanja, naziv izdavaca, 
-- broj porudzbina i ukupni sati provedeni na igrici
CREATE OR ALTER VIEW Gog.info1 AS
SELECT g.gameID,g.game_name, g.price, g.release_date, p.publisher_name, COUNT(*) as num_orders, SUM(s.hours_played) total_hours_played
FROM Gog.game g INNER JOIN Gog.publisher p
ON g.publisher_publisherID = p.publisherID
INNER JOIN Gog.orders o
ON g.gameID = o.game_gameID
INNER JOIN Gog.info s
ON s.game_gameID = o.game_gameID
GROUP BY g.gameID, g.game_name, g.price, g.release_date, p.publisher_name;
GO

SELECT * FROM Gog.info1;