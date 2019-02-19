USE GeganetMedical
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROC sphrm_WorkRoleInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@WorkRolePkID		nvarchar(16),
			@Cnt				Int,
			@Descr				nvarchar(MAX),
			@LogUserGroupID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( WorkRolePkID		nvarchar(16),
				LogUserGroupID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc 

	SELECT @WorkRolePkID=WorkRolePkID, @LogUserGroupID=LogUserGroupID FROM #tmp
	
	IF @Cnt<>0
	BEGIN
 	    RAISERROR (@Descr, 16, 1)
	    RETURN (1)		
    END
   
	delete A
	from hrmWorkRoleInfo A
		INNER JOIN #tmp B ON A.WorkRolePkID=B.WorkRolePkID

END
GO
