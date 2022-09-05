/**********************************************************************************
NOTE : Please check : this script will delete all unused departments such as : 
Rockford Profit Share Summary (128)
Distribution Channels Backup (150)

*************************************************************************************/
USE Synergi
GO

delete from AccommodationAvailability
from AccommodationAvailability AA
inner join AccommodationCode A on A.AccommodationCodeID = AA.AccommodationCodeID
inner join SubCentre SC on SC.SubCentreID = A.SubCentreID
inner join Centre C on C.CentreID = SC.CentreID
inner join RosterCentre RC on RC.RosterCentreID = C.RosterCentreId
where RC.DepartmentID in (150,128)

delete from AccommodationCode
from AccommodationCode A
inner join SubCentre SC on SC.SubCentreID = A.SubCentreID
inner join Centre C on C.CentreID = SC.CentreID
inner join RosterCentre RC on RC.RosterCentreID = C.RosterCentreId
where RC.DepartmentID in (150,128)

delete from SubCentreKPI 
from SubCentreKPI K
inner join SubCentre SC on K.SubCentreID = SC.SubCentreID
inner join Centre C on C.CentreID = SC.CentreID
inner join RosterCentre RC on RC.RosterCentreID = C.RosterCentreId
where RC.DepartmentID in (150,128)

delete from MicroCentre 
from MicroCentre K
inner join SubCentre SC on K.SubCentreID = SC.SubCentreID
inner join Centre C on C.CentreID = SC.CentreID
inner join RosterCentre RC on RC.RosterCentreID = C.RosterCentreId
where RC.DepartmentID in (150,128)

delete from SubCentre 
from SubCentre SC
inner join Centre C on C.CentreID = SC.CentreID
inner join RosterCentre RC on RC.RosterCentreID = C.RosterCentreId
where RC.DepartmentID in (150,128)

delete from CentreKPI 
from CentreKPI K
inner join Centre C on C.CentreID = K.CentreID
inner join RosterCentre RC on RC.RosterCentreID = C.RosterCentreId
where RC.DepartmentID in (150,128)

delete from Centre 
from Centre C
inner join RosterCentre RC on RC.RosterCentreID = C.RosterCentreId
where RC.DepartmentID in (150,128)


delete from RosterCentre 
from RosterCentre RC
where RC.DepartmentID in (150,128)

delete from SiteDepartment 
from SiteDepartment RC
where RC.DepartmentID in (150,128)


delete from Department 
where DepartmentID in (150,128)