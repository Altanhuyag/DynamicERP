IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmEmployeeMovement_RPT')
DROP PROC sphrm_hrmEmployeeMovement_RPT
GO
CREATE PROC sphrm_hrmEmployeeMovement_RPT
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
			@DepartmentPkID			nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( StartDate			datetime,
			FinishDate			datetime, 
			DepartmentPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc 
	SELECT @StartDate=StartDate, @FinishDate = FinishDate, @DepartmentPkID=isnull(DepartmentPkID,'') FROM #tmp
select A.*,P.PositionName,PF.PositionName as OldPosition ,DI.DepartmentName,E.FirstName, E.LastName,F.ConfigValue as Position, H.ConfigValue as EmployeeName,case when OldDepartmentPkID = DI.DepartmentPkID then N'Дотроо шилжсэн' else N'Гадагшаа шилжсэн' end  as Stat from hrmEmployeeMovement A
inner join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
left join hrmPositionInfo PF on A.OldPositionPkID = PF.PositionPkID
inner join hrmEmployeeInfo E on A.EmployeeInfoPKID = E.EmployeeInfoPkID
left join hrmDepartmentInfo DI on E.DepartmentPkID = DI.DepartmentPkID 
inner join (
select * from smmConstants
where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on E.Gender = M.ValueNum
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'EmployeeName1') H on M.ModuleID = H.ModuleID
left join (
select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'PositionName1') F on M.ModuleID = F.ModuleID

where ( convert(nvarchar,A.StartDate,102) between convert(nvarchar,@StartDate,102) and convert(nvarchar,@FinishDate,102)
or convert(nvarchar,A.FinishDate,102) between convert(nvarchar,@StartDate,102) and convert(nvarchar,@FinishDate,102) )


and case when @DepartmentPkID='' then '' else E.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end
END
GO
