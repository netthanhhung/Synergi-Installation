/**********************************************************************************
- Destination: Service Instance that contains SYNERGI database.
- Before running this script: please change parameters like :
  TimeClockServer.[TimeClockDev]
- @_PackageType: uncomment appropriate line to choose which package will be install
  
- This script does the following:
1) Copy lookup data from TimeClockServer.[TimeClockDev] to the new Synergi empty database
*************************************************************************************/
USE Synergi
GO

DECLARE @_PackageType int
--SELECT @_PackageType = 1 -- Full package
--SELECT @_PackageType = 2 -- Operations package
--SELECT @_PackageType = 3 -- Yield package
SELECT @_PackageType = 4 -- Basic package

DELETE FROM DepartmentBusinessArea
DELETE FROM UtilityDays
DELETE FROM AccommodationAvailability
DELETE FROM AccommodationCode
DELETE FROM AccommodationType
DELETE FROM MicroCentre
DELETE FROM SubCentre
DELETE FROM Centre
DELETE FROM RosterCentre
DELETE FROM Department
DELETE FROM LoadingCategory
DELETE FROM [Organisation]
DELETE FROM [ContactInformation]

DELETE FROM UserRoleAuth
DELETE FROM RoleComponentPermission
DELETE FROM [aspnet_Roles]
DELETE FROM aspnet_Membership
DELETE FROM aspnet_Users
DELETE FROM aspnet_Applications
DELETE FROM aspnet_SchemaVersions

DELETE FROM [YieldProfile]
DELETE FROM [Weekday]
DELETE FROM [UtilityWeekDays]
DELETE FROM [UtilityGlobals]
DELETE FROM [TransactionType]
DELETE FROM [TotalType]
DELETE FROM [TimeType]
DELETE FROM [SystemTemplate]
DELETE FROM [State]
DELETE FROM [SMSRuleType]
DELETE FROM [SalesForecastType]
DELETE FROM [DemandLevel]
DELETE FROM [Country]
DELETE FROM [BudgetType]
DELETE FROM [ActivityType]
DELETE FROM [Component]
DELETE FROM [CentreType]
DELETE FROM [CentreTypeGroup]
DELETE FROM [KPIType]
DELETE FROM [KPIDataType]
DELETE FROM [KPITypeGroup]
DELETE FROM [ExternalSystemMapping]
DELETE FROM [ExternalSystem]
DELETE FROM [ExternalSystemType]
DELETE FROM [EmployeeType]
DELETE FROM [DepartmentGroup]
DELETE FROM [DepartmentType]
DELETE FROM MetaDataType
DELETE FROM [MailTemplateType]
DELETE FROM [LookupValue]
DELETE FROM [LookupType]
DELETE FROM [RoomTypeCode]
DELETE FROM [ArchivedRoomType]
DELETE FROM [RoomType]
DELETE FROM [RoomGroup]
DELETE FROM [ProfileType]
DELETE FROM [PMS]
DELETE FROM [ParameterSetType]
DELETE FROM [Month]
DELETE FROM SalesForecastSource
DELETE FROM CompetitiveSet
DELETE FROM RosterShiftStatus
DELETE FROM CleanStatus
DELETE FROM [RoomStatus]
DELETE FROM CentreKPITemplate
DELETE FROM SubCentreKPITemplate
DELETE FROM SiteMetaDataTemplate
DELETE FROM SiteSeasonTemplate
DELETE FROM SiteDemandCurveTemplate
DELETE FROM YieldProfileRateTemplate
DELETE FROM RateAvailType
DELETE FROM DashboardConfigTemplate
DELETE FROM DecisionType
DELETE FROM Culture
DELETE FROM BatchJobStatus
DELETE FROM ForecastLevel
DELETE FROM GuestContactType
DELETE FROM ServiceType
DELETE FROM ReservationType

