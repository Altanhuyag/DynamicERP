
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resCardInfoGET_SEL')
DROP PROC spres_resCardInfoGET_SEL
GO
CREATE PROC spres_resCardInfoGET_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@CardID				nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				CardID	nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@CardID = CardID
	FROM #tmp

	SELECT a.CardID, FirstName + N' - ' + PhoneNumber AS FirstName, b.CardValue FROM resCardInfo a
	INNER JOIN resCardGroupInfo b ON b.CardGroupPkID = a.CardGroupPkID
	WHERE a.IsEnabled = 'Y' AND a.CardID = @CardID

END
GO
