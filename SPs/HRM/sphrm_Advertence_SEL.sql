IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Advertence_SEL')
DROP PROC sphrm_Advertence_SEL
GO
CREATE PROC sphrm_Advertence_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	select 
	A.*,B.AdvertenceName,E.AdvertenceTypeName,C.PositionName,D.FirstName+'.'+SUBSTRING(D.LastName,1,1) as FirstName, 
	A.UserName as EmployeeName,D.RegisterNo from hrmAdvertence A
	inner join hrmAdvertenceInfo B on A.AdvertenceInfoPkID=B.AdvertenceInfoPkID
	inner join hrmEmployeeInfo D on A.EmployeeInfoPkID=D.EmployeeInfoPkID
	left join hrmPositionInfo C on D.PositionPkID=C.PositionPkID	
	left join hrmAdvertenceTypeInfo E on B.AdvertenceTypeInfoPkID=E.AdvertenceTypeInfoPkID
	
	
	
    
	 
END
GO
