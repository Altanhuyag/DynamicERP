IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeDetailSearch_SEL')
DROP PROC sphrm_EmployeeDetailSearch_SEL
GO

CREATE PROC sphrm_EmployeeDetailSearch_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@ProfessionPkID		nvarchar(16),
			@EducationPkID		nvarchar(16),
			@PositionGroupPkID	nvarchar(16),
			@BeginDate			datetime,
			@EndDate				datetime,
			@CountryPkID			nvarchar(16),
			@UniversityPkID		nvarchar(16),
			@PositionPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  ProfessionPkID		nvarchar(16),
				EducationPkID		nvarchar(16),
				PositionGroupPkID	nvarchar(16),
				BeginDate			datetime,
				EndDate				datetime,
				CountryPkID			nvarchar(16),
				UniversityPkID		nvarchar(16),
				PositionPkID		nvarchar(16))
				
	EXEC sp_xml_removedocument @idoc

	SELECT  @ProfessionPkID = isnull(ProfessionPkID,''),
			@EducationPkID=isnull(EducationPkID,''),
			@PositionGroupPkID=isnull(PositionGroupPkID,''),
			@BeginDate=isnull(BeginDate,''),
			@EndDate=isnull(EndDate,''),
			@CountryPkID=isnull(CountryPkID,''),
			@UniversityPkID=isnull(UniversityPkID,''),
			@PositionPkID=isnull(PositionPkID,'') FROM #tmp
	
	
	SELECT D.DepartmentID,LC.LocationCodeName,A.*,D.DepartmentName,P.PositionName,PG.PositionGroupName , 
	C.ValueStr1 as MaleName,EI.EmployeePicture ImageFile,year(getdate())-year(A.Birthday) as Age,E.EducationName,C1.ValueStr1 as StatusName FROM hrmEmployeeInfo A
	left join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID	
	left join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
	left join hrmPositionGroup PG on A.PositionGroupPkID = PG.PositionGroupPkID
	left join (select * from smmConstants where ConstType='hrmMaleInfo') as C on A.Gender = C.ConstKey
	left join (select * from smmConstants where ConstType='hrmEmployeeStatus') as C1 on A.Status = C1.ConstKey
	left join hrmEmployeeImage EI on A.EmployeeInfoPkID = EI.EmployeePkID
	LEFT JOIN hrmEducationInfo E ON A.EducationPkID = E.EducationPkID
	left join hrmLocationCodeInfo LC on A.LocationCodePkID = LC.LocationCodePkID
	where A.Status<>'N'
	and case when @ProfessionPkID='' then '' else A.ProfessionPkID end = case when @ProfessionPkID='' then '' else @ProfessionPkID end
	and case when @EducationPkID='' then '' else A.EducationPkID end = case when @EducationPkID='' then '' else @EducationPkID end
	and case when @PositionGroupPkID='' then '' else PG.PositionGroupPkID end = case when @PositionGroupPkID='' then '' else @PositionGroupPkID end
	and case when @CountryPkID='' then '' else A.CountryID end = case when @CountryPkID='' then '' else @CountryPkID end
	and case when @UniversityPkID='' then '' else A.UniversityPkID end = case when @UniversityPkID='' then '' else @UniversityPkID end
	and case when @PositionPkID='' then '' else A.PositionPkID end = case when @PositionPkID='' then '' else @PositionPkID end	
	and case when @BeginDate='' then '' else A.EnterWorkDate end between case when @BeginDate='' then '' else @BeginDate end and case when @BeginDate='' then '' else @EndDate end
END
GO
