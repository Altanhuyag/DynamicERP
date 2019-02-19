IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Degree_DEL')
DROP PROC sphrm_Degree_DEL
GO
CREATE PROC sphrm_Degree_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@DegreePkID			nvarchar(16)
						
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DegreePkID			nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @DegreePkID=DegreePkID FROM #tmp
	
	DELETE FROM hrmDegree WhERE DegreePkID=@DegreePkID
END
GO
