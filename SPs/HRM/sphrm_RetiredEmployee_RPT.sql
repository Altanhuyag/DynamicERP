IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_RetiredEmployee_RPT')
DROP PROC sphrm_RetiredEmployee_RPT
GO
CREATE PROC sphrm_RetiredEmployee_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

SET NOCOUNT ON
DECLARE @idoc				INT,			
			@DepartmentPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( DepartmentPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	SELECT @DepartmentPkID=DepartmentPkID FROM #tmp
	select A.*,B.Address,P.PositionName,year(A.CommandDate)as RetiredDate1 ,C.DepartmentName,
	SUBSTRING(B.LastName,1,1)+'.'+B.FirstName as FirstName ,
	H.ConfigValue as Employee , F.ConfigValue as Position
	from hrmRetiredEmployee A
	left join hrmEmployeeInfo B on A.EmployeeInfoPkID=B.EmployeeInfoPkID
	left join hrmPositionInfo P on B.PositionPkID=P.PositionPkID
	inner join (select * from smmConstants
    where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on B.Gender = M.ValueNum
	left join (select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'EmployeeName1') H on M.ModuleID = H.ModuleID
	left join (select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'PositionName1') F on M.ModuleID = F.ModuleID
	left join hrmDepartmentInfo C on B.DepartmentPkID=C.DepartmentPkID
	where case when @DepartmentPkID='' then '' else B.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end

	END
GO
