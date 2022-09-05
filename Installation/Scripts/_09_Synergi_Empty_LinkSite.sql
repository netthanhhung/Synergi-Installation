/**********************************************************************************
- Destination: Service Instance that contains SYNERGI database.
- Before running this script: please change parameters like :
		@email_address=N'synergisupport@xnhotelsystems.com'
		
- This script does the following:
1) Create login 'synergiuser'.
*************************************************************************************/

USE Synergi
GO

DECLARE
	@_SiteId int
	, @_PmsId int -- 1: Charts, 2: Protel
	, @_ExternalKeyId int -- mpehotel in Protel, ...
	, @_PropCode varchar(50) -- propcode in Protel

SELECT
	@_SiteId = 1
	, @_PmsId = 2
	, @_ExternalKeyId = 1
	, @_PropCode = 'CRO'

/* Here is the script to create mapping data when create a new site */
-- Change KeyId (SiteId), ExternalKeyId (Protel mpehotel), PropCode
INSERT INTO ExternalSystemMapping (ExternalSystemId, KeyId, ExternalKeyId, DateStart, DisplayIndex, DateCreated, DateUpdated, CreatedBy, UpdatedBy)
VALUES(3,@_SiteId,@_ExternalKeyId, '01-Jan-1990', 1, GETDATE(), GETDATE(), 'Synergi-IT-Support', 'Synergi-IT-Support')

--No need any more, User can setup it on UI
--INSERT INTO SitePMS (SiteID, PMSID, PropCode, StartDate, DateCreated, DateUpdated, CreatedBy, UpdatedBy)
--VALUES(@_SiteId,@_PmsId,@_PropCode, '01-Jan-1990', GETDATE(), GETDATE(), 'Synergi-IT-Support', 'Synergi-IT-Support')