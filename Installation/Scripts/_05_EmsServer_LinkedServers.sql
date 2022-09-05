/**********************************************************************************
- Destination: Server Instance that contains SYNERGI database.
- Before running this script : please consider an option to change parameters like :
	@srvproduct=N'SQL_SERVER',
	@provider=N'SQLNCLI',
	@datasrc=N'ROCK-EMS\ION',
	@rmtuser=N'emsuser',
	@rmtpassword='emspassword'
	
This script does the following:
1) Create linked server to EMS system as EmsServer.
*************************************************************************************/

/****** Object:  LinkedServer [EmsServer]    Script Date: 07/13/2012 14:31:17 ******/
IF  EXISTS (SELECT srv.name FROM sys.servers srv WHERE srv.server_id != 0 AND srv.name = N'EmsServer')EXEC master.dbo.sp_dropserver @server=N'EmsServer', @droplogins='droplogins'
GO

/****** Object:  LinkedServer [EmsServer]    Script Date: 07/13/2012 14:31:17 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'EmsServer', @srvproduct=N'SQL_SERVER', @provider=N'SQLNCLI', @datasrc=N'ROCK-EMS\ION'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'EmsServer',@useself=N'True',@locallogin=N'synergiuser',@rmtuser=N'emsuser',@rmtpassword='emspassword'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'EmsServer',@useself=N'False',@locallogin=N'synergiuser',@rmtuser=N'emsuser',@rmtpassword='emspassword'

GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EmsServer', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


