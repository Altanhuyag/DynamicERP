IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spacc_BankInfo_DEL')
DROP PROC spacc_BankInfo_DEL
GO
CREATE PROC spacc_BankInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
)
WITH ENCRYPTION
AS  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@BankID			Nvarchar(10)	
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( BankID		NVARCHAR(10))
	EXEC sp_xml_removedocument @idoc 

    SELECT @BankID=BankID FROM #tmp	

	delete from accBankInfo 
	where BankID=@BankID

END
GO
