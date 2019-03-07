
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spacc_CustomerInfo_SEL')
DROP PROC spacc_CustomerInfo_SEL
GO
CREATE PROC spacc_CustomerInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	SELECT N'0' AS CustomerPkID , N'' AS CustomerName, 0 as Discount
	UNION ALL
	SELECT CustomerPkID, CustomerName + N' (' + ISNULL(RegNo, '') + ')' AS CustomerName, ISNULL(Discount, 0) FROM accCustomerInfo  
	
END
GO
