use Gog;
GO

-- Ovaj upit dohvata sve podatke vezane za igricu, ko ju je objavio
SELECT g.game_name, g.release_date, g.price, g.game_description, p.publisher_name
FROM Gog.Game AS g
INNER JOIN Gog.publisher AS p
ON g.publisher_publisherID = p.publisherID
GO

-- Ovaj upit nam govori o tome koliko je igrica trazena trenutno u procentima(od ukupne potraznje svih igrica)
SELECT g.game_name, 
       g.release_date, 
	   g.price, g.game_description, 
	   cast((1.0*COUNT(w.game_gameID))/(SELECT COUNT(*) from Gog.wishlist)*100 as decimal(7,2)) as 'Potraznja[%]'
FROM Gog.Game as g
INNER JOIN Gog.wishlist as w
ON g.gameID = w.game_gameID
GROUP BY g.game_name, g.release_date, g.price, g.game_description
GO


-- Ovaj upit nam daje uvid u to provedene sate neke igrice
SELECT g.game_name, g.release_date, g.price, g.game_description, SUM(hours_played) as total_hours_played
FROM Gog.Game as g
INNER JOIN Gog.info as i
ON g.gameID = i.game_gameID
GROUP BY g.game_name, g.release_date, g.price, g.game_description
ORDER BY total_hours_played DESC
GO

-- Ovaj upit nam daje godisnji promet za godinu 2019, za svaku igricu u koliko je primeraka prodana, kao i kolika je zarada na prodaju
-- sortirano po prodaji, opadajuce
SELECT g.game_name, g.price, COUNT(o.game_gameID) as num_sold, COUNT(o.game_gameID) * g.price AS revenue
FROM Gog.Game as g
INNER JOIN Gog.orders as o
ON g.gameID = o.game_gameID
WHERE YEAR(o.order_date) = 2019
GROUP BY g.game_name, g.price
HAVING g.price > 0
ORDER BY revenue DESC
GO

-- Ovaj upit dohvata sve igrice koje su podrzane na ruskom jeziku
SELECT  g.game_name, g.release_date, g.price, g.game_description
FROM Gog.Game as g
INNER JOIN Gog.game_has_languages as ghl
ON g.gameId = ghl.game_gameID
INNER JOIN Gog.languages as l
ON ghl.languages_languagesID = l.languagesID
WHERE l.langugages_name= N'русский'
GO

-- Vraca uvid u najpopularnije zanrove koje igraci igraju
SELECT ge.genre_name, SUM(i.hours_played) as hours_played
FROM Gog.genre AS ge
INNER JOIN Gog.game_has_genre AS ghe ON ghe.genre_genreID = ge.genreID
INNER JOIN Gog.game as g ON ghe.game_gameID = g.gameID
INNER JOIN Gog.info as i ON g.gameID = i.game_gameID
GROUP BY ge.genre_name
ORDER BY hours_played DESC
GO


-- Vraca tabelu korisnika, sortiranih po potrosnji, kao i uvid u to koliko je do sad potrosio
SELECT u.username, u.email, SUM(g.price) AS 'total_amount_spent(in EUR)'
FROM Gog.users AS u
INNER JOIN Gog.orders AS o
	ON o.users_usersID = u.usersID
INNER JOIN Gog.game AS g
	ON g.gameID = o.game_gameID
GROUP BY u.username, u.email
ORDER BY 'total_amount_spent(in EUR)' DESC
GO

-- Detaljan pregled o svakom korisniku(utroseno vreme na igranje, broj kupovina, trenutno novcano stanje)
SELECT u.username, 
       u.email,
	   COUNT(o.game_gameID) AS num_orders,  
	   w.wallet_funds, 
	   SUM(i.hours_played) AS hours_played
FROM Gog.users AS u
INNER JOIN Gog.wallet AS w
	ON w.users_usersID = u.usersID
INNER JOIN Gog.orders AS o
	ON o.users_usersID = u.usersID
INNER JOIN Gog.info AS i
	ON o.users_usersID = i.users_usersID
GROUP BY u.username, u.email, w.wallet_funds
ORDER BY num_orders DESC, wallet_funds DESC, hours_played DESC
GO


-- Vraca listing svih igrica koje su dostupne na platformi Linux
SELECT g.gameID, g.game_name, g.release_date, g.price, g.game_description, p.publisher_name
FROM Gog.Game AS g
INNER JOIN Gog.publisher AS p
ON g.publisher_publisherID = p.publisherID
INNER JOIN Gog.platforms_has_game AS phg
ON phg.game_gameID = g.gameID
INNER JOIN Gog.platforms AS pl
ON pl.platformsID = phg.platforms_platformsID
WHERE pl.platforms_name LIKE '%Linux%'
GROUP BY g.gameID, g.game_name, g.release_date, g.price, g.game_description, p.publisher_name
GO


-- Dohvati za svakog korisnika, koliko ima igrica u listi zelja
SELECT u.username, u.email, COUNT(wl.users_usersID) as num_wishlist_items
FROM Gog.users AS u
LEFT OUTER JOIN Gog.wishlist AS wl
ON wl.users_usersID = u.usersID
GROUP BY u.username, u.email
ORDER BY num_wishlist_items DESC
GO




