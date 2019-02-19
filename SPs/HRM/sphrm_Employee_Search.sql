IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Employee_Search')
DROP PROC sphrm_Employee_Search
GO
CREATE PROC sphrm_Employee_Search
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@QueryStr			NVARCHAR(max)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( QueryStr			NVARCHAR(max))
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@QueryStr=QueryStr	FROM #tmp
	
	SELECT A.*, B.NationalityName, C.AimagName, D.PositionName, E.ProfessionName, F.EducationName, G.DepartmentName  FROM hrmEmployeeInfo A
	LEFT JOIN hrmNationalityInfo B ON A.NationalityPkID=B.NationalityPkID
	LEFT JOIN hrmAimagInfo C ON A.AimagID=C.AimagID
	LEFT JOIN hrmPositionInfo D ON A.PositionPkID=D.PositionPkID
	LEFT JOIN hrmProfessionInfo E ON A.ProfessionPkID=E.ProfessionPkID
	LEFT JOIN hrmEducationInfo F ON A.EducationPkID=F.EducationPkID
	LEFT JOIN hrmDepartmentInfo G ON A.DepartmentPkID=G.DepartmentPkID
END
GO
