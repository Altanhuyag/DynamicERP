IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoContact_GET')
DROP PROC sphrm_EmployeeInfoContact_GET
GO
CREATE PROC sphrm_EmployeeInfoContact_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	DECLARE @idoc				INT,			
			@EmployeeInfoContactPkID			nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( EmployeeInfoContactPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	SELECT @EmployeeInfoContactPkID=EmployeeInfoContactPkID FROM #tmp
	
	select A.*,B.FirstName,B.LastName,P.PositionName,D.DepartmentName,C.ValueStr1 as StatusName from hrmEmployeeInfoContact A
	left join hrmEmployeeInfo B on A.EmployeeInfoPkID = B.EmployeeInfoPkID
	left join hrmDepartmentInfo D on B.DepartmentPkID = D.DepartmentPkID
	left join hrmPositionInfo P on B.PositionPkID = P.PositionPkID
	left join (select * from smmConstants where ConstType='hrmEmployeeStatus') C on B.Status = C.ConstKey
	where A.EmployeeInfoContactPkID = @EmployeeInfoContactPkID
	
		
END
GO
