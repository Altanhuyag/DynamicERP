IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Graduate_RPT')
DROP PROC sphrm_Graduate_RPT
GO
CREATE PROC sphrm_Graduate_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@DepartmentPkID		nvarchar(250),
			@RegisterNo			nvarchar(50),
			@Condition			nvarchar(1)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(250)	)
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DepartmentPkID=isnull(DepartmentPkID,'')	FROM #tmp
	
	select A.*,UI.UniversityName,P.ProfessionName,EI.EducationName,E.LastName,E.FirstName,Po.PositionName,DI.DepartmentName,Convert(nvarchar,YEAR(A.EnteredDate))+'-'+convert(nvarchar,YEAR(A.FinishedDate)) as EnteredYear from hrmGraduate A
	inner join hrmUniversityInfo UI on A.UniversityPkID = UI.UniversityPkID
	left join hrmProfessionInfo P on A.ProfessionPkID = P.ProfessionPkID
	inner join hrmEducationInfo EI on A.EducationPkID = EI.EducationPkID
	inner join hrmEmployeeInfo E on A.EmployeePkID = E.EmployeeInfoPkID
	left join hrmPositionInfo Po on E.PositionPkID = Po.PositionPkID
	left join hrmDepartmentInfo DI on E.DepartmentPkID = DI.DepartmentPkID
	where ISNULL(IsHighSchool,'N')='N' and case when @DepartmentPkID='' then '' else E.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end



END
GO
