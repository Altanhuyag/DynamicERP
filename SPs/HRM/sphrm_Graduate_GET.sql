IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Graduate_GET')
DROP PROC sphrm_Graduate_GET
GO
CREATE PROC sphrm_Graduate_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@GraduatePkID		NVARCHAR(16)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( GraduatePkID			NVARCHAR(16))
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@GraduatePkID=GraduatePkID	FROM #tmp	

	SELECT A.*, B.ProfessionName, C.EducationName , D.UniversityName,E.FirstName,E.RegisterNo,F.CountryName, case when A.IsHighSchool = 'Y' then N'Тийм' else N'Үгүй' end as IsHighSchoolName
	FROM hrmGraduate A 
		INNER JOIN hrmProfessionInfo B ON A.ProfessionPkID=B.ProfessionPkID 
		INNER JOIN hrmEducationInfo C ON A.EducationPkID=C.EducationPkID 
		INNER JOIN hrmUniversityInfo D ON A.UniversityPkID=D.UniversityPkID
		inner join hrmEmployeeInfo E on A.EmployeePkID=E.EmployeeInfoPkID
		inner join hrmCountryInfo F on A.CountryID = F.CountryID
		WHERE A.GraduatePkID=@GraduatePkID
END
GO
