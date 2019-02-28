IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EducationInfo_DEL')
DROP PROC sphrm_EducationInfo_DEL
GO
CREATE PROC sphrm_EducationInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@EducationPkID		nvarchar(16),
			@Cnt				Int,
			@Descr				nvarchar(MAX),
			@LogUserGroupID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( EducationPkID	nvarchar(16),
				LogUserGroupID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc 

	SELECT @EducationPkID=EducationPkID, @LogUserGroupID=LogUserGroupID FROM #tmp
	--exec dbo.spsmm_RecordIsUsed @LogUserGroupID, 'hrmEducationInfo',@EducationPkID, @Cnt output, @Descr output

	IF @Cnt<>0
	BEGIN
 	    RAISERROR (@Descr, 16, 1)
	    RETURN (1)		
    END
   
	DELETE A	
	FROM hrmEducationInfo A
		INNER JOIN #tmp B ON A.EducationPkID=B.EducationPkID
END
GO
