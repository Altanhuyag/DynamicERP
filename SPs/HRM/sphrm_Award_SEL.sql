IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Award_SEL')
DROP PROC sphrm_Award_SEL
GO
CREATE PROC sphrm_Award_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	select 
	A.*,B.AwardName,D.RegisterNo,C.PositionName,SUBSTRING(D.LastName,1,1)+'.'+ D.FirstName as FirstName,E.AwardTypeInfoName, 
	A.UserName  as EmployeeName from hrmAward A
	inner join hrmAwardInfo B on A.AwardInfoPkID=B.AwardInfoPkID
	inner join hrmEmployeeInfo D on A.EmployeeInfoPkID=D.EmployeeInfoPkID	
	left join hrmPositionInfo C on D.PositionPkID=C.PositionPkID	
	Left join hrmAwardTypeInfo E on A.AwardTypeInfoPkID=E.AwardTypeInfoPkID
END
GO
