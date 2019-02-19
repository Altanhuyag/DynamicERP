IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeCause_GET')
DROP PROC sphrm_EmployeeCause_GET
GO
CREATE PROC sphrm_EmployeeCause_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@EmployeeCausePkID	nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  EmployeeCausePkID		nvarchar(16))

	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@EmployeeCausePkID=EmployeeCausePkID	FROM #tmp

	select A.*,EI.LastName + N' овогтой '+EI.FirstName as FirstName	from hrmEmployeeCause A
	inner join hrmEmployeeInfo EI on A.EmployeeInfoPkID = EI.EmployeeInfoPkID
	WHERE A.EmployeeCausePkID=@EmployeeCausePkID
	
end
GO
