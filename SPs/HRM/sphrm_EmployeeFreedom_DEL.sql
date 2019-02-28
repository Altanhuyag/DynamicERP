IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeFreedom_DEL')
DROP PROC sphrm_EmployeeFreedom_DEL
GO
CREATE PROC sphrm_EmployeeFreedom_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@hrmEmployeeFreedom	nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	EmployeeFreedomPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @hrmEmployeeFreedom=EmployeeFreedomPkID FROM #tmp
	
	DELETE FROM hrmEmployeeFreedom
	where EmployeeFreedomPkID = @hrmEmployeeFreedom
	
	END
GO
