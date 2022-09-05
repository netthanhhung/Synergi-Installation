/**********************************************************************************
- Destination: Service Instance that contains SYNERGI database.
		
- This script does the following:
1) Create user 'synergiuser'.
*************************************************************************************/

USE SynergiComp
/****** Object:  User [synergiuser]    Script Date: 01/02/2010 11:56:07 ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'synergiuser')
BEGIN
	CREATE USER [synergiuser] FOR LOGIN [synergiuser]
END
GO

EXEC dbo.sp_addrolemember 'db_owner', 'synergiuser'
GO