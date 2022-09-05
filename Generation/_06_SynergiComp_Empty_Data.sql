/**********************************************************************************
- Destination: Service Instance that contains SynergiComp database.
- Before running this script: please change parameters like :
  [SynergiCompDEV]
- This script does the following:
1) Copy lookup data from [SynergiCompDEV] to the new SynergiComp empty database
*************************************************************************************/
USE SynergiComp_Empty
GO

DELETE FROM DomainCurrency
DELETE FROM SourceDomain
DELETE FROM Source
DELETE FROM SourceGroup

IF NOT EXISTS (SELECT * FROm DomainCurrency)
BEGIN TRY

	BEGIN TRANSACTION

    DECLARE 
        @C_CurrentUser varchar (128)
        , @C_CurrentDate datetime 
        , @C_ApplicationId uniqueidentifier
    SELECT 
        @C_CurrentUser = 'Synergi IT - Manual'
        , @C_CurrentDate = getDate()			
	
	/****** Object:  Table [dbo].[DecisionType]    Script Date: 04/17/2012 15:23:08 ******/	    	
    --SET IDENTITY_INSERT [dbo].[SourceGroup] ON
	INSERT INTO [dbo].[SourceGroup]
           ([SourceGroupID]
           ,[Name]
           ,[DateCreated]
           ,[DateUpdated]
           ,[CreatedBy]
           ,[UpdatedBy])
    SELECT [SourceGroupID]
           ,[Name]
           ,[DateCreated]
           ,[DateUpdated]
           ,[CreatedBy]
           ,[UpdatedBy]
    FROM [SynergiCompDEV].[dbo].[SourceGroup]  A
	--SET IDENTITY_INSERT [dbo].[SourceGroup] OFF 

	INSERT INTO [dbo].[Source]
           ([SourceID]
           ,[SourceGroupID]
           ,[SourceName]
           ,[Username]
           ,[Password]
           ,[IsActive]
           ,[SleepTime]
           ,[DateCreated]
           ,[DateUpdated]
           ,[CreatedBy]
           ,[UpdatedBy]
           ,[SystemName])
    SELECT [SourceID]
           ,[SourceGroupID]
           ,[SourceName]
           ,[Username]
           ,[Password]
           ,[IsActive]
           ,[SleepTime]
           ,[DateCreated]
           ,[DateUpdated]
           ,[CreatedBy]
           ,[UpdatedBy]
           ,[SystemName]
    FROM [SynergiCompDEV].[dbo].[Source]  A

	
	SET IDENTITY_INSERT [dbo].[SourceDomain] ON
	INSERT INTO [dbo].[SourceDomain]
           ([SourceDomainID], [SourceID]
           ,[Name]
           ,[Url]
           ,[DateFormat]
           ,[DateCreated]
           ,[DateUpdated]
           ,[CreatedBy]
           ,[UpdatedBy])
    SELECT [SourceDomainID], [SourceID]
           ,[Name]
           ,[Url]
           ,[DateFormat]
           ,[DateCreated]
           ,[DateUpdated]
           ,[CreatedBy]
           ,[UpdatedBy]
	FROM [SynergiCompDEV].[dbo].[SourceDomain]  A
	SET IDENTITY_INSERT [dbo].[SourceDomain] OFF    
	
	SET IDENTITY_INSERT [dbo].[DomainCurrency] ON
	INSERT INTO [dbo].[DomainCurrency]
           ([DomainCurrencyID],[SourceDomainID]
           ,[CurrencyCode]
           ,[DateCreated]
           ,[DateUpdated]
           ,[CreatedBy]
           ,[UpdatedBy])
	SELECT [DomainCurrencyID],[SourceDomainID]
           ,[CurrencyCode]
           ,[DateCreated]
           ,[DateUpdated]
           ,[CreatedBy]
           ,[UpdatedBy]           
    FROM [SynergiCompDEV].[dbo].[DomainCurrency]  A       
    SET IDENTITY_INSERT [dbo].[DomainCurrency] OFF     
                                   			              		            			
    COMMIT TRANSACTION 
	PRINT 'EXECUTED SUCCESSFULLY'
	
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION 
	PRINT	'ERROR_NUMBER ' + CONVERT(NVARCHAR(50),ERROR_NUMBER())
	PRINT	'ERROR_SEVERITY '+			CONVERT(NVARCHAR(50),ERROR_SEVERITY())
	PRINT	'ERROR_LINE	' +CONVERT(NVARCHAR(50),ERROR_LINE())
	PRINT	'ERROR_MESSAGE '+	ERROR_MESSAGE()
	PRINT 'EXECUTED UNSUCCESSFULLY'
END CATCH
GO
