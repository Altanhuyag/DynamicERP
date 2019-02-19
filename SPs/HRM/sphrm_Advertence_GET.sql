IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Advertence_GET')
DROP PROC sphrm_Advertence_GET
GO
CREATE PROC sphrm_Advertence_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@AdvertencePkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( AdvertencePkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	SELECT @AdvertencePkID=AdvertencePkID FROM #tmp
	select 
	A.*,D.RegisterNo,B.AdvertenceName,E.AdvertenceTypeName,E.AdvertenceTypeInfoPkID, C.PositionName,D.FirstName+'.'+SUBSTRING(D.LastName,1,1) as FirstName, 
	A.UserName as EmployeeName from hrmAdvertence A
	inner join hrmAdvertenceInfo B on A.AdvertenceInfoPkID=B.AdvertenceInfoPkID
	inner join hrmEmployeeInfo D on A.EmployeeInfoPkID=D.EmployeeInfoPkID
	left join hrmPositionInfo C on D.PositionPkID=C.PositionPkID	
	left join hrmAdvertenceTypeInfo E on B.AdvertenceTypeInfoPkID=E.AdvertenceTypeInfoPkID
	where A.AdvertencePkID=@AdvertencePkID
END
GO
