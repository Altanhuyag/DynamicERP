IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmEmployeeLetOut_RPT')
DROP PROC sphrm_hrmEmployeeLetOut_RPT
GO
CREATE PROC sphrm_hrmEmployeeLetOut_RPT
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

select A.*,P.PositionName, M.ValueStr1, E.FirstName,PF.ProfessionName, DI.DepartmentName, E.LastName,F.ConfigValue as Position, H.ConfigValue as EmployeeName  
,((year(Getdate()) - Year(E.NowEnterPositionDate)) + isnull(S.HistoryYear,0)) WorkedYear from hrmEmployeeLetOut A

inner join hrmEmployeeInfo E on A.EmployeeInfoPkID = E.EmployeeInfoPkID
inner join hrmPositionInfo P on E.PositionPkID = P.PositionPkID
left join hrmDepartmentInfo DI on E.DepartmentPkID = DI.DepartmentPkID
left join hrmProfessionInfo PF on E.ProfessionPkID = PF.ProfessionPkID
inner join (
select * from smmConstants
where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on E.Gender = M.ValueNum
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
			   ) as S on D.EmployeeInfoPkID = S.EmployeeInfoPkID
WHERE case when @DepartmentPkID='' then '' else E.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end
END
GO
