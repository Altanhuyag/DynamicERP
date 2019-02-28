IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SumInfo_UPD')
DROP PROC sphrm_SumInfo_UPD
GO
CREATE PROC sphrm_SumInfo_UPD
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
			@SumID				nvarchar(20),
			@SumName			nvarchar(255),
			@AimagID			nvarchar(20),
			@SortNo				int
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			SumID					nvarchar(20),
			SumName					nvarchar(255),
			AimagID					nvarchar(20),
			SortNo					int
			)
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@SumID=SumID,
			@SumName=SumName,
			@AimagID=AimagID,
			@SortNo=ISNULL(SortNo,'0')
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmSumInfo', @SumID output

		INSERT INTO hrmSumInfo(
			SumID,
			SumName,
			AimagID,
			SortNo
			)
		VALUES (
			@SumID,
			@SumName,
			@AimagID,
			@SortNo)
	END
	ELSE
		UPDATE hrmSumInfo
		SET 
			SumID=@SumID,
			SumName=@SumName,
			AimagID=@AimagID,
			SortNo=@SortNo

		WHERE SumID=@SumID
END
GO
