IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_FieldsInfoTableName_SEL')
DROP PROC sphrm_FieldsInfoTableName_SEL
GO
CREATE PROC sphrm_FieldsInfoTableName_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	select TableName,TableNameMon from hrmFieldsInfo 
	group by TableName,TableNameMon
	order by TableName
END
GO
