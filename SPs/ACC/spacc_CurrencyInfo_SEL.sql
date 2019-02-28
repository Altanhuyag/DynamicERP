----------------------------------------------------
-- <Үйлдэл> Салбар нэгжийн хуулах цонх
-- <Хийсэн> А.Алтанхуяг
-- <Хэзээ> 2018.08.28
-- <Өөрчлөлт оруулсан> 2018.08.28
------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spacc_CurrencyInfo_SEL')
DROP PROC spacc_CurrencyInfo_SEL
GO
CREATE PROC spacc_CurrencyInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
)
WITH ENCRYPTION
AS
  
BEGIN
	SELECT * FROM accCurrencyInfo
END

GO
