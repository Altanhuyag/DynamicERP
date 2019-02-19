IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SalaryInfo_DEL')
DROP PROC sphrm_SalaryInfo_DEL
GO
CREATE PROC sphrm_SalaryInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@SalaryInfoPkID nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	SalaryInfoPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc
	
	select @SalaryInfoPkID=SalaryInfoPkID from #tmp

  	DELETE 
	FROM hrmSalaryInfo where SalaryInfoPkID=@SalaryInfoPkID
END
GO
