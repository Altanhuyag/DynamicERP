IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Award_UPD')
DROP PROC sphrm_Award_UPD
GO
CREATE PROC sphrm_Award_UPD
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
			@AwardPkID			nvarchar(16),
			@EmployeeInfoPkID			nvarchar(16),
			@CreatedDate		datetime,
			@CommandNo			nvarchar(10),
			@CommandName		nvarchar(150),
			@AwardTypeInfoPkID	nvarchar (16),
			@AwardInfoPkID		nvarchar (16),
			@AwardAmt			money,
			@AwardDescr			nvarchar(255),
			@GetCreatedDate		datetime,
			@AwardAdditionalDescr nvarchar(255),			
			@IsNotCompanyAward	nvarchar(1),
			@UserName			nvarchar(150)
			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			AwardPkID			nvarchar(16),
			EmployeeInfoPkID			nvarchar(16),
			CreatedDate		    datetime,
			CommandNo			nvarchar(10),
			CommandName		    nvarchar(150),
			AwardTypeInfoPkID	nvarchar (16),
			AwardInfoPkID		nvarchar (16),
			AwardAmt			money,
			AwardDescr			nvarchar(255),
			GetCreatedDate		datetime,
			AwardAdditionalDescr nvarchar(255),
			IsNotCompanyAward	nvarchar(1),
			UserName			nvarchar(150))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@AwardPkID=AwardPkID,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@CreatedDate=CreatedDate,
			@CommandNo=isnull(CommandNo,''),
			@CommandName=isnull(CommandName,''),
			@AwardTypeInfoPkID=AwardTypeInfoPkID,
			@AwardInfoPkID=AwardInfoPkID,
			@AwardAmt=isnull(AwardAmt,0),
			@AwardDescr=isnull(AwardDescr,''),
			@GetCreatedDate=GetCreatedDate,
			@AwardAdditionalDescr=isnull(AwardAdditionalDescr,''),
			@IsNotCompanyAward=IsNotCompanyAward,
			@UserName = UserName

	FROM #tmp
   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmAward', @AwardPkID output

		INSERT INTO hrmAward(
				AwardPkID,
				EmployeeInfoPkID,
				CreatedDate,
				CommandNo,
				CommandName,
				AwardTypeInfoPkID,
				AwardInfoPkID,
				AwardAmt,
				AwardDescr,
				GetCreatedDate,
				AwardAdditionalDescr,
				UserName,
				IsNotCompanyAward)
		VALUES (@AwardPkID,
				@EmployeeInfoPkID,
				@CreatedDate,
				@CommandNo,
				@CommandName,
				@AwardTypeInfoPkID,
				@AwardInfoPkID,
				@AwardAmt,
				@AwardDescr,
				@GetCreatedDate,
				@AwardAdditionalDescr,
				@UserName,
				@IsNotCompanyAward
				)
	END
	ELSE
		UPDATE hrmAward
		SET AwardPkID=@AwardPkID,
			EmployeeInfoPkID=@EmployeeInfoPkID,
			CreatedDate=@CreatedDate,
			CommandNo=@CommandNo,
			CommandName=@CommandName,
			AwardTypeInfoPkID=@AwardTypeInfoPkID,
			AwardInfoPkID=@AwardInfoPkID,
			AwardAmt=@AwardAmt,
			AwardDescr=@AwardDescr,
			GetCreatedDate=@GetCreatedDate,
			AwardAdditionalDescr=@AwardAdditionalDescr,
			UserName=@UserName,
			IsNotCompanyAward=@IsNotCompanyAward

		WHERE AwardPkID=@AwardPkID
END
GO
