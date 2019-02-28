IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmEmployeeInfoMeasures_RPT')
DROP PROC sphrm_hrmEmployeeInfoMeasures_RPT
GO
CREATE PROC sphrm_hrmEmployeeInfoMeasures_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN

SET NOCOUNT ON
	DECLARE @idoc				INT,
			@StartDate		datetime,
			@FinishDate			datetime,
			@BreachPkID		nvarchar(20)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( StartDate			datetime,
			   FinishDate			datetime,
			   BreachPkID	nvarchar(20) )
	EXEC sp_xml_removedocument @idoc 
	SELECT @StartDate = StartDate, @FinishDate = FinishDate, @BreachPkID = isnull(BreachPkID,'') FROM #tmp

select A.*,BI.BreachName,EI.LastName,EI.FirstName,DI.DepartmentName,H.ConfigValue as EmployeeName,F.ConfigValue as Position,P.PositionName from hrmEmployeeInfoMeasures A
left join hrmBreachInfo BI on A.BreachPkID = BI.BreachPkID
inner join hrmEmployeeInfo EI on A.EmployeeInfoPkID = EI.EmployeeInfoPkID
inner join hrmDepartmentInfo DI on EI.DepartmentPkID = DI.DepartmentPkID
inner join hrmPositionInfo P on EI.PositionPkID = P.PositionPkID
inner join (
select * from smmConstants
where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on EI.Gender = M.ValueNum
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'EmployeeName1') H on M.ModuleID = H.ModuleID
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'PositionName1') F on M.ModuleID = F.ModuleID

where ( convert(nvarchar,A.BeginDate,102) between convert(nvarchar,@StartDate,102) and convert(nvarchar,@FinishDate,102)
or convert(nvarchar,A.EndDate,102) between convert(nvarchar,@StartDate,102) and convert(nvarchar,@FinishDate,102)
or CONVERT(nvarchar,@FinishDate,102) between CONVERT(nvarchar,A.BeginDate,102) and CONVERT(nvarchar,A.EndDate,102)
or CONVERT(nvarchar,@StartDate,102) between CONVERT(nvarchar,A.BeginDate,102) and CONVERT(nvarchar,A.EndDate,102)
or (CONVERT(nvarchar,A.BeginDate,102) between CONVERT(nvarchar,@StartDate,102) and CONVERT(nvarchar,@FinishDate)) and (CONVERT(nvarchar, A.EndDate,102) between CONVERT(nvarchar,@StartDate,102) and CONVERT(nvarchar,@FinishDate,102))
or (CONVERT(nvarchar,@StartDate,102) between CONVERT(nvarchar,A.BeginDate,102) and CONVERT(nvarchar,A.EndDate)) and (CONVERT(nvarchar, @FinishDate,102) between CONVERT(nvarchar,A.BeginDate,102) and CONVERT(nvarchar,A.EndDate,102)))

and case when isnull(@BreachPkID,'') ='' then '' else BI.BreachPkID end = case when isnull(@BreachPkID,'')='' then '' else @BreachPkID end

END

select * from hrmEmployeeInfoMeasures
GO
