IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmEmployeeVacation_RPT')
DROP PROC sphrm_hrmEmployeeVacation_RPT
GO
CREATE PROC sphrm_hrmEmployeeVacation_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN

SET NOCOUNT ON
	DECLARE @idoc				INT,
			@cYear		int,
			@DepartmentPkID			nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( cYear			int,			
			DepartmentPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc 

	SELECT @cYear=cYear, @DepartmentPkID=isnull(DepartmentPkID,'') FROM #tmp
select A.*,EI.FirstName,EI.LastName,P.PositionName, DI.DepartmentName, M.ValueStr1 as Gender,YEAR(GETDATE()) - YEAR(Birthday) as Age, H.ConfigValue as EmployeeName, F.ConfigValue as Position 
, ((year(Getdate()) - Year(EI.NowEnterPositionDate)) + isnull(E.HistoryYear,0)) WorkedYear, PF.ProfessionName, EI.HandPhone from hrmEmployeeCause A 

inner join hrmEmployeeInfo EI on A.EmployeeInfoPkID = EI.EmployeeInfoPkID
inner join hrmPositionInfo P on EI.PositionPkID = P.PositionPkID
left join hrmProfessionInfo PF on EI.ProfessionPkID = PF.ProfessionPkID
left join hrmDepartmentInfo DI on EI.DepartmentPkID = DI.DepartmentPkID
inner join (
select * from smmConstants
where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on EI.Gender = M.ValueNum
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'EmployeeName1') H on M.ModuleID = H.ModuleID
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'PositionName1') F on M.ModuleID = F.ModuleID
left join (
select D.EmployeeInfoPkID,Sum(year(D.RemissiveDate)-year(D.NominativeDate)) HistoryYear 
				from hrmWorkingHistory D 
				group by D.EmployeeInfoPkID
			   ) as E on A.EmployeeInfoPkID = E.EmployeeInfoPkID

where Year(A.StartDate) = @cYear
and A.CreatedFormName='frmEmployeeVacation'		  
and case when @DepartmentPkID='' then '' else EI.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end

END
GO
