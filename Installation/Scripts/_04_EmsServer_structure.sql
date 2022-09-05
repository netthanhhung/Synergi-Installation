/**********************************************************************************
- Destination: Server Instance that contains SYNERGI database.

- This script does the following:
1) [ufnSelectEnergyDelivered] 
2) [procImportEnergyDelivered]  
*************************************************************************************/


/****** Object:  UserDefinedFunction [dbo].[ufnSelectEnergyDelivered]    Script Date: 07/13/2012 09:43:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufnSelectEnergyDelivered]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufnSelectEnergyDelivered]
GO
CREATE FUNCTION [dbo].[ufnSelectEnergyDelivered]
(
@OrganisationId int
, @DateTimeEndUtc smalldatetime
)
RETURNS @Result TABLE
(
SiteId int
, SubCentreId int
, TimeStampUtc smalldatetime
, [Value] float
)
AS BEGIN

	-- ======================================================================
	-- CONST DECLARATIONS AND ASSIGNMENTS
	-- ======================================================================
	DECLARE @C_QuantityTypeActiveEnergyDelivered int
	SET @C_QuantityTypeActiveEnergyDelivered = 129


	-- ======================================================================
	-- PRINT 'TableVar declaration and Init - @MAPPINGS.'
	-- ======================================================================
	DECLARE @MAPPINGS TABLE
	(
	SiteId int
	, SubCentreId int
	, SourceId int
	)
	INSERT INTO @MAPPINGS
	SELECT
		S.SiteId
		, ESM.KeyId
		, ESM.ExternalKeyId
	FROM
		dbo.ExternalSystemMapping AS ESM
	INNER JOIN
		dbo.ExternalSystem AS ES
		ON ES.ExternalSystemId = ESM.ExternalSystemId
	INNER JOIN
		dbo.Site AS S
		ON S.OrganisationId = ES.OrganisationId 
		AND (ES.SiteId = S.SiteId OR ES.SiteId IS NULL)
	WHERE		
		S.OrganisationId = @OrganisationId
		AND ES.ExternalSystemTypeId = 2 -- EMS
	
	-- Get 25 hours so an inner join can get hourly diffs for the day.	
	Declare @DateTimeStartUtc smalldatetime
	SET @DateTimeStartUtc = DATEADD(hh, -25, @DateTimeEndUtc)	


	-- ======================================================================
	-- PRINT 'TableVar declaration and Init - @TS.'
	-- Get each hourly timestamp header per source.
	-- ======================================================================
	DECLARE @TS TABLE
	(
	SourceId int
	, TimeStampUtc datetime
	)
	INSERT INTO @TS
	SELECT		
		DISTINCT
		M.SourceId
		, DLS.TimeStampUtc
	FROM
		@MAPPINGS AS M
	INNER JOIN
		[EmsServer].[ION_Data].dbo.DataLogStamp AS DLS
		ON M.SourceId = DLS.SourceId
	WHERE
		DLS.TimeStampUtc BETWEEN @DateTimeStartUtc AND @DateTimeEndUtc 
		AND DATEPART(mi, DLS.TimeStampUtc) = 0
	-- SELECT * FROM @TS


	-- ======================================================================
	-- PRINT 'TableVar declaration and Init - @RS.'
	-- Store a reading per source per timestamp.
	-- ======================================================================
	DECLARE @R TABLE
	(
	SourceId int
	, TimeStampUtc datetime
	, [Value] float
	, Idx int
	)
	INSERT INTO @R
	SELECT
		T.SourceId
		, T.TimeStampUtc
		, DLC.Value
		, RANK() OVER(PARTITION BY T.SourceId ORDER BY T.TimeStampUtc)
	FROM
		@TS AS T
	INNER JOIN
		[EmsServer].[ION_Data].dbo.DataLogStamp AS DLSC
		ON T.SourceId = DLSC.SourceId
		AND T.TimeStampUtc = DLSC.TimeStampUtc
	INNER JOIN
		[EmsServer].[ION_Data].dbo.DataLog AS DLC
		ON DLSC.Id = DLC.DataLogStampId
		AND DLC.QuantityId = @C_QuantityTypeActiveEnergyDelivered
	WHERE
		DLC.Value IS NOT NULL
	-- SELECT * FROM @R	

	-- Group back up to subcentre as the source can be 1-n.
	INSERT INTO @Result
	SELECT
		M.SiteId 
		, M.SubCentreId 
		, R.TimeStampUtc
		, SUM(R.Value) AS [Value]
	FROM
		@MAPPINGS AS M
	INNER JOIN
		(
		SELECT
			CURR.SourceId
			, CURR.TimeStampUtc
			, CURR.Value - PREV.Value AS [Value]
		FROM
			@R AS CURR
		INNER JOIN
			@R AS PREV
			ON CURR.SourceId = PREV.SourceId
			AND CURR.Idx = PREV.Idx + 1
		) AS R			
		ON M.SourceId = R.SourceId
	GROUP BY
		M.SiteId 
		, M.SubCentreId 
		, R.TimeStampUtc

	RETURN

	-- ======================================================================
	-- Change History
	-- ======================================================================
	-- 25-Oct-2011 EJM
	-- Use ESTId to allow for multiple ES.
	-- 05-Oct-2011 EJM/TB
	-- Point at new ESM and new EmsServer.
	-- 24-Jun-2011 EJM
	-- Init
END
GO

/****** Object:  StoredProcedure [dbo].[procImportEnergyDelivered]    Script Date: 07/13/2012 09:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[procImportEnergyDelivered]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[procImportEnergyDelivered]
GO
CREATE PROCEDURE [dbo].[procImportEnergyDelivered]
(
@OrganisationId int
, @DateTimeEndUtc smalldatetime
)
AS BEGIN

	SET NOCOUNT ON

	-- ======================================================================
	-- CONST DECLARATIONS AND ASSIGNMENTS
	-- ======================================================================
	DECLARE
		@C_CurrentUser varchar (128)
		, @C_CurrentDate datetime 
		, @C_TotalTypeIdSystemImportAtSubCentre int

	SELECT 
		@C_CurrentUser = 'procImportEnergyDelivered'
		, @C_CurrentDate = getDate()
		, @C_TotalTypeIdSystemImportAtSubCentre = 10

	IF @DateTimeEndUtc IS NULL
	BEGIN
		SET @DateTimeEndUtc = getUtcDate()
	END


	-- ======================================================================
	-- PRINT 'TableVar declaration and Init - @READINGS.'
	-- ======================================================================
	DECLARE @READINGS TABLE
	(
	SiteId int
	, SubCentreId int
	, TimeStampUtc smalldatetime
	, [Value] float
	)
	INSERT INTO @READINGS
	SELECT
		SiteId 
		, SubCentreId 
		, TimeStampUtc 
		, [Value] 
	FROM
		dbo.ufnSelectEnergyDelivered(@OrganisationId, @DateTimeEndUtc)


	UPDATE
		dbo.Sale
	SET
		Quantity = R.Value
		, DateUpdated = @C_CurrentDate
		, UpdatedBy = @C_CurrentUser
	FROM
		dbo.Sale AS S
	INNER JOIN
		@READINGS AS R
		ON S.SiteId = R.SiteId
		AND S.SubCentreId = R.SubCentreId
		AND S.DateOfSaleStart = R.TimeStampUtc

	
	INSERT INTO
		dbo.Sale
		(
		SiteID
		, CentreID
		, SubCentreID
		, DateOfSaleStart
		, DateOfSaleEnd
		, Quantity
		, CostPerItem
		, UserTotal
		, Total
		, TotalTypeID
		, DateCreated
		, DateUpdated
		, CreatedBy
		, UpdatedBy
		)
	SELECT
		R.SiteId
		, NULL -- CentreID
		, R.SubCentreId
		, R.TimeStampUtc
		, R.TimeStampUtc
		, R.Value
		, 0 -- CostPerItem
		, 0 -- UserTotal
		, 0 -- Total
		, @C_TotalTypeIdSystemImportAtSubCentre
		, @C_CurrentDate
		, @C_CurrentDate
		, @C_CurrentUser
		, @C_CurrentUser
	FROM
		@READINGS AS R
	LEFT OUTER JOIN
		dbo.Sale AS S
		ON S.SiteId = R.SiteId
		AND S.SubCentreId = R.SubCentreId
		AND S.DateOfSaleStart = R.TimeStampUtc
	WHERE
		S.SiteId IS NULL

	-- ======================================================================
	-- Change History
	-- ======================================================================
	-- 24-Oct-2011 EJM
	-- Changed TotalTypeId to be an import.
	-- 24-Jun-2011 EJM
	-- Init
END
GO





