IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeCause_DEL')
DROP PROC sphrm_EmployeeCause_DEL
GO
CREATE PROC sphrm_EmployeeCause_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@EmployeeCausePkID	nvarchar(16),
			@EmployeeInfoPkID nvarchar(16),
			@YearPkID nvarchar(16),
			@CreatedFormName nvarchar(150)

	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	EmployeeCausePkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @EmployeeCausePkID=EmployeeCausePkID FROM #tmp
	
	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	select @EmployeeInfoPkID = EmployeeInfoPkID,@CreatedFormName = CreatedFormName from hrmEmployeeCause  where EmployeeCausePkID = @EmployeeCausePkID
	
	DELETE FROM hrmEmployeeCause
	where EmployeeCausePkID = @EmployeeCausePkID

	IF (@CreatedFormName = 'frmPregnant')
	BEGIN
		update hrmEmployeeInfo
		set Status=1
		where EmployeeInfoPkID = @EmployeeInfoPkID and YearPkID = @YearPkID
	END
	
	END
GO
