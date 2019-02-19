IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_FieldsInfoFieldName_SEL')
DROP PROC sphrm_FieldsInfoFieldName_SEL
GO
CREATE PROC sphrm_FieldsInfoFieldName_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
SET NOCOUNT ON
	DECLARE @idoc				Int,
			@TableName			nvarchar(255)
--			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  TableName			nvarchar(255))

	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@TableName=TableName	FROM #tmp
	select FieldName,Caption from hrmFieldsInfo 
	where TableName = @TableName	
END
GO
