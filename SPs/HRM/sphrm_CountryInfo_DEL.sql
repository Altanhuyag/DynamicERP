IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_CountryInfo_DEL')
DROP PROC sphrm_CountryInfo_DEL
GO
CREATE PROC sphrm_CountryInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	CountryID		nvarchar(20) )
	EXEC sp_xml_removedocument @idoc

  	DELETE A
	FROM hrmCountryInfo A
		INNER JOIN #tmp B ON A.CountryID =B.CountryID
END
GO
