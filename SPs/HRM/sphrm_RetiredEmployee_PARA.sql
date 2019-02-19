IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_RetiredEmployee_PARA')
DROP PROC sphrm_RetiredEmployee_PARA
GO

CREATE PROC sphrm_RetiredEmployee_PARA
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN

	DECLARE @idoc			INT,
			@DepartmentPkID		nvarchar(16),
			@EmployeeInfoPkID nvarchar(16),
			@YearPkID nvarchar(16),
			@IsType nvarchar(1),
			@DateIs nvarchar(1),
			@StartDate datetime,
			@FinishDate datetime

	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(16),
		IsType nvarchar(1),
		DateIs nvarchar(1),
		StartDate datetime,
		FinishDate datetime)
	EXEC sp_xml_removedocument @idoc

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	SELECT @DepartmentPkID=DepartmentPkID,@IsType = IsType,@DateIs = DateIs,@StartDate = StartDate,@FinishDate = FinishDate FROM #tmp
	
	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	SELECT A.*,D.DepartmentName,P.PositionName,PG.PositionGroupName , C.ValueStr1 as MaleName,year(getdate())-year(EI.Birthday) as Age FROM hrmRetiredEmployee A
	inner join hrmEmployeeInfo EI on A.EmployeeInfoPkID = EI.EmployeeInfoPkID and EI.YearPkID = @YearPkID
	inner join hrmDepartmentInfo D on EI.DepartmentPkID = D.DepartmentPkID	
	inner join hrmPositionInfo P on EI.PositionPkID = P.PositionPkID
	inner join hrmPositionGroup PG on P.PositionGroupPkID = PG.PositionGroupPkID
	inner join (select * from smmConstants where ConstType='hrmMaleInfo') as C on EI.Gender = C.ConstKey
	where 1=1
	and case when @IsType = 'Y' then EI.DepartmentPkID else '' end = case when @IsType='Y' then @DepartmentPkID else '' end 	
	and case when @DateIs = 'Y' then Convert(nvarchar,A.CommandDate,102) else getdate() end between case when @DateIs='Y' then convert(nvarchar,@StartDate,102) else getdate() end 	and case when @DateIs='Y' then convert(nvarchar,@FinishDate,102) else getdate() end 	
	
END

GO
