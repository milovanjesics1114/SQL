use Gog
GO

-- visevrednosni upiti
-- Ovaj upit nam dohvata sve igrice, koje su izdate od 2018. godine
SELECT * FROM Gog.Game WHERE Gog.Game.GameID in (select Gog.Game.GameID where Gog.Game.release_date > '2018')
GO


-- skalarni
-- Ovaj upit nam vraca igricu koja kosta najvise trenutno u nasem shop-u
SELECT * FROM Gog.Game WHERE Gog.Game.price = (SELECT MAX(Gog.Game.price) FROM Gog.Game);
GO

-- korelativni
-- ovaj upit se koristi da bi dobili uvid u izdavace igrica i koliko naslova su do sad izdali, sortirano opadjauce
select spolj.publisher_name, (SELECT COUNT(*) FROM Gog.Game WHERE Gog.Game.publisher_publisherID = spolj.publisherID) AS BrojIgrica
From Gog.Publisher AS spolj
WHERE (SELECT COUNT(*) FROM Gog.Game WHERE Gog.Game.publisher_publisherID = spolj.publisherID) > 0
ORDER BY BrojIgrica DESC

-- exists
-- Ovaj upit se koristi da bi nam dao uvid u najtrazenije igrice trenutno. Igrica spada u najtrazenije ako je ptoraznja
-- za njom veca ili jednaka 10% od ukupne
select k.game_name
FROM Gog.Game AS k
WHERE EXISTS(SELECT COUNT(*) FROM Gog.wishlist AS w 
                             WHERE w.game_gameID = k.gameID 
							 GROUP BY w.game_gameID
							 HAVING (COUNT(*)*1.0)/(SELECT COUNT(*) from Gog.wishlist) >= 0.1)
GO


-- offset fetch
-- Ovaj upit vraca 10 igrica, pomerenih za 10 mesta(odnosno dohvatanje narednih 10), koje su inicijalno sortirane po potraznji
SELECT * 
FROM Gog.Game AS g
ORDER BY (SELECT COUNT(*) FROM Gog.wishlist AS w WHERE w.game_gameID = g.gameID GROUP BY w.game_gameID) DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
GO



