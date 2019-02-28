IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_RetiredEmployee_DEL')
DROP PROC sphrm_RetiredEmployee_DEL
GO
CREATE PROC sphrm_RetiredEmployee_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@RetiredEmployeePkID		nvarchar(16),
			@EmployeeInfoPkID nvarchar(16),
			@YearPkID nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	RetiredEmployeePkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	SELECT @RetiredEmployeePkID=RetiredEmployeePkID FROM #tmp
	
	select @EmployeeInfoPkID = EmployeeInfoPkID from hrmRetiredEmployee where RetiredEmployeePkID = @RetiredEmployeePkID

	DELETE FROM hrmRetiredEmployee
	where RetiredEmployeePkID = @RetiredEmployeePkID


	update hrmEmployeeInfo set Status =1 where EmployeeInfoPkID = @EmployeeInfoPkID and YearPkID = @YearPkID
	
	END
GO
