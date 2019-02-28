
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_LifeTimeInfo_SEL')
DROP PROC sphtl_LifeTimeInfo_SEL
GO
CREATE PROC sphtl_LifeTimeInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	DECLARE @idoc			INT,
	@name nvarchar(150)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	name nvarchar(150) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@name = name
	FROM #tmp

	SELECT LifeTimePkID, LifeTimeName, StartDay, FinishDay, StartTime, FinishTime FROM htlLifeTime 
	WHERE LifeTimeName like N'%' + @name + '%'

END
GO
