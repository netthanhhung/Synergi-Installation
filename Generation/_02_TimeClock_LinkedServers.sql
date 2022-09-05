/**********************************************************************************
- Destination: Service Instance that contains SYNERGI database.
- Before running this script : please consider an option to change parameters like :
	@srvproduct=N'SQL_SERVER',
	@provider=N'SQLNCLI',
	@datasrc=N'ROCK-SQL02',
	@rmtuser='synergiDev',
	@rmtpassword='synergiDev'

This script does the following:
1) Create linked server to TimeClockDev as TimeClockServer.
*************************************************************************************/

/****** Object:  LinkedServer [TimeClockServer]    Script Date: 04/26/2012 14:34:42 ******/
IF  EXISTS (SELECT srv.name FROM sys.servers srv WHERE srv.server_id != 0 AND srv.name=N'TimeClockServer')
EXEC master.dbo.sp_dropserver @server=N'TimeClockServer', @droplogins='droplogins'
GO

EXEC master.dbo.sp_addlinkedserver @server=N'TimeClockServer', @srvproduct=N'SQL_SERVER', @provider=N'SQLNCLI', @datasrc=N'ROCK-SQL02'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'TimeClockServer',@useself=N'True',@locallogin='synergiuser',@rmtuser='synergiDEV',@rmtpassword='synergiDEV'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'TimeClockServer',@useself=N'False',@locallogin='synergiuser',@rmtuser='synergiDEV',@rmtpassword='synergiDEV'

GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'TimeClockServer', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO





