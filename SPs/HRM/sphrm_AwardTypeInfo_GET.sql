IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AwardTypeInfo_GET')
DROP PROC sphrm_AwardTypeInfo_GET
GO
CREATE PROC sphrm_AwardTypeInfo_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@AwardTypeInfoPkID			nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( AwardTypeInfoPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc
	select * from hrmAwardTypeInfo

	
END
GO
