IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AimagInfo_DEL')
DROP PROC sphrm_AimagInfo_DEL
GO
CREATE PROC sphrm_AimagInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
	@AimagID nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	AimagID		nvarchar(20))
	EXEC sp_xml_removedocument @idoc
	
	select @AimagID = AimagID from #tmp

	IF (select count(*) from hrmEmployeeInfo where AimagID = @AimagID)>0
	BEGIN
	 raiserror(N'Ажилтны бүртгэлд ашигласан байна. Устгах боломжгүй.',16,1)
	 return
	END
  
	DELETE A
	FROM hrmAimagInfo A
		INNER JOIN #tmp B ON A.AimagID=B.AimagID
END
GO
