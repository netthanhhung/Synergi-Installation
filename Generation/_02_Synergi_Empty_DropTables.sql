/**********************************************************************************
CHANGED OBJECT LIST
[_oldEzyTransaction] : drop table
[_oldOSVAccommodationData] : drop table
[_temp] : drop table
AccommodationAvailabilityBU : drop table
AccommodationAvailabilityBU2 : drop table
ArchivedBudgetCentreKPI_201001271545 : drop table
ArchivedBudgetSubCentreKPI_201001271545 : drop table
dbo.BudgetForecast_201001191415 : drop table
dbo.BudgetForecast_201003261550 : drop table
dbo.CentreKPI_201001191415 : drop table
dbo.CentreKPI_201001221355 : drop table
dbo.InvoiceBU : drop table
dbo.reportStats : drop table
dbo.SubCentreKPI_201001191415 : drop table
dbo.SubCentreKPI_201001221355 : drop table
Myob.Transaction_14_11200 : drop table

*************************************************************************************/
USE [Synergi]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_EzyTransaction_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_oldEzyTransaction] DROP CONSTRAINT [DF_EzyTransaction_DateCreated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_EzyTransaction_DateUpdated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_oldEzyTransaction] DROP CONSTRAINT [DF_EzyTransaction_DateUpdated]
END

GO

