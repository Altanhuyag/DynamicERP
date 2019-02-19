IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmHealthStatus_RPT')
DROP PROC sphrm_hrmHealthStatus_RPT
GO
CREATE PROC sphrm_hrmHealthStatus_RPT
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
			@DepartmentPkID			nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( StartDate			datetime,
			FinishDate			datetime, 
			DepartmentPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc 
	SELECT @StartDate=StartDate, @FinishDate = FinishDate, @DepartmentPkID=isnull(DepartmentPkID,'') FROM #tmp
	
select  A.*, EI.LastName,EI.FirstName,M.ValueStr1 as Gender,H.ConfigValue as EmployeeName,F.ConfigValue as Position,DI.DepartmentName,P.PositionName,PT.PatientTypeName, YEAR(GETDATE()) - YEAR(Birthday) as Age, DAY(A.FinishDate)-DAY(A.StartDate) as udur 
,((year(Getdate()) - Year(EI.NowEnterPositionDate)) + isnull(E.HistoryYear,0)) WorkedYear
from hrmHealthStatus A 
inner join hrmEmployeeInfo EI on A.EmployeeInfoPkID = EI.EmployeeInfoPkID
inner join hrmPositionInfo P on EI.PositionPkID = P.PositionPkID
left join hrmDepartmentInfo DI on EI.DepartmentPkID = DI.DepartmentPkID
inner join hrmHealthPatientTypeInfo PT on A.PatientTypePkID = PT.PatientTypePkID
inner join (
select * from smmConstants
where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on EI.Gender = M.ValueNum
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'EmployeeName1') H on M.ModuleID = H.ModuleID
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'PositionName1') F on M.ModuleID = F.ModuleID

left join hrmEmployeeVacation D on EI.EmployeeInfoPkID = D.EmployeeInfoPkID
left join (
select D.EmployeeInfoPkID,Sum(year(D.RemissiveDate)-year(D.NominativeDate)) HistoryYear
				from hrmWorkingHistory D 				
				group by D.EmployeeInfoPkID
			   ) as E on EI.EmployeeInfoPkID = E.EmployeeInfoPkID
where (convert(nvarchar,A.StartDate,102) between convert(nvarchar,@StartDate,102) and convert(nvarchar,@FinishDate,102)
or convert(nvarchar,A.FinishDate,102) between convert(nvarchar,@StartDate,102) and convert(nvarchar,@FinishDate,102))
and case when @DepartmentPkID='' then '' else EI.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end

END

GO
