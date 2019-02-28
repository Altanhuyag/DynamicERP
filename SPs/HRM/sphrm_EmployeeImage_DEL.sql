IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeImage_DEL')
DROP PROC sphrm_EmployeeImage_DEL
GO
CREATE PROC sphrm_EmployeeImage_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@EmployeeInfoPkID			nvarchar(50),
			@YearPkID					nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	EmployeeInfoPkID			nvarchar(16))
	EXEC sp_xml_removedocument @idoc	
   
    select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	DELETE A
	FROM hrmEmployeeImage A
		INNER JOIN #tmp B ON A.EmployeePkID=B.EmployeeInfoPkID
END
GO