/****** Object:  Table [dbo].[_oldEzyTransaction]    Script Date: 04/17/2012 11:50:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_oldEzyTransaction]') AND type in (N'U'))
DROP TABLE [dbo].[_oldEzyTransaction]
GO

/****** Object:  Table [dbo].[_oldOSVAccommodationData]    Script Date: 04/17/2012 11:51:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_oldOSVAccommodationData]') AND type in (N'U'))
DROP TABLE [dbo].[_oldOSVAccommodationData]
GO

/****** Object:  Table [dbo].[_temp]    Script Date: 04/17/2012 11:51:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_temp]') AND type in (N'U'))
DROP TABLE [dbo].[_temp]
GO

/****** Object:  Table [dbo].[AccommodationAvailabilityBU]    Script Date: 04/17/2012 11:52:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AccommodationAvailabilityBU]') AND type in (N'U'))
DROP TABLE [dbo].[AccommodationAvailabilityBU]
GO

/****** Object:  Table [dbo].[AccommodationAvailabilityBU2]    Script Date: 04/17/2012 11:52:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AccommodationAvailabilityBU2]') AND type in (N'U'))
DROP TABLE [dbo].[AccommodationAvailabilityBU2]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_SiteID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_SiteID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_KPITypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_KPITypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_DateStart]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_DateStart]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_BudgetVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_BudgetVersion]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_Factor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_Factor]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_Factor2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_Factor2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_Factor3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_Factor3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_EstimatedSpend]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_EstimatedSpend]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_FactorType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_FactorType]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_IsKeyRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_IsKeyRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_IsKeyImprovementRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_IsKeyImprovementRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_OriginalDateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_OriginalDateCreated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_OriginalDateUpdated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_OriginalDateUpdated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_OriginalCreatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_OriginalCreatedBy]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetCentreKPI_201001271545_OriginalUpdatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetCentreKPI_201001271545_OriginalUpdatedBy]
END

GO

/****** Object:  Table [dbo].[ArchivedBudgetCentreKPI_201001271545]    Script Date: 04/17/2012 11:52:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchivedBudgetCentreKPI_201001271545]') AND type in (N'U'))
DROP TABLE [dbo].[ArchivedBudgetCentreKPI_201001271545]
GO



IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_SiteID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_SiteID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_KPITypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_KPITypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_DateStart]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_DateStart]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_BudgetVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_BudgetVersion]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_Factor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_Factor]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_Factor2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_Factor2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_Factor3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_Factor3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_EstimatedSpend]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_EstimatedSpend]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_KPITypeID_1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_KPITypeID_1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_IsKeyRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_IsKeyRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_IsKeyImprovementRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_IsKeyImprovementRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_OriginalDateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_OriginalDateCreated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_OriginalDateUpdated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_OriginalDateUpdated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_OriginalCreatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_OriginalCreatedBy]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_OriginalUpdatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_OriginalUpdatedBy]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_DateCreated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_DateUpdated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_DateUpdated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_CreatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_CreatedBy]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ArchivedBudgetSubCentreKPI_201001271545_UpdatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545] DROP CONSTRAINT [DF_ArchivedBudgetSubCentreKPI_201001271545_UpdatedBy]
END

GO

/****** Object:  Table [dbo].[ArchivedBudgetSubCentreKPI_201001271545]    Script Date: 04/17/2012 11:53:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchivedBudgetSubCentreKPI_201001271545]') AND type in (N'U'))
DROP TABLE [dbo].[ArchivedBudgetSubCentreKPI_201001271545]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BudgetForecast_201001191415_SiteID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BudgetForecast_201001191415] DROP CONSTRAINT [DF_BudgetForecast_201001191415_SiteID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BudgetForecast_201001191415_UserTotal]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BudgetForecast_201001191415] DROP CONSTRAINT [DF_BudgetForecast_201001191415_UserTotal]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BudgetForecast_201001191415_Total]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BudgetForecast_201001191415] DROP CONSTRAINT [DF_BudgetForecast_201001191415_Total]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BudgetForecast_201001191415_TotalTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BudgetForecast_201001191415] DROP CONSTRAINT [DF_BudgetForecast_201001191415_TotalTypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BudgetForecast_201001191415_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BudgetForecast_201001191415] DROP CONSTRAINT [DF_BudgetForecast_201001191415_DateCreated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BudgetForecast_201001191415_DateUpdated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BudgetForecast_201001191415] DROP CONSTRAINT [DF_BudgetForecast_201001191415_DateUpdated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BudgetForecast_201001191415_CreatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BudgetForecast_201001191415] DROP CONSTRAINT [DF_BudgetForecast_201001191415_CreatedBy]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BudgetForecast_201001191415_UpdatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BudgetForecast_201001191415] DROP CONSTRAINT [DF_BudgetForecast_201001191415_UpdatedBy]
END

GO

/****** Object:  Table [dbo].[BudgetForecast_201001191415]    Script Date: 04/17/2012 11:53:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BudgetForecast_201001191415]') AND type in (N'U'))
DROP TABLE [dbo].[BudgetForecast_201001191415]
GO

/****** Object:  Table [dbo].[BudgetForecast_201003261550]    Script Date: 04/17/2012 11:54:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BudgetForecast_201003261550]') AND type in (N'U'))
DROP TABLE [dbo].[BudgetForecast_201003261550]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_SiteID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_SiteID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_KPITypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_KPITypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_BudgetVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_BudgetVersion]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_Factor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_Factor]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_Factor2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_Factor2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_Factor3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_Factor3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_EstimatedSpend]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_EstimatedSpend]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_FactorType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_FactorType]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_IsKeyRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_IsKeyRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001191415_IsKeyImprovementRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001191415] DROP CONSTRAINT [DF_CentreKPI_201001191415_IsKeyImprovementRatio]
END

GO

/****** Object:  Table [dbo].[CentreKPI_201001191415]    Script Date: 04/17/2012 11:54:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CentreKPI_201001191415]') AND type in (N'U'))
DROP TABLE [dbo].[CentreKPI_201001191415]
GO


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_SiteID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_SiteID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_KPITypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_KPITypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_BudgetVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_BudgetVersion]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_Factor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_Factor]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_Factor2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_Factor2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_Factor3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_Factor3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_EstimatedSpend]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_EstimatedSpend]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_FactorType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_FactorType]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_IsKeyRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_IsKeyRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CentreKPI_201001221355_IsKeyImprovementRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CentreKPI_201001221355] DROP CONSTRAINT [DF_CentreKPI_201001221355_IsKeyImprovementRatio]
END

GO

/****** Object:  Table [dbo].[CentreKPI_201001221355]    Script Date: 04/17/2012 11:55:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CentreKPI_201001221355]') AND type in (N'U'))
DROP TABLE [dbo].[CentreKPI_201001221355]
GO

/****** Object:  Table [dbo].[InvoiceBU]    Script Date: 04/17/2012 11:55:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InvoiceBU]') AND type in (N'U'))
DROP TABLE [dbo].[InvoiceBU]
GO

/****** Object:  Table [dbo].[reportStats]    Script Date: 04/17/2012 11:56:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reportStats]') AND type in (N'U'))
DROP TABLE [dbo].[reportStats]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_SiteID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_SiteID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_KPITypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_KPITypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_BudgetVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_BudgetVersion]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_Factor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_Factor]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_Factor2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_Factor2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_Factor3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_Factor3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_EstimatedSpend]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_EstimatedSpend]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_KPITypeID_1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_KPITypeID_1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_IsKeyRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_IsKeyRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_IsKeyImprovementRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_IsKeyImprovementRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_DateCreated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_DateUpdated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_DateUpdated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_CreatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_CreatedBy]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001191415_UpdatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001191415] DROP CONSTRAINT [DF_SubCentreKPI_201001191415_UpdatedBy]
END

GO

/****** Object:  Table [dbo].[SubCentreKPI_201001191415]    Script Date: 04/17/2012 11:56:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubCentreKPI_201001191415]') AND type in (N'U'))
DROP TABLE [dbo].[SubCentreKPI_201001191415]
GO



IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_SiteID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_SiteID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_KPITypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_KPITypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_BudgetVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_BudgetVersion]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_Factor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_Factor]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_Factor2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_Factor2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_Factor3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_Factor3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_EstimatedSpend]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_EstimatedSpend]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_KPITypeID_1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_KPITypeID_1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_IsKeyRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_IsKeyRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_IsKeyImprovementRatio]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_IsKeyImprovementRatio]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_DateCreated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_DateUpdated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_DateUpdated]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_CreatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_CreatedBy]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubCentreKPI_201001221355_UpdatedBy]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubCentreKPI_201001221355] DROP CONSTRAINT [DF_SubCentreKPI_201001221355_UpdatedBy]
END

GO

/****** Object:  Table [dbo].[SubCentreKPI_201001221355]    Script Date: 04/17/2012 11:56:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubCentreKPI_201001221355]') AND type in (N'U'))
DROP TABLE [dbo].[SubCentreKPI_201001221355]
GO



IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[df_Transaction_14_11200]') AND type = 'D')
BEGIN
ALTER TABLE [Myob].[Transaction_14_11200] DROP CONSTRAINT [df_Transaction_14_11200]
END

GO

/****** Object:  Table [Myob].[Transaction_14_11200]    Script Date: 04/17/2012 11:57:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Myob].[Transaction_14_11200]') AND type in (N'U'))
DROP TABLE [Myob].[Transaction_14_11200]
GO






