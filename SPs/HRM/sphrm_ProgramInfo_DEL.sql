IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ProgramInfo_DEL')
DROP PROC sphrm_ProgramInfo_DEL
GO
CREATE PROC sphrm_ProgramInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@ProgramInfoPkID nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	ProgramInfoPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	select @ProgramInfoPkID=ProgramInfoPkID from #tmp

  	DELETE FROM hrmProgramInfo 
	where ProgramInfoPkID=@ProgramInfoPkID
END
GO
