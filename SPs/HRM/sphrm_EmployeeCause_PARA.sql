IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeCause_PARA')
DROP PROC sphrm_EmployeeCause_PARA
GO
create proc sphrm_EmployeeCause_PARA

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
			@FreedomTypePkID	nvarchar(16),
			@QueryString nvarchar(max)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( StartDate		datetime,
			   FinishDate		datetime,
			   IsType			nvarchar(1),
			   DateIs			nvarchar(1),
			   FreedomTypePkID   nvarchar(16)
			    )
	EXEC sp_xml_removedocument @idoc

	SELECT @StartDate=StartDate , @FinishDate=FinishDate,
	@IsType = IsType, @DateIs = DateIs, @FreedomTypePkID = FreedomTypePkID from #tmp
	
	SET @QueryString = 'select A.*,	B.FirstName AS FirstName,B.RegisterNo,C.DepartmentName,D.PositionName,
	E.FreedomTypeName,HPT.PatientTypeName,
	CI.CountryInfoName,Ai.AimagName
	from hrmEmployeeCause A
	inner join hrmEmployeeInfo B on A.EmployeeInfoPkID=B.EmployeeInfoPkID
	left join hrmDepartmentInfo C on B.DepartmentPkID=C.DepartmentPkID
	left join hrmPositionInfo D on B.PositionPkID=D.PositionPkID
	left join hrmFreedomTypeInfo E on A.FreedomTypePkID=E.FreedomTypePkID
	left join hrmHealthPatientTypeInfo HPT on A.PatientTypePkID = HPT.PatientTypePkID
	left join hrmCountryInfo CI on A.CountryInfoPkID = CI.CountryInfoPkID
	left join hrmAimagInfo AI on A.AimagID = AI.AimagID
	where 1=1 '
	if (isnull(@IsType,'N')='Y')
		SET @QueryString = @QueryString + ' and A.FreedomTypePkID = '''+@FreedomTypePkID+''''
	if (ISNULL(@DateIs,'N') = 'Y')
	set @QueryString = @QueryString + ' and convert(nvarchar,A.CommandDate,102) between convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@StartDate,102)+'''),102) and convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@FinishDate,102)+'''),102)'
	--raiserror(@QueryString,16,1)
	exec(@QueryString)
END
GO
