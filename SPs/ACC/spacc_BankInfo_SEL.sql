IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spacc_BankInfo_SEL')
DROP PROC spacc_BankInfo_SEL
GO
CREATE PROC spacc_BankInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
)
WITH ENCRYPTION
AS
  
BEGIN
	SELECT *,BankID+' '+BankName as BankDescr FROM accBankInfo
END

GO
