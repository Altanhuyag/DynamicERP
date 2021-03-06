﻿IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmEmployeeMovementOut_RPT')
DROP PROC sphrm_hrmEmployeeMovementOut_RPT
GO
CREATE PROC sphrm_hrmEmployeeMovementOut_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN

SET NOCOUNT ON
	DECLARE @idoc				INT,
			@BeginDate			datetime,
			@EndDate			datetime
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( BeginDate			datetime,
			EndDate			datetime )
	EXEC sp_xml_removedocument @idoc 

	SELECT @BeginDate=BeginDate, @EndDate = EndDate FROM #tmp

select A.*,P.PositionName,PF.PositionName as OldPosition ,DI.DepartmentName,E.FirstName, E.LastName,F.ConfigValue as Position, H.ConfigValue as EmployeeName  from hrmEmployeeMovement A

inner join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
left join hrmPositionInfo PF on A.OldPositionPkID = P.PositionPkID
inner join hrmEmployeeInfo E on A.PositionPkID = E.PositionPkID
left join hrmDepartmentInfo DI on E.DepartmentPkID = DI.DepartmentPkID
inner join (
select * from smmConstants
where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on E.Gender = M.ValueNum
inner join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'EmployeeName1') H on M.ModuleID = H.ModuleID
inner join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'PositionName1') F on M.ModuleID = F.ModuleID

where convert(nvarchar,A.StartDate,102) between convert(nvarchar,@BeginDate,102) and convert(nvarchar,@EndDate,102)
or convert(nvarchar,A.FinishDate,102) between convert(nvarchar,@BeginDate,102) and convert(nvarchar,@EndDate,102)

END
GO
