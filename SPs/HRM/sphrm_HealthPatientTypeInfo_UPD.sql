IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_HealthPatientTypeInfo_UPD')
DROP PROC sphrm_HealthPatientTypeInfo_UPD
GO
CREATE PROC sphrm_HealthPatientTypeInfo_UPD
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
			@PatientTypePkID nvarchar(16),
			@PatientTypeName nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			PatientTypePkID nvarchar(16),
			PatientTypeName nvarchar(16)
			)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@PatientTypePkID=PatientTypePkID,
			@PatientTypeName=PatientTypeName
	FROM #tmp

	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmHealthPatientTypeInfo', @PatientTypePkID output

		INSERT INTO hrmHealthPatientTypeInfo(PatientTypePkID ,
				PatientTypeName
				)
		VALUES (
				@PatientTypePkID,
				@PatientTypeName
				)	
	END
	ELSE
		UPDATE hrmHealthPatientTypeInfo
		SET PatientTypePkID=@PatientTypePkID,
			PatientTypeName=@PatientTypeName
			
		WHERE PatientTypePkID=@PatientTypePkID
END
GO
