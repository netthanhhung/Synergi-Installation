USE [master]
GO
/****** Object:  Database [SynergiComp]    Script Date: 11/01/2013 09:15:21 ******/
CREATE DATABASE [SynergiComp] ON  PRIMARY 
( NAME = N'SynergiComp', FILENAME = N'C:\DBs\SynergiComp.mdf' , SIZE = 25600KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SynergiComp_log', FILENAME = N'C:\DBs\SynergiComp.ldf' , SIZE = 149696KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SynergiComp] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SynergiComp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SynergiComp] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [SynergiComp] SET ANSI_NULLS OFF
GO
ALTER DATABASE [SynergiComp] SET ANSI_PADDING OFF
GO
ALTER DATABASE [SynergiComp] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [SynergiComp] SET ARITHABORT OFF
GO
ALTER DATABASE [SynergiComp] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [SynergiComp] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [SynergiComp] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [SynergiComp] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [SynergiComp] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [SynergiComp] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [SynergiComp] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [SynergiComp] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [SynergiComp] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [SynergiComp] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [SynergiComp] SET  DISABLE_BROKER
GO
ALTER DATABASE [SynergiComp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [SynergiComp] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [SynergiComp] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [SynergiComp] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [SynergiComp] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [SynergiComp] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [SynergiComp] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [SynergiComp] SET  READ_WRITE
GO
ALTER DATABASE [SynergiComp] SET RECOVERY FULL
GO
ALTER DATABASE [SynergiComp] SET  MULTI_USER
GO
ALTER DATABASE [SynergiComp] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [SynergiComp] SET DB_CHAINING OFF
GO
USE [SynergiComp]
GO
/****** Object:  UserDefinedFunction [dbo].[ufnSplit]    Script Date: 11/01/2013 09:15:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufnSplit](@sep char(1), @s varchar(MAX))     
returns @temptable 
TABLE 
(
Id int NOT NULL IDENTITY (1, 1)
, Token varchar(MAX) NULL
)
AS BEGIN

    declare @idx int     
    declare @split varchar(max)     

    select @idx = 1     
        if len(@s )<1 or @s is null  return     

    while @idx!= 0     
    begin     
        set @idx = charindex(@sep,@s)     
        if @idx!=0     
            set @split= left(@s,@idx - 1)     
        else     
            set @split= @s

        if(len(@split)>0)
            insert into @temptable(Token) values(ltrim(rtrim(@split)))     

        set @s= right(@s,len(@s) - @idx)     
        if len(@s) = 0 break     
    end 

	return     
	
	-- ======================================================================
	-- Change History
	-- ======================================================================
	-- 27-Mar-2012 EJM
	-- Remove the CTE based parse due to the stupid maxrecursion limitations.

END
GO
/****** Object:  Table [dbo].[SourceGroup]    Script Date: 11/01/2013 09:15:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SourceGroup](
	[SourceGroupID] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Concurrency] [timestamp] NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateUpdated] [smalldatetime] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
 CONSTRAINT [PK_SourceGroup] PRIMARY KEY CLUSTERED 
(
	[SourceGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Property]    Script Date: 11/01/2013 09:15:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Property](
	[PropertyID] [int] IDENTITY(1,1) NOT NULL,
	[PropName] [nvarchar](255) NOT NULL,
	[SiteID] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[Concurrency] [timestamp] NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateUpdated] [smalldatetime] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
 CONSTRAINT [PK_Property] PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[ufnSelectWageOptimisationHourlyRooms]    Script Date: 11/01/2013 09:15:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufnSelectWageOptimisationHourlyRooms] 
(
	@SiteID int = null
	, @CentreID int = null
	, @DateStart smalldatetime = null
	, @DateEnd smalldatetime = null
	, @Source int
)
RETURNS @result TABLE
(
	Hrs decimal (20,8)
	, Checkins decimal (20,8)
	, Checkouts decimal (20,8)
	, GuestContacts decimal (20,8)
	, Shifts decimal (20,8)
	, BaseWage decimal (20,8)
	, Loading decimal (20,8)
	, TotalWages decimal (20,8)
	, Cost decimal (20,8)
	, TargetCost decimal (20,8)
	, WageToTargetPercent decimal (20,8)
)
AS BEGIN

	DECLARE @_SiteID int
		, @_CentreID int
		, @_KPIDataTypeID int
		, @_DateStart smalldatetime
		, @_DateEnd smalldatetime
		, @_OrganisationId int
		, @_Source int

	SET @_SiteID = @SiteID
	SET @_CentreID = @CentreID
	SET @_DateStart = @DateStart
	SET @_DateEnd = @DateEnd
	SET @_Source = @Source
	--SET @_SiteID = 8
	--SET @_PropCode = 'RA'
	--SET @_CentreID = 268 --HouseService Payroll Centre
	--SET @_DateStart = '01/Sep/2012'
	--SET @_DateEnd = '06/Sep/2012'

	SET @_KPIDataTypeID = 4
	
	IF (@_OrganisationId IS NULL AND @_SiteId IS NOT NULL)
	SELECT @_OrganisationId = (SELECT S.OrganisationId FROM dbo.Site AS S WHERE S.SiteId = @_SiteId)	

	DECLARE @_CountDays int 
	SET @_CountDays = DateDiff (dd, @_DateStart, @_DateEnd) + 1		

	-- ======================================================================	
	-- BEGIN - BUILD WeekBookings TABLE

	DECLARE @HourlyBookings AS TABLE
	(
		Buchnr int,
		SiteId int,
		EventDate smalldatetime,
		ArrDate smalldatetime,
		DepDate smalldatetime,
		ArrivalTime varchar(5),
		DepartureTime varchar(5),
		RmNt int
	)
		
	INSERT INTO @HourlyBookings (Buchnr, SiteId, EventDate, ArrDate, DepDate, ArrivalTime, DepartureTime, RmNt)
	SELECT
		Buchnr as Buchnr
		, @_SiteId as SiteId
		, UD.DateEntry AS EventDate
		, PRO.ArrDate As ArrDate
		, PRO.DepDate As DepDate
		, PRO.ArrivalTime As ArrivalTime
		, PRO.DepartureTime As DepartureTime
		, ISNULL(SUM(PRO.RmNt),0) as RmNt				
	FROM UtilityDays UD
	LEFT OUTER JOIN	[dbo].[vwHoldings] AS PRO 
		ON PRO.OrganisationID = @_OrganisationID
		AND PRO.SiteId = @_SiteId 
		AND UD.DateEntry = PRO.EventDate
	WHERE
		UD.DateEntry BETWEEN @_DateStart AND @_DateEnd
	GROUP BY UD.DateEntry, ArrDate, DepDate, ArrivalTime, DepartureTime, Buchnr, RmNt
	
	-- END - BUILD Bookings TABLE
	
	-- ======================================================================	
	
	IF @_Source = 2	--Rosters
	BEGIN
		INSERT INTO @result
		SELECT		
			Hrs
			, Checkins
			, Checkouts
			, GuestContacts
			, Shifts
			, BaseWage
			, Loading
			, TotalWages
			, Cost
			, TargetCost
			, CASE WHEN TargetCost = 0
				THEN 0
				ELSE 100 * Cost / TargetCost
				END AS WageToTargetPercent
		FROM
		(
			SELECT		
				RS_UH.Hrs
				, ISNULL(SUM(B_UH.Checkins) / @_CountDays, 0) AS Checkins
				, ISNULL(SUM(B_UH.Checkouts / @_CountDays), 0) AS Checkouts
				, ISNULL(SUM(B_UH.Checkins + B_UH.Checkouts) / @_CountDays, 0) AS GuestContacts
				, ISNULL(Max(RS_UH.Shifts) / @_CountDays, 0) AS Shifts
				, ISNULL(Max(RS_UH.BaseWage) / @_CountDays, 0) AS BaseWage
				, ISNULL(Max (RS_UH.Loading) / @_CountDays, 0) AS Loading
				, ISNULL(Max(RS_UH.TotalWages) / @_CountDays, 0) AS TotalWages
				, ISNULL(Max(RS_UH.TotalWages) / @_CountDays, 0) AS Cost
				, Max(C_KPI.DailyCost) / 24 
					+ Max(C_KPI.CoverCost) 
					* ISNULL(SUM(B_UH.Checkins + B_UH.Checkouts) / @_CountDays, 0) AS TargetCost
			FROM
			-- For Reception instead of getting the KPILevel = 4 and KPILevelID = 59 
			-- to bring back Rooms Sold, get the number of guest contacts = checkins and checkouts for the day
			(
				SELECT 
					Hrs
					, SUM(Checkins) AS Checkins
					, 0 AS Checkouts
				FROM
				(
					SELECT UH.Hrs AS Hrs, MAX(B.RmNt) AS Checkins
					FROM @HourlyBookings B  
					INNER JOIN UtilityHours UH ON UH.Hrs = CASE WHEN ISDATE (B.ArrivalTime) = 1 THEN DatePart (hh, B.ArrivalTime) END
						AND (B.ArrDate Between @_DateStart AND @_DateEnd)
					GROUP BY UH.Hrs, B.Buchnr
				) AS U_BH1
				GROUP BY U_BH1.Hrs

				UNION

				SELECT Hrs, 0 AS Checkins, SUM(Checkouts) AS Checkouts
				FROM
				(
					SELECT UH.Hrs AS Hrs, MAX(B2.RmNt) AS Checkouts
					FROM @HourlyBookings B2 
					INNER JOIN UtilityHours UH ON UH.Hrs = CASE WHEN ISDATE (B2.DepartureTime) = 1 THEN DatePart (hh,B2.DepartureTime) END
						AND (B2.DepDate Between @_DateStart AND @_DateEnd)
					GROUP BY UH.Hrs, B2.Buchnr
				) AS U_BH2
				GROUP BY U_BH2.Hrs
			) AS B_UH

			LEFT OUTER JOIN
				[dbo].[ufnSelectWOHourlyRosterShifts] (@_SiteId, @_CentreId, @_DateStart, @_DateEnd) AS RS_UH
				ON B_UH.Hrs = RS_UH.Hrs
		
			LEFT OUTER JOIN CentreKPI C_KPI ON (SiteID = @_SiteID) AND (CentreID = @_CentreID) AND (KPIDataTypeID = @_KPIDataTypeID)

			GROUP BY RS_UH.Hrs
		) AS I
		ORDER BY Hrs
	END
	ELSE
	BEGIN
		INSERT INTO @result
		SELECT		
			Hrs
			, Checkins
			, Checkouts
			, GuestContacts
			, Shifts
			, BaseWage
			, Loading
			, TotalWages
			, Cost
			, TargetCost
			, CASE WHEN TargetCost = 0
				THEN 0
				ELSE 100 * Cost / TargetCost
				END AS WageToTargetPercent
		FROM
		(
			SELECT
				TS_UH.Hrs
				, ISNULL(SUM(B_UH.Checkins) / @_CountDays, 0) AS Checkins
				, ISNULL(SUM(B_UH.Checkouts / @_CountDays), 0) AS Checkouts
				, ISNULL(SUM(B_UH.Checkins + B_UH.Checkouts) / @_CountDays, 0) AS GuestContacts
				, ISNULL(Max(TS_UH.Shifts) / @_CountDays, 0) AS Shifts
				, ISNULL(Max(TS_UH.BaseWage) / @_CountDays, 0) AS BaseWage
				, ISNULL(Max(TS_UH.Loading) / @_CountDays, 0) AS Loading
				, ISNULL(Max(TS_UH.TotalWages) / @_CountDays, 0) AS TotalWages
				, ISNULL(Max(TS_UH.TotalWages) / @_CountDays, 0) AS Cost
				, Max(C_KPI.DailyCost) / 24 
					+ Max(C_KPI.CoverCost) 
					* ISNULL(SUM(B_UH.Checkins + B_UH.Checkouts) / @_CountDays, 0) AS TargetCost
			FROM
			-- For Reception instead of getting the KPILevel = 4 and KPILevelID = 59
			-- to bring back Rooms Sold, get the number of guest contacts = checkins and checkouts for the day
			(
				SELECT Hrs, SUM(Checkins) AS Checkins, 0 AS Checkouts
				FROM
				(
					SELECT UH.Hrs AS Hrs, MAX(B.RmNt) AS Checkins
					FROM @HourlyBookings B  
					INNER JOIN UtilityHours UH ON UH.Hrs = CASE WHEN ISDATE (B.ArrivalTime) = 1 THEN DatePart (hh, B.ArrivalTime) END
						AND (B.ArrDate Between @_DateStart AND @_DateEnd)
					GROUP BY UH.Hrs, B.Buchnr
				) AS U_BH1
				GROUP BY U_BH1.Hrs

				UNION

				SELECT Hrs, 0 AS Checkins, SUM(Checkouts) AS Checkouts
				FROM
				(
					SELECT UH.Hrs AS Hrs, MAX(B2.RmNt) AS Checkouts
					FROM @HourlyBookings B2 
					INNER JOIN UtilityHours UH ON UH.Hrs = CASE WHEN ISDATE (B2.DepartureTime) = 1 THEN DatePart (hh,B2.DepartureTime) END
						AND (B2.DepDate Between @_DateStart AND @_DateEnd)
					GROUP BY UH.Hrs, B2.Buchnr
				) AS U_BH2
				GROUP BY U_BH2.Hrs
			) AS B_UH

			LEFT OUTER JOIN
				[dbo].[ufnSelectWOHourlyTimeCardShifts] (@_SiteId, @_CentreId, @_DateStart, @_DateEnd) AS TS_UH
				ON B_UH.Hrs = TS_UH.Hrs 

			LEFT OUTER JOIN CentreKPI C_KPI ON (SiteID = @_SiteID) AND (CentreID = @_CentreID) AND (KPIDataTypeID = @_KPIDataTypeID)

			GROUP BY TS_UH.Hrs
		) AS I
		ORDER BY Hrs
	END
	
	RETURN

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 05-Sep-2013 EJM/TB
	-- Fixed divzero error when no target.
	-- 18-Mar-2013 VH
	-- Initialise from procListWageOptimisationHourlyFromRosters

END
GO
/****** Object:  UserDefinedFunction [dbo].[ufnListDistributionChannel]    Script Date: 11/01/2013 09:15:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufnListDistributionChannel]
(
	@OrganisationId int = null,
	@SiteID int = null,
	@ShowLegacy bit = null,
	@ShowBalance bit = null
)
RETURNS 
@Table_Var TABLE 
(	
	RosterCentreID int,
	DepartmentID int,
	Name varchar(128),
	Description varchar(255),
	IsGrouped bit,
	DisplayIndex int,
	IsLegacy bit,
	IsBalance bit,
	HistoricalId int
)
AS
BEGIN
	
	INSERT INTO @Table_Var
	SELECT RC.RosterCentreID, RC.DepartmentID, RC.Name, RC.Description, RC.IsGrouped,
			RC.DisplayIndex, RC.IsLegacy, RC.IsBalance, RC.HistoricalId
	FROM RosterCentre RC 
		INNER JOIN Department D ON D.DepartmentID = RC.DepartmentID
	WHERE D.DepartmentBusinessAreaID = 2 --Is Distribution Channel
	AND (@OrganisationId IS NULL OR D.OrganisationID = @OrganisationId)
	AND (@SiteID IS NULL OR RC.DepartmentID IN (SELECT SD.DepartmentID 
											FROM SiteDepartment as SD INNER JOIN Department as D on SD.DepartmentID=D.DepartmentID and D.DepartmentBusinessAreaID = 2
											WHERE SiteID = @SiteID))
	AND (@ShowLegacy IS NULL OR @ShowLegacy = 1 OR RC.IsLegacy = @ShowLegacy)
	AND (@ShowBalance IS NULL OR @ShowBalance = 1 OR RC.IsBalance = @ShowBalance)
	ORDER BY DisplayIndex
	
	RETURN 

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 19-Sep-2013 HT
	-- Replace Department.IsDistributionChannel BY DepartmentBusinessArea 
	-- 11-Aug-2011 HT
	-- Creating function to select DC.
END
GO
/****** Object:  Table [dbo].[PropertyCompetitor]    Script Date: 11/01/2013 09:15:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PropertyCompetitor](
	[PropertyCompetitorID] [int] IDENTITY(1,1) NOT NULL,
	[PropertyID] [int] NOT NULL,
	[CompetitorID] [int] NOT NULL,
	[ChartSeriesColour] [varchar](50) NOT NULL,
	[IsKeyCompetitor] [bit] NOT NULL,
	[DisplayLowerLimit] [int] NOT NULL,
	[DisplayUpperLimit] [int] NOT NULL,
 CONSTRAINT [PK_PropertyCompetitor] PRIMARY KEY CLUSTERED 
(
	[PropertyCompetitorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[procDeleteProperty]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeleteProperty]
(
	@PropertyId int
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM dbo.Property
	WHERE PropertyId = @PropertyId

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Dec-2012 HT
	-- INIT
END
GO
/****** Object:  Table [dbo].[Source]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Source](
	[SourceID] [int] NOT NULL,
	[SourceGroupID] [int] NOT NULL,
	[SourceName] [nvarchar](255) NOT NULL,
	[Username] [varchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[SleepTime] [int] NOT NULL,
	[Concurrency] [timestamp] NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateUpdated] [smalldatetime] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Source] ADD [SystemName] [varchar](255) NOT NULL
ALTER TABLE [dbo].[Source] ADD  CONSTRAINT [PK_Source] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[procSaveProperty]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procSaveProperty]
(
 @PropertyId int OUTPUT
, @PropName varchar(255)
, @SiteId int
, @IsActive bit = 1
, @CurrentUser varchar(128)
)
AS
BEGIN

	SET NOCOUNT ON

	IF (@PropertyId IS NULL OR @PropertyId = 0)
	BEGIN
	
		INSERT INTO [Property]
			(
			[PropName]
			, [SiteID] 
			, [IsActive] 
			, [DateCreated] 
			, [DateUpdated] 
			, [CreatedBy] 
			, [UpdatedBy]
			)
			VALUES
			(
			@PropName
			, @SiteId
			, @IsActive
			, GETDATE() 
			, GETDATE() 
			, @CurrentUser 
			, @CurrentUser 
			)
			
		SET @PropertyId = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN

		UPDATE 
			[Property]
		SET
			[PropName] = @PropName
			, [SiteID] = @SiteId
			, [IsActive] = @IsActive
			, [DateUpdated] = GETDATE()
			, [UpdatedBy] = @CurrentUser
		WHERE
			[PropertyID] = @PropertyId

	END

	SELECT [Concurrency] FROM [Property] WHERE [PropertyID] = @PropertyId
	
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  Table [dbo].[SourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SourceDomain](
	[SourceDomainID] [int] IDENTITY(1,1) NOT NULL,
	[SourceID] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Url] [varchar](255) NULL,
	[DateFormat] [varchar](50) NULL,
	[Concurrency] [timestamp] NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateUpdated] [smalldatetime] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
 CONSTRAINT [PK_SourceDomain] PRIMARY KEY CLUSTERED 
(
	[SourceDomainID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[procSavePropertyCompetitor]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procSavePropertyCompetitor]
(
@PropertyId int
, @CompetitorId int
, @ChartSeriesColour varchar(50)
, @IsKeyCompetitor bit
, @DisplayLowerLimit int
, @DisplayUpperLimit int
)
AS
BEGIN

	SET NOCOUNT ON

	IF NOT EXISTS (SELECT * FROM dbo.PropertyCompetitor 
					WHERE PropertyId = @PropertyId
					AND CompetitorId = @CompetitorId)
	BEGIN
	
		INSERT INTO [PropertyCompetitor]
		(
			[PropertyID]
			, [CompetitorID]
			, [ChartSeriesColour]
			, [IsKeyCompetitor]
			, [DisplayLowerLimit]
			, [DisplayUpperLimit]
		)
		VALUES
		(
			@PropertyId
			, @CompetitorId
			, @ChartSeriesColour
			, @IsKeyCompetitor
			, @DisplayLowerLimit
			, @DisplayUpperLimit
		)
	END
	ELSE
	BEGIN
		UPDATE 
			[PropertyCompetitor]
		SET 
			ChartSeriesColour = @ChartSeriesColour
			, IsKeyCompetitor = @IsKeyCompetitor
			, DisplayLowerLimit = @DisplayLowerLimit
			, DisplayUpperLimit = @DisplayUpperLimit
		WHERE 
			PropertyId = @PropertyId AND CompetitorId = @CompetitorId
	END
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Dec-2012 TB
	-- Remove CurrencyCode
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procSaveSource]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procSaveSource]
(
 @SourceId int
, @SourceGroupId int
, @SourceName nvarchar(255)
, @SystemName varchar(255)
, @SleepTime int
, @Username varchar(255)
, @Password nvarchar(255)
, @IsActive bit
, @CurrentUser varchar(128)
)
AS
BEGIN

	SET NOCOUNT ON

	IF NOT EXISTS (SELECT * FROM [Source] WHERE SourceID = @SourceId)
	BEGIN
	
		INSERT INTO [Source]
			(
			[SourceID]
			, [SourceGroupID]
			, [SourceName]
			, [SystemName]
			, [SleepTime]
			, [Username]
			, [Password]
			, [IsActive]	
			, [DateCreated] 
			, [DateUpdated] 
			, [CreatedBy] 
			, [UpdatedBy] 
			)
			VALUES
			(
			@SourceId
			, @SourceGroupId
			, @SourceName
			, @SystemName
			, @SleepTime
			, @Username
			, @Password
			, @IsActive	
			, GETDATE() 
			, GETDATE() 
			, @CurrentUser 
			, @CurrentUser 
			)
	END
	ELSE
	BEGIN

		UPDATE 
			[Source]
		SET
			[SourceGroupID] = @SourceGroupId
			, [SourceName] = @SourceName
			, [SystemName] = @SystemName
			, [SleepTime] = @SleepTime
			, [Username] = @Username
			, [Password] = @Password
			, [IsActive] = @IsActive	
			, [DateUpdated] = GETDATE()
			, [UpdatedBy] = @CurrentUser
		WHERE
			[SourceID] = @SourceId

	END

	SELECT [Concurrency] FROM [Source] WHERE [SourceID] = @SourceId
	
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procListSource]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListSource]
( 
@SourceName nvarchar(255)
, @LoadInActive bit
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT	S.SourceID, S.SourceName, S.SystemName, S.SourceGroupID, SG.Name as SourceGroupName, S.SleepTime, S.Username, S.Password, 
			S.IsActive, S.Concurrency, S.DateCreated, S.DateUpdated, S.CreatedBy, S.UpdatedBy
	FROM	dbo.Source S
	INNER JOIN dbo.SourceGroup SG on S.SourceGroupID = SG.SourceGroupID
	WHERE (@SourceName IS NULL OR S.SourceName = @SourceName)
	AND (S.IsActive = 1 OR @LoadInActive = 1)
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procDeletePropertyCompetitor]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeletePropertyCompetitor]
(
	@PropertyId int
	, @CompetitorId int
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM dbo.PropertyCompetitor
	WHERE PropertyId = @PropertyId
	AND CompetitorId = @CompetitorId

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Dec-2012 TB
	-- Remove CurrencyCode
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procListPropertyCompetitor]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListPropertyCompetitor]
(
	@PropertyId int = null
	, @SiteId int = null
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT	PC.PropertyCompetitorID, P1.PropertyID, P1.PropName, P2.PropertyID as CompetitorId, 
		P2.PropName as CompetitorName, PC.ChartSeriesColour, PC.IsKeyCompetitor, PC.DisplayLowerLimit, PC.DisplayUpperLimit
	FROM
		PropertyCompetitor PC
	INNER JOIN dbo.Property AS P1 on P1.PropertyID = PC.PropertyID
	INNER JOIN dbo.Property AS P2 on P2.PropertyID = PC.CompetitorID
	WHERE (@PropertyId IS NULL OR PC.PropertyID = @PropertyId)
	AND (@SiteId IS NULL OR P1.SiteID = @SiteId)
	ORDER BY P1.PropName, P2.PropName
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Dec-2012 TB
	-- Remove CurrencyCode
	-- 14-Nov-2012 HT
	-- Initialize Implementation
END
GO
/****** Object:  Table [dbo].[DomainCurrency]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DomainCurrency](
	[DomainCurrencyID] [int] IDENTITY(1,1) NOT NULL,
	[SourceDomainID] [int] NOT NULL,
	[CurrencyCode] [varchar](10) NULL,
	[Concurrency] [timestamp] NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateUpdated] [smalldatetime] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
 CONSTRAINT [PK_DomainCurrency] PRIMARY KEY CLUSTERED 
(
	[DomainCurrencyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PropertySourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PropertySourceDomain](
	[PropertySourceDomainID] [int] IDENTITY(1,1) NOT NULL,
	[PropertyID] [int] NOT NULL,
	[SourceDomainID] [int] NOT NULL,
	[Code] [nvarchar](100) NULL,
	[SourcePropertyName] [nvarchar](255) NOT NULL,
	[SourceCityName] [nvarchar](255) NULL,
	[CurrencyCode] [varchar](10) NULL,
	[IsActive] [bit] NOT NULL,
	[Concurrency] [timestamp] NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateUpdated] [smalldatetime] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
 CONSTRAINT [PK_PropertySourceDomain] PRIMARY KEY CLUSTERED 
(
	[PropertySourceDomainID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[procListSourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListSourceDomain]
( 
@SourceId int = null
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT	S.SourceID, S.SourceName, SD.SourceDomainID, SD.Name, SD.Url, SD.DateFormat, 
			SD.Concurrency, SD.DateCreated, SD.DateUpdated, SD.CreatedBy, SD.UpdatedBy
	FROM	
		dbo.Source S
	INNER JOIN 
		dbo.SourceDomain SD on S.SourceID = SD.SourceID
	WHERE 
		@SourceId IS NULL OR S.SourceID = @SourceId
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Dec-2012 HT
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procSavePropertySourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procSavePropertySourceDomain]
(
 @PropertySourceDomainID int OUTPUT
, @PropertyID int
, @SourceDomainID int
, @Code nvarchar(100) = NULL
, @SourcePropertyName nvarchar(255)
, @SourceCityName nvarchar(255)
, @CurrencyCode varchar(10)
, @IsActive bit
, @CurrentUser varchar(128)
)
AS
BEGIN
	SET NOCOUNT ON

	IF (@PropertySourceDomainID IS NULL OR @PropertySourceDomainID = 0)
	BEGIN
	
		INSERT INTO [PropertySourceDomain]
			(
			[PropertyID]
			, [SourceDomainID]
			, [Code]
			, [SourcePropertyName]
			, [SourceCityName]
			, [CurrencyCode]
			, [IsActive]	
			, [DateCreated] 
			, [DateUpdated] 
			, [CreatedBy] 
			, [UpdatedBy] 
			)
			VALUES
			(
			@PropertyID
			, @SourceDomainID
			, @Code
			, @SourcePropertyName
			, @SourceCityName
			, @CurrencyCode
			, @IsActive	
			, GETDATE() 
			, GETDATE() 
			, @CurrentUser 
			, @CurrentUser 
			)
			
		SET @PropertySourceDomainID = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN

		UPDATE 
			[PropertySourceDomain]
		SET
			[PropertyID] = @PropertyID
			, [SourceDomainID] = @SourceDomainID
			, [Code] = @Code
			, [SourcePropertyName] = @SourcePropertyName
			, [SourceCityName] = @SourceCityName
			, [CurrencyCode] = @CurrencyCode
			, [IsActive] = @IsActive	
			, [DateUpdated] = GETDATE()
			, [UpdatedBy] = @CurrentUser
		WHERE
			[PropertySourceDomainID] = @PropertySourceDomainID

	END

	SELECT [Concurrency] FROM [PropertySourceDomain] WHERE [PropertySourceDomainID] = @PropertySourceDomainID

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procListSourceOfSite]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListSourceOfSite]
( 
@SiteId int
, @LoadInActive bit
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT DISTINCT	S.SourceID, S.SourceName, S.SystemName, S.SourceGroupID, SG.Name as SourceGroupName, S.SleepTime, S.Username, S.Password, 
			S.IsActive, S.Concurrency, S.DateCreated, S.DateUpdated, S.CreatedBy, S.UpdatedBy
	FROM	dbo.Source S
	INNER JOIN 
		dbo.SourceGroup SG on S.SourceGroupID = SG.SourceGroupID
	INNER JOIN 
		SourceDomain SD on S.SourceID = SD.SourceID
	INNER JOIN 
		PropertySourceDomain PSD on SD.SourceDomainID = PSD.SourceDomainID
	INNER JOIN 
		Property P on PSD.PropertyID = P.PropertyID
	WHERE (P.SiteID = @SiteId)
	AND (S.IsActive = 1 OR @LoadInActive = 1)
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  Table [dbo].[RoomRateHistory]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[RoomRateHistory](
	[RoomRateHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[PropertySourceDomainID] [int] NOT NULL,
	[RateDate] [datetime] NOT NULL,
	[Rate] [money] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[CurrencyCode] [varchar](10) NULL,
 CONSTRAINT [PK_RoomRateHistory] PRIMARY KEY CLUSTERED 
(
	[RoomRateHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RoomRate]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[RoomRate](
	[RoomRateID] [int] IDENTITY(1,1) NOT NULL,
	[PropertySourceDomainID] [int] NOT NULL,
	[RateDate] [datetime] NOT NULL,
	[Rate] [money] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[CurrencyCode] [varchar](10) NULL,
 CONSTRAINT [PK_RoomRate] PRIMARY KEY CLUSTERED 
(
	[RoomRateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PropertySourceDomainParameter]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PropertySourceDomainParameter](
	[PropertySourceDomainParameterId] [int] IDENTITY(1,1) NOT NULL,
	[PropertySourceDomainId] [int] NOT NULL,
	[ParameterName] [varchar](100) NOT NULL,
	[ParameterValue] [varchar](200) NOT NULL,
	[IsRequired] [bit] NOT NULL,
 CONSTRAINT [PK_PropertySourceDomainParameter] PRIMARY KEY CLUSTERED 
(
	[PropertySourceDomainParameterId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[procListAvailableSource]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListAvailableSource]
AS
BEGIN
	SET NOCOUNT ON

	SELECT Distinct	S.SourceID, S.SourceName, S.SystemName, S.SourceGroupID, SG.Name as SourceGroupName, S.SleepTime, S.Username, S.Password, 
			S.IsActive, S.Concurrency, S.DateCreated, S.DateUpdated, S.CreatedBy, S.UpdatedBy
	FROM	dbo.Source S
	INNER JOIN 
		dbo.SourceGroup SG on S.SourceGroupID = SG.SourceGroupID
	INNER JOIN
		dbo.SourceDomain AS SD ON S.SourceID = SD.SourceID
	INNER JOIN
		dbo.PropertySourceDomain AS PSD ON SD.SourceDomainID = PSD.SourceDomainID
	WHERE S.IsActive = 1 AND PSD.IsActive = 1
	
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 29-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procListProperty]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListProperty]
(
	@PropertyId int = null
	, @LoadMappedOnly bit
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT	PropertyID, PropName, SiteID, IsActive, 
			CASE 
			WHEN 
				(SELECT COUNT(*) FROM 
					(SELECT distinct PropertyID FROM dbo.PropertyCompetitor WHERE PropertyID = P.PropertyID
					UNION
					SELECT distinct PropertyID FROM dbo.PropertySourceDomain WHERE PropertyID = P.PropertyID) A
				) > 0 THEN 0 ELSE 1 END AS CanDelete,
			Concurrency, DateCreated, DateUpdated, CreatedBy, UpdatedBy
	FROM	dbo.Property P
	WHERE	(@PropertyId IS NULL OR PropertyID = @PropertyId)
	AND (@LoadMappedOnly = 0 OR SiteID IS NOT NULL)
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Dec-2012 HT
	-- Add @LoadMappedOnly
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procListDomainCurrencyOfSite]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListDomainCurrencyOfSite]
( 
@SiteId int
, @SourceId int 
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT DISTINCT	C.DomainCurrencyID, C.SourceDomainID, SD.Name as SourceDomainName, C.CurrencyCode, 
			C.Concurrency, C.DateCreated, C.DateUpdated, C.CreatedBy, C.UpdatedBy
	FROM	
		dbo.DomainCurrency C
	INNER JOIN 
		dbo.SourceDomain SD on C.SourceDomainID = SD.SourceDomainID
	INNER JOIN 
		dbo.PropertySourceDomain PSD on (SD.SourceDomainID = PSD.SourceDomainID AND C.CurrencyCode = PSD.CurrencyCode)
	INNER JOIN 
		dbo.Property P on P.PropertyID = PSD.PropertyID
	WHERE 
		P.SiteID = @SiteId
	AND SD.SourceID = @SourceId	
	ORDER BY C.CurrencyCode		
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Dec-2012 HT
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procListDomainCurrency]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListDomainCurrency]
( 
@SourceDomainId int = null
, @OnlyAvailable bit
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT Distinct	C.DomainCurrencyID, C.SourceDomainID, SD.Name as SourceDomainName, C.CurrencyCode, 
			C.Concurrency, C.DateCreated, C.DateUpdated, C.CreatedBy, C.UpdatedBy
	FROM	
		dbo.DomainCurrency C
	INNER JOIN 
		dbo.SourceDomain SD on C.SourceDomainID = SD.SourceDomainID
	LEFT OUTER JOIN 
		dbo.PropertySourceDomain PSD on (PSD.SourceDomainID = SD.SourceDomainID AND C.CurrencyCode = PSD.CurrencyCode)
	WHERE 
		@SourceDomainId IS NULL OR C.SourceDomainID = @SourceDomainId
	AND (@OnlyAvailable = 0 OR PSD.PropertySourceDomainID IS NOT NULL)
	ORDER BY C.CurrencyCode		
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Dec-2012 HT
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procListPropertySourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListPropertySourceDomain]
(
	@PropertyId int = null
	, @SourceName nvarchar(255)
	, @SourceDomainName nvarchar(255)
	, @CurrencyCode varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	PS.PropertySourceDomainID, PS.PropertyID, SD.SourceDomainID, SD.Name as SourceDomainName, SD.DateFormat, 
			S.SourceID, S.SourceName, SD.Url, S.Username, S.Password, 
			PS.Code, PS.SourcePropertyName, PS.SourceCityName, ISNULL(PS.IsActive, 0) AS IsActive,
			PS.CurrencyCode, S.SleepTime
	FROM
		dbo.PropertySourceDomain AS PS
	INNER JOIN 
		Property P on PS.PropertyID = P.PropertyID
	INNER JOIN 
		SourceDomain SD on PS.SourceDomainID = SD.SourceDomainID	
	INNER JOIN 
		dbo.Source S on S.SourceID = SD.SourceID	
	WHERE (@PropertyId IS NULL OR P.PropertyID = @PropertyId)
	AND (@SourceName IS NULL OR S.SourceName = @SourceName)
	AND (@SourceDomainName IS NULL OR SD.Name = @SourceDomainName)
	AND (@CurrencyCode IS NULL OR PS.CurrencyCode = @CurrencyCode)

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 05-Nov-2012 HT
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procSaveRoomRateHistory]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procSaveRoomRateHistory]
(
 @RoomRateHistoryID int OUTPUT
, @PropertySourceDomainID int
, @RateDate datetime
, @Rate money
, @ActionDate datetime
, @CurrencyCode varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON

	IF NOT EXISTS (SELECT * FROM [RoomRateHistory] WHERE PropertySourceDomainID = @PropertySourceDomainID AND RateDate = @RateDate AND CurrencyCode = @CurrencyCode)
	BEGIN
	
		INSERT INTO [RoomRateHistory]
			(
			[PropertySourceDomainID]
			, [RateDate]
			, [Rate]
			, [ActionDate]
			, [CurrencyCode]
			)
			VALUES
			(
			@PropertySourceDomainID
			, @RateDate
			, @Rate
			, @ActionDate
			, @CurrencyCode
			)
			
		SET @RoomRateHistoryID = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN

		UPDATE 
			[RoomRateHistory]
		SET
			[PropertySourceDomainID] = @PropertySourceDomainID
			, [RateDate] = @RateDate
			, [Rate] = @Rate
			, [ActionDate] = @ActionDate
			, [CurrencyCode] = @CurrencyCode
		WHERE PropertySourceDomainID = @PropertySourceDomainID 
		AND RateDate = @RateDate 
		AND CurrencyCode = @CurrencyCode

	END


	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procSaveRoomRate]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procSaveRoomRate]
(
 @RoomRateID int OUTPUT
, @PropertySourceDomainID int
, @RateDate datetime
, @Rate money
, @ActionDate datetime
, @CurrencyCode varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON

	IF NOT EXISTS (SELECT * FROM [RoomRate] WHERE PropertySourceDomainID = @PropertySourceDomainID AND RateDate = @RateDate AND CurrencyCode = @CurrencyCode)
	BEGIN
	
		INSERT INTO [RoomRate]
			(
			[PropertySourceDomainID]
			, [RateDate]
			, [Rate]
			, [ActionDate]
			, [CurrencyCode]
			)
			VALUES
			(
			@PropertySourceDomainID
			, @RateDate
			, @Rate
			, @ActionDate
			, @CurrencyCode
			)
			
		SET @RoomRateID = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN

		UPDATE 
			[RoomRate]
		SET
			[PropertySourceDomainID] = @PropertySourceDomainID
			, [RateDate] = @RateDate
			, [Rate] = @Rate
			, [ActionDate] = @ActionDate
			, [CurrencyCode] = @CurrencyCode
		WHERE PropertySourceDomainID = @PropertySourceDomainID 
		AND RateDate = @RateDate
		AND CurrencyCode = @CurrencyCode
	END


	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 05-Nov-2012 HT
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procSavePropertySourceDomainParameter]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procSavePropertySourceDomainParameter]
(
@PropertySourceDomainParameterId int OUTPUT
, @PropertySourceDomainId int
, @ParameterName varchar(100)
, @ParameterValue varchar(200)
, @IsRequired bit
)
AS
BEGIN

	SET NOCOUNT ON

	IF (@PropertySourceDomainParameterId IS NULL OR @PropertySourceDomainParameterId = 0)
	BEGIN
	
		INSERT INTO [PropertySourceDomainParameter]
			(
			[PropertySourceDomainId]
			, [ParameterName]
			, [ParameterValue]
			, [IsRequired]
			)
			VALUES
			(
			@PropertySourceDomainId
			, @ParameterName
			, @ParameterValue
			, @IsRequired
			)
	END
	ELSE
	BEGIN

		UPDATE 
			[PropertySourceDomainParameter]
		SET
			[PropertySourceDomainId] = @PropertySourceDomainId
			, [ParameterName] = @ParameterName
			, [ParameterValue] = @ParameterValue
			, [IsRequired] = @IsRequired
		WHERE
			PropertySourceDomainParameterId = @PropertySourceDomainParameterId

	END
	
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procListRoomRateHistory]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListRoomRateHistory]
(
@SiteId	int
, @SourceId int
, @CurrencyCode varchar(10)
, @SelectedCompetitorIds varchar (MAX)
, @DateStart datetime
, @DateEnd datetime = null
, @FromDate datetime = null
)
AS BEGIN	
		
	DECLARE @_PropertySourceDomain TABLE
	(
		PropertySourceDomainId int
		, PropertyId int
		, CurrencyCode varchar(10)
		, CompName varchar(255)
		, IsCompetitor bit
		, ChartSeriesColour varchar(50)
	)		
	INSERT INTO @_PropertySourceDomain
	SELECT distinct PS.PropertySourceDomainID, P.PropertyID, PS.CurrencyCode, P.PropName, 
		CASE WHEN P.SiteID = SiteID THEN 0 ELSE 1 END,
		PC.ChartSeriesColour
	FROM PropertySourceDomain PS
	INNER JOIN SourceDomain SD on PS.SourceDomainID = SD.SourceDomainID
	INNER JOIN Property P on PS.PropertyID = P.PropertyID
	LEFT OUTER JOIN [dbo].[ufnSplit] (',', @SelectedCompetitorIds) C on C.Token = PS.PropertyID
	LEFT OUTER JOIN PropertyCompetitor PC on P.PropertyID = PC.PropertyID AND PS.PropertyID = PC.CompetitorID
	WHERE SD.SourceID = @SourceId
	AND PS.CurrencyCode = @CurrencyCode
	AND (P.SiteID = @SiteId OR C.Token IS NOT NULL)
		
	DECLARE @_ActionDateHistory TABLE
	(
		PropertySourceDomainId int
		, RateDate smalldatetime
		, MaxActionDate datetime
	)	
	INSERT INTO @_ActionDateHistory
	SELECT 
		R.PropertySourceDomainID,
		R.RateDate,
		Max(R.ActionDate)
	FROM [dbo].[RoomRateHistory] AS R 
	INNER JOIN @_PropertySourceDomain PS on R.PropertySourceDomainID = PS.PropertySourceDomainId	
	WHERE	R.RateDate >= @DateStart
	AND		(@DateEnd IS NULL OR R.RateDate <= @DateEnd)
	AND		(@FromDate IS NULL OR R.ActionDate <= @FromDate)
	GROUP BY R.PropertySourceDomainID, R.RateDate
	
	-- Get COALESCE RATE for Competitor
	SELECT 
		R.RoomRateHistoryID,
		R.PropertySourceDomainID,
		R.RateDate,
		R.Rate,
		R.ActionDate,
		R.CurrencyCode
	FROM [dbo].[RoomRateHistory] AS R 	
	INNER JOIN @_ActionDateHistory H on R.PropertySourceDomainID = H.PropertySourceDomainId
								AND R.RateDate = H.RateDate
								AND R.ActionDate = H.MaxActionDate
	WHERE	R.RateDate >= @DateStart
	AND		(@DateEnd IS NULL OR R.RateDate <= @DateEnd)	
	ORDER BY
		R.RateDate

	-- ======================================================================
	-- Change History
	-- ======================================================================
	-- 11-SEP-2013 HT
	-- INIT

END
GO
/****** Object:  StoredProcedure [dbo].[procListPropertySourceDomainParameter]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListPropertySourceDomainParameter]
(
	@PropertySourceDomainId int
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	PropertySourceDomainParameterId, PropertySourceDomainId, ParameterName, ParameterValue, IsRequired
	FROM
		dbo.PropertySourceDomainParameter
	WHERE PropertySourceDomainId = @PropertySourceDomainId

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procListCompetitorRateCoalesce]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListCompetitorRateCoalesce]
(
@SiteId	int
, @SourceId int
, @CurrencyCode varchar(10)
, @SelectedCompetitorIds varchar (MAX)
, @DateStart datetime
, @DateEnd datetime = null
)
AS BEGIN	
		
	DECLARE @_PropertySourceDomain TABLE
	(
		PropertySourceDomainId int
		, PropertyId int
		, CurrencyCode varchar(10)
		, CompName varchar(255)
		, IsCompetitor bit
		, ChartSeriesColour varchar(50)
	)		
	INSERT INTO @_PropertySourceDomain
	SELECT distinct PS.PropertySourceDomainID, P.PropertyID, PS.CurrencyCode, P.PropName, 
		CASE WHEN P.SiteID = SiteID THEN 0 ELSE 1 END,
		PC.ChartSeriesColour
	FROM PropertySourceDomain PS
	INNER JOIN SourceDomain SD on PS.SourceDomainID = SD.SourceDomainID
	INNER JOIN Property P on PS.PropertyID = P.PropertyID
	LEFT OUTER JOIN [dbo].[ufnSplit] (',', @SelectedCompetitorIds) C on C.Token = PS.PropertyID
	LEFT OUTER JOIN PropertyCompetitor PC on P.PropertyID = PC.PropertyID AND PS.PropertyID = PC.CompetitorID
	WHERE SD.SourceID = @SourceId
	AND PS.CurrencyCode = @CurrencyCode
	AND (P.SiteID = @SiteId OR C.Token IS NOT NULL)
		
	-- Create table @CompetitorRateLastFound to store all last records from CompetitorRateHistory	
	DECLARE @CompetitorRateLastFound AS TABLE
	(
		ID int identity(1,1),
		PropertySourceDomainId int,
		RateDate datetime NOT NULL,
		DateUpdated datetime NOT NULL
	)	
	INSERT INTO @CompetitorRateLastFound(PropertySourceDomainId, RateDate, DateUpdated)
	SELECT H.PropertySourceDomainID, H.RateDate, max(H.ActionDate)
	FROM RoomRateHistory H
	INNER JOIN @_PropertySourceDomain PS on H.PropertySourceDomainID = PS.PropertySourceDomainId
	WHERE	RateDate >= @DateStart
	AND		(@DateEnd IS NULL OR RateDate <= @DateEnd)
	GROUP BY H.PropertySourceDomainID, H.RateDate		
		
	-- Create table @CompetitorRatePrevious to store lastest rates which different with current rate.
	DECLARE @CompetitorRatePrevious  AS TABLE
	(
		PropertySourceDomainId int,
		RateDate datetime NOT NULL,
		Rate decimal
	)	
	INSERT INTO @CompetitorRatePrevious(PropertySourceDomainId, RateDate, Rate)
	SELECT CRH.PropertySourceDomainID, CRH.RateDate, CRH.Rate
	FROM RoomRateHistory CRH
	INNER JOIN (
		SELECT H.PropertySourceDomainID, H.RateDate, max(H.ActionDate) as LastestDateUpdated
		FROM RoomRateHistory H
		INNER JOIN @_PropertySourceDomain PS on H.PropertySourceDomainID = PS.PropertySourceDomainId
		WHERE	H.RateDate >= @DateStart
		AND		(@DateEnd IS NULL OR RateDate <= @DateEnd)
		AND		H.Rate <> (SELECT Rate from [dbo].[RoomRate] R 
							WHERE R.RateDate = H.RateDate
							AND R.PropertySourceDomainID = H.PropertySourceDomainID)
		GROUP BY H.PropertySourceDomainID, RateDate	
	) as A on CRH.PropertySourceDomainID = A.PropertySourceDomainID 
			AND CRH.RateDate = A.RateDate AND CRH.ActionDate = A.LastestDateUpdated
		
		
	-- Get COALESCE RATE for Competitor
	SELECT 
		PS.PropertySourceDomainId
		, PS.PropertyId
		, PS.CompName
		, PS.ChartSeriesColour
		, R.RateDate AS RateDate
		, CASE WHEN R.Rate != 0 THEN R.Rate ELSE 
			CASE WHEN CRH.Rate IS NULL THEN 0 ELSE CRH.Rate END
		  END AS Rate
		, PS.IsCompetitor
		, ISNULL(P.Rate,0) as PreviousRate
		, PS.CurrencyCode
	FROM [dbo].[RoomRate] AS R 
	INNER JOIN @_PropertySourceDomain PS on R.PropertySourceDomainID = PS.PropertySourceDomainId
	LEFT OUTER JOIN		
		(
		SELECT CRH.PropertySourceDomainID, CRH.RateDate, CRH.Rate
		FROM RoomRateHistory CRH
		INNER JOIN @CompetitorRateLastFound CRLF 
			ON CRH.PropertySourceDomainID = CRLF.PropertySourceDomainId AND CRH.RateDate = CRLF.RateDate AND CRH.ActionDate = CRLF.DateUpdated
		) AS CRH ON CRH.PropertySourceDomainID = R.PropertySourceDomainID AND CRH.RateDate = R.RateDate
	LEFT OUTER JOIN 
		@CompetitorRatePrevious as P
		ON  P.PropertySourceDomainID = R.PropertySourceDomainID AND P.RateDate = R.RateDate
	WHERE	R.RateDate >= @DateStart
	AND		(@DateEnd IS NULL OR R.RateDate <= @DateEnd)	
	ORDER BY
		PS.IsCompetitor, PS.CompName, R.RateDate

	-- ======================================================================
	-- Change History
	-- ======================================================================
	-- 23-NOV-2012 HT
	-- INIT

END
GO
/****** Object:  StoredProcedure [dbo].[procListChangedCompetitorRate]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procListChangedCompetitorRate]
(
@PropertySourceDomainId int
, @DateStart datetime
, @DateEnd datetime = null
)
AS BEGIN	
		
	DECLARE @_DateToday smalldatetime			
	SELECT	@_DateToday = DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())) 	
			
	DECLARE @_PropertySourceDomain TABLE
	(
		PropertySourceDomainId int
		, PropertyId int
		, CurrencyCode varchar(10)
		, CompName varchar(255)
		, IsCompetitor bit
		, ChartSeriesColour varchar(50)
	)		
	INSERT INTO @_PropertySourceDomain
	SELECT distinct PS.PropertySourceDomainID, P.PropertyID, PS.CurrencyCode, P.PropName, 
		CASE WHEN P.SiteID = SiteID THEN 0 ELSE 1 END,
		PC.ChartSeriesColour
	FROM PropertySourceDomain PS
	INNER JOIN Property P on PS.PropertyID = P.PropertyID
	LEFT OUTER JOIN PropertyCompetitor PC on P.PropertyID = PC.PropertyID AND PS.PropertyID = PC.CompetitorID
	WHERE PS.PropertySourceDomainID = @PropertySourceDomainId		
	
	-- Create table @CompetitorRateLastFound to store all last records from CompetitorRateHistory	
	DECLARE @CompetitorRateLastFound AS TABLE
	(
		ID int identity(1,1),
		PropertySourceDomainId int,
		RateDate datetime NOT NULL,
		DateUpdated datetime NOT NULL
	)	
	INSERT INTO @CompetitorRateLastFound(PropertySourceDomainId, RateDate, DateUpdated)
	SELECT H.PropertySourceDomainID, H.RateDate, max(H.ActionDate)
	FROM RoomRateHistory H
	INNER JOIN @_PropertySourceDomain PS on H.PropertySourceDomainID = PS.PropertySourceDomainId
	WHERE	RateDate >= @DateStart
	AND (@DateEnd IS NULL OR RateDate <= @DateEnd)
	GROUP BY H.PropertySourceDomainID, H.RateDate
		
	-- Get COALESCE RATE for Competitor
	SELECT 
		PS.PropertySourceDomainId
		, PS.PropertyId
		, PS.CompName
		, PS.ChartSeriesColour
		, R.RateDate AS RateDate
		, R.Rate
		, PS.IsCompetitor
		, ISNULL(CRH.Rate,0) as PreviousRate
		, PS.CurrencyCode
	FROM [dbo].[RoomRate] AS R 
	INNER JOIN @_PropertySourceDomain PS on R.PropertySourceDomainID = PS.PropertySourceDomainId
	LEFT OUTER JOIN		
		(
		SELECT CRH.PropertySourceDomainID, CRH.RateDate, CRH.Rate
		FROM RoomRateHistory CRH
		INNER JOIN @CompetitorRateLastFound CRLF 
			ON CRH.PropertySourceDomainID = CRLF.PropertySourceDomainId AND CRH.RateDate = CRLF.RateDate AND CRH.ActionDate = CRLF.DateUpdated
		) AS CRH ON CRH.PropertySourceDomainID = R.PropertySourceDomainID AND CRH.RateDate = R.RateDate
	WHERE	R.RateDate >= @DateStart
	AND (@DateEnd IS NULL OR R.RateDate <= @DateEnd)		
	AND	  R.ActionDate >= @_DateToday
	AND   R.Rate <> CRH.Rate
	ORDER BY
		PS.IsCompetitor, PS.CompName, R.RateDate

	-- ======================================================================
	-- Change History
	-- ======================================================================
	-- 11-DEC-2012 HT
	-- INIT to get all rates which are changed for each Property Source

END
GO
/****** Object:  StoredProcedure [dbo].[procDeletePropertySourceDomainParameter]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeletePropertySourceDomainParameter]
(
	@PropertySourceDomainParameterId int
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM dbo.PropertySourceDomainParameter
	WHERE PropertySourceDomainParameterId = @PropertySourceDomainParameterId

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 25-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procDeletePropertySourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeletePropertySourceDomain]
(
	@PropertySourceDomainId int
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM dbo.RoomRate
	WHERE PropertySourceDomainId = @PropertySourceDomainId
	
	DELETE FROM dbo.RoomRateHistory
	WHERE PropertySourceDomainId = @PropertySourceDomainId
	
	DELETE FROM dbo.PropertySourceDomainParameter
	WHERE PropertySourceDomainId = @PropertySourceDomainId
	
	DELETE FROM dbo.PropertySourceDomain
	WHERE PropertySourceDomainId = @PropertySourceDomainId

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 20-DEC-2012 HT
	-- Delete RoomRate, RoomRateHistory, PropertySourceDomainParameter first
	-- 05-Nov-2012 TB
	-- Initialize Implementation
END
GO
/****** Object:  StoredProcedure [dbo].[procCopyRoomRateToHistory]    Script Date: 11/01/2013 09:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procCopyRoomRateToHistory]
(
 @PropertySourceDomainID int
, @DateStart datetime
, @DateEnd datetime
)
AS
BEGIN
	SET NOCOUNT ON
	--Fill the latest rate in history
	DECLARE @_RateHistory TABLE
	(
		PropertySourceDomainId int
		, RateDate smalldatetime
		, Rate money
	)	
	INSERT INTO @_RateHistory
	SELECT [PropertySourceDomainID], [RateDate], [Rate]
	FROM RoomRateHistory H 	
	WHERE H.PropertySourceDomainID = @PropertySourceDomainID
	AND H.RateDate BETWEEN @DateStart AND @DateEnd 
	AND H.ActionDate = (SELECT max(ActionDate)
						FROM RoomRateHistory 
						WHERE PropertySourceDomainID = H.PropertySourceDomainID
						AND RateDate = H.RateDate)
	
	--only insert the rates which are different with the latest rates in history :
	INSERT INTO [RoomRateHistory]([PropertySourceDomainID], [RateDate], [Rate], [ActionDate], [CurrencyCode])
	SELECT R.[PropertySourceDomainID], R.[RateDate], R.[Rate], R.[ActionDate], R.[CurrencyCode]
	FROM RoomRate R
	LEFT OUTER JOIN @_RateHistory H on (R.PropertySourceDomainID = H.PropertySourceDomainId AND R.RateDate = H.RateDate)
	WHERE R.PropertySourceDomainID = @PropertySourceDomainID
	AND R.RateDate BETWEEN @DateStart AND @DateEnd
	AND (H.Rate IS NULL OR H.Rate <> R.Rate)
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 23-Nov-2012 HT
	-- Initialize Implementation
	
END
GO
/****** Object:  Default [DF_SourceGroup_DateCreated]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[SourceGroup] ADD  CONSTRAINT [DF_SourceGroup_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_SourceGroup_DateUpdated]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[SourceGroup] ADD  CONSTRAINT [DF_SourceGroup_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO
/****** Object:  Default [DF_SourceGroup_CreatedBy]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[SourceGroup] ADD  CONSTRAINT [DF_SourceGroup_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
/****** Object:  Default [DF_SourceGroup_UpdatedBy]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[SourceGroup] ADD  CONSTRAINT [DF_SourceGroup_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
/****** Object:  Default [DF_Property_IsActive]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[Property] ADD  CONSTRAINT [DF_Property_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_Property_DateCreated]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[Property] ADD  CONSTRAINT [DF_Property_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_Property_DateUpdated]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[Property] ADD  CONSTRAINT [DF_Property_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO
/****** Object:  Default [DF_Property_CreatedBy]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[Property] ADD  CONSTRAINT [DF_Property_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
/****** Object:  Default [DF_Property_UpdatedBy]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[Property] ADD  CONSTRAINT [DF_Property_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
/****** Object:  Default [DF_Source_IsActive]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[Source] ADD  CONSTRAINT [DF_Source_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_Source_SleepTime]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[Source] ADD  CONSTRAINT [DF_Source_SleepTime]  DEFAULT ((5)) FOR [SleepTime]
GO
/****** Object:  Default [DF_Source_DateCreated]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[Source] ADD  CONSTRAINT [DF_Source_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_Source_DateUpdated]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[Source] ADD  CONSTRAINT [DF_Source_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO
/****** Object:  Default [DF_Source_CreatedBy]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[Source] ADD  CONSTRAINT [DF_Source_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
/****** Object:  Default [DF_Source_UpdatedBy]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[Source] ADD  CONSTRAINT [DF_Source_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
/****** Object:  Default [DF_SourceDomain_DateCreated]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[SourceDomain] ADD  CONSTRAINT [DF_SourceDomain_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_SourceDomain_DateUpdated]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[SourceDomain] ADD  CONSTRAINT [DF_SourceDomain_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO
/****** Object:  Default [DF_SourceDomain_CreatedBy]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[SourceDomain] ADD  CONSTRAINT [DF_SourceDomain_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
/****** Object:  Default [DF_SourceDomain_UpdatedBy]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[SourceDomain] ADD  CONSTRAINT [DF_SourceDomain_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
/****** Object:  Default [DF_DomainCurrency_DateCreated]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[DomainCurrency] ADD  CONSTRAINT [DF_DomainCurrency_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_DomainCurrency_DateUpdated]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[DomainCurrency] ADD  CONSTRAINT [DF_DomainCurrency_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO
/****** Object:  Default [DF_DomainCurrency_CreatedBy]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[DomainCurrency] ADD  CONSTRAINT [DF_DomainCurrency_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
/****** Object:  Default [DF_DomainCurrency_UpdatedBy]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[DomainCurrency] ADD  CONSTRAINT [DF_DomainCurrency_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
/****** Object:  Default [DF_PropertySourceDomain_IsActive]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[PropertySourceDomain] ADD  CONSTRAINT [DF_PropertySourceDomain_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_PropertySourceDomain_DateCreated]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[PropertySourceDomain] ADD  CONSTRAINT [DF_PropertySourceDomain_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_PropertySourceDomain_DateUpdated]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[PropertySourceDomain] ADD  CONSTRAINT [DF_PropertySourceDomain_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO
/****** Object:  Default [DF_PropertySourceDomain_CreatedBy]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[PropertySourceDomain] ADD  CONSTRAINT [DF_PropertySourceDomain_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
/****** Object:  Default [DF_PropertySourceDomain_UpdatedBy]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[PropertySourceDomain] ADD  CONSTRAINT [DF_PropertySourceDomain_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
/****** Object:  ForeignKey [FK_PropertyCompetitor_Property]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[PropertyCompetitor]  WITH CHECK ADD  CONSTRAINT [FK_PropertyCompetitor_Property] FOREIGN KEY([PropertyID])
REFERENCES [dbo].[Property] ([PropertyID])
GO
ALTER TABLE [dbo].[PropertyCompetitor] CHECK CONSTRAINT [FK_PropertyCompetitor_Property]
GO
/****** Object:  ForeignKey [FK_PropertyCompetitor_Property1]    Script Date: 11/01/2013 09:15:21 ******/
ALTER TABLE [dbo].[PropertyCompetitor]  WITH CHECK ADD  CONSTRAINT [FK_PropertyCompetitor_Property1] FOREIGN KEY([CompetitorID])
REFERENCES [dbo].[Property] ([PropertyID])
GO
ALTER TABLE [dbo].[PropertyCompetitor] CHECK CONSTRAINT [FK_PropertyCompetitor_Property1]
GO
/****** Object:  ForeignKey [FK_Source_SourceGroup]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[Source]  WITH CHECK ADD  CONSTRAINT [FK_Source_SourceGroup] FOREIGN KEY([SourceGroupID])
REFERENCES [dbo].[SourceGroup] ([SourceGroupID])
GO
ALTER TABLE [dbo].[Source] CHECK CONSTRAINT [FK_Source_SourceGroup]
GO
/****** Object:  ForeignKey [FK_SourceDomain_Source]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[SourceDomain]  WITH CHECK ADD  CONSTRAINT [FK_SourceDomain_Source] FOREIGN KEY([SourceID])
REFERENCES [dbo].[Source] ([SourceID])
GO
ALTER TABLE [dbo].[SourceDomain] CHECK CONSTRAINT [FK_SourceDomain_Source]
GO
/****** Object:  ForeignKey [FK_DomainCurrency_SourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[DomainCurrency]  WITH CHECK ADD  CONSTRAINT [FK_DomainCurrency_SourceDomain] FOREIGN KEY([SourceDomainID])
REFERENCES [dbo].[SourceDomain] ([SourceDomainID])
GO
ALTER TABLE [dbo].[DomainCurrency] CHECK CONSTRAINT [FK_DomainCurrency_SourceDomain]
GO
/****** Object:  ForeignKey [FK_PropertySourceDomain_Property]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[PropertySourceDomain]  WITH CHECK ADD  CONSTRAINT [FK_PropertySourceDomain_Property] FOREIGN KEY([PropertyID])
REFERENCES [dbo].[Property] ([PropertyID])
GO
ALTER TABLE [dbo].[PropertySourceDomain] CHECK CONSTRAINT [FK_PropertySourceDomain_Property]
GO
/****** Object:  ForeignKey [FK_PropertySourceDomain_SourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[PropertySourceDomain]  WITH CHECK ADD  CONSTRAINT [FK_PropertySourceDomain_SourceDomain] FOREIGN KEY([SourceDomainID])
REFERENCES [dbo].[SourceDomain] ([SourceDomainID])
GO
ALTER TABLE [dbo].[PropertySourceDomain] CHECK CONSTRAINT [FK_PropertySourceDomain_SourceDomain]
GO
/****** Object:  ForeignKey [FK_RoomRateHistory_PropertySourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[RoomRateHistory]  WITH CHECK ADD  CONSTRAINT [FK_RoomRateHistory_PropertySourceDomain] FOREIGN KEY([PropertySourceDomainID])
REFERENCES [dbo].[PropertySourceDomain] ([PropertySourceDomainID])
GO
ALTER TABLE [dbo].[RoomRateHistory] CHECK CONSTRAINT [FK_RoomRateHistory_PropertySourceDomain]
GO
/****** Object:  ForeignKey [FK_RoomRate_PropertySourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[RoomRate]  WITH CHECK ADD  CONSTRAINT [FK_RoomRate_PropertySourceDomain] FOREIGN KEY([PropertySourceDomainID])
REFERENCES [dbo].[PropertySourceDomain] ([PropertySourceDomainID])
GO
ALTER TABLE [dbo].[RoomRate] CHECK CONSTRAINT [FK_RoomRate_PropertySourceDomain]
GO
/****** Object:  ForeignKey [FK_PropertySourceDomainParameter_PropertySourceDomain]    Script Date: 11/01/2013 09:15:22 ******/
ALTER TABLE [dbo].[PropertySourceDomainParameter]  WITH CHECK ADD  CONSTRAINT [FK_PropertySourceDomainParameter_PropertySourceDomain] FOREIGN KEY([PropertySourceDomainId])
REFERENCES [dbo].[PropertySourceDomain] ([PropertySourceDomainID])
GO
ALTER TABLE [dbo].[PropertySourceDomainParameter] CHECK CONSTRAINT [FK_PropertySourceDomainParameter_PropertySourceDomain]
GO
