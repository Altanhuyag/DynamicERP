IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spacc_BankInfo_UPD')
DROP PROC spacc_BankInfo_UPD
GO
CREATE PROC spacc_BankInfo_UPD
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
			@Adding				TinyInt,
			@BankID				NVARCHAR(10),
			@BankName			NVARCHAR(200),
			@CreatedDate		DATETIME,
			@CreatedProgID		NVARCHAR(10),
			@LastUpdate			DATETIME,
			@IPAddress			NVARCHAR(30),
			@LastUserName		NVARCHAR(30),
			@MACAddress			nvarchar(30)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				BankID				NVARCHAR(10),
				BankName			NVARCHAR(200),
				CreatedDate			DATETIME,
				CreatedProgID		NVARCHAR(10),
				LastUpdate			DATETIME,
				IPAddress			NVARCHAR(30),
				LastUserName		NVARCHAR(30),
				MACAddress			nvarchar(30)
	)
	EXEC sp_xml_removedocument @idoc 	

	--RAISERROR(@XML,16,1)
	SELECT 
	@Adding = Adding,
	@BankID=BankID,
	@BankName=BankName,
	@CreatedDate=GETDATE(),
	@CreatedProgID=isnull(CreatedProgID,'ACC'),
	@LastUpdate=GETDATE(),
	@IPAddress=isnull(IPAddress,''),
	@LastUserName='',
	@MACAddress=isnull(MACAddress,'')

	 FROM #tmp  
	IF @Adding=0 
	BEGIN 
		if (select COUNT(*) from accBankInfo where BankID=@BankID)=0
		BEGIN
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
			@IPAddress,
			'',			
			@MACAddress
			) 
		END	
			
		ELSE
		BEGIN
			UPDATE accBankInfo
			SET 
				BankName = @BankName,
				LastUserName = @LastUserName,
				LastUpdate=getdate(),
				IPAddress = @IPAddress,
				MACAddress=@MACAddress
			WHERE BankID=@BankID 
		END
		
	END
		ELSE
		BEGIN
			UPDATE accBankInfo
			SET 
				BankName = @BankName,
				LastUserName = @LastUserName,
				LastUpdate=getdate(),
				IPAddress = @IPAddress,
				MACAddress=@MACAddress
			WHERE BankID=@BankID 
		END
END
GO
