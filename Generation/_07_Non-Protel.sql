/**********************************************************************************
NOTE : this script is run only when Synergi doesn't use Protel.
*************************************************************************************/

USE Synergi
GO

/****** Object:  StoredProcedure [dbo].[procListPmsRoomType]    Script Date: 10/02/2012 16:58:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[procListPmsRoomType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[procListPmsRoomType]
GO
CREATE PROCEDURE [dbo].[procListPmsRoomType]

AS BEGIN

	SET NOCOUNT ON
	
		SELECT	
			RoomTypeId as Id
			, Name as PmsKey
			, Description as Name
		FROM RoomType	
END
GO



ALTER PROCEDURE [dbo].[procListRateAvailability2]
(
	@SiteID int,
	@DateStart smalldatetime = NULL,
	@DateEnd smalldatetime = NULL
)
AS 
BEGIN

	SET NOCOUNT ON

	SELECT 
		YL.Code as YieldLevel
		, RG.Code as RateGroup
		, RC.Code as RateCode
		, RT.Name as RT	
		, MIN(DateStart) AS DateStart
		, MAX(DateEnd) AS DateEnd
		, REPLACE(REPLACE(ISNULL(RA.Pattern, '?'), '{0}', BR.Param1), '{1}', BR.Param2) as Status
		, 1 AS EntryLevel
	FROM BookingRule as BR
	INNER JOIN RateCodeRoomType as RCRT on BR.RateCodeRoomTypeId = RCRT.RateCodeRoomTypeId
	INNER JOIN RoomType as RT on RT.RoomTypeId = RCRT.RoomTypeId
	INNER JOIN RateCode RC on RC.RateCodeId = RCRT.RateCodeId
	INNER JOIN RateGroup RG on RG.RateGroupId = RC.RateGroupId
	INNER JOIN SiteYieldLevel YL on YL.SiteYieldLevelId = RG.SiteYieldLevelId	
	LEFT OUTER JOIN dbo.RateAvailType as RA on RA.TypeID = BR.RateAvailTypeId
	WHERE (@SiteId is null OR BR.SiteId = @SiteId)
		AND (BR.DateEnd IS NULL OR BR.DateEnd >= @DateStart)
		AND BR.DateStart <= @DateEnd
		AND (YL.IsLegacy = 0 AND RG.IsLegacy = 0 AND RC.IsLegacy = 0 AND RCRT.IsLegacy = 0)
	GROUP BY 
		YL.Code
		, YL.Priority
		, RG.Code
		, RC.Code
		, RT.Name	
		, RA.Pattern
		, BR.Param1
		, BR.Param2
	ORDER BY 
		YL.Priority
		, RG.Code
		, RC.Code
		, RT.Name
		
	-- ======================================================================
	-- Change History
	-- ====================================================================== 
	-- 07-NOV-2013 HT
	-- INIT : use only for Non-Protel, In Yield Leve Pane page
			
END
GO

