IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmEmployeeMission_RPT')
DROP PROC sphrm_hrmEmployeeMission_RPT
GO
CREATE PROC sphrm_hrmEmployeeMission_RPT
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

select A.*,P.PositionName, E.FirstName, DI.DepartmentName, E.LastName,F.ConfigValue as Position, H.ConfigValue as EmployeeName  from hrmEmployeeMission A

inner join hrmEmployeeInfo E on A.EmployeeInfoPkID = E.RegisterNo
inner join hrmPositionInfo P on E.PositionPkID = P.PositionPkID
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
