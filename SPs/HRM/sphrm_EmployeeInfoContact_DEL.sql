IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoContact_DEL')
DROP PROC sphrm_EmployeeInfoContact_DEL
GO
CREATE PROC sphrm_EmployeeInfoContact_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@EmployeeInfoContactPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	EmployeeInfoContactPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @EmployeeInfoContactPkID=EmployeeInfoContactPkID FROM #tmp
	
	DELETE FROM hrmEmployeeInfoContact
	where EmployeeInfoContactPkID = @EmployeeInfoContactPkID
	
	END
GO
