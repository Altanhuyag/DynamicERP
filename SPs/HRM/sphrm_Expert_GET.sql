IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Expert_GET')
DROP PROC sphrm_Expert_GET
GO
CREATE PROC sphrm_Expert_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@ExpertPkID		NVARCHAR(16)
	
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	ExpertPkID			NVARCHAR(16))

	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@ExpertPkID=ExpertPkID 	FROM #tmp	
	
	SELECT a.*, b.FirstName, b.RegisterNo FROM hrmExpert a
	INNER JOIN hrmEmployeeInfo b on b.EmployeeInfoPkID = a.EmployeeInfoPkID
	WHERE a.ExpertPkID=@ExpertPkID
END
GO
