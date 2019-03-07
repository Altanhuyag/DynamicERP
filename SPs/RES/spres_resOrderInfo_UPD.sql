
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resOrderInfo_UPD')
DROP PROC spres_resOrderInfo_UPD
GO
CREATE PROC spres_resOrderInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	DECLARE @idoc			INT,
	@OrderPkID nvarchar(16),
	@TablePkID nvarchar(16),
	@AdultNum int,
	@ChildrenNum int,
	@ReceiptNo nvarchar(35),
	@OrderDate datetime,
	@CustomerPkID nvarchar(16),
	@RoyaltyNo nvarchar(20),
	@Status int,
	@passvalue nvarchar(max)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	OrderPkID nvarchar(16),
				TablePkID nvarchar(16),
				AdultNum int,
				ChildrenNum int,
				ReceiptNo nvarchar(35),
				OrderDate datetime,
				CustomerPkID nvarchar(16),
				RoyaltyNo nvarchar(20),
				Status int,
				passvalue nvarchar(max)  )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@OrderPkID = OrderPkID,
	@TablePkID = TablePkID,
	@AdultNum = AdultNum,
	@ChildrenNum = ChildrenNum,
	@ReceiptNo = ReceiptNo,
	@OrderDate = OrderDate,
	@CustomerPkID = CustomerPkID,
	@RoyaltyNo = RoyaltyNo,
	@Status = Status,
	@passvalue = passvalue
	FROM #tmp

	BEGIN TRANSACTION
		
		IF EXISTS (SELECT * FROM resOrderInfo WHERE OrderPkID = @OrderPkID)
		BEGIN
			IF(@Status = 2)
			BEGIN
				UPDATE resOrderInfo SET 
				TablePkID = @TablePkID,
				AdultNum = @AdultNum,
				ChildrenNum = @ChildrenNum,
				ReceiptNo = @ReceiptNo,
				OrderDate = @OrderDate,
				CustomerPkID = @CustomerPkID,
				RoyaltyNo = @RoyaltyNo,
				Status = @Status
				WHERE OrderPkID = @OrderPkID
			END
		END
		ELSE
		BEGIN
			EXEC dbo.spsmm_LastSequence_SEL 'resOrderInfo', @OrderPkID OUTPUT
			INSERT INTO resOrderInfo VALUES
			(@OrderPkID, @TablePkID, @AdultNum, @ChildrenNum, @ReceiptNo, @OrderDate, @CustomerPkID, @RoyaltyNo, @Status)
		END
		
		DECLARE @name VARCHAR(max)
		DECLARE @iid nvarchar(16)
		DECLARE @prc money
		DECLARE @qty int
		DECLARE db_cursor CURSOR FOR 
		SELECT Name FROM splitstringbyseparator(@passvalue, ';')
		DELETE FROM resOrderItems WHERE OrderPkID = @OrderPkID

		OPEN db_cursor  
		FETCH NEXT FROM db_cursor INTO @name  

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
			
			SELECT 
			@iid = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 0),
			@prc = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 1),
			@qty = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 2)

			INSERT INTO resOrderItems VALUES(@OrderPkID, @iid, @prc, @qty)


		FETCH NEXT FROM db_cursor INTO @name 
		END 

		CLOSE db_cursor  
		DEALLOCATE db_cursor

	COMMIT TRANSACTION
END
GO

