USE Gog;
GO

----------------------------
--Table: users
----------------------------
DROP TABLE IF EXISTS Gog.users;

CREATE TABLE Gog.users
(
	usersID INT IDENTITY(1,1) PRIMARY KEY,
	username NVARCHAR(55) NOT NULL,
	email NVARCHAR(255) NOT NULL,
	users_password NVARCHAR(255) NOT NULL,
	users_location NVARCHAR(56) NULL,
	CONSTRAINT username_UNIQUE UNIQUE (username ASC)
);

----------------------------
--Table: publisher
----------------------------

DROP TABLE IF EXISTS Gog.publisher;

CREATE TABLE Gog.publisher
(
	publisherID INT IDENTITY(1,1) PRIMARY KEY,
	publisher_name NVARCHAR(255) NOT NULL,
	publisher_description NVARCHAR(255),
	CONSTRAINT publisher_name_UNIQUE UNIQUE (publisher_name ASC)
);

----------------------------
--Table: system_requirements
----------------------------

DROP TABLE IF EXISTS Gog.system_requirements;

CREATE TABLE Gog.system_requirements
(
	system_requirementsID INT IDENTITY(1,1) PRIMARY KEY,
	system_name NVARCHAR(50) NOT NULL,
	proccesor NVARCHAR(100) NOT NULL,
	memory NVARCHAR(20) NOT NULL,
	graphics NVARCHAR(255) NOT NULL,
	note NVARCHAR(255) NOT NULL
);

----------------------------
--Table: game
----------------------------

DROP TABLE IF EXISTS Gog.game;

