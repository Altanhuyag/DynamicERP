IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Degree_GET')
DROP PROC sphrm_Degree_GET
GO
CREATE PROC sphrm_Degree_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@DegreePkID			NVARCHAR(16)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( DegreePkID			NVARCHAR(16))
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DegreePkID=DegreePkID	FROM #tmp	
	
	SELECT a.*, b.DegreeInfoName, c.FirstName, c.RegisterNo
	FROM hrmDegree a
	inner join hrmDegreeInfo b on b.DegreeInfoPkID = a.DegreeInfoPkID
	inner join hrmEmployeeInfo c on c.EmployeeInfoPkID = a.EmployeeInfoPkID
END
GO
