IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_HealthPatientTypeInfo_GET')
DROP PROC sphrm_HealthPatientTypeInfo_GET
GO
CREATE PROC sphrm_HealthPatientTypeInfo_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@HealthPatientTypeInfoPkID			nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( HealthPatientTypeInfoPkID			nvarchar(16) )
	EXEC sp_xml_removedocument @idoc
	
	select * from hrmHealthPatientTypeInfo

	
END
GO
