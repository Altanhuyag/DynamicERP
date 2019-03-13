IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spacc_BankInfo_IMPORT')
DROP PROC spacc_BankInfo_IMPORT
GO
CREATE PROC spacc_BankInfo_IMPORT
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
			@BankID				NVARCHAR(10),
			@BankName			NVARCHAR(200)
		
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				BankID				NVARCHAR(10),
				BankName			NVARCHAR(200)				
	)
	EXEC sp_xml_removedocument @idoc 	

	--RAISERROR(@XML,16,1)
	SELECT 
		@BankID=BankID,
		@BankName=BankName
	
	 FROM #tmp  
	 

			INSERT INTO accBankInfo
			(
			BankID,
			BankName,
			CreatedDate,
			CreatedProgID,
			LastUpdate,
			IPAddress,
			LastUserName,
			MACAddress
			)		
			VALUES 
			(
			@BankID,
			@BankName,
			GetDate(),
			'DYA',
			GETDATE(),
			'-',
			'',			
			'-'
			) 
		
END
GO
