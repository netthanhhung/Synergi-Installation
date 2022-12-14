/**********************************************************************************
- Destination: Service Instance that contains PROTEL database.		
- This script does the following;
1) Create tables: ckit_roomratevar1, ckit_roomratevar2, ckit_roomratevar3, ckit_roomratevar4, ckit_resroomratevar1, ckit_resroomratevar2, ckit_resroomratevar3, ckit_resroomratevar4.
*************************************************************************************/

USE [Protel]
GO
/****** Object:  Table [proteluser].[ckit_roomratevar4]    Script Date: 07/18/2012 14:57:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [proteluser].[ckit_roomratevar4](
	[datum] [datetime] NOT NULL,
	[betrag] [decimal](9, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [proteluser].[ckit_roomratevar3]    Script Date: 07/18/2012 14:57:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [proteluser].[ckit_roomratevar3](
	[datum] [datetime] NOT NULL,
	[betrag] [decimal](9, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [proteluser].[ckit_roomratevar2]    Script Date: 07/18/2012 14:57:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [proteluser].[ckit_roomratevar2](
	[datum] [datetime] NOT NULL,
	[betrag] [decimal](9, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [proteluser].[ckit_roomratevar1]    Script Date: 07/18/2012 14:57:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [proteluser].[ckit_roomratevar1](
	[datum] [datetime] NOT NULL,
	[betrag] [decimal](9, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [proteluser].[ckit_resroomratevar4]    Script Date: 07/18/2012 14:57:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [proteluser].[ckit_resroomratevar4](
	[leistacc] [int] NOT NULL,
	[datum] [datetime] NOT NULL,
	[betrag] [decimal](9, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [proteluser].[ckit_resroomratevar3]    Script Date: 07/18/2012 14:57:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [proteluser].[ckit_resroomratevar3](
	[leistacc] [int] NOT NULL,
	[datum] [datetime] NOT NULL,
	[betrag] [decimal](9, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [proteluser].[ckit_resroomratevar2]    Script Date: 07/18/2012 14:57:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [proteluser].[ckit_resroomratevar2](
	[leistacc] [int] NOT NULL,
	[datum] [datetime] NOT NULL,
	[betrag] [decimal](9, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [proteluser].[ckit_resroomratevar1]    Script Date: 07/18/2012 14:57:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [proteluser].[ckit_resroomratevar1](
	[leistacc] [int] NOT NULL,
	[datum] [datetime] NOT NULL,
	[betrag] [decimal](9, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Default [DF__ckit_resr__leist__7C350A54]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar1] ADD  DEFAULT ((-1)) FOR [leistacc]
GO
/****** Object:  Default [DF__ckit_resr__datum__7D292E8D]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar1] ADD  DEFAULT ('1900-01-01') FOR [datum]
GO
/****** Object:  Default [DF__ckit_resr__betra__7E1D52C6]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar1] ADD  DEFAULT ((0)) FOR [betrag]
GO
/****** Object:  Default [DF__ckit_resr__leist__6C354363]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar2] ADD  DEFAULT ((-1)) FOR [leistacc]
GO
/****** Object:  Default [DF__ckit_resr__datum__6D29679C]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar2] ADD  DEFAULT ('1900-01-01') FOR [datum]
GO
/****** Object:  Default [DF__ckit_resr__betra__6E1D8BD5]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar2] ADD  DEFAULT ((0)) FOR [betrag]
GO
/****** Object:  Default [DF__ckit_resr__leist__73D6652B]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar3] ADD  DEFAULT ((-1)) FOR [leistacc]
GO
/****** Object:  Default [DF__ckit_resr__datum__74CA8964]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar3] ADD  DEFAULT ('1900-01-01') FOR [datum]
GO
/****** Object:  Default [DF__ckit_resr__betra__75BEAD9D]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar3] ADD  DEFAULT ((0)) FOR [betrag]
GO
/****** Object:  Default [DF__ckit_resr__leist__26A2A771]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar4] ADD  DEFAULT ((-1)) FOR [leistacc]
GO
/****** Object:  Default [DF__ckit_resr__datum__2796CBAA]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar4] ADD  DEFAULT ('1900-01-01') FOR [datum]
GO
/****** Object:  Default [DF__ckit_resr__betra__288AEFE3]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_resroomratevar4] ADD  DEFAULT ((0)) FOR [betrag]
GO
/****** Object:  Default [DF__ckit_room__datum__79589DA9]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_roomratevar1] ADD  DEFAULT ('1900-01-01') FOR [datum]
GO
/****** Object:  Default [DF__ckit_room__betra__7A4CC1E2]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_roomratevar1] ADD  DEFAULT ((0)) FOR [betrag]
GO
/****** Object:  Default [DF__ckit_room__datum__6958D6B8]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_roomratevar2] ADD  DEFAULT ('1900-01-01') FOR [datum]
GO
/****** Object:  Default [DF__ckit_room__betra__6A4CFAF1]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_roomratevar2] ADD  DEFAULT ((0)) FOR [betrag]
GO
/****** Object:  Default [DF__ckit_room__datum__70F9F880]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_roomratevar3] ADD  DEFAULT ('1900-01-01') FOR [datum]
GO
/****** Object:  Default [DF__ckit_room__betra__71EE1CB9]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_roomratevar3] ADD  DEFAULT ((0)) FOR [betrag]
GO
/****** Object:  Default [DF__ckit_room__datum__23C63AC6]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_roomratevar4] ADD  DEFAULT ('1900-01-01') FOR [datum]
GO
/****** Object:  Default [DF__ckit_room__betra__24BA5EFF]    Script Date: 07/18/2012 14:57:04 ******/
ALTER TABLE [proteluser].[ckit_roomratevar4] ADD  DEFAULT ((0)) FOR [betrag]
GO
