IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeLetOut_DEL')
DROP PROC sphrm_EmployeeLetOut_DEL
GO
CREATE PROC sphrm_EmployeeLetOut_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@EmployeeLetOutPkID		nvarchar(16),
			@EmployeeInfoPkID		nvarchar(16),
			@YearPkID				nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	EmployeeLetOutPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @EmployeeLetOutPkID=EmployeeLetOutPkID FROM #tmp
	
	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	select @EmployeeInfoPkID = EmployeeInfoPkID from hrmEmployeeLetOut where EmployeeLetOutPkID = @EmployeeLetOutPkID

	DELETE FROM hrmEmployeeLetOut
	where EmployeeLetOutPkID = @EmployeeLetOutPkID

	update hrmEmployeeInfo
	set Status = 1
	where EmployeeInfoPkID = @EmployeeInfoPkID and YearPkID = @YearPkID
	
	END
GO
