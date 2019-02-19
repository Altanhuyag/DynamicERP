IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LocationCodeInfo_UPD')
DROP PROC sphrm_LocationCodeInfo_UPD
GO
CREATE PROC sphrm_LocationCodeInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@Adding				TinyInt,
			@LocationCodePkID	nvarchar(16),
			@LocationCodeName	nvarchar(255),
			@IsEnabled	nvarchar(1)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				LocationCodePkID	nvarchar(16),
				LocationCodeName	nvarchar(255),
				IsEnabled	nvarchar(1)
				)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @LocationCodePkID=LocationCodePkID,@LocationCodeName=LocationCodeName,@IsEnabled=IsEnabled FROM #tmp
   
	
	IF @Adding=0 BEGIN
	
		IF (SELECT COUNT(*) FROM hrmLocationCodeInfo WHERE LocationCodeName=@LocationCodeName) > 0
			BEGIN
 				RAISERROR ('Таны байршлын газрын нэр давхардаж байна. Та өөр нэр оруулна уу!', 16, 1)
				RETURN (1)
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmLocationCodeInfo', @LocationCodePkID output

		INSERT INTO hrmLocationCodeInfo(LocationCodePkID,
										LocationCodeName,
										IsEnabled
										)		
		VALUES (@LocationCodePkID,
										@LocationCodeName,
										@IsEnabled) 
	END
	ELSE
		UPDATE hrmLocationCodeInfo
		SET @LocationCodeName=@LocationCodeName,IsEnabled=@IsEnabled
		WHERE LocationCodePkID=@LocationCodePkID
		
	select @LocationCodePkID as LocationCodePkID
END
GO
