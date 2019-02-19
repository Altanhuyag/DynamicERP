IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmNewEmployeeInfo_RPT')
DROP PROC sphrm_hrmNewEmployeeInfo_RPT
GO
CREATE PROC sphrm_hrmNewEmployeeInfo_RPT
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

select A.*,DI.DepartmentName,M.ValueStr1,PF.ProfessionName,EI.HandPhone,H.ConfigValue as EmployeeName,F.ConfigValue as Position,P.PositionName,DATEADD(MONTH,-3,getdate()) from hrmEmployeeInfo A

inner join hrmEmployeeInfo EI on A.RegisterNo = EI.RegisterNo
inner join hrmDepartmentInfo DI on EI.DepartmentPkID = DI.DepartmentPkID
inner join hrmPositionInfo P on EI.PositionPkID = P.PositionPkID
left join hrmProfessionInfo PF on EI.ProfessionPkID = PF.ProfessionPkID
inner join (
select * from smmConstants
where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on EI.Gender = M.ValueNum
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'EmployeeName1') H on M.ModuleID = H.ModuleID
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'PositionName1') F on M.ModuleID = F.ModuleID
where convert(nvarchar,A.EnterWorkDate,102) 
between convert(nvarchar,DATEADD(MONTH,-3,getdate()),102)  and convert(nvarchar,GETDATE(),102)
and  case when @DepartmentPkID='' then '' else EI.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end

END
GO
