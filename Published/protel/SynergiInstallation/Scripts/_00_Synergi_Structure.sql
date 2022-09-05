/**********************************************************************************
- Destination: Server Instance that contains SYNERGI database.
- Before running this script: please change parameters like :
		@email_address=N'synergisupport@xnhotelsystems.com'
		
- This script does the following:
1) Create login 'synergiuser'.
2) Create user 'synergiuser'.
3) Create Operator 'Synergi Support'.
*************************************************************************************/


USE master

/****** Object:  Login [synergiuser]    Script Date: 01/02/2010 11:56:07 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'synergiuser')
CREATE LOGIN [synergiuser] WITH PASSWORD=N'synergipassword', DEFAULT_DATABASE=[Synergi], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO


USE Synergi
/****** Object:  User [synergiuser]    Script Date: 01/02/2010 11:56:07 ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'synergiuser')
BEGIN
	CREATE USER [synergiuser] FOR LOGIN [synergiuser]
END
GO

EXEC dbo.sp_addrolemember 'db_owner', 'synergiuser'
GO


USE [msdb]
GO

/****** Object:  Operator [Synergi Support]    Script Date: 07/17/2012 10:58:39 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Synergi Support')
	EXEC msdb.dbo.sp_add_operator @name=N'Synergi Support', 
		@enabled=1, 
		@weekday_pager_start_time=90000, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=90000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=90000, 
		@sunday_pager_end_time=180000, 
		@pager_days=0, 
		@email_address=N'synergisupport@xnhotelsystems.com', 
		@category_name=N'[Uncategorized]'
GO
