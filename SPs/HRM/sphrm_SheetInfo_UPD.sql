IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SheetInfo_UPD')
DROP PROC sphrm_SheetInfo_UPD
GO
CREATE PROC sphrm_SheetInfo_UPD
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
			@SheetInfoPkID		nvarchar(16),
			@SheetInfoName		nvarchar(255),
			@SheetOrder			int,
			@SheetFileName		nvarchar(255)
			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				SheetInfoPkID		nvarchar(16),
				SheetInfoName		nvarchar(255),
				SheetOrder			int,
				SheetFileName		nvarchar(255))
	EXEC sp_xml_removedocument @idoc

	
	SELECT	@Adding=Adding,
			@SheetInfoPkID=SheetInfoPkID,
			@SheetInfoName=SheetInfoName,
			@SheetOrder=SheetOrder,
			@SheetFileName=SheetFileName
	FROM #tmp
 	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmSheetInfo', @SheetInfoPkID output

		INSERT INTO hrmSheetInfo
							(	SheetInfoPkID,
								SheetInfoName,
								SheetOrder,
								SheetFileName)
		
		VALUES (				@SheetInfoPkID,
								@SheetInfoName,
								@SheetOrder,
								@SheetFileName)
	END
	ELSE
		UPDATE hrmSheetInfo
		SET 
								SheetInfoName=@SheetInfoName,
								SheetOrder=@SheetOrder,
								SheetFileName=@SheetFileName
		WHERE SheetInfoPkID=@SheetInfoPkID
END
GO
