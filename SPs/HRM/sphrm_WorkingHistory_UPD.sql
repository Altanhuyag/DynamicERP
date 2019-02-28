IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_WorkingHistory_UPD')
DROP PROC sphrm_WorkingHistory_UPD
GO
CREATE PROC sphrm_WorkingHistory_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				TinyInt,
			@WorkingHistoryPkID	nvarchar(16),
			@EmployeeInfoPkID	nvarchar(16),
			@CompanyName		nvarchar(250),
			@PositionName		nvarchar(250),
			@Province			nvarchar(250),
			@NominativeDate		datetime,
			@RemissiveDate		datetime,
			@JobExitReasonPkID	nvarchar(16),
			@Description		nvarchar(255),
			@IsCompany			nvarchar(1),
			@EventInfoPkID		nvarchar(16)

	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				WorkingHistoryPkID	nvarchar(16),
				EmployeeInfoPkID	nvarchar(16),
				CompanyName			nvarchar(250),
				PositionName		nvarchar(250),
				Province			nvarchar(250),
				NominativeDate		datetime,
				RemissiveDate		datetime,
				JobExitReasonPkID	nvarchar(16),
				Description			nvarchar(255),
				IsCompany			nvarchar(1),
				EventInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@WorkingHistoryPkID=WorkingHistoryPkID,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@CompanyName=CompanyName,
			@PositionName=PositionName,
			@Province=Province,
			@NominativeDate=NominativeDate,
			@RemissiveDate=RemissiveDate,
			@JobExitReasonPkID=JobExitReasonPkID,
			@Description=Description,
			@IsCompany = IsCompany,
			@EventInfoPkID = EventInfoPkID
	FROM #tmp
   
	
	IF(@EmployeeInfoPkID = '' or @EmployeeInfoPkID is null)
	BEGIN
		RAISERROR(N'Ажилтнаа сонгоно уу!', 16, 1)
		RETURN
	END

	IF(@JobExitReasonPkID = '' or @JobExitReasonPkID is null)
	BEGIN
		RAISERROR(N'Шалтгаанаа сонгоно уу!', 16, 1)
		RETURN
	END

	IF(@EventInfoPkID = '' or @EventInfoPkID is null)
	BEGIN
		RAISERROR(N'Чиглэлээ сонгоно уу!', 16, 1)
		RETURN
	END
	
	IF @Adding=0 BEGIN

		EXEC dbo.spsmm_LastSequence_SEL 'hrmWorkingHistory', @WorkingHistoryPkID output

		INSERT INTO hrmWorkingHistory
							(	WorkingHistoryPkID,
								EmployeeInfoPkID,
								CompanyName,
								PositionName,
								Province,
								NominativeDate,
								RemissiveDate,
								JobExitReasonPkID,
								Description,
								IsCompany,
								EventInfoPkID)
		VALUES (				@WorkingHistoryPkID,
								@EmployeeInfoPkID,
								@CompanyName,
								@PositionName,
								@Province,
								@NominativeDate,
								@RemissiveDate,
								@JobExitReasonPkID,
								@Description,
								@IsCompany,
								@EventInfoPkID)
	END
	ELSE
		UPDATE hrmWorkingHistory
		SET EmployeeInfoPkID=@EmployeeInfoPkID,
			CompanyName=@CompanyName,
			Province=@Province,
			NominativeDate=@NominativeDate,
			RemissiveDate=@RemissiveDate,
			JobExitReasonPkID=@JobExitReasonPkID,
			Description=@Description,
			PositionName=@PositionName,
			IsCompany = @IsCompany,
			EventInfoPkID = @EventInfoPkID
		WHERE WorkingHistoryPkID=@WorkingHistoryPkID
END
GO
