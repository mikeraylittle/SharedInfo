Use Reports
Go

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

If (OBJECT_ID('uspGetLoanContactInformation', 'P') IS NOT NULL)
	Drop Procedure [dbo].[uspGetLoanContactInformation];
Go

CREATE PROCEDURE [dbo].[uspGetLoanContactInformation]
	@LoanNumber varchar(30)
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	Declare @oid int,
			@parent int,
			@org_code varchar (10),
			@userid varchar (16),
			@LoanOfficerEmail varchar (64),
			@LoanProcessorEmail varchar (64),
			@BranchManagerEmail varchar (64),
			@BranchSupportEmail varchar (64),
			@LOCCopies varchar (300),
			@Borrower varchar (100)

	Select @BranchSupportEmail = ConfigValue
	From ConfigValues
	Where ConfigType = 'Branch_Support_Email'

	SELECT Top 1 @LoanOfficerEmail = Case When IsNull(e.TerminationDate, '1900-01-01 00:00:00.000') = '1900-01-01 00:00:00.000' Then lo.email else @BranchSupportEmail end, 
	@LoanProcessorEmail = Case When ISNULL(ep.TerminationDate, '1900-01-01 00:00:00.000') = '1900-01-01 00:00:00.000' Then IsNull(lp.email, 'none') else 'none' end, 
	@userid = lo.userid, @Borrower = ls.BorrowerFirstName + ' ' + ls.BorrowerLastName
	FROM emdb.emdbuser.LoanSummary ls
	Left Join emdb.emdbuser.users lo On lo.userid = ls.LoanOfficerId 
	Left Join emdb.emdbuser.users lp On lp.userid = ls.LoanProcessorId
	Left Join dbo.Employee e On RTrim(LTrim(e.FirstName)) = RTRIM(LTrim(lo.first_name)) 
		And RTRIM(LTrim(e.LastName)) = RTRIM(LTrim(lo.last_name))
	Left Join dbo.Employee ep On RTrim(LTrim(ep.FirstName)) = RTRIM(LTrim(lp.first_name)) 
		And RTRIM(LTrim(ep.LastName)) = RTRIM(LTrim(lp.last_name))	
	Where ls.LoanNumber = @LoanNumber
	Order By e.HireDate Desc
			
	Select @org_code = lx._ORGID
	From emdb.emdbuser.LoanSummary ls
	Inner Join emdb.emdbuser.LOANXDB_S_02 lx On lx.XrefId = ls.XRefID
	Where ls.LoanNumber = @LoanNumber

	Select	@oid = oid, 
			@parent = parent
	From dbo.ufnBranchOrgCode(@org_code)

	Select @BranchManagerEmail = email 
	From ufnBranchManager(@oid)

	If ISNULL(@BranchManagerEmail, 'none') = 'none'
	Begin
		Select @BranchManagerEmail = email 
		From ufnBranchManager(@parent)
	End
		
	SELECT @LOCCopies = COALESCE(@LOCCopies + ';', '') + Cast(us.Email As varchar(64))
	FROM NetPopMimeCCopied np
	Inner Join emdb.emdbuser.users us On us.userid = np.ccID
	where np.loID = @userid	
	And np.LoanNumber = @LoanNumber

	Select	IsNull(@LoanOfficerEmail, @BranchSupportEmail) As 'LoanOfficerEmail', 
			@LoanProcessorEmail As 'LoanProcessorEmail', 
			IsNull(@BranchManagerEmail, @BranchSupportEmail) As 'BranchManagerEmail',
			IsNull(@LOCCopies, 'none') As 'LOCCopies', 
			@org_code As 'OrgCode',
			@Borrower As 'Borrower'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
