IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LicenseInfo_UPD')
DROP PROC sphrm_LicenseInfo_UPD
GO
CREATE PROC sphrm_LicenseInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				int,
			@LicenseInfoPkID	nvarchar(16),
			@EmployeeInfoPkID	nvarchar(16),
			@LicenseInfoTypeID	nvarchar(16),
			@LicenseInfoID	nvarchar(16),
			@CommandNo	nvarchar(16),
			@CommandDate	datetime,
			@StartDate	datetime,
			@FinishDate	datetime,
			@Descr	nvarchar(255),
			@CreatedDate	datetime,
			@LastUpdateDate	datetime,
			@UserName	nvarchar(150)

	
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	
				Adding				Int,
				LicenseInfoPkID	nvarchar(16),
				EmployeeInfoPkID	nvarchar(16),
				LicenseInfoTypeID	nvarchar(16),
				LicenseInfoID	nvarchar(16),
				CommandNo	nvarchar(16),
				CommandDate	datetime,
				StartDate	datetime,
				FinishDate	datetime,
				Descr	nvarchar(255),
				CreatedDate	datetime,
				LastUpdateDate	datetime,
				UserName	nvarchar(150))

	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@Adding=Adding, 
			@LicenseInfoPkID=LicenseInfoPkID,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@LicenseInfoPkID=LicenseInfoPkID,
			@LicenseInfoTypeID = LicenseInfoTypeID,
			@LicenseInfoID=LicenseInfoID,
			@CommandNo=CommandNo,
			@CommandDate=CommandDate,
			@StartDate=StartDate,
			@FinishDate=FinishDate,
			@Descr=isnull(Descr,''),
			@CreatedDate=isnull(CreatedDate,getdate()),
			@LastUpdateDate=isnull(LastUpdateDate,getdate()),
			@UserName=UserName
 	FROM #tmp	
	
	IF @Adding=0 BEGIN
			
		EXEC spsmm_LastSequence_SEL 'hrmLicenseInfo', @LicenseInfoPkID output
			
		IF (SELECT count(*) FROM hrmLicenseInfo WHERE LicenseInfoPkID=@LicenseInfoPkID) > 0 BEGIN
			RAISERROR('Дугаар давхардсан байна.',16,1)
			RETURN 1
		END
		
		INSERT INTO hrmLicenseInfo(LicenseInfoPkID,
									EmployeeInfoPkID,
									LicenseInfoTypeID,
									LicenseInfoID,
									CommandNo,
									CommandDate,
									StartDate,
									FinishDate,
									Descr,
									CreatedDate,
									LastUpdateDate,
									UserName
									)
		VALUES (@LicenseInfoPkID,
									@EmployeeInfoPkID,
									@LicenseInfoTypeID,
									@LicenseInfoID,
									@CommandNo,
									@CommandDate,
									@StartDate,
									@FinishDate,
									@Descr,
									@CreatedDate,
									@LastUpdateDate,
									@UserName)
	END
	ELSE 
		UPDATE	hrmLicenseInfo
        SET		LicenseInfoTypeID = @LicenseInfoTypeID,
				EmployeeInfoPkID=@EmployeeInfoPkID,
				LicenseInfoPkID=@LicenseInfoPkID,
				LicenseInfoID=@LicenseInfoID,
				CommandNo=@CommandNo,
				CommandDate=@CommandDate,
				StartDate=@StartDate,
				FinishDate=@FinishDate,
				Descr=@Descr,				
				LastUpdateDate=@LastUpdateDate,
				UserName=@UserName
		WHERE LicenseInfoPkID=@LicenseInfoPkID

END
GO
