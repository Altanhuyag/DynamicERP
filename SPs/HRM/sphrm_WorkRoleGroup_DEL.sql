USE GeganetMedical
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROC sphrm_WorkRoleGroup_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@WorkRoleGroupPkID	nvarchar(16),
			@Cnt				Int,
			@Descr				nvarchar(MAX),
			@LogUserGroupID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( WorkRoleGroupPkID	nvarchar(16),
				LogUserGroupID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc 

	SELECT @WorkRoleGroupPkID=WorkRoleGroupPkID, @LogUserGroupID=LogUserGroupID FROM #tmp
	
	   
	delete A	
	from hrmWorkRoleGroup A
		INNER JOIN #tmp B ON A.WorkRoleGroupPkID=B.WorkRoleGroupPkID

END
GO
