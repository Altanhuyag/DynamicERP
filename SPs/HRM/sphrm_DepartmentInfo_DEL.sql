IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DepartmentInfo_DEL')
DROP PROC sphrm_DepartmentInfo_DEL
GO
CREATE PROC sphrm_DepartmentInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
)
WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@DepartmentPkID	    nvarchar(16),
			@YearPkID nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( DepartmentPkID	    nvarchar(16))
	EXEC sp_xml_removedocument @idoc 

    SELECT @DepartmentPkID=DepartmentPkID FROM #tmp	

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	--Тухайн салбар нэгжийн мэдэлэл хүний бүртгэлд оржуу гэдгийг шалгах хэрэгтэй

	delete from hrmDepartmentInfo 
	where DepartmentPkID=@DepartmentPkID
	and YearPkID = @YearPkID
	and ParentPkID<>'-1'
END
GO
