----------------------------------------------------
-- <Үйлдэл> Салбар нэгжийн хуулах цонх
-- <Хийсэн> А.Алтанхуяг
-- <Хэзээ> 2018.08.28
-- <Өөрчлөлт оруулсан> 2018.08.28
------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spacc_CurrencyInfo_DEL')
DROP PROC spacc_CurrencyInfo_DEL
GO
CREATE PROC spacc_CurrencyInfo_DEL
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
			@CurrencyID			Nvarchar(6),
			@ProgID				nvarchar(6),
			@CreatedProgID		nvarchar(6)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( CurrencyID		NVARCHAR(6),
				ProgID			nvarchar(10))
	EXEC sp_xml_removedocument @idoc 

    SELECT @CurrencyID=CurrencyID,@ProgID = isnull(ProgID,'') FROM #tmp	

	select @CreatedProgID = CreatedProgID from accCurrencyInfo where CurrencyID=@CurrencyID
		
	IF (@CreatedProgID <> @ProgID and @ProgID<>'')
	BEGIN
		raiserror(N'Устгах боломжгүй байна. Энэ програмаас үүсгэсэн бичлэг биш байна.',16,1)
		return
	END

	delete from accCurrencyInfo 
	where CurrencyID=@CurrencyID
END
GO