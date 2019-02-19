IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DegreeInfo_UPD')
DROP PROC sphrm_DegreeInfo_UPD
GO
CREATE PROC sphrm_DegreeInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				int,
			@DegreeInfoPkID			NVARCHAR(20),
			@DegreeInfoName			nvarchar(250)
	
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	
				Adding				Int,
				DegreeInfoPkID				NVARCHAR(20),
				DegreeInfoName			nvarchar(250))

	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@Adding=Adding, @DegreeInfoPkID=DegreeInfoPkID, @DegreeInfoName=DegreeInfoName 	FROM #tmp	
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmDegreeInfo', @DegreeInfoPkID output

		INSERT INTO hrmDegreeInfo(DegreeInfoPkID, DegreeInfoName)
		VALUES (@DegreeInfoPkID, @DegreeInfoName)
	END
	ELSE 
		UPDATE	hrmDegreeInfo
        SET		DegreeInfoName=@DegreeInfoName
		WHERE DegreeInfoPkID=@DegreeInfoPkID

END
GO
