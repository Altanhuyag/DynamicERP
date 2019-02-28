IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SheetDetailInfo_DEL')
DROP PROC sphrm_SheetDetailInfo_DEL
GO
CREATE PROC sphrm_ProjectGroupInfo_UPD
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
			@ProjectGroupInfoPkID	nvarchar(16),
			@ProjectGroupInfoName	nvarchar(250),
			@SortedOrder			int,
			@IsDepartment			nvarchar(1),
			@DepartmentPkID			nvarchar(16)			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			ProjectGroupInfoPkID	nvarchar(16),
			ProjectGroupInfoName	nvarchar(250),
			SortedOrder			int,
			IsDepartment			nvarchar(1),
			DepartmentPkID			nvarchar(16))
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@ProjectGroupInfoPkID	=ProjectGroupInfoPkID,
			@ProjectGroupInfoName	=ProjectGroupInfoName,
			@SortedOrder			=SortedOrder,
			@IsDepartment			=IsDepartment,
			@DepartmentPkID			=isnull(DepartmentPkID,'')
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmProjectGroupInfo', @ProjectGroupInfoPkID output

		INSERT INTO hrmProjectGroupInfo(
			ProjectGroupInfoPkID,
			ProjectGroupInfoName,
			SortedOrder,
			IsDepartment,
			DepartmentPkID)
		VALUES (@ProjectGroupInfoPkID,
			@ProjectGroupInfoName	,
			@SortedOrder			,
			@IsDepartment			,
			@DepartmentPkID)
	END
	ELSE
		UPDATE hrmProjectGroupInfo
		SET 
			ProjectGroupInfoPkID	=@ProjectGroupInfoPkID,
			ProjectGroupInfoName	=@ProjectGroupInfoName,
			SortedOrder			=@SortedOrder,
			IsDepartment			=@IsDepartment,
			DepartmentPkID			=@DepartmentPkID

		WHERE ProjectGroupInfoPkID	=@ProjectGroupInfoPkID
END
GO
