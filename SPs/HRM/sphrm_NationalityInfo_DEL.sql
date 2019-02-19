IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SumInfo_GET')
DROP PROC sphrm_SumInfo_GET
GO
CREATE PROC sphrm_NationalityInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc					INT,			
			@NationalityPkID		nvarchar(16),
			@Cnt					Int,
			@Descr					nvarchar(MAX),
			@LogUserGroupID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( NationalityPkID		nvarchar(16),
				LogUserGroupID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	SELECT @NationalityPkID=NationalityPkID, @LogUserGroupID=LogUserGroupID FROM #tmp
	--EXEC SystemManager.dbo.spsmm_RecordIsUsed @LogUserGroupID, 'hrmNationalityInfo',@NationalityPkID, @Cnt output, @Descr output

	IF @Cnt<>0
	BEGIN
 	    RAISERROR (@Descr, 16, 1)
	    RETURN (1)		
    END
   
	DELETE A
	FROM hrmNationalityInfo A
		INNER JOIN #tmp B ON A.NationalityPkID=B.NationalityPkID
END
GO
