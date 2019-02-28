IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_BreachInfo_UPD')
DROP PROC sphrm_BreachInfo_UPD
GO
CREATE PROC sphrm_BreachInfo_UPD
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
			@BreachPkID		NVARCHAR(16),
			@BreachName		NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				BreachPkID			NVARCHAR(16),
				BreachName			NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @BreachPkID=BreachPkID, @BreachName=BreachName FROM #tmp
   
	
	IF @Adding=0 BEGIN
	
		IF (SELECT COUNT(*) FROM hrmBreachInfo WHERE BreachName=@BreachName) > 0
			BEGIN
 				RAISERROR ('Зөрчил шийтгэлийн нэр давхардаж байна !', 16, 1)
				RETURN (1)
			END
		
		EXEC spsmm_LastSequence_SEL 'hrmBreachInfo', @BreachPkID output

		INSERT INTO hrmBreachInfo(BreachPkID, BreachName )		
		VALUES (@BreachPkID, @BreachName ) 
	END
	ELSE
		UPDATE hrmBreachInfo
		SET BreachName=@BreachName
		WHERE BreachPkID=@BreachPkID
END
GO
