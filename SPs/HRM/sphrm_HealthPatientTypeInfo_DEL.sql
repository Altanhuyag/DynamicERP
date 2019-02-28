IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_HealthPatientTypeInfo_DEL')
DROP PROC sphrm_HealthPatientTypeInfo_DEL
GO
CREATE PROC sphrm_HealthPatientTypeInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@PatientTypePkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	PatientTypePkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @PatientTypePkID=PatientTypePkID FROM #tmp
	
	DELETE FROM hrmHealthPatientTypeInfo
	where PatientTypePkID = @PatientTypePkID
	
	END
GO
