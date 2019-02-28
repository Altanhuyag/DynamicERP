
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_ServiceInfo_SEL')
DROP PROC sphtl_ServiceInfo_SEL
GO
CREATE PROC sphtl_ServiceInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	DECLARE @idoc			INT,
	@name nvarchar(150)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	name nvarchar(150) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@name = name
	FROM #tmp

	SELECT ServiceInfoPkID, ServiceName, ServiceDescr, (case when IsChangePrice = N'T' then N'Тийм' else N'Үгүй' end) as IsChangePrice 
	FROM htlServiceInfo WHERE ServiceName like N'%' + @name + '%'

END
GO
