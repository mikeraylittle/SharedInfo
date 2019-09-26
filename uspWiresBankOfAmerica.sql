USE [Monitoring]
GO

/****** Object:  StoredProcedure [dbo].[uspWiresBank]    Script Date: 08/20/2012 15:07:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	if exists(select 1 from sysobjects where name='uspWiresBank' and type='p')
	  drop proc dbo.uspWiresBank
	go

--select * from Monitoring..WiresBOA where JobID = 508

Create Procedure [dbo].[uspWiresBank]
	@Jobid int,
	@LoanList Varchar(max)
	-- Truncate Table Monitoring..WiresBOA
	-- uspWiresBank 521, '290120605097' 805120501324,150120710565,830120513517,300120712910,150120713080,995120712565,882111072634,737120401768'
as

SET NOCOUNT ON

declare @Split Char(1),
	@X XML
	
Declare @WiresImport as Table
(
	LoanNumber Varchar(max)
)

Set @Split = ','

-- Moving the comma delimited values into an XML node
SELECT @X = CONVERT(xml,'<root><s>' + REPLACE(@LoanList,@Split,'</s><s>') + '</s></root>')

-- Inserting the xml nodes into the WiresImport temp table
Insert into @WiresImport
(LoanNumber)
SELECT [Value] = T.c.value('.','varchar(20)')
FROM @X.nodes('/root/s') T(c)




Select  ClientsLoanNumber Into #Temp from Monitoring..WiresBOA where JobID = @jobid
IF @@ROWCOUNT = 0
BEGIN
 Insert Into Monitoring..WiresBOA(
	JobID
	,Client_ID
	,ClientsLoanNumber
	,Draft_Num 
	,Original_PrincipalBalance
	,Unpaid_PrincipalBalance	
	,Note_Rate 
	,PI 
	,First_payment 
	,Maturity_Date 
	,Loan_Purpose 
	,Takeout_Investor 	
	,Loan_Type  	
	,DocumentStyle_Type 
	,Amortization_Type 
	,LoanPayment_Type 
	,Property_Type 	
	,Property_Street 
	,Property_City 	
	,Property_State 	
	,Property_Zip 
	,Occupancy_Type 
	,LTV 
	,CLTV 
	,Borrower_FirstName 
	,Borrowers_MiddleInitial 
	,Borrower_LastName 
	,Borrower_SSN# 
	,Borrower_FICO1 
	,Subprime_CreditGrade 
	,Requested_AdvanceDate 
	,Requested_WireAmount 
	,Wire_RecipientName 
	,WireRecipient_Address 
	,Wire_RecipientCity 
	,Wire_RecipientState 
	,Wire_RecipientZip
	,Title_Insurer 
	,EscrowTitle_Closing
	,Bank_Name 
	,Bank_CityState 
	,Bank_ABANum 
	,Bank_Account 
	,LineType_WarehouseEPP 
	,Request_Type 
	,UWConfirm_ApprovalType 
	,UW_ConfirmationNum 
	,UWExpiration_Date 
	,LockConfirm_ApprovalType 
	,Commitment_Num 
	,Takeout_ExpirationDate 
	,Takeout_Price 
	,Investor_LoanNum 
	,HUD1_Date 
	,Non_PerformingFlag 
	,FurtherCredit_AccountNum  
	,FurtherCredit_BankName 
	,Auto_LinkFlag
	,Ext 
	,Sub_Customer 
	,Bulk_BatchNum 
	,Mailing_Address 
	,Mailing_City 
	,Mailing_State 
	,Mailing_Zip 
	,MFR_Units 
	,Back_EndRatio 
	,Escrow 
	,Fixed_Period
	,Index_Category 
	,Initial_Cap 
	,Periodic_Cap 
	,Lifetime_Cap 
	,Margin 
	,Interest_OnlyTerm
	,LPMI_Premium 
	,PMI_Insurer 
	,PMI 
	,Piggy_Back 
	,Prepay_Term 
	,Prepay_Months 
	,Prepay_Type 
	,Self_Employed 
	,Start_Rate 
	,Number_ofUnits 
	,Appraised_Value 
	,Bankruptcy_DischargeDate 
	,Foreclosure_Date 
	,Lien_Type 
	,ThirtyMonthLates 
	,Section_32 
	,Note_Date
	,Base_Loan_Amount
	,Total_Rehab_Cost
	,Line_Type_Repo_EPP
	,Register_Flag
	,External_Custodian
	,Impound_Amount
	,Original_Amortization_Term
	,Rate_Floor
	,MIN_Number
	,Sub_Loan_Type
	,Special_Loan_feature
	,Debt_To_Income
	,MIP_Perc
	,Borrower1_DOB
	,Borrower1_Country_of_Citizenship
	,Borrower1_Position_Title_Type_of_Business
	,Borrower2__First_Name
	,Borrower2_Middle_Initial
	,Borrower2_Last_Name
	,Borrower2_FICO
	,Borrower2_SSN
	,Borrower2_DOB
	,Borrower2_Country_of_Citizenship
	,Borrower2_Position_Title_Type_of_Business
	,Borrower3__First_Name
	,Borrower3_Middle_Initial
	,Borrower3_Last_Name
	,Borrower3_FICO
	,Borrower3_SSN
	,Borrower3_DOB
	,Borrower3_Country_of_Citizenship
	,Borrower3_Position_Title_Type_of_Business
	,Borrower4__First_Name
	,Borrower4_Middle_Initial
	,Borrower4_Last_Name
	,Borrower4_FICO
	,Borrower4_SSN
	,Borrower4_DOB
	,Borrower4_Country_of_Citizenship
	,Borrower4_Position_Title_Type_of_Business

)

Select 	
	@JobID
	,'Client_ID' = '9345'
	,'Clients_Loan Number' = _364
	,'Draft_Num' = ''
	,'Original_Principal Balance' = _2	
	,'Unpaid_Principal Balance' = case when _service_x91 > 0 then _service_x91 else _2	end
	,'Note_Rate' = _3	
	,'P&I' = _228	
	,'First_payment Date' = _682	
	,'Maturity_Date' = _1961	
	,'Loan_Purpose' = Case _19
		WHEN 'Purchase' Then 'PURCHASE'
		WHEN 'Cash-Out Refinance' Then 'Cash out Refinance'
		WHEN 'NoCash-Out Refinance' THEN 'Refinance/Rate Term'
		WHEN 'ConstructionToPermanent' THEN 'Construction to Perm'
		Else _19
		END

	,'Takeout_Investor' = ''		
	,'Loan_Type' = Case When (left(_1401, 1) = 'C' OR LEFT(_1401, 5) = 'TXVTC') AND (_2278 ='BANK OF AMERICA' OR _2278 = 'COUNTRYWIDE HOME LOANS INC.') THEN 'CL Conforming' 
	When (left(_1401, 1) = 'C' OR LEFT(_1401, 5) = 'TXVTC')  THEN 'Conforming' 			
	When (left(_1401, 1) = 'F' OR LEFT(_1401, 5) = 'TXVTF') AND (_2278 ='BANK OF AMERICA' OR _2278 = 'COUNTRYWIDE HOME LOANS INC.') THEN 'CL FHA' 
	When (left(_1401, 1) = 'F' OR LEFT(_1401, 5) = 'TXVTF')  THEN 'FHA'
	When (left(_1401, 1) = 'V' OR LEFT(_1401, 5) = 'TXVTV') AND (_2278 ='BANK OF AMERICA' OR _2278 = 'COUNTRYWIDE HOME LOANS INC.') THEN 'CL VA'
	When (left(_1401, 1) = 'V' OR LEFT(_1401, 5) = 'TXVTV')  THEN 'VA'
	When (left(_1401, 1) = 'J')AND (_2278 ='BANK OF AMERICA' OR _2278 = 'COUNTRYWIDE HOME LOANS INC.') THEN 'CL JUMBO' 	
	When (left(_1401, 1) = 'J') THEN 'JUMBO' 
	END		
	,'Document Style_Type'= Case  When lower(left(_MORNET_X67,1)) = 'f' Then 'Full' when lower(LEFT(_MORNET_X67, 1)) = 'a' then 'Alternative' when lower(LEFT(_MORNET_X67,1)) = 's' Then 'Streamline' end -- ColumnVerbiage THEN E.ReportVerbiage ELSE 'Full' END	
	,'Amortization_Type' = case when _608 = 'GraduatedPaymentMortgage' Then 'GPM' else 'Basic' end
	,'Loan Payment_Type' = Convert(varchar(30), _608) --_1172
	,'Property_Type' = Case when PropertyType = 'Attached' and Convert(varchar(2),Convert(decimal(2,0),_16)) in ('1', '0','') Then 'Single Family Dwelling' WHEN PropertyType = 'Attached' THEN 'MFR'
		WHEN PropertyType = 'Condominium' THEN 'Condo' WHEN PropertyType = 'Cooperative' THEN 'Cooperative Housing' WHEN PropertyType = 'Detached' THEN 'Single Family Dwelling'
		WHEN PropertyType = 'HighRiseCondominium' THEN 'Condo' WHEN PropertyType = 'ManufacturedHousing' THEN 'Manufactured Home' WHEN PropertyType = 'PUD' THEN 'PUD'
		WHEN PropertyType = 'DetachedCondo' THEN 'Condo' WHEN PropertyType = 'ManufacturedHomeCondoPUDCoOp' THEN 'Manufactured Home' ELSE PropertyType END
	,'Property_Street Address' = REPLACE(_11,',', '')	
	,'Property_City'= REPLACE(_12,',', '')	
	,'Property_State' =REPLACE(_14,',', '')	
	,'Property_Zip' = Case WHEN _15 <> '' THEN '~' + Convert(Varchar(9), _15	)END
	,'Occupancy_Type' = CASE _1811	
		WHEN 'PrimaryResidence' THEN 'Owner Occupied' 
		WHEN 'SecondHome' THEN 'Second Home'
		WHEN 'Investor' THEN 'Non-owner Occupied' 
		ELSE _1811
		END 
	,'LTV' = _353	
	,'CLTV' = _976	
	,'Borrower_First Name' = CASE WHEN CHARINDEX(' ',REPLACE( _36,',', '')) > 1 THEN Substring(REPLACE(_36,',', ''), 1,(CHARINDEX(' ',_36))) ELSE _36 END	
	,'Borrowers_Middle Initial' = CASE WHEN CHARINDEX(' ',_36) > 1 THEN Substring(_36, (CHARINDEX(' ',_36)+1),1) ELSE ''END --SUBSTRING(,1,1)
	,'Borrower_Last Name' = Replace(_37		,',','')
	,'Borrower_SSN#' = ''		
	,'Borrower_FICO1' = _VASUMM_X23
	,'Subprime_Credit Grade' = '' -- will be empty until Subprime loans are initiated
	,'Requested_Advance Date' =Convert(Varchar(10), Log_MS_Date_FundsOrdered, 101)
	,'Requested_Wire Amount' = _1990	
	,'Wire_Recipient Name' = CASE WHEN _610 <> '' THEN  REPLACE(_610,',', '') ELSE REPLACE(_411,',', '') END--:_610	
	,'Wire Recipient_Address' = CASE WHEN _612 <> '' THEN REPLACE(_612,',', '') ELSE REPLACE(_412,',', '') END --_613--:
	,'Wire_Recipient City' = CASE WHEN 613<> '' THEN REPLACE(_613,',', '') ELSE REPLACE(_413,',', '') END--:
	,'Wire_Recipient State' =CASE WHEN _1175<> '' THEN REPLACE(_1175,',', '') ELSE REPLACE(_1174,',', '') END  
	,'Wire_Recipient Zip' = CASE WHEN _614<> '' THEN '~' + Convert(varchar(7),_614) WHEN _414 <> '' THEN '~' + Convert(varchar(7),_414) ELSE '' END	
	,'Title_Insurer' = CASE WHEN _411<> '' THEN REPLACE(_411,',', '') ELSE REPLACE(_186,',', '') END ----:
	,'Escrow/Title_Closing #' = CASE WHEN _186 <> '' THEN _186 ELSE _187 END 
	,'Bank_Name' = CASE WHEN _CX_FUNDING_21 <> '' THEN REPLACE(_CX_FUNDING_21,',', '') ELSE REPLACE(_CX_FUNDING_7,',', '') END
	,'Bank_City/State' = CASE WHEN _CX_FUNDING_12 <> '' THEN REPLACE(_CX_FUNDING_12,',', '') ELSE REPLACE(_CX_FUNDING_15,',', '')	 END
	,'Bank_ABA Num' = CASE WHEN _VEND_X398 <> '' THEN '~' + _VEND_X398 WHEN _VEND_X396 <> '' THEN '~' + _VEND_X396  ELSE '' END 
	,'Bank_Account' = CASE WHEN _VEND_X397 <> '' THEN '~' + Convert(varchar(25), _VEND_X397) When _VEND_X399 <> '' THEN '~' + Convert(varchar(25), _VEND_X399) ELSE ''END
	,'Line Type_(Warehouse/EPP)' =  	CASE _2278									
		WHEN 'Countrywide Home Loans Inc.' THEN 'REPO'
		WHEN 'Bank of America' THEN 'REPO' 
		ELSE 'REPO'
		END	
	,'Request_Type (C/W/D' = 'W'
	,'UW Confirm_Approval Type' = ''
	,'UW_Confirmation Num' = ''
	,'UW Expiration_Date' = ''
	,'Lock Confirm_Approval Type' =''
	,'Commitment_Num' = ''
	,'Takeout_Expiration Date' = ''
	,'Takeout_Price' = ''
	,'Investor_Loan Num' = Convert(varchar(12), _2288)
	,'HUD-1_Date' = ''
	,'Non_Performing Flag' = ''																																												
	,'Further Credit_Account Num' = _CX_FUNDING_5	
	,'Further Credit_Bank Name' = ''
	,'Auto_Link Flag' = ''
	,'Ext' = 'Deutsche Bank National Trust'
	,'Sub_Customer' = ''
	,'Bulk_Batch#' = ''
	,'Mailing_Address' =''
	,'Mailing_City' = ''
	,'Mailing_State' = ''
	,'Mailing_Zip' = ''
	,'MFR_Units' = Convert(Varchar(Max), Convert(Decimal(5,0),_16)) 
	,'Back_End Ratio' = ''
	,'Escrow' = ''
	,'Fixed_Period' =  Convert(varchar(max), Convert(decimal(5,0),_696))
	,'Index_Category' = Case when _608 != 'AdjustableRate' Then '' else Case when _1172 In ('FHA', 'VA') then 'Treasury 1 Year' when _1172 = 'Conventional'then 'Libor 1 Year' end end-- Convert(varchar(30), _1959) 
	,'Initial_Cap' = Convert(Varchar(Max), Convert(Decimal(5,0),_697)) 
	,'Periodic_Cap' = Convert(Varchar(Max), Convert(Decimal(15,3),_695))
	,'Lifetime_Cap' = Convert(Varchar(Max), Convert(Decimal(5,0),_247))
	,'Margin' = Convert(Varchar(Max), Convert(Decimal(15,3),_689))
	,'Interest_Only Term' = Convert(Varchar(Max), Convert(Decimal(5,0),_1177))
	,'LPMI_Premium' = ''
	,'PMI_Insurer' = ''
	,'PMI%' = ''
	,'Piggy_Back' = ''
	,'Prepay_Term ?' = ''
	,'Prepay_Months' = ''
	,'Prepay_Type' = ''
	,'Self_Employed?' = ''
	,'Start_Rate' = _3
	,'Number_of Units' = ''
	,'Appraised_Value' = ''
	,'Bankruptcy_Discharge Date' = Convert(Varchar(10), '',101)
	,'Foreclosure_Date' = ''
	,'Lien_Type' = CASE _420 WHEN 'First Lien' THEN 1 WHEN 'Second Lien' THEN 2 END
	,'0 * 30_Month Lates' = ''
	,'Section_32' = ''
	,'Note_Date' = Convert(Varchar(Max), Convert(Varchar(10),_748,101))
	,'Base_Loan_Amount' = Convert(varchar(max), Convert(decimal(18,2),_1109))
	,'Total_Rehab_Cost' = ''
	,'Line_Type_Repo_EPP' = ''
	,'Register_Flag' = ''
	,'External_Custodian' = 'Deutsche Bank'
	,'Impound_Amount' = ''
	,'Original_Amortization_Term' = Convert(Varchar(Max), Convert(Decimal(5,0),_4))
	,'Rate_Floor' = Convert(Varchar(Max), Convert(Decimal(7,3),_1699))
	,'MIN_Number' = ''
	,'Sub_Loan_Type' = ''
	,'Special_Loan_feature' = ''
	,'Debt_To_Income' = Convert(Varchar(max), Convert(decimal(9,5),_742))
	,'MIP_Perc' = '' --Convert(Varchar(Max), Convert(Decimal(7,3),_1107))
	,'Borrower1_DOB' = ''
	,'Borrower1_Country_of_Citizenship' = ''
	,'Borrower1_Position_Title_Type_of_Business' = ''
	,'Borrower2__First_Name' = ''
	,'Borrower2_Middle_Initial' = ''
	,'Borrower2_Last_Name' = ''
	,'Borrower2_FICO' = dbo.udfWiresGetSSN (_60, _1452, _1415)
	,'Borrower2_SSN' = ''
	,'Borrower2_DOB' = ''
	,'Borrower2_Country_of_Citizenship' = ''
	,'Borrower2_Position_Title_Type_of_Business' = ''
	,'Borrower3__First_Name' = ''
	,'Borrower3_Middle_Initial' = ''
	,'Borrower3_Last_Name' = ''
	,'Borrower3_FICO' = ''
	,'Borrower3_SSN' = ''
	,'Borrower3_DOB' = ''
	,'Borrower3_Country_of_Citizenship' = ''
	,'Borrower3_Position_Title_Type_of_Business' = ''
	,'Borrower4__First_Name' = ''
	,'Borrower4_Middle_Initial' = ''
	,'Borrower4_Last_Name' = ''
	,'Borrower4_FICO' = ''
	,'Borrower4_SSN' = ''
	,'Borrower4_DOB' = ''
	,'Borrower4_Country_of_Citizenship' = ''
	,'Borrower4_Position_Title_Type_of_Business' = ''



From  ERDB.ERDBuser.loansummary loansummary
INNER JOIN ERDB.ERDBuser.LOANXDB_D_01 LOANXDB_D_01 ON LoanSummary.XrefId = LOANXDB_D_01.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_D_02 LOANXDB_D_02 ON LoanSummary.XrefId = LOANXDB_D_02.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_N_01 LOANXDB_N_01 ON LoanSummary.XrefId = LOANXDB_N_01.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_N_02 LOANXDB_N_02 ON LoanSummary.XrefId = LOANXDB_N_02.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_N_03 LOANXDB_N_03 ON LoanSummary.XrefId = LOANXDB_N_03.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_N_04 LOANXDB_N_04 ON LoanSummary.XrefId = LOANXDB_N_04.XrefId 
INNER JOIN ERDB.ERDBuser.LOANXDB_N_05 LOANXDB_N_05 ON LoanSummary.XrefId = LOANXDB_N_05.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_N_06 LOANXDB_N_06 ON LoanSummary.XrefId = LOANXDB_N_06.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_N_07 LOANXDB_N_07 ON LoanSummary.XrefId = LOANXDB_N_07.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_N_08 LOANXDB_N_08 ON LoanSummary.XrefId = LOANXDB_N_08.XrefId

INNER JOIN ERDB.ERDBuser.LOANXDB_S_01 LOANXDB_S_01 ON LoanSummary.XrefId = LOANXDB_S_01.XrefId 
INNER JOIN ERDB.ERDBuser.LOANXDB_S_02 LOANXDB_S_02 ON LoanSummary.XrefId = LOANXDB_S_02.XrefId 
INNER JOIN ERDB.ERDBuser.LOANXDB_S_03 LOANXDB_S_03 ON LoanSummary.XrefId = LOANXDB_S_03.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_S_04 LOANXDB_S_04 ON LoanSummary.XrefId = LOANXDB_S_04.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_S_05 LOANXDB_S_05 ON LoanSummary.XrefId = LOANXDB_S_05.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_S_06 LOANXDB_S_06 ON LoanSummary.XrefId = LOANXDB_S_06.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_S_07 LOANXDB_S_07 ON LoanSummary.XrefId = LOANXDB_S_07.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_S_08 LOANXDB_S_08 ON LoanSummary.XrefId = LOANXDB_S_08.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_S_09 LOANXDB_S_09 ON LoanSummary.XrefId = LOANXDB_S_09.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_S_10 LOANXDB_S_10 ON LoanSummary.XrefId = LOANXDB_S_10.XrefId
INNER JOIN ERDB.ERDBuser.LOANXDB_S_11 LOANXDB_S_11 ON LoanSummary.XrefId = LOANXDB_S_11.XrefId
Inner join (Select LoanNumber From @WiresImport) WI ON LoanSummary.LoanNumber = WI.LoanNumber
--Left Join (Select ColumnVerbiage, ReportVerbiage From Monitoring..Encompass2DocTypeMapping Where Lender = 'BOA') E on LOANXDB_S_11._MORNET_X67 = E.ColumnVerbiage

END
/*
Select 	
	Client_ID
	,'ClientsLoan Number' = ClientsLoanNumber
	,Draft_Num 
	,'Original_Principal Balance' = Original_PrincipalBalance
	,'Unpaid_Principal Balance' = Unpaid_PrincipalBalance	
	,Note_Rate 
	,'P&I' = PI 
	,'First_payment Date' = Convert(varchar(10), First_payment , 101)
	,'Maturity_Date' = Convert(varchar(10), Maturity_Date , 101)
	,Loan_Purpose 
	,Takeout_Investor 	
	,Loan_Type  	
	,'Document Style_Type' = DocumentStyle_Type 
	,Amortization_Type 
	,'Loan Payment_Type' = LoanPayment_Type 
	,Property_Type 	
	,Property_Street 
	,Property_City 	
	,Property_State 	
	,Property_Zip 
	,Occupancy_Type 
	,LTV 
	,CLTV 
	,'Borrower_First Name' = Borrower_FirstName 
	,'Borrowers_Middle Initial' = Borrowers_MiddleInitial 
	,'Borrower_Last Name' = Borrower_LastName 
	,Borrower_SSN# 
	,Borrower_FICO1 
	,'Subprime_Credit Grade' = Subprime_CreditGrade 
	,'Requested_Advance Date' = Convert(Varchar(10), Requested_AdvanceDate , 101)
	,'Requested_Wire Amount' = Requested_WireAmount 
	,'Wire_Recipient Name' = Wire_RecipientName 
	,'Wire Recipient_Address' = WireRecipient_Address 
	,'Wire_Recipient City' = Wire_RecipientCity 
	,'Wire_Recipient State' = Wire_RecipientState 
	,'Wire_Recipient Zip' = Wire_RecipientZip
	,Title_Insurer 
	,'Escrow/Title_Closing#' = EscrowTitle_Closing
	,Bank_Name 
	,'Bank_City/State' = Bank_CityState 
	,'Bank_ABA Num' = Bank_ABANum 
	,Bank_Account 
	,'Line Type_(Warehouse/EPP)' = LineType_WarehouseEPP 
	,Request_Type 
	,'UW Confirm_Approval Type' = UWConfirm_ApprovalType 
	,'UW_Confirmation Num' = UW_ConfirmationNum 
	,'UW Expiration_Date' = UWExpiration_Date 
	,'Lock Confirm_Approval Type' = LockConfirm_ApprovalType 
	,Commitment_Num 
	,'Takeout_Expiration Date' = Takeout_ExpirationDate 
	,Takeout_Price 
	,'Investor_Loan Num' = Investor_LoanNum 
	,'HUD-1_Date' = HUD1_Date 
	,'Non_Performing Flag' = Non_PerformingFlag 
	,'Further Credit_Account Num' = FurtherCredit_AccountNum  
	,'Further Credit_Bank Name' = FurtherCredit_BankName 
	,'Auto_Link Flag' = Auto_LinkFlag
	,Ext 
	,Sub_Customer 
	,'Bulk_Batch#' = Bulk_BatchNum 
	,Mailing_Address 
	,Mailing_City 
	,Mailing_State 
	,Mailing_Zip 
	,MFR_Units 
	,'Do Not_Delete' = ''
	,'Do Not_Delete' = ''
	,'Do Not_Delete' = ''
	,'Do Not_Delete' = ''
	,'Do Not_Delete' = ''
	,'Do Not_Delete' = ''
	,'Do Not_Delete' = ''
	,'Do Not_Delete' = ''
	,'Do Not_Delete' = ''
	,'Back_End Ratio' = Back_EndRatio 
	,Escrow 
	,Fixed_Period
	,Index_Category 
	,Initial_Cap 
	,Periodic_Cap 
	,Lifetime_Cap 
	,Margin 
	,'Interest_Only Term' = Interest_OnlyTerm
	,LPMI_Premium 
	,PMI_Insurer 
	,'PMI%' = PMI 
	,Piggy_Back 
	,'Prepay_Term ?' = Prepay_Term 
	,Prepay_Months 
	,Prepay_Type 
	,'Self_Employed?' = Self_Employed 
	,Start_Rate 
	,'Number_of Units' = Number_ofUnits 
	,Appraised_Value 
	,'Bankruptcy_Discharge Date' = CASE WHEN Convert(varchar(10),Bankruptcy_DischargeDate, 101) = '01/01/1900' THEN '' ELSE Convert(Varchar(10), Bankruptcy_DischargeDate, 101) end
	,Foreclosure_Date 
	,Lien_Type 
	,'0 * 30_Month Lates' = ThirtyMonthLates 
	,Section_32 
From Monitoring..WiresBOA
where JobID = @jobID

*/
/***************************************************************************************************************
This section is for the new BOA file update 
****************************************************************************************************************/

