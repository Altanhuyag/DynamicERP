
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spacc_CurrencyInfoSCH_SEL')
DROP PROC spacc_CurrencyInfoSCH_SEL
GO
CREATE PROC spacc_CurrencyInfoSCH_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
)
WITH ENCRYPTION
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

	SELECT CurrencyID, CurrencyName, (case when IsMainCurrency = N'Y' then N'Тийм' else N'Үгүй' end) as IsMainCurrency FROM accCurrencyInfo where CurrencyName like N'%'+@name+'%'
END

GO
