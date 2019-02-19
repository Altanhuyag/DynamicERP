IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Year_UPD')
DROP PROC sphrm_Year_UPD
GO
CREATE PROC sphrm_Year_UPD
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
			@YearPkID nvarchar(16),
			@Year1 int,
			@Year2 int
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			YearPkID nvarchar(16),
			Year1 int,
			Year2 int
			)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@YearPkID=YearPkID,
			@Year1=Year1,
			@Year2 = Year2
	FROM #tmp

	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmYear', @YearPkID output

		INSERT INTO hrmYearInfo(
				YearPkID ,
				Year1,
				Year2)
		VALUES (
				@YearPkID ,
				@Year1,
				@Year2)	
	END
	ELSE
		UPDATE hrmYearInfo
		SET 
			Year1=@Year1,
			Year2=@Year2
			
		WHERE YearPkID=@YearPkID
END
GO
