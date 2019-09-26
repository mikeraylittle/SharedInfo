USE XDocsToEnc
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF EXISTS (SELECT name from sys.indexes WHERE name = N'UQ_Config_ConfigItem') 
   DROP INDEX UQ_Config_ConfigItem ON Config; 
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Config]') AND type in (N'U'))
	CREATE TABLE [dbo].[Config](
		[ConfigId] [int] IDENTITY(1,1) NOT NULL,
		[ConfigItem] [nvarchar] (50) NOT NULL,
		[ConfigValue] [nvarchar] (200) NOT NULL,
		[BeginDate] [datetime] NOT NULL,
		[ExpireDate] [datetime],
	 CONSTRAINT [PK_Config_ConfigId] UNIQUE CLUSTERED 
	(
		[ConfigId]
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.Columns WHERE TABLE_NAME = 'Config' AND COLUMN_NAME = 'Process')
	ALTER TABLE Config ADD ProcessID int;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Config]') AND name = N'UQ_Config_ConfigItem')
	CREATE UNIQUE NONCLUSTERED INDEX [UQ_Config_ConfigItem] ON [dbo].[Config] 
	(
		[ConfigItem] ASC,
		[BeginDate] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY];
GO

SET ANSI_PADDING OFF
GO