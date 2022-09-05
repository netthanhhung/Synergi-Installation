/**********************************************************************************
- Destination: Server Instance that contains SYNERGI database.
- Before running this script : please consider an option to change parameters like :
	@srvproduct=N'SQL_SERVER',
	@provider=N'SQLNCLI',
	@datasrc=N'localhost',
	@rmtuser='proteluser',
	@rmtpassword='protelpassword'

This script does the following:
1) Create linked server to Protel as ProtelServer.
*************************************************************************************/

/****** Object:  LinkedServer [ProtelServer]    Script Date: 04/26/2012 14:34:42 ******/
IF  EXISTS (SELECT srv.name FROM sys.servers srv WHERE srv.server_id != 0 AND srv.name = N'ProtelServer')
EXEC master.dbo.sp_dropserver @server=N'ProtelServer', @droplogins='droplogins'
GO

EXEC master.dbo.sp_addlinkedserver @server = N'ProtelServer', @srvproduct=N'SQL_SERVER', @provider=N'SQLNCLI', @datasrc=N'localhost'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ProtelServer',@useself=N'True',@locallogin='synergiuser',@rmtuser='proteluser',@rmtpassword='protelpassword'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ProtelServer',@useself=N'False',@locallogin='synergiuser',@rmtuser='proteluser',@rmtpassword='protelpassword'

GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ProtelServer', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO





