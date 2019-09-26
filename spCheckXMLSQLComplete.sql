Use XDocsToEnc
Go

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

If (OBJECT_ID('[dbo].[spCheckXMLSQLComplete]', 'P') IS NOT NULL)
	Drop Procedure [dbo].[spCheckXMLSQLComplete];
Go

CREATE  PROCEDURE [dbo].[spCheckXMLSQLComplete]
AS
	Declare @DefaultDate Datetime,
			@RunID int
	
	Set @DefaultDate = 0

	Select srl.RunID
	From RunLog srl
	Inner Join DocProcesses sp On sp.ProcessID = srl.ProcessID And sp.ProcessName = 'XMLToSQL'
	Where DATEADD(dd, DATEDIFF(dd,0,srl.StartDate), 0) = DATEADD(dd, DATEDIFF(dd,0,getdate()), 0)
	And IsNull(srl.EndDate, 0) <> @DefaultDate
Go

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
