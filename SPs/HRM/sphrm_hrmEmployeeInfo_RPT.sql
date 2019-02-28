IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmEmployeeInfo_RPT')
DROP PROC sphrm_hrmEmployeeInfo_RPT
GO
CREATE PROC sphrm_hrmEmployeeInfo_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN

SET NOCOUNT ON
	DECLARE @idoc				INT,
			@StartDate			datetime,
			@FinishDate			datetime,
			@DepartmentPkID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	StartDate			datetime,
				FinishDate			datetime, 
				DepartmentPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc 
--RAISERROR(@XML,16,1)
	SELECT @StartDate=StartDate, @FinishDate = FinishDate, @DepartmentPkID=isnull(DepartmentPkID,'') FROM #tmp

select @StartDate as StartDate,@FinishDate as FinishDate,A.FirstName,A.LastName,P.PositionName,PF.ProfessionName, 
A.HandPhone ,M.ValueStr1 as Gender, DI.DepartmentName, A.Birthday, M.ValueStr1 as Gender,
YEAR(GETDATE()) - YEAR(Birthday) as Age, H.ConfigValue as EmployeeName , F.ConfigValue as Position
,((year(Getdate()) - Year(A.NowEnterPositionDate)) + isnull(E.HistoryYear,0)) WorkedYear,
EM.EmployeeInfoPkID,Count(EM.EmployeeInfoPkID) as REG, count(W.EmployeeInfoPkID) as Regs from hrmEmployeeInfo A 
left join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
left join hrmDepartmentInfo DI on A.DepartmentPkID = DI.DepartmentPkID
left join hrmProfessionInfo PF on A.ProfessionPkID = PF.ProfessionPkID
left join hrmEmployeeInfoMeasures EM on A.EmployeeInfoPkID = EM.EmployeeInfoPkID
left join hrmAward W on A.EmployeeInfoPkID = W.EmployeeInfoPkID
left join (
select * from smmConstants
where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on A.Gender = M.ValueNum

left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'EmployeeName1') H on M.ModuleID = H.ModuleID
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'PositionName1') F on M.ModuleID = F.ModuleID

left join hrmEmployeeVacation D on A.EmployeeInfoPkID = D.EmployeeInfoPkID
left join (
select D.EmployeeInfoPkID,Sum(year(D.RemissiveDate)-year(D.NominativeDate)) HistoryYear
				from hrmWorkingHistory D 
				left join hrmEmployeeInfo EI on D.EmployeeInfoPkID=EI.EmployeeInfoPkID
				group by D.EmployeeInfoPkID
			   ) as E on A.EmployeeInfoPkID = E.EmployeeInfoPkID

where --convert(nvarchar,A.EnterWorkDate,102) between convert(nvarchar,@StartDate,102) and convert(nvarchar,@FinishDate,102)
--and 
case when ISNULL(@DepartmentPkID,'')='' then '' else A.DepartmentPkID end = case when ISNULL(@DepartmentPkID,'')='' then '' else @DepartmentPkID end
group by A.FirstName,A.LastName,P.PositionName,PF.ProfessionName, A.HandPhone ,M.ValueStr1, DI.DepartmentName, A.Birthday, M.ValueStr1,YEAR(GETDATE()) - YEAR(Birthday), H.ConfigValue , F.ConfigValue
,((year(Getdate()) - Year(A.NowEnterPositionDate)) + isnull(E.HistoryYear,0)),EM.EmployeeInfoPkID,A.WorkedYear
END
GO
