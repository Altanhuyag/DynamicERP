IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SumInfo_GET')
DROP PROC sphrm_SumInfo_GET
GO
CREATE PROC sphrm_SumInfo_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@AimagID			nvarchar(20)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( AimagID		nvarchar(20) )
	EXEC sp_xml_removedocument @idoc

	SELECT @AimagID=AimagID FROM #tmp
	select A.*, B.AimagName from hrmSumInfo A
	left join hrmAimagInfo B on A.AimagID=B.AimagID
	where A.AimagID=@AimagID
	
END
GO
