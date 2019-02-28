IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AgeLimitInfo_UPD')
DROP PROC sphrm_AgeLimitInfo_UPD
GO
CREATE PROC sphrm_AgeLimitInfo_UPD
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
			@AgeLimitInfoPkID	nvarchar(16),
			@AgeLimitInfoName	nvarchar(150),
			@Age1				int,
			@Age2				int,
			@SortID				int			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			AgeLimitInfoPkID			nvarchar(16),
			AgeLimitInfoName			nvarchar(150),
			Age1						int,
			Age2						int,
			SortID						int)
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@AgeLimitInfoPkID=AgeLimitInfoPkID,
			@AgeLimitInfoName=AgeLimitInfoName,
			@Age1=Age1,
			@Age2=Age2,
			@SortID=SortID
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmAgeLimitInfo', @AgeLimitInfoPkID output

		INSERT INTO hrmAgeLimitInfo(
			AgeLimitInfoPkID,
			AgeLimitInfoName,
			Age1,
			Age2,
			SortID)
		VALUES (@AgeLimitInfoPkID,
			@AgeLimitInfoName,
			@Age1,
			@Age2,
			@SortID)
	END
	ELSE
		UPDATE hrmAgeLimitInfo
		SET 
			AgeLimitInfoName=@AgeLimitInfoName,
			Age1=@Age1,
			Age2=@Age2,
			SortID=@SortID

		WHERE AgeLimitInfoPkID=@AgeLimitInfoPkID
END
GO
