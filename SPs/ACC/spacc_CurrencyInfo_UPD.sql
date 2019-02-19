----------------------------------------------------
-- <Үйлдэл> Салбар нэгжийн хуулах цонх
-- <Хийсэн> А.Алтанхуяг
-- <Хэзээ> 2018.08.28
-- <Өөрчлөлт оруулсан> 2018.08.28
------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spacc_CurrencyInfo_UPD')
DROP PROC spacc_CurrencyInfo_UPD
GO
CREATE PROC spacc_CurrencyInfo_UPD
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
			@CurrencyID			NVARCHAR(16),
			@CurrencyName		NVARCHAR(50),				
			@CreatedProgID		NVARCHAR(10),
			@CreatedDate	    DATETIME,
			@LastUpdate			DATETIME,
			@IPAddress			NVARCHAR(30),
			@LastUserName		NVARCHAR(30),
			@MACAddress			NVARCHAR(30),
			@IsMainCurrency		NVARCHAR(1)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				CurrencyID			NVARCHAR(6),
				CurrencyName		NVARCHAR(50),				
				CreatedProgID		NVARCHAR(10),
				CreatedDate		    DATETIME,
				LastUpdate			DATETIME,
				IPAddress			NVARCHAR(30),
				LastUserName		NVARCHAR(30),
				MACAddress			NVARCHAR(30),
				IsMainCurrency		NVARCHAR(1)
				)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT 	
		@Adding=Adding, 
		@CurrencyID=CurrencyID, 
		@CurrencyName=CurrencyName,
		@CreatedProgID=CreatedProgID,
		@CreatedDate=CreatedDate,
		@LastUpdate=LastUpdate,
		@IPAddress=IPAddress, 
		@LastUserName=LastUserName, 
		@MACAddress=MACAddress,
		@IsMainCurrency=IsMainCurrency
	FROM #tmp
	   
	IF @Adding=0 BEGIN 		
		if (@IsMainCurrency='Y')
		BEGIN
		if (select COUNT(*) from accCurrencyInfo where IsMainCurrency=@IsMainCurrency)>0
		begin
				 raiserror('Уучлаарай үндсэн мөнгөн тэмдэгт өмнө нь бүртгэгдсэн байна. Та зөвхөн нэг мөнгөн тэмдэгт бүртгэх боломжтой.',16,1)
				 return
		end
		END
			
				if (select COUNT(*) from accCurrencyInfo where CurrencyID=@CurrencyID)=0
					BEGIN		
						INSERT INTO accCurrencyInfo
						(
						CurrencyID, 
						CurrencyName,
						CreatedProgID,
						CreatedDate, 
						LastUpdate, 
						LastUserName,
						IPAddress, 
						MACAddress,
						IsMainCurrency
						)		
						VALUES 
						(
						@CurrencyID,
						@CurrencyName,
						'ACC',
						GETDATE(), 
						GETDATE(), 
						'',
						@IPAddress,
						@MACAddress,
						@IsMainCurrency
						) 
					END 		
					ELSE 
					BEGIN 	
						
						UPDATE accCurrencyInfo
						SET 
						
						CurrencyName=@CurrencyName,
						LastUpdate=GETDATE(),
						IPAddress=@IPAddress,
						MACAddress=@MACAddress,
						IsMainCurrency=@IsMainCurrency
						
						WHERE CurrencyID=@CurrencyID; 
					    
					END
		END
		ELSE 
					BEGIN 	
						
						UPDATE accCurrencyInfo
						SET 
						
						CurrencyName=@CurrencyName,
						LastUpdate=GETDATE(),
						IPAddress=@IPAddress,
						MACAddress=@MACAddress,
						IsMainCurrency=@IsMainCurrency
						
						WHERE CurrencyID=@CurrencyID; 
					    
					END
END



GO
