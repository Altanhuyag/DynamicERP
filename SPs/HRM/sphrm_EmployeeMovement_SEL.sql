﻿IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeMovement_SEL')
DROP PROC sphrm_EmployeeMovement_SEL
GO
CREATE PROC sphrm_EmployeeMovement_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	select A.*,B.FirstName AS FirstName,C.DepartmentName,C1.DepartmentName as OldDepartmentName,
	D.PositionName, D1.PositionName as OldPositionName, E.ValueStr1 as StatusName,E1.ValueStr1 as OldStatusName from hrmEmployeeMovement A
	inner join hrmEmployeeInfo B on A.EmployeeInfoPKID=B.EmployeeInfoPkID
	left join hrmDepartmentInfo C on A.DepartmentPkID=C.DepartmentPkID
	left join hrmDepartmentInfo C1 on A.OldDepartmentPkID=C1.DepartmentPkID
	left join hrmPositionInfo D on A.PositionPkID=D.PositionPkID
	left join hrmPositionInfo D1 on A.OldPositionPkID=D1.PositionPkID
	
	left join (select * from smmConstants where ConstType='hrmEmployeeStatus') E on A.StatusPkID = E.ConstKey
	left join (select * from smmConstants where ConstType='hrmEmployeeStatus') E1 on A.OldStatusPkID = E1.ConstKey
END



GO