IF NOT EXISTS (SELECT * FROm aspnet_Applications)
BEGIN TRY

	BEGIN TRANSACTION

    DECLARE 
        @C_CurrentUser varchar (128)
        , @C_CurrentDate datetime 
        , @C_ApplicationId uniqueidentifier
    SELECT 
        @C_CurrentUser = 'Synergi IT - Manual'
        , @C_CurrentDate = getDate()			
	
	DECLARE @LoopDate smalldatetime
	SET @LoopDate = '01-Jan-1905'

	DELETE FROM dbo.UtilityDays

	WHILE @LoopDate < '06-Jun-2079'
	BEGIN
	--	SELECT @LoopDate, DATEADD(YEAR, -1, @LoopDate), DATEADD(YEAR, -2, @LoopDate), DATEADD(YEAR, -3, @LoopDate), DATEADD(YEAR, -4, @LoopDate), DATEADD(YEAR, -5, @LoopDate), DATEADD(WK, 52 * -1, @LoopDate), DATEADD(WK, 52 * -2, @LoopDate), DATEADD(WK, 52 * -3, @LoopDate), DATEADD(WK, 52 * -4, @LoopDate), DATEADD(WK, 52 * -5, @LoopDate)
		INSERT INTO dbo.UtilityDays (DateEntry, DateYear1, DateYear2, DateYear3, DateYear4, DateYear5, DateYear1Offset, DateYear2Offset, DateYear3Offset, DateYear4Offset, DateYear5Offset)
		VALUES (@LoopDate, DATEADD(YEAR, -1, @LoopDate), DATEADD(YEAR, -2, @LoopDate), DATEADD(YEAR, -3, @LoopDate), DATEADD(YEAR, -4, @LoopDate), DATEADD(YEAR, -5, @LoopDate), DATEADD(WK, 52 * -1, @LoopDate), DATEADD(WK, 52 * -2, @LoopDate), DATEADD(WK, 52 * -3, @LoopDate), DATEADD(WK, 52 * -4, @LoopDate), DATEADD(WK, 52 * -5, @LoopDate))	
		
		SET @LoopDate = DATEADD(DAY, 1, @LoopDate)
	END

	INSERT INTO [dbo].[aspnet_Applications]
		 ([ApplicationName],[LoweredApplicationName],[ApplicationId],[Description])
	VALUES ('/','/',NEWID(), NULL)
	
	INSERT INTO [dbo].[aspnet_SchemaVersions]([Feature],[CompatibleSchemaVersion],[IsCurrentVersion])
	VALUES('common', 1, 1)
	INSERT INTO [dbo].[aspnet_SchemaVersions]([Feature],[CompatibleSchemaVersion],[IsCurrentVersion])
	VALUES('health monitoring', 1, 1)
	INSERT INTO [dbo].[aspnet_SchemaVersions]([Feature],[CompatibleSchemaVersion],[IsCurrentVersion])
	VALUES('membership', 1, 1)
	INSERT INTO [dbo].[aspnet_SchemaVersions]([Feature],[CompatibleSchemaVersion],[IsCurrentVersion])
	VALUES('personalization', 1, 1)
	INSERT INTO [dbo].[aspnet_SchemaVersions]([Feature],[CompatibleSchemaVersion],[IsCurrentVersion])
	VALUES('profile', 1, 1)
	INSERT INTO [dbo].[aspnet_SchemaVersions]([Feature],[CompatibleSchemaVersion],[IsCurrentVersion])
	VALUES('role manager', 1, 1)
	
	SELECT @C_ApplicationId = ApplicationId FROM aspnet_Applications		
	
	INSERT INTO [dbo].[aspnet_Users]
         ([ApplicationId],[UserId],[UserName],[LoweredUserName],[MobileAlias],[IsAnonymous],[LastActivityDate])
	VALUES
       (@C_ApplicationId,'A56F648B-E943-4BCF-82A5-D3D0C4E0D52E'
       ,'PortalAdmin', 'portaladmin',NULL, 0, @C_CurrentDate)

	INSERT INTO [dbo].[aspnet_Membership]
       ([ApplicationId],[UserId],[Password],[PasswordFormat],[PasswordSalt],[MobilePIN],[Email]
       ,[LoweredEmail],[PasswordQuestion],[PasswordAnswer],[IsApproved],[IsLockedOut],[CreateDate]
       ,[LastLoginDate],[LastPasswordChangedDate],[LastLockoutDate],[FailedPasswordAttemptCount]
       ,[FailedPasswordAttemptWindowStart],[FailedPasswordAnswerAttemptCount]
       ,[FailedPasswordAnswerAttemptWindowStart],[Comment])
	VALUES
       (@C_ApplicationId,'A56F648B-E943-4BCF-82A5-D3D0C4E0D52E','BCuyFePubV9cRKBDNX9BYLM3sUI='
       ,1,'DRveBflXiP5pYyS15MMGGQ==',NULL,NULL,NULL,NULL,NULL,1,0,@C_CurrentDate,@C_CurrentDate
       ,@C_CurrentDate,@C_CurrentDate,0,@C_CurrentDate,0,@C_CurrentDate,NULL)
    
    INSERT INTO [dbo].[aspnet_Roles]
       ([ApplicationId],[RoleId],[RoleName],[LoweredRoleName],[Description],[IsCustom])
    SELECT  @C_ApplicationId,[RoleId],[RoleName],[LoweredRoleName],[Description],[IsCustom]
    FROM TimeClockServer.[TimeClockDev].[dbo].[aspnet_Roles]
    
    /****** Object:  Table [dbo].[Component]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[Component] ON
	INSERT [dbo].[Component] ([ComponentId], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [ComponentId], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[Component]
	SET IDENTITY_INSERT [dbo].[Component] OFF
	
    INSERT INTO [dbo].[UserRoleAuth]
           ([UserId],[RoleId],[WholeOrg],[SiteGroupId],[SiteId],[DepartmentId],[RosterCentreId],[CentreId]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    VALUES ('A56F648B-E943-4BCF-82A5-D3D0C4E0D52E', 'CF1114D0-BD7D-4FD5-BA83-A4924D9C0E68', 1, null, null, null, null, null
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser)
			
	INSERT INTO [dbo].[RoleComponentPermission]
           ([RoleId],[ComponentId],[WriteRight]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
	SELECT [RoleId],[ComponentId],[WriteRight]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[RoleComponentPermission] 
	
	/****** Object:  Table [dbo].[DepartmentBusinessArea]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[DepartmentBusinessArea] ON
	INSERT [dbo].[DepartmentBusinessArea] ([DepartmentBusinessAreaID], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [DepartmentBusinessAreaID], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[DepartmentBusinessArea]
	SET IDENTITY_INSERT [dbo].[DepartmentBusinessArea] OFF
	
    --Start import lookup data
    /****** Object:  Table [dbo].[YieldProfile]    Script Date: 04/17/2012 15:23:08 ******/
    SET IDENTITY_INSERT [dbo].[YieldProfile] ON
	INSERT [dbo].[YieldProfile] ([YieldProfileId], [DisplayName], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [YieldProfileId], [DisplayName], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[YieldProfile]
	SET IDENTITY_INSERT [dbo].[YieldProfile] OFF
	
	/****** Object:  Table [dbo].[Weekday]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[Weekday] ON
	INSERT [dbo].[Weekday] ([WeekdayID], [Name], [DisplayIndex], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [WeekdayID], [Name], DisplayIndex, @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[Weekday]
	SET IDENTITY_INSERT [dbo].[Weekday] OFF
	
	/****** Object:  Table [dbo].[UtilityWeekDays]    Script Date: 04/17/2012 15:23:08 ******/
	INSERT [dbo].[UtilityWeekDays] ([WeekDayId], [WeekDayIdPlusOne])
	SELECT [WeekDayId], [WeekDayIdPlusOne]
	FROM TimeClockServer.[TimeClockDev].[dbo].[UtilityWeekDays]
	
	/****** Object:  Table [dbo].[UtilityGlobals]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[UtilityGlobals] ON
	INSERT [dbo].[UtilityGlobals] ([Id], [DateCreated], [DateUpdated], [DateIndividualCodesStarted], [MiscAccountCode]) 
	SELECT [Id], @C_CurrentDate, @C_CurrentDate, [DateIndividualCodesStarted], [MiscAccountCode]
	FROM TimeClockServer.[TimeClockDev].[dbo].[UtilityGlobals]
	SET IDENTITY_INSERT [dbo].[UtilityGlobals] OFF
	
	/****** Object:  Table [dbo].[TransactionType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[TransactionType] ON
	INSERT [dbo].[TransactionType] ([TransactionTypeID], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [TransactionTypeID], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[TransactionType]
	SET IDENTITY_INSERT [dbo].[TransactionType] OFF
	
	/****** Object:  Table [dbo].[TotalType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[TotalType] ON
	INSERT [dbo].[TotalType] ([TotalTypeID], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [TotalTypeID], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[TotalType]
	SET IDENTITY_INSERT [dbo].[TotalType] OFF
	
	/****** Object:  Table [dbo].[TimeType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[TimeType] ON
	INSERT [dbo].[TimeType] ([TimeTypeID], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [TimeTypeID], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[TimeType]
	SET IDENTITY_INSERT [dbo].[TimeType] OFF
	
	/****** Object:  Table [dbo].[SystemTemplate]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[SystemTemplate] ON
	INSERT [dbo].[SystemTemplate] ([SystemTemplateId], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [SystemTemplateId], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[SystemTemplate]
	SET IDENTITY_INSERT [dbo].[SystemTemplate] OFF
	
	/****** Object:  Table [dbo].[State]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[State] ON
	INSERT [dbo].[State] ([StateId], [Name], [ShortName], [CountryId])
	SELECT [StateId], [Name], [ShortName], [CountryId]
	FROM TimeClockServer.[TimeClockDev].[dbo].[State]
	SET IDENTITY_INSERT [dbo].[State] OFF
	
	/****** Object:  Table [dbo].[SMSRuleType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[SMSRuleType] ON
	INSERT [dbo].[SMSRuleType] ([SMSRuleTypeID], [TypeName], [Params], [Description], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [SMSRuleTypeID], [TypeName], [Params], [Description], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[SMSRuleType]
	SET IDENTITY_INSERT [dbo].[SMSRuleType] OFF
	
	/****** Object:  Table [dbo].[SalesForecastType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[SalesForecastType] ON
	INSERT [dbo].[SalesForecastType] ([TypeID], [TypeName], [mode]) 
	SELECT [TypeID], [TypeName], [mode]
	FROM TimeClockServer.[TimeClockDev].[dbo].[SalesForecastType]
	SET IDENTITY_INSERT [dbo].[SalesForecastType] OFF
	
	/****** Object:  Table [dbo].[DemandLevel]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[DemandLevel] ON
	INSERT [dbo].[DemandLevel] ([DemandLevelId], [DisplayName], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [DemandLevelId], [DisplayName], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[DemandLevel]
	SET IDENTITY_INSERT [dbo].[DemandLevel] OFF
	
	/****** Object:  Table [dbo].[Country]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[Country] ON
	INSERT [dbo].[Country] ([CountryID], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [CountryID], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[Country]
	SET IDENTITY_INSERT [dbo].[Country] OFF
	
	/****** Object:  Table [dbo].[BudgetType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[BudgetType] ON
	INSERT [dbo].[BudgetType] ([BudgetTypeID], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [BudgetTypeID], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[BudgetType]
	SET IDENTITY_INSERT [dbo].[BudgetType] OFF
	
	/****** Object:  Table [dbo].[ActivityType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[ActivityType] ON
	INSERT [dbo].[ActivityType] ([ActivityTypeId], [IsLegacy], [HistoricalId], [Name], [Description], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [ActivityTypeId], [IsLegacy], [HistoricalId], [Name], [Description], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[ActivityType]
	SET IDENTITY_INSERT [dbo].[ActivityType] OFF
	
	/****** Object:  Table [dbo].[AccommodationType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[AccommodationType] ON
	INSERT [dbo].[AccommodationType] ([AccommodationTypeID], [Name], [DisplayIndex], [IsLegacy], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [AccommodationTypeID], [Name], [DisplayIndex], [IsLegacy], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[AccommodationType]
	SET IDENTITY_INSERT [dbo].[AccommodationType] OFF
	
	/****** Object:  Table [dbo].[CentreTypeGroup]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[CentreTypeGroup] ON
	INSERT [dbo].[CentreTypeGroup] ([CentreTypeGroupId], [Name], [DisplayIndex], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [CentreTypeGroupId], [Name], [DisplayIndex], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[CentreTypeGroup]
	SET IDENTITY_INSERT [dbo].[CentreTypeGroup] OFF
	
	/****** Object:  Table [dbo].[KPITypeGroup]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[KPITypeGroup] ON
	INSERT [dbo].[KPITypeGroup] ([KPITypeGroupID], [Name], 
					[DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy])
	SELECT [KPITypeGroupID], [Name], 
			@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[KPITypeGroup]
	SET IDENTITY_INSERT [dbo].[KPITypeGroup] OFF
	
	/****** Object:  Table [dbo].[KPIType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[KPIType] ON
	INSERT [dbo].[KPIType] ([KPITypeID], [Name], [DisplayIndex], [ApplicableToWageOp], 
					[DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy], [KPITypeGroupID])
	SELECT [KPITypeID], [Name], [DisplayIndex], [ApplicableToWageOp], 
			@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser, [KPITypeGroupID]
	FROM TimeClockServer.[TimeClockDev].[dbo].[KPIType]
	SET IDENTITY_INSERT [dbo].[KPIType] OFF
	
	/****** Object:  Table [dbo].[KPIDataType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[KPIDataType] ON
	INSERT [dbo].[KPIDataType] ([KPIDataTypeID], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [KPIDataTypeID], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[KPIDataType]
	SET IDENTITY_INSERT [dbo].[KPIDataType] OFF
	

	
	
	/****** Object:  Table [dbo].[ExternalSystemType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[ExternalSystemType] ON
	INSERT [dbo].[ExternalSystemType] ([ExternalSystemTypeId], [Name], [DisplayIndex], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [ExternalSystemTypeId], [Name], [DisplayIndex], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[ExternalSystemType]
	SET IDENTITY_INSERT [dbo].[ExternalSystemType] OFF
	
	/****** Object:  Table [dbo].[ExternalSystem]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[ExternalSystem] ON
	INSERT INTO [dbo].[ExternalSystem]
           ([ExternalSystemId],[Name],[ExternalSystemTypeId],[DeveloperNote],[StartDate],[EndDate]
           ,[OrganisationID],[SiteID]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy]) 
	SELECT [ExternalSystemId],[Name],[ExternalSystemTypeId],[DeveloperNote],[StartDate],[EndDate]
           ,[OrganisationID],[SiteID]
           ,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[ExternalSystem]
	WHERE (OrganisationID IS NULL OR OrganisationID = 34)
	AND SiteID IS NULL
	SET IDENTITY_INSERT [dbo].[ExternalSystem] OFF	
	
	
	/****** Object:  Table [dbo].[EmployeeType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[EmployeeType] ON
	INSERT [dbo].[EmployeeType] ([EmployeeTypeID], [Name], [DisplayIndex], [IsLegacy], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [EmployeeTypeID], [Name], [DisplayIndex], [IsLegacy], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[EmployeeType]
	SET IDENTITY_INSERT [dbo].[EmployeeType] OFF
	
	/****** Object:  Table [dbo].[DepartmentType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[DepartmentType] ON
	INSERT [dbo].[DepartmentType] ([DepartmentTypeID], [Name], [DisplayIndex], [IsLegacy], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy], [RoomGroup]) 
	SELECT [DepartmentTypeID], [Name], [DisplayIndex], [IsLegacy], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser, [RoomGroup]
	FROM TimeClockServer.[TimeClockDev].[dbo].[DepartmentType]
	SET IDENTITY_INSERT [dbo].[DepartmentType] OFF
	
	/****** Object:  Table [dbo].[MetaDataType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[MetaDataType] ON
	INSERT [dbo].[MetaDataType] ([MetaDataTypeId], [DisplayName], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [MetaDataTypeId], [DisplayName], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[MetaDataType]
	SET IDENTITY_INSERT [dbo].[MetaDataType] OFF
	
	/****** Object:  Table [dbo].[MailTemplateType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[MailTemplateType] ON
	INSERT [dbo].[MailTemplateType] ([MailTemplateTypeID], [TemplateName], [Params], [Description], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [MailTemplateTypeID], [TemplateName], [Params], [Description], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[MailTemplateType]
	SET IDENTITY_INSERT [dbo].[MailTemplateType] OFF
		
	/****** Object:  Table [dbo].[RoomGroup]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[RoomGroup] ON
	INSERT [dbo].[RoomGroup] ([RoomGroupID], [Name], [DisplayIndex], [IsLegacy], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [RoomGroupID], [Name], [DisplayIndex], [IsLegacy], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[RoomGroup]
	SET IDENTITY_INSERT [dbo].[RoomGroup] OFF
	
	/****** Object:  Table [dbo].[ProfileType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[ProfileType] ON
	INSERT [dbo].[ProfileType] ([ProfileTypeId], [IsLegacy], [HistoricalId], [Description], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [ProfileTypeId], [IsLegacy], [HistoricalId], [Description], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[ProfileType]
	SET IDENTITY_INSERT [dbo].[ProfileType] OFF
	
	/****** Object:  Table [dbo].[PMS]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[PMS] ON
	INSERT [dbo].[PMS] ([PMSID], [Name], [PMSDataPath], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [PMSID], [Name], [PMSDataPath], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[PMS]
	SET IDENTITY_INSERT [dbo].[PMS] OFF
	
	/****** Object:  Table [dbo].[ParameterSetType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[ParameterSetType] ON
	INSERT [dbo].[ParameterSetType] ([ParameterSetTypeId], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [ParameterSetTypeId], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[ParameterSetType]
	SET IDENTITY_INSERT [dbo].[ParameterSetType] OFF
	
	/****** Object:  Table [dbo].[Month]    Script Date: 04/17/2012 15:23:08 ******/
	INSERT [dbo].[Month] ([Month], [FinancialOrder], [CalendarOrder]) 
	SELECT [Month], [FinancialOrder], [CalendarOrder]
	FROM TimeClockServer.[TimeClockDev].[dbo].[Month]
	
	/****** Object:  Table [dbo].[[ArchivedRoomType]]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[ArchivedRoomType] ON	
	INSERT INTO [dbo].[ArchivedRoomType]
           ([RoomTypeID],[RoomGroupID],[Name],[AccountCode],[DisplayIndex],[IsLegacy],[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
	SELECT [RoomTypeID],[RoomGroupID],[Name],[AccountCode],[DisplayIndex],[IsLegacy],@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[ArchivedRoomType]          
    SET IDENTITY_INSERT [dbo].[ArchivedRoomType] OFF
    
	/****** Object:  Table [dbo].[RoomType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[RoomType] ON
	INSERT [dbo].[RoomType] ([RoomTypeID], [Name], [Description], [HistoricalId], [IsLegacy], 
						[DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy])
	SELECT [RoomTypeID], [Name], [Description], [HistoricalId], [IsLegacy], 
			@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[RoomType] RT
	SET IDENTITY_INSERT [dbo].[RoomType] OFF
	
	/****** Object:  Table [dbo].[CentreType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[CentreType] ON
	INSERT [dbo].[CentreType] ([CentreTypeID], [Name], [Multiplier], [DisplayIndex], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy], [CentreTypeGroupId]) 
	SELECT [CentreTypeID], [Name], [Multiplier], [DisplayIndex], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser, [CentreTypeGroupId]
	FROM TimeClockServer.[TimeClockDev].[dbo].[CentreType]
	SET IDENTITY_INSERT [dbo].[CentreType] OFF
	
	/****** Object:  Table [dbo].[DepartmentGroup]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[DepartmentGroup] ON
	INSERT [dbo].[DepartmentGroup] ([DepartmentGroupID], [DepartmentTypeID], [Name], [DisplayIndex], [IsLegacy], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [DepartmentGroupID], [DepartmentTypeID], [Name], [DisplayIndex], [IsLegacy], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[DepartmentGroup]
	SET IDENTITY_INSERT [dbo].[DepartmentGroup] OFF
	
	/****** Object:  Table [dbo].[RoomTypeCode]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[RoomTypeCode] ON
	INSERT [dbo].[RoomTypeCode] ([RoomTypeCodeID], [RoomTypeID], [Code], [IsLegacy], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [RoomTypeCodeID], [RoomTypeID], [Code], [IsLegacy], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[RoomTypeCode]
	SET IDENTITY_INSERT [dbo].[RoomTypeCode] OFF
	
	/****** Object:  Table [dbo].[[ContactInformation]]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[ContactInformation] ON
	INSERT INTO [dbo].[ContactInformation]
           ([ContactInformationId],[FirstName],[LastName],[Address],[Address2],[City],[State]
           ,[Postcode],[CountryID],[PhoneNumber],[FaxNumber],[Email],[HistoricalId]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
     VALUES
           (1, 'Please Update','Please Update','Please Update','Please Update','Please Update', 1
           , 'Please Update', 13, 'Please Update','Please Update','Please Update', NULL
           ,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser)
    SET IDENTITY_INSERT [dbo].[ContactInformation] OFF
    
    /****** Object:  Table [dbo].[Organisation]    Script Date: 04/17/2012 15:23:08 ******/	
    SET IDENTITY_INSERT [dbo].[Organisation] ON
    INSERT INTO [dbo].[Organisation]
           ([OrganisationId], [Name],[ContactInformationID],[LicenceKey],[WeekStartDayID],[SalesTimeTypeID]
           ,[TimeTypeID],[DisplayIndex],[IsLegacy],[TimeCardStartRounding],[TimeCardEndRounding]
           ,[AuthorisationCode],[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy]
           ,LcidGeneral, LcidNumberFormat, LcidDateFormat, DateFormatMY, LayoutLevel)
	SELECT OrganisationID, 'Your Organisation',1,'Not used',[WeekStartDayID],[SalesTimeTypeID]
		  ,[TimeTypeID],[DisplayIndex],[IsLegacy],[TimeCardStartRounding],[TimeCardEndRounding]
		   ,'org001',@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
		   ,LcidGeneral, LcidNumberFormat, LcidDateFormat, DateFormatMY, LayoutLevel
	FROM TimeClockServer.[TimeClockDev].[dbo].Organisation 
	WHERE OrganisationID = 34 
	SET IDENTITY_INSERT [dbo].[Organisation] OFF
	
	/****** Object:  Table [dbo].[LookupType]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[LookupType] ON
	INSERT [dbo].[LookupType] ([LookupTypeId], [Name], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) 
	SELECT [LookupTypeId], [Name], @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[LookupType]
	SET IDENTITY_INSERT [dbo].[LookupType] OFF
	
	/****** Object:  Table [dbo].[LookupValue]    Script Date: 04/17/2012 15:23:08 ******/
	SET IDENTITY_INSERT [dbo].[LookupValue] ON
	INSERT [dbo].[LookupValue]
           ([LookupValueId],[LookupTypeId],[OrganisationId],[SiteId],[Key],[Text],[Value],[DisplayIndex]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
	SELECT [LookupValueId],[LookupTypeId],[OrganisationId],[SiteId],[Key],[Text],[Value],[DisplayIndex]		
		, @C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[LookupValue]
	WHERE SiteId IS NULL
	SET IDENTITY_INSERT [dbo].[LookupValue] OFF
		
	/****** Object:  Table [dbo].[LoadingCategory]    Script Date: 04/17/2012 15:23:08 ******/	
    SET IDENTITY_INSERT [dbo].[LoadingCategory] ON
	INSERT INTO [dbo].[LoadingCategory]
           ([LoadingCategoryId],[OrganisationID],[Name],[Description],[IsLegacy]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
	SELECT  [LoadingCategoryId],[OrganisationID],[Name],[Description],[IsLegacy]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[LoadingCategory]
	WHERE OrganisationID = 34
    SET IDENTITY_INSERT [dbo].[LoadingCategory] OFF 
      
    /****** Object:  Table [dbo].[Department]    Script Date: 04/17/2012 15:23:08 ******/	    
	SET IDENTITY_INSERT [dbo].[Department] ON
	INSERT INTO .[dbo].[Department]
           ([DepartmentId], [OrganisationID],[DepartmentGroupID]
           ,[Name]
           ,[Description]
           ,[IsPrimary],[IsBudgeting],[IsRostering]
           ,[BudgetTypeID],[DisplayIndex],[IsLegacy],[HistoricalId],[SMSActivated]
           ,[DepartmentBusinessAreaID]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
	SELECT [DepartmentId], [OrganisationID],[DepartmentGroupID]
			, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Name,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')
			, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Description,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')
			,[IsPrimary],[IsBudgeting],[IsRostering]
           ,[BudgetTypeID],[DisplayIndex],[IsLegacy],[HistoricalId],[SMSActivated]
           ,[DepartmentBusinessAreaID]
           ,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[Department] 
	WHERE OrganisationID = 34 AND [IsLegacy] = 0             
	SET IDENTITY_INSERT [dbo].[Department] OFF

	/****** Object:  Table [dbo].[RosterCentre]    Script Date: 04/17/2012 15:23:08 ******/	    
	SET IDENTITY_INSERT [dbo].[RosterCentre] ON
	INSERT INTO [dbo].[RosterCentre]
           ([RosterCentreID],[DepartmentID]
           ,[Name]
           ,[Description]
           ,[IsGrouped],[DisplayIndex],[IsLegacy],[IsBalance],[HistoricalId]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
	SELECT R.[RosterCentreID],R.[DepartmentID]
            ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(R.Name,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')
			,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(R.Description,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')
			,R.IsGrouped,R.[DisplayIndex],R.[IsLegacy],R.[IsBalance],R.[HistoricalId]
            ,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
    FROM TimeClockServer.[TimeClockDev].[dbo].[RosterCentre] R
    INNER JOIN [dbo].[Department] D on R.DepartmentID = D.DepartmentID
	WHERE OrganisationID = 34 AND R.IsLegacy = 0
	SET IDENTITY_INSERT [dbo].[RosterCentre] OFF
	
	/****** Object:  Table [dbo].[Centre]    Script Date: 04/17/2012 15:23:08 ******/	    	
	SET IDENTITY_INSERT [dbo].[Centre] ON
	INSERT INTO [dbo].[Centre]
           ([CentreId],[RosterCentreId],[CentreTypeId]
           ,[Name]
           ,[Description]
           ,[AccountCode],[LoadingCategoryId]
           ,[HasWageOptimisation],[AutomateWageOptimisationEntry],[OffsetWageOptimisationDate]
           ,[DisplayIndex],[IsLegacy],[IsBalance],[HistoricalId]
           ,[DontShowSales]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
	SELECT C.[CentreId], C.[RosterCentreId],C.[CentreTypeId]
			,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(C.Name,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')
			,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(C.Description,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')			
			,C.[AccountCode],C.[LoadingCategoryId]
           ,C.[HasWageOptimisation],C.[AutomateWageOptimisationEntry],C.[OffsetWageOptimisationDate]
           ,C.[DisplayIndex],C.[IsLegacy],C.[IsBalance],C.[HistoricalId]
           ,CASE WHEN C.DontShowSales IS null THEN 0 ELSE C.DontShowSales END
           ,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser 
	FROM TimeClockServer.[TimeClockDev].[dbo].[Centre] C
	INNER JOIN [LoadingCategory] L on L.LoadingCategoryID = C.LoadingCategoryId
	INNER JOIN [dbo].[RosterCentre] R on C.RosterCentreId = R.RosterCentreID
    INNER JOIN [dbo].[Department] D on R.DepartmentID = D.DepartmentID
	WHERE D.OrganisationID = 34 AND C.IsLegacy = 0
	SET IDENTITY_INSERT [dbo].[Centre] OFF
	   
	/****** Object:  Table [dbo].[SubCentre]    Script Date: 04/17/2012 15:23:08 ******/	    	
	SET IDENTITY_INSERT [dbo].[SubCentre] ON
	INSERT INTO [dbo].[SubCentre]
           ([SubCentreId],[CentreID]
           ,[Name]
           ,[Description]
           ,[AccountCode],[AccountCode2]
           ,[DisplayIndex],[IsLegacy],[IsBalance],[HistoricalId]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])    
	SELECT SC.[SubCentreId], SC.[CentreID]
			,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SC.Name,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')
			,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SC.Description,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')
			,SC.[AccountCode],SC.[AccountCode2]
            ,SC.[DisplayIndex],SC.[IsLegacy],SC.[IsBalance],SC.[HistoricalId] 
            ,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser                      
    FROM TimeClockServer.[TimeClockDev].[dbo].[SubCentre] SC
    INNER JOIN [dbo].[Centre] C on C.CentreId = SC.CentreID
	INNER JOIN [dbo].[RosterCentre] R on C.RosterCentreId = R.RosterCentreID
    INNER JOIN [dbo].[Department] D on R.DepartmentID = D.DepartmentID
	WHERE OrganisationID = 34 AND SC.IsLegacy = 0    
    SET IDENTITY_INSERT [dbo].[SubCentre] OFF
    
    /****** Object:  Table [dbo].[MicroCentre]    Script Date: 04/17/2012 15:23:08 ******/	    	
    SET IDENTITY_INSERT [dbo].[MicroCentre] ON
	INSERT INTO [dbo].[MicroCentre]
           ([MicroCentreId],[SubCentreId]
           ,[Name]
           ,[Description]
           ,[AccountCode],[DisplayIndex],[IsLegacy],[HistoricalId]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])    
	SELECT MC.[MicroCentreId],MC.[SubCentreId]
			,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(MC.Name,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')
			,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(MC.Description,'Rockford ',''), 'Novotel',''),'Adelaide',''), 'Mildura', ''),'Sydney', '')
			,MC.AccountCode,MC.[DisplayIndex],MC.[IsLegacy],MC.[HistoricalId]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser                      
    FROM TimeClockServer.[TimeClockDev].[dbo].[MicroCentre] MC
    INNER JOIN [dbo].[SubCentre] SC on MC.SubCentreId = SC.SubCentreID
    INNER JOIN [dbo].[Centre] C on C.CentreId = SC.CentreID
	INNER JOIN [dbo].[RosterCentre] R on C.RosterCentreId = R.RosterCentreID
    INNER JOIN [dbo].[Department] D on R.DepartmentID = D.DepartmentID
	WHERE OrganisationID = 34 AND MC.IsLegacy = 0 	       
    SET IDENTITY_INSERT [dbo].[MicroCentre] OFF
    
    /****** Object:  Table [dbo].[SalesForecastSource]    Script Date: 04/17/2012 15:23:08 ******/	    	
    SET IDENTITY_INSERT [dbo].[SalesForecastSource] ON
    INSERT INTO [dbo].[SalesForecastSource]
           ([SourceID],[SourceName])
    SELECT [SourceID],[SourceName]                      
    FROM TimeClockServer.[TimeClockDev].[dbo].[SalesForecastSource]    
    SET IDENTITY_INSERT [dbo].[SalesForecastSource] OFF     
      
    /****** Object:  Table [dbo].[AccommodationCode]    Script Date: 04/17/2012 15:23:08 ******/	    	
    SET IDENTITY_INSERT [dbo].[AccommodationCode] ON    
    INSERT INTO [dbo].[AccommodationCode]
           ([AccommodationCodeID],[AccommodationTypeID],[SubCentreID],[Code],[IsLegacy]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy],PreviousAccountCode)
    SELECT A.[AccommodationCodeID],A.[AccommodationTypeID],A.[SubCentreID],A.[Code],A.[IsLegacy]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser,PreviousAccountCode
	FROM TimeClockServer.[TimeClockDev].[dbo].[AccommodationCode]  A
	INNER JOIN [SubCentre] SC on A.SubCentreID = SC.SubCentreID
	WHERE A.IsLegacy = 0
    SET IDENTITY_INSERT [dbo].[AccommodationCode] OFF     
     	
    /****** Object:  Table [dbo].[CompetitiveSet]    Script Date: 04/17/2012 15:23:08 ******/			
	INSERT INTO [dbo].[CompetitiveSet]
           ([CompetitiveSetId],[Name]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    SELECT C.[CompetitiveSetId],C.[Name]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
    FROM TimeClockServer.[TimeClockDev].[dbo].[CompetitiveSet]  C
	            			
	/****** Object:  Table [dbo].[[RosterShiftStatus]]    Script Date: 04/17/2012 15:23:08 ******/	    	
    SET IDENTITY_INSERT [dbo].[RosterShiftStatus] ON
    INSERT INTO [dbo].[RosterShiftStatus]
           ([RosterShiftStatusId],[Name],[IsLegacy]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy],IsValidRosterShift)
    SELECT [RosterShiftStatusId],[Name],[IsLegacy]			
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser,IsValidRosterShift
    FROM TimeClockServer.[TimeClockDev].[dbo].[RosterShiftStatus]  A
	SET IDENTITY_INSERT [dbo].[RosterShiftStatus] OFF 

	/****** Object:  Table [dbo].[CleanStatus]    Script Date: 04/17/2012 15:23:08 ******/	    	     
	INSERT INTO [dbo].[CleanStatus]
           ([CleanStatusId],[HistoricalId],[Name],[IsLegacy],[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    SELECT [CleanStatusId],[HistoricalId],[Name],[IsLegacy]			
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser  
    FROM TimeClockServer.[TimeClockDev].[dbo].[CleanStatus]  A	
    
    /****** Object:  Table [dbo].[RoomStatus]    Script Date: 04/17/2012 15:23:08 ******/	    	     	
    INSERT INTO [dbo].[RoomStatus]
           ([RoomStatusId],[Name],[IsLegacy],[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    SELECT [RoomStatusId],[Name],[IsLegacy]		
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser  
    FROM TimeClockServer.[TimeClockDev].[dbo].[RoomStatus]  A	
    
    /****** Object:  Table [dbo].[CentreKPITemplate]    Script Date: 04/17/2012 15:23:08 ******/	    	
    INSERT INTO CentreKPITemplate
			   (CentreID,KPIDataTypeID,BudgetId,BudgetVersion,Name
			   ,KPI,Percentage,CoverCost,DailyCost,EstimatedSpend,KPITypeID,OnCost,KpiLevel,KpiLevelID
			   ,IsKeyRatio,IsKeyImprovementRatio,TimeOfDay
			   ,DateCreated,DateUpdated,CreatedBy,UpdatedBy)
	SELECT   K.CentreID,KPIDataTypeID,BudgetId,BudgetVersion,Name
			,KPI,Percentage,CoverCost,DailyCost,EstimatedSpend,KPITypeID,OnCost,KpiLevel,KpiLevelID
			,IsKeyRatio,IsKeyImprovementRatio,TimeOfDay
			, @C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser
	FROM    TimeClockServer.[TimeClockDev].[dbo].[CentreKPITemplate] K

	/****** Object:  Table [dbo].[SubCentreKPITemplate]    Script Date: 04/17/2012 15:23:08 ******/	    	    
	INSERT INTO SubCentreKPITemplate
			   (SubCentreID,KPIDataTypeID,BudgetId,BudgetVersion
			   ,Name
			   ,KPI,Percentage,CoverCost,DailyCost
			   ,EstimatedSpend,KPITypeID,KpiLevel,KpiLevelID,IsKeyRatio,IsKeyImprovementRatio,TimeOfDay
			   ,DateCreated,DateUpdated,CreatedBy,UpdatedBy)	    
	SELECT   K.SubCentreID,KPIDataTypeID,BudgetId,BudgetVersion
			,Name
			,KPI,Percentage,CoverCost,DailyCost
			,EstimatedSpend,KPITypeID,KpiLevel,KpiLevelID,IsKeyRatio,IsKeyImprovementRatio,TimeOfDay
			,@C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser
	FROM    TimeClockServer.[TimeClockDev].[dbo].[SubCentreKPITemplate] K	
	
	/****** Object:  Table [dbo].[SiteMetaDataTemplate]    Script Date: 04/17/2012 15:23:08 ******/	    	    
	INSERT INTO SiteMetaDataTemplate
       (MetaDataTypeId,DateStart,Value,IsBalance,DateCreated,DateUpdated,CreatedBy,UpdatedBy)
	SELECT MetaDataTypeId,DateStart,Value, @C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[SiteMetaData]
	WHERE SIteid = 8
	
	/****** Object:  Table [dbo].[SiteSeasonTemplate]    Script Date: 04/17/2012 15:23:08 ******/	    	    
	INSERT INTO SiteSeasonTemplate
       (DemandLevelId,DisplayIndex,Colour,DisplayName,RecommendedSeasonLevel,TotalLowYield
       ,Rate,RevPAR,DateCreated,DateUpdated,CreatedBy,UpdatedBy)
	SELECT DemandLevelId,DisplayIndex,Colour,DisplayName,RecommendedSeasonLevel,TotalLowYield
       ,Rate,RevPAR,@C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser
	FROM TimeClockServer.[TimeClockDev].[dbo].[SiteSeason]
	WHERE SIteid = 8
	
	/****** Object:  Table [dbo].[SiteDemandCurveTemplate]    Script Date: 04/17/2012 15:23:08 ******/	    	    
	INSERT INTO SiteDemandCurveTemplate
       (DemandLevelId,DaysOut,DemandPercentage,DemandPercent
       ,DateCreated,DateUpdated,CreatedBy,UpdatedBy)
	SELECT  DemandLevelId,DaysOut,DemandPercentage,DemandPercent   
		,@C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser     
	FROM TimeClockServer.[TimeClockDev].[dbo].[SiteDemandCurve]
	WHERE SIteid = 8
	
	/****** Object:  Table [dbo].[YieldProfileRateTemplate]    Script Date: 04/17/2012 15:23:08 ******/	
	INSERT INTO YieldProfileRateTemplate
           (DemandLevelId,YieldProfileId,Rate,DateCreated,DateUpdated,CreatedBy,UpdatedBy)
	SELECT  DemandLevelId,YieldProfileId,Rate
		,@C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser     
	FROM TimeClockServer.[TimeClockDev].[dbo].[YieldProfileRateTemplate]	
	
	
	/****** Object:  Table [dbo].[RateAvailType]    Script Date: 04/17/2012 15:23:08 ******/	    	
    SET IDENTITY_INSERT [dbo].[RateAvailType] ON
    INSERT INTO [dbo].[RateAvailType]
           ([TypeId],[mode],[Name],[Pattern],[Description]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    SELECT [TypeId],[mode],[Name],[Pattern],[Description]		
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser  
    FROM TimeClockServer.[TimeClockDev].[dbo].[RateAvailType]  A
	SET IDENTITY_INSERT [dbo].[RateAvailType] OFF 
	   	
    /****** Object:  Table [dbo].[DashboardConfigTemplate]    Script Date: 08/31/2012 16:39:16 ******/
	SET IDENTITY_INSERT [dbo].[DashboardConfigTemplate] ON
	IF (@_PackageType = 1)
	BEGIN
		/** Full Package Default HomePage **/
		INSERT [dbo].[DashboardConfigTemplate] ([DashboardConfigTemplateId], [SiteId], [SiteGroupId], [DepartmentId], [RoleId], [UserName], [DashboardType], [DashboardConfig], [IsDefault], [Description], [Priority], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) VALUES (12, NULL, NULL, NULL, NULL, NULL, 4, N'<?xml version="1.0" encoding="utf-8"?><RadDocking>
		  <SplitContainers>
			<RadSplitContainer Dock="DockedLeft" RelativeWidth="100" RelativeHeight="100" IsAutoGenerated="True" Orientation="Vertical">
			  <Items>
				<RadPaneGroup RelativeWidth="100" RelativeHeight="100" IsAutoGenerated="True" SelectedIndex="0">
				  <Items>
					<RadPane SerializationTag="BalancedScorecardsDashboard" IsDockable="True" Title="Balanced Scorecards Dashboard" Header="cdaba620-56e5-46be-9f7d-57a93629344f" CanUserClose="True" />
				  </Items>
				</RadPaneGroup>
				<RadPaneGroup RelativeWidth="100" RelativeHeight="100" IsAutoGenerated="True" SelectedIndex="-1">
				  <Items />
				</RadPaneGroup>
			  </Items>
			</RadSplitContainer>
			<RadSplitContainer Dock="DockedTop" Height="180" RelativeWidth="100" RelativeHeight="100" IsAutoGenerated="True">
			  <Items>
				<RadPaneGroup SelectedIndex="-1">
				  <Items />
				</RadPaneGroup>
			  </Items>
			</RadSplitContainer>
			<RadSplitContainer Dock="DockedLeft" Width="240">
			  <Items>
				<RadPaneGroup SerializationTag="MainPaneGroup" SelectedIndex="-1">
				  <Items />
				</RadPaneGroup>
			  </Items>
			</RadSplitContainer>
		  </SplitContainers>
		</RadDocking>', 1, N'Default HomePage', 0, @C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser)
	END
	
	IF (@_PackageType = 2)
	BEGIN
		/** Operations Package Default HomePage **/
		INSERT [dbo].[DashboardConfigTemplate] ([DashboardConfigTemplateId], [SiteId], [SiteGroupId], [DepartmentId], [RoleId], [UserName], [DashboardType], [DashboardConfig], [IsDefault], [Description], [Priority], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) VALUES (13, NULL, NULL, NULL, NULL, NULL, 4, N'<?xml version="1.0" encoding="utf-8"?><RadDocking>
		  <SplitContainers>
			<RadSplitContainer Dock="DockedLeft" RelativeWidth="100" RelativeHeight="100" IsAutoGenerated="True">
			  <Items>
				<RadPaneGroup SelectedIndex="0">
				  <Items>
					<RadPane SerializationTag="BalancedScorecardsDashboard" IsDockable="True" Title="Balanced Scorecards Dashboard" Header="dd25f129-84f3-412d-94d1-fbacb0e317a4" CanUserClose="True" />
				  </Items>
				</RadPaneGroup>
			  </Items>
			</RadSplitContainer>
			<RadSplitContainer Dock="DockedLeft" Width="240">
			  <Items>
				<RadPaneGroup SerializationTag="MainPaneGroup" SelectedIndex="-1">
				  <Items />
				</RadPaneGroup>
			  </Items>
			</RadSplitContainer>
		  </SplitContainers>
		</RadDocking>', 1, N'Default HomePage', 0, @C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser)
	END
	
	IF (@_PackageType = 3)
	BEGIN
		/** Yield Package Default HomePage **/
		INSERT [dbo].[DashboardConfigTemplate] ([DashboardConfigTemplateId], [SiteId], [SiteGroupId], [DepartmentId], [RoleId], [UserName], [DashboardType], [DashboardConfig], [IsDefault], [Description], [Priority], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) VALUES (14, NULL, NULL, NULL, NULL, NULL, 4, N'<?xml version="1.0" encoding="utf-8"?><RadDocking>
		  <SplitContainers>
			<RadSplitContainer Dock="DockedLeft" RelativeWidth="100" RelativeHeight="100" IsAutoGenerated="True">
			  <Items>
				<RadPaneGroup SelectedIndex="0">
				  <Items>
					<RadPane SerializationTag="PickupChart" IsDockable="True" Title="Pickup Chart" Header="5b46d2a4-2b59-491b-9b9d-a8b9086db786" CanUserClose="True" />
				  </Items>
				</RadPaneGroup>
			  </Items>
			</RadSplitContainer>
			<RadSplitContainer Dock="DockedLeft" Width="240">
			  <Items>
				<RadPaneGroup SerializationTag="MainPaneGroup" SelectedIndex="-1">
				  <Items />
				</RadPaneGroup>
			  </Items>
			</RadSplitContainer>
		  </SplitContainers>
		</RadDocking>', 1, N'Default HomePage', 0, @C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser)
	END
	
	IF (@_PackageType = 4)
	BEGIN
		/** Basic Package Default HomePage **/
		INSERT [dbo].[DashboardConfigTemplate] ([DashboardConfigTemplateId], [SiteId], [SiteGroupId], [DepartmentId], [RoleId], [UserName], [DashboardType], [DashboardConfig], [IsDefault], [Description], [Priority], [DateCreated], [DateUpdated], [CreatedBy], [UpdatedBy]) VALUES (15, NULL, NULL, NULL, NULL, NULL, 4, N'<?xml version="1.0" encoding="utf-8"?><RadDocking>
		  <SplitContainers>
			<RadSplitContainer Dock="DockedLeft" RelativeWidth="100" RelativeHeight="100" IsAutoGenerated="True">
			  <Items>
				<RadPaneGroup SelectedIndex="0">
				  <Items>
					<RadPane SerializationTag="PickupChart" IsDockable="True" Title="Pickup Chart" Header="05ba8c22-71eb-4e85-8192-e8b73fcecf15" CanUserClose="True" />
				  </Items>
				</RadPaneGroup>
			  </Items>
			</RadSplitContainer>
			<RadSplitContainer Dock="DockedLeft" Width="240">
			  <Items>
				<RadPaneGroup SerializationTag="MainPaneGroup" SelectedIndex="-1">
				  <Items />
				</RadPaneGroup>
			  </Items>
			</RadSplitContainer>
		  </SplitContainers>
		</RadDocking>', 1, N'Default HomePage', 0, @C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser)
	END
	
	SET IDENTITY_INSERT [dbo].[DashboardConfigTemplate] OFF

	/****** Object:  Table [dbo].[DecisionType]    Script Date: 04/17/2012 15:23:08 ******/	    	
    --SET IDENTITY_INSERT [dbo].[DecisionType] ON
    INSERT INTO [dbo].[DecisionType]
           ([DecisionTypeId],[Name]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    SELECT [DecisionTypeId],[Name]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser  
    FROM TimeClockServer.[TimeClockDev].[dbo].[DecisionType]  A
	--SET IDENTITY_INSERT [dbo].[DecisionType] OFF 

	/****** Object:  Table [dbo].[DecisionType]    Script Date: 04/17/2012 15:23:08 ******/	    	
	INSERT INTO [dbo].[Culture]
           ([LCID],[Name],[EnglishName],[NativeName],[LayoutLevel])
    SELECT [LCID],[Name],[EnglishName],[NativeName],[LayoutLevel] 
    FROM TimeClockServer.[TimeClockDev].[dbo].[Culture]  A

	/****** Object:  Table [dbo].[DecisionType]    Script Date: 04/17/2012 15:23:08 ******/	    	
	INSERT INTO [dbo].[BatchJobStatus]
           ([BatchJobStatusID],[Name] 
            ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    SELECT [BatchJobStatusID],[Name]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser
    FROM TimeClockServer.[TimeClockDev].[dbo].[BatchJobStatus]  A        

	/****** Object:  Table [dbo].[DecisionType]    Script Date: 04/17/2012 15:23:08 ******/	    	
	INSERT INTO [dbo].[ForecastLevel]
           ([ForecastLevelID],[ForecastLevelName])
    SELECT [ForecastLevelID],[Name]
    FROM TimeClockServer.[TimeClockDev].[dbo].[ForecastLevel]  A   

	/****** Object:  Table [dbo].[GuestContactType]    Script Date: 04/17/2012 15:23:08 ******/	    	
    SET IDENTITY_INSERT [dbo].[GuestContactType] ON
    INSERT INTO [dbo].[GuestContactType]
           ([GuestContactTypeId],[Name]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    SELECT [GuestContactTypeId],[Name]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser  
    FROM TimeClockServer.[TimeClockDev].[dbo].[GuestContactType]  A
	SET IDENTITY_INSERT [dbo].[GuestContactType] OFF 
	
	/****** Object:  Table [dbo].[ServiceType]    Script Date: 04/17/2012 15:23:08 ******/	    	
    SET IDENTITY_INSERT [dbo].[ServiceType] ON
    INSERT INTO [dbo].[ServiceType]
           ([ServiceTypeId],[Name]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    SELECT [ServiceTypeId],[Name]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser  
    FROM TimeClockServer.[TimeClockDev].[dbo].[ServiceType]  A
	SET IDENTITY_INSERT [dbo].[ServiceType] OFF 

	/****** Object:  Table [dbo].[ReservationType]    Script Date: 04/17/2012 15:23:08 ******/	    	
    SET IDENTITY_INSERT [dbo].[ReservationType] ON
    INSERT INTO [dbo].[ReservationType]
           ([ReservationTypeId],[Name]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
    SELECT [ReservationTypeId],[Name]
			,@C_CurrentDate,@C_CurrentDate,@C_CurrentUser,@C_CurrentUser  
    FROM TimeClockServer.[TimeClockDev].[dbo].[ReservationType]  A
	SET IDENTITY_INSERT [dbo].[ReservationType] OFF 
			                       			              		            			
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

/* Here is the script to create mapping data when create a new site
insert into ExternalSystemMapping (ExternalSystemId, KeyId, ExternalKeyId, DateStart, DisplayIndex, DateCreated, DateUpdated, CreatedBy, UpdatedBy)
values(3,6,4, '01-Jan-1990', 2, GETDATE(), GETDATE(), 'HT', 'HT')
insert into SitePMS (SiteID, PMSID, PropCode, StartDate, DateCreated, DateUpdated, CreatedBy, UpdatedBy)
values(5,2,'RA', '01-Jan-1990', GETDATE(), GETDATE(), 'HT', 'HT')
*/