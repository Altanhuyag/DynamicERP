IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AdvertenceInfo_UPD')
DROP PROC sphrm_AdvertenceInfo_UPD
GO
CREATE PROC sphrm_AdvertenceInfo_UPD
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
			@AdvertenceInfoPkID nvarchar(16),
			@AdvertenceName nvarchar(250),
			@AdvertenceTypeInfoPkID nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding		  TinyInt,
			AdvertenceInfoPkID nvarchar(16),
			AdvertenceName nvarchar(250),
			AdvertenceTypeInfoPkID nvarchar(16)
			)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@AdvertenceInfoPkID=AdvertenceInfoPkID,
			@AdvertenceName=AdvertenceName,
			@AdvertenceTypeInfoPkID=AdvertenceTypeInfoPkID
	FROM #tmp

	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmAdvertenceInfo', @AdvertenceInfoPkID output

		INSERT INTO hrmAdvertenceInfo(AdvertenceInfoPkID ,
									  AdvertenceTypeInfoPkID,
									  AdvertenceName 
									  )
		VALUES (@AdvertenceInfoPkID,
				@AdvertenceTypeInfoPkID,
				@AdvertenceName
				)	
	END
	ELSE
		UPDATE hrmAdvertenceInfo
		SET AdvertenceInfoPkID=@AdvertenceInfoPkID,
			AdvertenceTypeInfoPkID=@AdvertenceTypeInfoPkID,
			AdvertenceName=@AdvertenceName
			
		WHERE AdvertenceInfoPkID=@AdvertenceInfoPkID
END
GO
