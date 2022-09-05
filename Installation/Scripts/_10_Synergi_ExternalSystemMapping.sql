/**********************************************************************************
- Destination: Service Instance that contains SYNERGI database.
- Purpose : to create mapping records for Distribution Channels, Yield Level

- Distribution Channels :
	+ insert records into [ExternalSystemMapping] : NOTE : have to input manually
- Yield Level 
	+ insert records into [ExternalSystemMapping]
	+ insert records into [YieldLevel]
	+ Update colour for YieldLevel records.
*************************************************************************************/
USE Synergi

BEGIN TRY

	BEGIN TRANSACTION

	DECLARE 
        @C_CurrentUser varchar (128)
        , @C_CurrentDate datetime 
    SELECT 
        @C_CurrentUser = 'Synergi IT - Manual'
        , @C_CurrentDate = getDate()        	
    	
	IF NOT EXISTS (SELECT ExternalSystemMappingId FROM [ExternalSystemMapping] WHERE [ExternalSystemId] = 29 ) 
	BEGIN
	
		INSERT INTO [dbo].[ExternalSystemMapping]
           ([ExternalSystemId],[KeyId],[ExternalKeyId],[ExternalKeyString],[DateStart],[DateEnd],[DisplayIndex]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
        SELECT 29, YL.ref, YL.ref, YL.short, '01-Jan-1900', NULL, YL.ref
			, @C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser
        FROM ProtelServer.protel.proteluser.yieldlvl YL      
                
		SET IDENTITY_INSERT [dbo].[YieldLevel] ON
		INSERT INTO [dbo].[YieldLevel]
           ([YieldLevelId],[Code],[Name],[Colour]
           ,[DateCreated],[DateUpdated],[CreatedBy],[UpdatedBy])
        SELECT YL.ref, YL.short, YL.text, NULL
			, @C_CurrentDate, @C_CurrentDate, @C_CurrentUser, @C_CurrentUser
        FROM ProtelServer.protel.proteluser.yieldlvl YL        
        SET IDENTITY_INSERT [dbo].[YieldLevel] OFF
        
        Update YieldLevel Set Colour = '#FF00FFFF' where yieldLevelId = 1;
        Update YieldLevel Set Colour = '#FF0000FF' where yieldLevelId = 2;
        Update YieldLevel Set Colour = '#FF8A2BE2' where yieldLevelId = 3;
        Update YieldLevel Set Colour = '#FFA52A2A' where yieldLevelId = 4;
        Update YieldLevel Set Colour = '#FFD2691E' where yieldLevelId = 5;
        Update YieldLevel Set Colour = '#FFFF7F50' where yieldLevelId = 6;
        Update YieldLevel Set Colour = '#FF00FFFF' where yieldLevelId = 7;
        Update YieldLevel Set Colour = '#FFFFD700' where yieldLevelId = 8;
        Update YieldLevel Set Colour = '#FFDAA520' where yieldLevelId = 9;
        Update YieldLevel Set Colour = '#FF808080' where yieldLevelId = 10;
        Update YieldLevel Set Colour = '#FF008000' where yieldLevelId = 11;
        Update YieldLevel Set Colour = '#FFADFF2F' where yieldLevelId = 12;
        Update YieldLevel Set Colour = '#FFFF69B4' where yieldLevelId = 13;
        Update YieldLevel Set Colour = '#FFCD5C5C' where yieldLevelId = 14;
        Update YieldLevel Set Colour = '#FFE0FFFF' where yieldLevelId = 15;
        Update YieldLevel Set Colour = '#FFFFB6C1' where yieldLevelId = 16;
        Update YieldLevel Set Colour = '#FFFFA07A' where yieldLevelId = 17;
        Update YieldLevel Set Colour = '#FF20B2AA' where yieldLevelId = 18;
        Update YieldLevel Set Colour = '#FF87CEFA' where yieldLevelId = 19;
        Update YieldLevel Set Colour = '#FF778899' where yieldLevelId = 20;
        Update YieldLevel Set Colour = '#FFB0C4DE' where yieldLevelId = 21;
        Update YieldLevel Set Colour = '#FFFFFFE0' where yieldLevelId = 22;
        Update YieldLevel Set Colour = '#FFFA8072' where yieldLevelId = 23;
        Update YieldLevel Set Colour = '#FFC0C0C0' where yieldLevelId = 24;
        Update YieldLevel Set Colour = '#FF708090' where yieldLevelId = 25;
        Update YieldLevel Set Colour = '#FFFFFAFA' where yieldLevelId = 26;
        
	END

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
