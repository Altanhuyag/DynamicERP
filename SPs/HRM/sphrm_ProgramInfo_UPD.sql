IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ProgramInfo_UPD')
DROP PROC sphrm_ProgramInfo_UPD
GO
CREATE PROC sphrm_ProgramInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,
			@Adding						TinyInt,
			@ProgramInfoPkID			nvarchar(16),
			@ProgramName				nvarchar(250)
			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,	
			ProgramInfoPkID			nvarchar(16),
			ProgramName				nvarchar(250))
					
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	
			@Adding=Adding,
			@ProgramInfoPkID	=ProgramInfoPkID,
			@ProgramName		=ProgramName
	FROM #tmp

	IF @Adding=0 BEGIN
	
		exec dbo.spsmm_LastSequence_SEL 'hrmProgramInfo',@ProgramInfoPkID output
		
		INSERT INTO hrmProgramInfo 
					(	ProgramInfoPkID,
						ProgramName )
		
		VALUES (@ProgramInfoPkID,
				@ProgramName )
	END
	ELSE

		UPDATE hrmProgramInfo
		SET ProgramName =@ProgramName
		WHERE ProgramInfoPkID =@ProgramInfoPkID
END

GO
