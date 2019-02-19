IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeMovement_PARA')
DROP PROC sphrm_EmployeeMovement_PARA
GO
create proc sphrm_EmployeeMovement_PARA

(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) with encryption

as

begin
SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@StartDate		datetime,
			@FinishDate		datetime,
			@IsType			nvarchar(1),
			@DateIs			nvarchar(1),
			@DepartmentPkID	nvarchar(16),
			@QueryString nvarchar(max)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( StartDate		datetime,
			   FinishDate		datetime,
			   IsType			nvarchar(1),
			   DateIs			nvarchar(1),
			   DepartmentPkID   nvarchar(16)
			    )
	EXEC sp_xml_removedocument @idoc

	SELECT @StartDate=StartDate , @FinishDate=FinishDate,
	@IsType = IsType, @DateIs = DateIs, @DepartmentPkID = DepartmentPkID from #tmp
	
	SET @QueryString = 'select A.*,B.FirstName AS FirstName,C.DepartmentName,C1.DepartmentName as OldDepartmentName,
	D.PositionName, D1.PositionName as OldPositionName, E.ValueStr1 as StatusName from hrmEmployeeMovement A
	inner join hrmEmployeeInfo B on A.EmployeeInfoPkID=B.EmployeeInfoPkID	
	left join hrmDepartmentInfo C on A.DepartmentPkID=C.DepartmentPkID
	left join hrmDepartmentInfo C1 on A.OldDepartmentPkID=C1.DepartmentPkID
	left join hrmPositionInfo D on A.PositionPkID=D.PositionPkID
	left join hrmPositionInfo D1 on A.OldPositionPkID=D1.PositionPkID	
	left join (select * from smmConstants where ConstType=''hrmEmployeeStatus'') E on B.Status = E.ConstKey
	where 1=1 '
	if (isnull(@IsType,'N')='Y')
		SET @QueryString = @QueryString + ' and A.DepartmentPkID = '''+@DepartmentPkID+''''
	if (ISNULL(@DateIs,'N') = 'Y')
	set @QueryString = @QueryString + ' and convert(nvarchar,A.StartDate,102) between convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@StartDate,102)+'''),102) and convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@FinishDate,102)+'''),102)'
	--raiserror(@QueryString,16,1)
	exec(@QueryString)
END
GO
