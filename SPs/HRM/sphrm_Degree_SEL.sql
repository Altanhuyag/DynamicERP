IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Degree_SEL')
DROP PROC sphrm_Degree_SEL
GO
CREATE PROC sphrm_Degree_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT a.*, b.DegreeInfoName, c.FirstName, c.RegisterNo
	FROM hrmDegree a
	inner join hrmDegreeInfo b on b.DegreeInfoPkID = a.DegreeInfoPkID
	inner join hrmEmployeeInfo c on c.EmployeeInfoPkID = a.EmployeeInfoPkID
END
GO
