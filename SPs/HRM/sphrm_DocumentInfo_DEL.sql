IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DocumentInfo_DEL')
DROP PROC sphrm_DocumentInfo_DEL
GO
CREATE PROC sphrm_DocumentInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@DocumentInfoPkID nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DocumentInfoPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	select @DocumentInfoPkID=DocumentInfoPkID from #tmp

  	DELETE FROM hrmDocumentInfo 
	where DocumentInfoPkID=@DocumentInfoPkID
END
GO
