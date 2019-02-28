IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AdvertenceTypeInfo_UPD')
DROP PROC sphrm_AdvertenceTypeInfo_UPD
GO
CREATE PROC sphrm_AdvertenceTypeInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				TinyInt,
			@AdvertenceTypeInfoPkID nvarchar(16),
			@AdvertenceTypeName nvarchar(250)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding		  TinyInt,
			AdvertenceTypeInfoPkID nvarchar(16),
			AdvertenceTypeName nvarchar(250)
			
			)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@AdvertenceTypeInfoPkID=AdvertenceTypeInfoPkID,
			@AdvertenceTypeName=AdvertenceTypeName
			
	FROM #tmp

	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmAdvertenceTypeInfo', @AdvertenceTypeInfoPkID output

		INSERT INTO hrmAdvertenceTypeInfo(AdvertenceTypeInfoPkID ,
									 	  AdvertenceTypeName 
									  )
		VALUES (
				@AdvertenceTypeInfoPkID,
				@AdvertenceTypeName
				)	
	END
	ELSE
		UPDATE hrmAdvertenceTypeInfo
		SET AdvertenceTypeInfoPkID=@AdvertenceTypeInfoPkID,
			
			AdvertenceTypeName=@AdvertenceTypeName
			
		WHERE AdvertenceTypeInfoPkID=@AdvertenceTypeInfoPkID
END
GO