Select 	
	Client_ID
	,'ClientsLoan Number' = ClientsLoanNumber
	,'Original_Principal Balance' = Original_PrincipalBalance
	,'Unpaid_Principal Balance' = Unpaid_PrincipalBalance	
	,Note_Rate 
	,'Note Date' = Note_Date
	,'P&I' = PI 
	,'Base Loan Amount' =Base_Loan_Amount
	,'Total Rehab Cost'	=Total_Rehab_Cost
	,'First_payment Date' = Convert(varchar(10), First_payment , 101)
	,'Maturity_Date' = Convert(varchar(10), Maturity_Date , 101)
	,Amortization_Type 
	,'Loan Payment_Type' = LoanPayment_Type 
	,'Line Type (Repo/EPP)' = Line_Type_Repo_EPP
	,'HUD-1_Date' = HUD1_Date 
	,'Register Flag' = Register_Flag
	,'External Custodian' = External_Custodian
	,Escrow
	,'Impound Amount' = Impound_Amount
	,'Fixed_Period' = Case when Convert(Decimal(10,2), Fixed_Period) = '0.00' then '' else Fixed_Period end
	,'Index_Category' = case when Convert(varchar(max),Index_Category) = '0.00' then '' else Index_Category end 
	,'Initial_Cap' = case when Convert(Decimal(10,2),Initial_Cap) = '0.00' then '' else Initial_Cap end 
	,'Periodic_Cap' = case when Convert(Decimal(10,3),Periodic_Cap) = '0.000' then '' else Periodic_Cap end
	,'Lifetime_Cap' = case when Convert(Decimal(10,2),Lifetime_Cap) = '0.00' then '' else Lifetime_Cap end
	,'Margin' =  case when Convert(Decimal(10,2),Margin) = '0.00' then '' else Margin end
	,'Interest_Only Term' = case when Convert(Decimal(10,2),Interest_OnlyTerm) = '0.00' then '' else Interest_OnlyTerm end
	,'Prepay_Term ?' = Prepay_Term 
	,Prepay_Months 
	,Prepay_Type 
	,Start_Rate 
	,'Original Amortization Term' = Original_Amortization_Term
	,'Rate Floor' = case when Convert(Decimal(10,2),Rate_Floor) = '0.00' then '' else Rate_Floor end 
	,'MIN Number' = MIN_Number
	,Loan_Type  	
	,'Sub Loan Type' = Sub_Loan_Type
	,'Special Loan feature' = Special_Loan_feature
	,Lien_Type 
	,Loan_Purpose 
	,'Document Style_Type' = DocumentStyle_Type 
	,Property_Type 
	,'MFR_Units' = Case when Convert(varchar(max),MFR_Units) = '0.00' then '' else MFR_Units end
	,Occupancy_Type 	
	,LTV 
	,CLTV 
	,'Debt To Income' = Debt_To_Income
	,Takeout_Investor 
	,'Subprime_Credit Grade' = Subprime_CreditGrade 
	,'UW Confirm_Approval Type' = UWConfirm_ApprovalType 
	,'UW_Confirmation Num' = UW_ConfirmationNum 
	,'UW Expiration_Date' = UWExpiration_Date 
	,'Lock Confirm_Approval Type' = LockConfirm_ApprovalType 
	,Commitment_Num 
	,'Takeout_Expiration Date' = Takeout_ExpirationDate 
	,Takeout_Price 
	,'Investor_Loan Num' = Investor_LoanNum 
	,'Non_Performing Flag' = Non_PerformingFlag 
	,LPMI_Premium 
	,'MIP %' = MIP_Perc
	,PMI_Insurer 
	,'PMI%' = PMI 
	,Piggy_Back 
	,'Self_Employed?' = Self_Employed 
	,Appraised_Value 
	,'Bankruptcy_Discharge Date' = CASE WHEN Convert(varchar(10),Bankruptcy_DischargeDate, 101) = '01/01/1900' THEN '' ELSE Convert(Varchar(10), Bankruptcy_DischargeDate, 101) end
	,Foreclosure_Date 
	,'0 * 30_Month Lates' = ThirtyMonthLates 	
	,Section_32 
	,Sub_Customer 
	,'Borrower_First Name' = Borrower_FirstName 
	,'Borrowers_Middle Initial' = Borrowers_MiddleInitial 
	,'Borrower_Last Name' = Borrower_LastName 
	,Borrower_FICO1 
	,Borrower_SSN# 
	,'Borrower1 DOB' = Borrower1_DOB
	,'Borrower1 Country of Citizenship' = Borrower1_Country_of_Citizenship
	,'Borrower1 Position/Title/Type of Business' = Borrower1_Position_Title_Type_of_Business
	,'Borrower2  First Name' = Borrower2__First_Name
	,'Borrower2 Middle Initial' = Borrower2_Middle_Initial
	,'Borrower2 Last Name' = Borrower2_Last_Name
	,'Borrower2 FICO' = Borrower2_FICO
	,'Borrower2 SSN' = Borrower2_SSN
	,'Borrower2 DOB' = Borrower2_DOB
	,'Borrower2 Country of Citizenship' = Borrower2_Country_of_Citizenship		
	,'Borrower2 Position/Title/Type of Business' = Borrower2_Position_Title_Type_of_Business
	,'Borrower3  First Name' = Borrower3__First_Name
	,'Borrower3 Middle Initial' = Borrower3_Middle_Initial
	,'Borrower3 Last Name' =Borrower3_Last_Name
	,'Borrower3 FICO' = Borrower3_FICO	
	,'Borrower3 SSN' = Borrower3_SSN
	,'Borrower3 DOB' = Borrower3_DOB
	,'Borrower3 Country of Citizenship' = Borrower3_Country_of_Citizenship
	,'Borrower3 Position/Title/Type of Business' = Borrower3_Position_Title_Type_of_Business
	,'Borrower4  First Name' = Borrower4__First_Name
	,'Borrower4 Middle Initial' = Borrower4_Middle_Initial	
	,'Borrower4 Last Name' = Borrower4_Last_Name
	,'Borrower4 FICO' = Borrower4_FICO
	,'Borrower4 SSN' = 	Borrower4_SSN
	,'Borrower4 DOB' = Borrower4_DOB
	,'Borrower4 Country of Citizenship' = Borrower4_Country_of_Citizenship	
	,'Borrower4 Position/Title/Type of Business' = 	Borrower4_Position_Title_Type_of_Business
	,Mailing_Address 
	,Mailing_City 
	,Mailing_State 
	,Mailing_Zip 
	,Property_Street 
	,Property_City 	
	,Property_State 	
	,Property_Zip 	
	,Draft_Num 	
	,'Requested_Advance Date' = Convert(Varchar(10), Requested_AdvanceDate , 101)
	,'Requested_Wire Amount' = Requested_WireAmount 
	,'Wire_Recipient Name' = Wire_RecipientName 
	,'Wire Recipient_Address' = WireRecipient_Address 
	,'Wire_Recipient City' = Wire_RecipientCity 
	,'Wire_Recipient State' = Wire_RecipientState 
	,'Wire_Recipient Zip' = Wire_RecipientZip
	,Title_Insurer 
	,'Escrow/Title_Closing#' = EscrowTitle_Closing
	,Bank_Name 
	,'Bank_City/State' = Bank_CityState 
	,'Bank_ABA Num' = Bank_ABANum 
	,Bank_Account 
	,Request_Type 
	,'Further Credit_Account Num' = FurtherCredit_AccountNum  
	,'Further Credit_Bank Name' = FurtherCredit_BankName 	
	,'Bulk_Batch#' = Bulk_BatchNum 
	

	--,'Line Type_(Warehouse/EPP)' = LineType_WarehouseEPP 
	--,'Auto_Link Flag' = Auto_LinkFlag
	--,Ext 
	--,MFR_Units 
	--,'Do Not_Delete' = 
	--,'Do Not_Delete' = 
	--,'Do Not_Delete' = 
	--,'Do Not_Delete' = 
	--,'Do Not_Delete' = 
	--,'Do Not_Delete' = 
	--,'Do Not_Delete' = 
	--,'Do Not_Delete' = 
	--,'Do Not_Delete' = 
	--,'Back_End Ratio' = Back_EndRatio 
	--,'Number_of Units' = Number_ofUnits 

From Monitoring..WiresBOA
where JobID = @Jobid



GO


grant exec on uspWiresBank to svcWiresWCF
go