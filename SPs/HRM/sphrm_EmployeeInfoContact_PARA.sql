IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoContact_PARA')
DROP PROC sphrm_EmployeeInfoContact_PARA
GO
create proc sphrm_EmployeeInfoContact_PARA

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
			@DateIs			nvarchar(1),
			@IsRegisterNo		nvarchar(1),
			@RegisterNo		nvarchar(16),
			@QueryString	nvarchar(max)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( StartDate		datetime,
			   FinishDate		datetime,
			   DateIs			nvarchar(1),
			   IsRegisterNo		nvarchar(1),
			   RegisterNo		nvarchar(16)
			    )
	EXEC sp_xml_removedocument @idoc

	SELECT @StartDate=Startdate , @FinishDate=FinishDate, @DateIs = DateIs,
	@IsRegisterNo=IsRegisterNo,
	@RegisterNo=RegisterNo from #tmp
	
	SET @QueryString = 'select A.*,B.FirstName AS FirstName,P.PositionName,
	D.DepartmentName,C.ValueStr1 as StatusName,P1.PositionGroupName,P.PositionName,CC.ValueStr1 as SalaryTypeName,CCC.ValueStr1 as WorkingStatusName,
	case when A.EndDate<getdate() then N''Хөдөлмөрийн гэрээг сунгах шаардлага'' 
	else N''Хөдөлмөрийн гэрээ хэвийн'' end As ContactStatusName 
	from hrmEmployeeInfoContact A
	left join hrmEmployeeInfo B on A.EmployeeInfoPkID = B.EmployeeInfoPkID
	left join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID
	left join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
	left join hrmPositionGroup P1 on A.PositionGroupPkID=P1.PositionGroupPkID
	left join (select * from smmConstants where ConstType=''hrmEmployeeStatus'') C on A.Status = C.ConstKey
	left join (select * from smmConstants where ConstType=''hrmSalaryType'') CC on A.SalaryTypeID = CC.ValueNum
	left join (select * from smmConstants where ConstType=''hrmWorkingStatus'') CCC on A.WorkingStatusID = CCC.ValueNum
	where 1=1 '
	if (isnull(@IsRegisterNo,'N')='Y')
		SET @QueryString = @QueryString + ' and A.RegisterNo = N'''+@RegisterNo+''''
	if (ISNULL(@DateIs,'N') = 'Y')
		set @QueryString = @QueryString + ' and convert(nvarchar,A.BeginDate,102) between convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@StartDate,102)+'''),102) and convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@FinishDate,102)+'''),102)'
	--raiserror(@QueryString,16,1)
	exec(@QueryString)
END
GO
