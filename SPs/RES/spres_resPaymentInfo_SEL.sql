
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resPaymentInfo_SEL')
DROP PROC spres_resPaymentInfo_SEL
GO
CREATE PROC spres_resPaymentInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	
	SELECT PaymentPkID, PaymentName FROM resPaymentInfo

END
GO
