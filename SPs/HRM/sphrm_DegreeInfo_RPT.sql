IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DegreeInfo_RPT')
DROP PROC sphrm_DegreeInfo_RPT
GO
CREATE PROC sphrm_DegreeInfo_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@DepartmentPkID		nvarchar(250)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(250)
			)
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DepartmentPkID=DepartmentPkID	FROM #tmp
	
	declare @DegreeInfoPkID nvarchar(16),
	@QueryString nvarchar(max),
	@String nvarchar(max),
	@i				int

	DECLARE db_cursor CURSOR FOR  
	SELECT DegreeInfoPkID FROM hrmDegreeInfo 

	OPEN db_cursor   
	FETCH NEXT FROM db_cursor INTO @DegreeInfoPkID
	set @QueryString=''
	set @i=0
	WHILE @@FETCH_STATUS = 0   
	BEGIN   
		   set @i=@i+1 
		   SET @QueryString = @QueryString + 'sum(case when A.Gender=''0'' and ALI.DegreeInfoPkID='+@DegreeInfoPkID+' then 1 else 0 end) as F'+CONVERT(nvarchar,@i)+','
		   SET @QueryString = @QueryString + 'sum(case when ALI.DegreeInfoPkID='+@DegreeInfoPkID+' then 1 else 0 end) as S'+CONVERT(nvarchar,@i)+','
		   FETCH NEXT FROM db_cursor INTO @DegreeInfoPkID  
	END   

	CLOSE db_cursor   
	DEALLOCATE db_cursor
	set @QueryString = SUBSTRING(@QueryString,0,LEN(@QueryString))

	set @String='select A.DepartmentPkID,case when len(DI.DepartmentName)>30 then substring(DI.DepartmentName,0,30) else DI.DepartmentName end DepartmentName,H.ConfigValue as Employee , F.ConfigValue as Position,'+ @QueryString+'

	from hrmEmployeeInfo A
	left join hrmDegree B on A.EmployeeInfoPkID=B.EmployeeInfoPkID
	left join hrmDegreeInfo ALI on B.DegreeInfoPkID=ALI.DegreeInfoPkID
	left join hrmDepartmentInfo DI on A.DepartmentPkID = DI.DepartmentPkID
	inner join (select * from smmConstants
    where ModuleID=''HRM'' and ConstType=''hrmMaleInfo'' ) M on A.Gender = M.ValueNum
	left join (select *  from smmConfig  where ModuleID = ''HRM'' and ConfigID = ''EmployeeName1'') H on M.ModuleID = H.ModuleID
    left join (select *  from smmConfig  where ModuleID = ''HRM'' and ConfigID = ''PositionName1'') F on M.ModuleID = F.ModuleID

	group by A.DepartmentPkID,DI.DepartmentName,H.ConfigValue,F.ConfigValue'
	exec (@String)
END

GO
