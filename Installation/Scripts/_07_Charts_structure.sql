/**********************************************************************************
- Destination: Server Instance that contains SYNERGI database.
*************************************************************************************/

/****** Object:  Schema [ChartsSchema]    Script Date: 07/12/2012 11:52:34 ******/
CREATE SCHEMA [ChartsSchema] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Charts]    Script Date: 07/12/2012 11:52:34 ******/
CREATE SCHEMA [Charts] AUTHORIZATION [dbo]
GO

/****** Object:  Table [Charts].[DistributionChannel]    Script Date: 07/12/2012 11:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Charts].[DistributionChannel](
	[DistributionChannelID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateUpdated] [smalldatetime] NOT NULL,
	[CreatedBy] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
	[UpdatedBy] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
 CONSTRAINT [PK_DistributionChannel] PRIMARY KEY CLUSTERED 
(
	[DistributionChannelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO


/****** Object:  View [ChartsSchema].[vwStayDay]    Script Date: 07/12/2012 11:55:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [ChartsSchema].[vwStayDay]
AS 

	SELECT     
		SD.PropCode
		, SD.EventDate
		, SD.RmNt 
		, SD.TotalAccomm AS AccomRevenue
		, SD.TotalRevenue
		, SD.CompanyKey
		, SD.AgentCode1

--		, SD.RoomType
--		, S.BookDate
--		, SD.TotalAccomm
--        , CASE WHEN (S.GroupName = '') THEN 0 ELSE SD.RmNt END AS GroupQuantity
--		, 0 AS LowYieldQuantity 
	FROM
		Charts.dbo.StayDay AS SD WITH (NOLOCK)
	INNER JOIN
		Charts.dbo.Stay AS S WITH (NOLOCK)
		ON SD.KeyCode = S.KeyCode
	WHERE
		NOT (S.Sharer = 'Y' AND S.TotalAccomm = 0)
		AND (SD.RoomType NOT LIKE '![%' ESCAPE '!')		-- Exclude 'dummy' room types, i.e. those beginning with '[', e.g. '[CP'
		AND (SD.RoomType NOT LIKE '!*%' ESCAPE '!')
		AND (SD.RmNt IS NOT NULL)

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 07-Nov-2010 EJM
	-- Task 510: Rewrite to return charts data for Materialisation in the same
	-- format as already taken from Protel
GO
/****** Object:  View [Charts].[vwStayDay]    Script Date: 07/12/2012 11:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Charts].[vwStayDay]
AS
      SELECT    
            SD.PropCode
            , SD.RoomType
            , SD.EventDate AS Date
            , SD.RmNt AS Quantity
            , S.BookDate
            , SD.TotalAccomm
            , SD.TotalAccomm AS AccomRevenue
            , SD.TotalRevenue
            , CASE WHEN (S.GroupName = '') THEN 0 ELSE SD.RmNt END AS GroupQuantity
			, 0 AS LowYieldQuantity 
      FROM
            Charts.dbo.StayDay AS SD WITH (NOLOCK)
      INNER JOIN
            Charts.dbo.Stay AS S WITH (NOLOCK)
            ON SD.KeyCode = S.KeyCode
      WHERE
            NOT (S.Sharer = 'Y' AND S.TotalAccomm = 0)
            AND (SD.RoomType NOT LIKE '![%' ESCAPE '!')           -- Exclude 'dummy' room types, i.e. those beginning with '[', e.g. '[CP'
            AND (SD.RoomType NOT LIKE '!*%' ESCAPE '!')
            AND (SD.RmNt IS NOT NULL)
GO
/****** Object:  View [Charts].[vwStay]    Script Date: 07/12/2012 11:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Charts].[vwStay]
AS
SELECT     s.KeyCode, s.ArrDate, s.DepDate, s.LastName, s.FirstName, s.MktgAreaCode, s.MktgAreaName, s.AgentCode1, s.AgentName1, s.AgentCatg1, 
                      s.TotalAccomm AS StayTotalAccomm, s.TotalAccomm AS StayAccomRevenue, s.TotalRevenue As StayTotalRevenue, sd.EventDate, sd.PropCode, sd.RoomType, sd.Company, sd.GtNt, sd.RmNt, sd.Arrv, sd.TotalAccomm, sd.TotalAccomm AS AccomRevenue, sd.TotalRevenue, 
                      s.BookDate, s.Sharer, s.StaySubType
FROM         Charts.dbo.StayDay AS sd WITH (NOLOCK) 
INNER JOIN
                      Charts.dbo.Stay AS s WITH (NOLOCK) 
ON s.KeyCode = sd.KeyCode
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "sd"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 344
               Right = 196
            End
            DisplayFlags = 280
            TopColumn = 33
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 231
               Bottom = 346
               Right = 413
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1470
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Charts', @level1type=N'VIEW',@level1name=N'vwStay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Charts', @level1type=N'VIEW',@level1name=N'vwStay'
GO

/****** Object:  UserDefinedFunction [ChartsSchema].[ufnListCompanyDivision]    Script Date: 07/12/2012 11:55:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [ChartsSchema].[ufnListCompanyDivision]
(
	@SiteID INT,
	@PMSID INT
)
RETURNS TABLE
AS 
	
	RETURN
	SELECT  
		1 AS PmsID -- Charts PmsId
		, KeyCode AS PmsProfileKey 
		, 'Agent' AS PmsProfileType
		, [Name] AS CompanyName
		, '' AS MasterName
		, ISNULL((Address1 + ' ' + Address2 + ' ' + City + ' ' + State + ' ' + PostCode), '') AS Address
	FROM
		Charts.dbo.Agent 

	UNION

	SELECT	
		1 AS PmsID -- Charts PmsId
		, CAST(ID AS VARCHAR(50)) AS PmsProfileKey
		, 'Company' AS PmsProfileType
		, Company AS CompanyName
		, '' AS MasterName
		, ISNULL((Address1 + ' ' + Address2 + ' ' + City + ' ' + State + ' ' + PostCode), '') AS Address
	FROM	
		Charts.dbo.Company

	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 04-Sep-2011 EJM
	-- Refactor into ChartsSchema.
GO

