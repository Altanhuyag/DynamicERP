IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ProgramInfo_GET')
DROP PROC sphrm_ProgramInfo_GET
GO
CREATE PROC sphrm_ProgramInfo_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,
			@ProgramInfoPkID			nvarchar(16)

	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  ProgramInfoPkID			nvarchar(16))
					
	EXEC sp_xml_removedocument @idoc 	

	SELECT	
			@ProgramInfoPkID	=ProgramInfoPkID
	FROM #tmp

	SELECT * FROM hrmProgramInfo WHERE ProgramInfoPkID = @ProgramInfoPkID
END

GO
