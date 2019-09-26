Use Monitoring
Go

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

If (OBJECT_ID('uspGetucdpDocumentFileIdentifier', 'P') IS NOT NULL)
	Drop Procedure [dbo].[uspGetucdpDocumentFileIdentifier];
Go

CREATE  PROCEDURE [dbo].[uspGetucdpDocumentFileIdentifier]
WITH EXECUTE AS CALLER
AS
	Declare @ULDDX31 as Table(
		[LoanNumber] [nvarchar](3000) not NULL,
		[AppraisalID] [int] NULL,
		[OrderedDate] [datetime] NOT NULL,
		DateCreated   datetime not null,
		UcdpDocumentFileIdentifier varchar(20) not null,
		Guid varchar(38) not null)

	Declare @Today as datetime
	
	Select @Today = GETDATE()

	Insert into @ULDDX31
			 (LoanNumber
			  ,AppraisalID
			  ,OrderedDate
			  ,DateCreated
			  ,UcdpDocumentFileIdentifier
			  ,Guid)
			  
	SELECT top 10
	substring(app.LoanNumber,1,12) As 'LoanNumber',  
	app.AppraisalId, 
	App.OrderedDate,
	@Today,	
	app.UcdpDocumentFileIdentifier,
	er.Guid
	From A1Closing..Appraisal app with (nolock)
	left Join ERDB.ERDBUser.LoanSummary er with (nolock) On er.LoanNumber = substring(app.LoanNumber,1,12)
	left Join ERDB.ERDBUser.LOANXDB_S_01 lxd with (nolock) On lxd.XrefId = er.XrefId 
	left join monitoring..TradeAssignment ta with (nolock) On ta.LoanGUID = er.Guid
	Where app.UcdpDocumentFileIdentifier Is Not Null
	And er.LoanNumber is not null
	And ta.LoanGuid is null
	And isnull(lxd._ULDD_X31,'''') <> app.UcdpDocumentFileIdentifier
	And App.AppraisalId not in (Select AppraisalId from Monitoring..ULDDX31Updated with (nolock)) 
	and exists(
	Select substring(x.LoanNumber,1,12) as 'LoanNumber' , max(appraisalid)
		From A1Closing..Appraisal X with (nolock)
		group by substring(x.LoanNumber,1,12))
	Order by 2		

	Insert into Monitoring..ULDDX31Updated 
	 (LoanNumber
	  ,AppraisalID
	  ,OrderedDate
	  ,UcdpDocumentFileIdentifier
	  ,DateCreated
	  ,Guid)
	 Select 
	   A.LoanNumber
	  ,A.AppraisalID
	  ,A.OrderedDate
	  ,A.UcdpDocumentFileIdentifier
	  ,A.DateCreated
	  ,A.Guid
	  From @ULDDX31 A

	Select A.Guid as Guid
		,  A.AppraisalID
		,  A.LoanNumber
		,  'ULDD.X31' As 'FieldID' 
		,  A.UcdpDocumentFileIdentifier
	From @ULDDX31 A
Go

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO