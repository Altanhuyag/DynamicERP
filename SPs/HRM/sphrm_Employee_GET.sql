IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Employee_GET')
DROP PROC sphrm_Employee_GET
GO
CREATE PROC sphrm_Employee_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@DepartmentPkID		nvarchar(250),
			@SortOrder			nvarchar(150),
			@YearPkID			nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  DepartmentPkID		nvarchar(250))

	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@DepartmentPkID=DepartmentPkID	FROM #tmp
	
	select @SortOrder = SortedOrder from hrmDepartmentInfo where DepartmentPkID = @DepartmentPkID
	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID = 'YearPkID'

	select EI.EmployeeInfoPkID,dbo.fntsh_MinToTime(sum(A.LateTimeMin)) as LateTimeMin into #tmpTime from tshMachineDataCalc A
	inner join tshEnrollUser EU on A.EnrollUserID = EU.EnrollUserID
	inner join hrmEmployeeInfo EI on EU.RegisterNo = EI.RegisterNo	
	where month(Convert(datetime,InCheckDate)) = month(getdate())
	group by EI.EmployeeInfoPkID
	
	IF isnull(@DepartmentPkID,'-') = '-' 
	BEGIN
				SELECT D.DepartmentID,LC.LocationCodeName,A.*,D.DepartmentName,P.PositionName,PG.PositionGroupName , C.ValueStr1 as MaleName,EI.EmployeePicture as ImageFile,year(getdate())-year(A.Birthday) as Age,E.EducationName,C1.ValueStr1 as StatusName FROM hrmEmployeeInfo A
				left join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID	
				left join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
				left join hrmPositionGroup PG on A.PositionGroupPkID = PG.PositionGroupPkID
				left join (select * from smmConstants where ConstType='hrmMaleInfo') as C on A.Gender = C.ConstKey
				left join hrmEmployeeImage EI on A.EmployeeInfoPkID = EI.EmployeePkID
				LEFT JOIN hrmEducationInfo E ON A.EducationPkID = E.EducationPkID
				left join hrmLocationCodeInfo LC on A.LocationCodePkID = LC.LocationCodePkID
				left join (select * from smmConstants where ConstType='hrmEmployeeStatus') as C1 on A.Status = C1.ConstKey
				where A.Status<>1 and A.YearPkID = @YearPkID
	END
    ELSE
				SELECT D.DepartmentID,LC.LocationCodeName,A.*,D.DepartmentName,P.PositionName,PG.PositionGroupName , 
				C.ValueStr1 as MaleName,EI.EmployeePicture as ImageFile,
				year(getdate())-year(A.Birthday) as Age,E.EducationName,
				C1.ValueStr1 as StatusName, DATEDIFF(month, A.ActualEnterJobDate , GETDATE()) as cMonth,isnull(T.LateTimeMin,'00:00') as LateTimeMin FROM hrmEmployeeInfo A
				left join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID	
				left join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
				left join hrmPositionGroup PG on A.PositionGroupPkID = PG.PositionGroupPkID
				left join (select * from smmConstants where ConstType='hrmMaleInfo') as C on A.Gender = C.ConstKey
				left join hrmEmployeeImage EI on A.EmployeeInfoPkID = EI.EmployeePkID
				LEFT JOIN hrmEducationInfo E ON A.EducationPkID = E.EducationPkID
				left join (select * from smmConstants where ConstType='hrmEmployeeStatus') as C1 on A.Status = C1.ConstKey
				left join hrmLocationCodeInfo LC on A.LocationCodePkID = LC.LocationCodePkID
				left join #tmpTime T on A.EmployeeInfoPkID = T.EmployeeInfoPkID
				WHERE A.DepartmentPkID in (select DepartmentPkID from hrmDepartmentInfo where SortedOrder like @SortOrder+'%')
				and A.YearPkID = @YearPkID
				and A.Status = 1
	
END
GO
