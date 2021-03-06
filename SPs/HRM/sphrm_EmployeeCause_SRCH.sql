IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeCause_SRCH')
DROP PROC sphrm_EmployeeCause_SRCH
GO
create proc sphrm_EmployeeCause_SRCH

(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) with encryption

as

begin
SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@BeginDate		datetime,
			   @FinishDate		datetime,
			   @IsType1			nvarchar(1),
			   @IsDate1			nvarchar(1),
			   @TypeName		   nvarchar(50)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( BeginDate		datetime,
			   FinishDate		datetime,
			   IsType1			nvarchar(1),
			   IsDate1			nvarchar(1),
			   TypeName		   nvarchar(50)
			    )
	EXEC sp_xml_removedocument @idoc

	SELECT @BeginDate=BeginDate, @FinishDate=FinishDate,
	@IsType1 = IsType1, @IsDate1 = IsDate1, @TypeName = TypeName from #tmp
	
	select * from (
	select A.*,B.LastName,	B.FirstName AS FirstName,B.RegisterNo,C.DepartmentName,D.PositionName,
	E.FreedomTypeName,HPT.PatientTypeName,
	CI.CountryName,Ai.AimagName,
	case when A.CreatedFormName='frmEmployeeFreedom' then N'Чөлөө'
	when A.CreatedFormName='frmHealthStatus1' then N'Акт'
	when A.CreatedFormName='frmEmployeeMission' then N'Томилолт'
	when A.CreatedFormName='frmPregnant' then N'Жирэмсэний амралт'
	when A.CreatedFormName='frmEmployeeVacation' then N'Ээлжийн амралт'
	else '' end as TypeName	from hrmEmployeeCause A
	inner join hrmEmployeeInfo B on A.EmployeeInfoPkID=B.EmployeeInfoPkID
	left join hrmDepartmentInfo C on B.DepartmentPkID=C.DepartmentPkID
	left join hrmPositionInfo D on B.PositionPkID=D.PositionPkID
	left join hrmFreedomTypeInfo E on A.FreedomTypePkID=E.FreedomTypePkID
	left join hrmHealthPatientTypeInfo HPT on A.PatientTypePkID = HPT.PatientTypePkID
	left join hrmCountryInfo CI on A.CountryInfoPkID = CI.CountryID
	left join hrmAimagInfo AI on A.AimagID = AI.AimagID
	) A
	where case when @IsType1='Y' then A.TypeName else '' end = case when @IsType1='Y' then @TypeName else '' end
	and case when @IsDate1='Y' then A.StartDate else getdate() end between case when @IsDate1='Y' then @BeginDate else getdate() end and case when @IsDate1='Y' then @FinishDate else getdate() end
END
GO
