Use EmailReports
Go

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

If (OBJECT_ID('uspSendNetPopMimeSharedEmail', 'P') IS NOT NULL)
	Drop Procedure [dbo].[uspSendNetPopMimeSharedEmail];
Go

CREATE PROCEDURE [dbo].[uspSendNetPopMimeSharedEmail]
	@Recipients varchar (1000),
	@Subject varchar (200),
	@Message varchar (max),
	@FromEmail varchar (50),
	@SourceAppName varchar (50),
	@CcEmail varchar (1000) = null,
	@BccEmail varchar (1000) = null,
	@Attachments varchar (2000) = null
AS
	Declare @NetPopMimeSharedID bigint,
			@EmailSent bit

	Begin Try
		Insert Into NetPopMimeShared (Recipients, Subject, Message, Receivedtime, EmailSent, FromEmail, SourceAppName, CcEmail, BccEmail, Attachments)
		values (@Recipients, @Subject, @Message, GetDate(), 0, @FromEmail, @SourceAppName, @CcEmail, @BccEmail, @Attachments)
		
		Set @NetPopMimeSharedID = SCOPE_IDENTITY()
		
		EXEC msdb.dbo.sp_send_dbmail
		 @profile_name=@FromEmail,
		 @recipients= @Recipients,
		 @copy_recipients = @CcEmail,
		 @blind_copy_recipients = @BccEmail,
		 @body=@Message, 
		 @subject = @Subject,
		 @body_format = 'HTML',
		 @file_attachments=@Attachments
		 
		Update NetPopMimeShared
		Set EmailSent = 1,
			SentTime = GetDate()
		Where NetPopMimeSharedID = @NetPopMimeSharedID
	End Try
	Begin Catch
		Declare @Err_Message varchar(255),
				@Err_Number bigint,
				@Err_Severity int
				
		Select @Err_Message = ERROR_MESSAGE(), @Err_Number = ERROR_NUMBER(), @Err_Severity = ERROR_SEVERITY()
				
		--Log error
		EXEC xp_logevent @Err_Number, @Err_Message, @Err_Severity
	End Catch
Go

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
