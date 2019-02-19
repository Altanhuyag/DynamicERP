IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Expert_SEL')
DROP PROC sphrm_Expert_SEL
GO
CREATE PROC sphrm_Expert_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT a.*, b.FirstName, b.RegisterNo FROM hrmExpert a
	INNER JOIN hrmEmployeeInfo b on b.EmployeeInfoPkID = a.EmployeeInfoPkID
END
GO