CREATE TABLE Gog.game
(
	gameID INT IDENTITY(1,1) PRIMARY KEY,
	game_name NVARCHAR(255) NOT NULL,
	release_date DATE NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	on_sale SMALLINT NOT NULL,
	game_description NVARCHAR(255) NOT NULL,
	publisher_publisherID INT NOT NULL,
	system_requirements_system_requirementsID INT NOT NULL,
	CONSTRAINT game_name_UNIQUE UNIQUE (game_name ASC),
	INDEX fk_game_publisher1_idx (publisher_publisherID ASC),
	INDEX fk_game_system_requirements1_idx (system_requirements_system_requirementsID ASC),
	CONSTRAINT fk_game_publisher1
		FOREIGN KEY (publisher_publisherID)
		REFERENCES Gog.publisher (publisherID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_game_system_requirements1
		FOREIGN KEY (system_requirements_system_requirementsID)
		REFERENCES Gog.system_requirements (system_requirementsID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION

);

----------------------------
--Table: wishlist
----------------------------

DROP TABLE IF EXISTS Gog.wishlist;

CREATE TABLE Gog.wishlist
(
	wishlist_date DATE NOT NULL,
	game_gameID INT NOT NULL,
	users_usersID INT NOT NULL,
	PRIMARY KEY (game_gameID, users_usersID),
	CONSTRAINT fk_wishlist_game1
		FOREIGN KEY (game_gameID)
		REFERENCES Gog.game (gameID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_wishlist_users1
		FOREIGN KEY (users_usersID)
		REFERENCES Gog.users (usersID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

----------------------------
--Table: order
----------------------------

DROP TABLE IF EXISTS Gog.orders;

CREATE TABLE Gog.orders
(
	order_date DATE NOT NULL,
	users_usersID INT NOT NULL,
	game_gameID INT NOT NULL,
	PRIMARY KEY (users_usersID, game_gameID),
	CONSTRAINT fk_orders_users1
		FOREIGN KEY (users_usersID)
		REFERENCES Gog.users (usersID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_orders_game1
		FOREIGN KEY (game_gameID)
		REFERENCES Gog.game (gameID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

----------------------------
--Table: platforms
----------------------------

DROP TABLE IF EXISTS Gog.platforms;

CREATE TABLE Gog.platforms
(
	platformsID INT IDENTITY (1,1) PRIMARY KEY,
	platforms_name NVARCHAR(75) NOT NULL,
	CONSTRAINT platforms_name_UNIQUE UNIQUE (platforms_name ASC)
);

----------------------------
--Table: genre
----------------------------

DROP TABLE IF EXISTS Gog.genre;

CREATE TABLE Gog.genre
(
	genreID INT IDENTITY(1,1) PRIMARY KEY,
	genre_name NVARCHAR(255) NOT NULL,
	CONSTRAINT genre_name_UNIQUE UNIQUE (genre_name ASC)
);

----------------------------
--Table: languages
----------------------------

DROP TABLE IF EXISTS Gog.languages;

CREATE TABLE Gog.languages
(
	languagesID INT IDENTITY(1,1) PRIMARY KEY,
	langugages_name NVARCHAR (50) NOT NULL
);


----------------------------
--Table: platforms_has_game
----------------------------

DROP TABLE IF EXISTS Gog.platforms_has_game;


CREATE TABLE Gog.platforms_has_game
(
	platforms_platformsID INT NOT NULL,
	game_gameID INT NOT NULL,
	PRIMARY KEY (platforms_platformsID, game_gameID),
	CONSTRAINT fk_platforms_has_game_plaforms1
		FOREIGN KEY (platforms_platformsID)
		REFERENCES Gog.platforms (platformsID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_platforms_has_game_game1
		FOREIGN KEY (game_gameID)
		REFERENCES Gog.game (gameID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

----------------------------
--Table: game_has_languages
----------------------------

DROP TABLE IF EXISTS Gog.game_has_languages;

CREATE TABLE Gog.game_has_languages
(
	game_gameID INT NOT NULL,
	languages_languagesID INT NOT NULL,
	PRIMARY KEY (game_gameID, languages_languagesID),
	CONSTRAINT fk_game_has_languages_game1
		FOREIGN KEY (game_gameID)
		REFERENCES Gog.game (gameID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_game_has_languages_languages1
		FOREIGN KEY (languages_languagesID)
		REFERENCES Gog.languages (languagesID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

----------------------------
--Table: wallet
----------------------------

DROP TABLE IF EXISTS Gog.wallet;

CREATE TABLE Gog.wallet
(
	walletID INT IDENTITY(1,1) PRIMARY KEY,
	wallet_funds DECIMAL(10,2) NOT NULL,
	users_usersID INT NOT NULL,
	CONSTRAINT fk_wallet_users1
		FOREIGN KEY (users_usersID)
		REFERENCES Gog.users (usersID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

----------------------------
--Table: game_has_genre
----------------------------

DROP TABLE IF EXISTS Gog.game_has_genre;

CREATE TABLE Gog.game_has_genre
(
	game_gameID INT NOT NULL,
	genre_genreID INT NOT NULL,
	PRIMARY KEY (game_gameID, genre_genreID),
	CONSTRAINT fk_game_has_genre_game1
		FOREIGN KEY (game_gameID)
		REFERENCES Gog.game (gameID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_game_has_genre_genre1
		FOREIGN KEY (genre_genreID)
		REFERENCES Gog.genre (genreID)
);

----------------------------
--Table: features
----------------------------

DROP TABLE IF EXISTS Gog.features;

CREATE TABLE Gog.features
(
	featuresID INT IDENTITY(1,1) PRIMARY KEY,
	features_name NVARCHAR(255) NOT NULL
);

----------------------------
--Table: info
----------------------------

DROP TABLE IF EXISTS Gog.info

CREATE TABLE Gog.info
(
	infoID INT IDENTITY(1,1) PRIMARY KEY,
	hours_played DECIMAL(10,2) NOT NULL,
	info_state NVARCHAR(255) NOT NULL,
	users_usersID INT NOT NULL,
	game_gameID INT NOT NULL,
	CONSTRAINT fk_info_users1
		FOREIGN KEY (users_usersID)
		REFERENCES Gog.users (usersID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_info_game1
		FOREIGN KEY (game_gameID)
		REFERENCES Gog.game (gameID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

----------------------------
--Table: game_has_features
----------------------------

DROP TABLE IF EXISTS Gog.game_has_features;

CREATE TABLE Gog.game_has_features
(
	game_gameID INT NOT NULL,
	features_featuresID INT NOT NULL,
	PRIMARY KEY (game_gameID, features_featuresID),
	CONSTRAINT fk_game_has_features_game1
		FOREIGN KEY (game_gameID)
		REFERENCES Gog.game (gameID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_game_has_features_features1
		FOREIGN KEY (features_featuresID)
		REFERENCES Gog.features (featuresID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);






