/**********************************************************************************
NOTE : this script is run only when Synergi us standard Protel.
*************************************************************************************/

USE Synergi
GO

ALTER PROCEDURE [ProtelSchema].[procImportPmsDayMarker] 
AS BEGIN

	SET NOCOUNT ON;	

	DECLARE 
		@C_PmsIdProtel int
		, @C_Today smalldatetime
		, @C_CurrentDate varchar(50)
		, @C_CurrentUser varchar(50)
	SELECT
		@C_PmsIdProtel = 2
		, @C_Today = DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))
		, @C_CurrentDate = getDate()
		, @C_CurrentUser = 'procImportPmsDayMarker'

	-- Temp table to hold Day marker data from PMS
	CREATE TABLE #PMSData
	(		
		SiteId int NOT NULL,
		Date smalldatetime NOT NULL, 
		Rate decimal(20,8) NOT NULL		
	)

	INSERT INTO #PMSData
	(
		SiteId, Date, Rate
	) 
	SELECT A.SiteId, A.Date, A.Rate
	FROM
	(	SELECT		S.SiteId as SiteId, datum as Date, betrag as Rate
		FROM		ProtelServer.protel.proteluser.ckit_roomratevar1 R, ProtelServer.protel.proteluser.lizenz P		
		INNER JOIN	SitePMS as S on (S.PMSID = @C_PmsIdProtel AND S.PropCode = P.short)
		WHERE		P.mpehotel = 1	
		AND			R.datum >= @C_Today

		UNION 

		SELECT		S.SiteId as SiteId, datum as Date, betrag as Rate
		FROM		ProtelServer.protel.proteluser.ckit_roomratevar3 R, ProtelServer.protel.proteluser.lizenz P		
		INNER JOIN	SitePMS as S on (S.PMSID = @C_PmsIdProtel AND S.PropCode = P.short)
		WHERE		P.mpehotel = 3	
		AND			R.datum >= @C_Today

		UNION 

		SELECT		S.SiteId as SiteId, datum as Date, betrag as Rate
		FROM		ProtelServer.protel.proteluser.ckit_roomratevar4 R, ProtelServer.protel.proteluser.lizenz P		
		INNER JOIN	SitePMS as S on (S.PMSID = @C_PmsIdProtel AND S.PropCode = P.short)
		WHERE		P.mpehotel = 4	
		AND			R.datum >= @C_Today
	) AS A
	
	--Start to update data into Synergi.PmsDaymarker
	DECLARE @SiteIdValue int, @DateValue smalldatetime, @RateValue decimal(20,8);

	DECLARE PMSData_cursor CURSOR FOR
	SELECT SiteId, Date, Rate FROM #PMSData

	OPEN PMSData_cursor
	-- Perform the first fetch.
	FETCH NEXT FROM PMSData_cursor INTO @SiteIdValue, @DateValue, @RateValue

	-- Check @@FETCH_STATUS to see if there are any more rows to fetch.
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Do any processing here
		DECLARE @CurrentRate decimal(20,8)
				, @PmsDayMarkerId int
					
		SELECT @CurrentRate = max(Rate)
		FROM dbo.PmsDaymarker
		WHERE  SiteId = @SiteIdValue
		AND Date = @DateValue

		IF(@CurrentRate IS NULL) --means the record not exist
		BEGIN 
			INSERT INTO dbo.PmsDaymarker (PmsId,SiteId,[Date],Rate, Justification,
						DateCreated,DateUpdated,CreatedBy,UpdatedBy)
			VALUES (@C_PmsIdProtel,@SiteIdValue,@DateValue,@RateValue, NULL,				
					@C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser)
		END
		ELSE IF (@CurrentRate <> @RateValue) -- means the rate has been updated 
		BEGIN
			
			UPDATE	dbo.PmsDaymarker
			SET		PmsId = @C_PmsIdProtel,
					SiteId = @SiteIdValue,
					[Date] = @DateValue,
					Rate = @RateValue,												
					DateUpdated = @C_CurrentDate,
					UpdatedBy = @C_CurrentUser
			WHERE	SiteId = @SiteIdValue
			AND		Date = @DateValue			
		END
	
		SELECT @PmsDayMarkerId = PmsDaymarkerId
		FROM dbo.PmsDaymarker
		WHERE  SiteId = @SiteIdValue
		AND Date = @DateValue
		
		IF(@CurrentRate IS NULL OR @CurrentRate <> @RateValue)
		BEGIN
			INSERT INTO dbo.DayMarkerJustification
				(PmsDayMarkerId,Justification,OldRate,NewRate,UpdateStatus,RecommendedRate
				,DateCreated,DateUpdated,CreatedBy,UpdatedBy)
			VALUES (@PmsDayMarkerId, 'Imported from Protel', @CurrentRate, @RateValue, 'OVERRIDE', NULL,
				@C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser)
		END
		
		FETCH NEXT FROM PMSData_cursor INTO @SiteIdValue, @DateValue, @RateValue;
	END

	CLOSE PMSData_cursor
	DEALLOCATE PMSData_cursor

	DROP TABLE #PMSData

	-- ======================================================================
	-- Change History
	-- ======================================================================
	-- 01-Apr-2013 HT
	-- Insert log into DayMarkerJustification.
	-- 16-Jul-2012 EJM
	-- Use ProtelServer.
	-- 03-Sep-2011 EJM
	-- Moved into Protel schema and removed params as no point.
	-- 13-Apr-2011 Hung Tran
	-- This proc will be run periodly to update Current Day Marker in Synergi database (from PMS)

END
GO
