USE [master]
GO

DROP DATABASE IF EXISTS Gog;
GO


CREATE DATABASE Gog
 ON   
( 
	NAME = N'Gog', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Gog.mdf', 
	SIZE = 25MB, 
	MAXSIZE = UNLIMITED, 
	FILEGROWTH = 4096KB 
)
 LOG ON 
( 
	NAME = N'Gog_log', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Gog_log.ldf',
	SIZE = 1024KB, 
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10%
);
GO

USE Gog;
GO


CREATE SCHEMA Gog AUTHORIZATION dbo;
GO