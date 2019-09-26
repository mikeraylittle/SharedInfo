USE XDocsToEnc
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF EXISTS(SELECT * FROM sys.foreign_keys WHERE object_id = object_id(N'[dbo].[FK_RunLog_XdocProcesses_ProcessID]') and parent_object_id = object_id(N'[dbo].[RunLog]'))
	ALTER TABLE RunLog DROP CONSTRAINT FK_RunLog_XdocProcesses_ProcessID;
GO 

IF EXISTS(Select * FROM sys.key_constraints Where object_id = object_id(N'[UQ_RunLog_ProcessID_StartDate]') And parent_object_id = object_id(N'[dbo].[RunLog]'))
	ALTER TABLE RunLog DROP CONSTRAINT UQ_RunLog_ProcessID_StartDate;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RunLog]') AND type in (N'U'))
	CREATE TABLE [dbo].[RunLog](
		[RunID] [int] IDENTITY(1,1) NOT NULL,
		[ProcessID] [int] NOT NULL,
		[StartDate] [datetime] NOT NULL,
		[EndDate] [datetime] NULL,
	 CONSTRAINT [PK_RunLog_RunID] UNIQUE CLUSTERED 
	(
		[RunID]
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];
GO

IF NOT EXISTS(Select * FROM sys.key_constraints Where object_id = object_id(N'[UQ_RunLog_ProcessID_StartDate]') And parent_object_id = object_id(N'[dbo].[RunLog]'))
	ALTER TABLE RunLog ADD CONSTRAINT UQ_RunLog_ProcessID_StartDate UNIQUE (ProcessID, StartDate);
GO

IF NOT EXISTS(SELECT * FROM sys.foreign_keys WHERE object_id = object_id(N'[dbo].[FK_RunLog_XdocProcesses_ProcessID]') and parent_object_id = object_id(N'[dbo].[RunLog]'))
	ALTER TABLE [dbo].[RunLog]  WITH CHECK ADD  CONSTRAINT [FK_RunLog_XdocProcesses_ProcessID] FOREIGN KEY([ProcessID])
	REFERENCES [dbo].[XdocProcesses] ([ProcessID])
	ON UPDATE CASCADE
	ON DELETE CASCADE
	GO

	ALTER TABLE [dbo].[RunLog] CHECK CONSTRAINT [FK_RunLog_XdocProcesses_ProcessID];
GO

SET ANSI_PADDING OFF
GO