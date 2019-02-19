IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AgeLimit_RPT')
DROP PROC sphrm_AgeLimit_RPT
GO
CREATE PROC sphrm_AgeLimit_RPT
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
	
	declare @AgeLimitPkID nvarchar(16),
	@QueryString nvarchar(max),
	@String nvarchar(max),
	@i				int

	DECLARE db_cursor CURSOR FOR  
	SELECT AgeLimitInfoPkID FROM hrmAgeLimitInfo 

	OPEN db_cursor   
	FETCH NEXT FROM db_cursor INTO @AgeLimitPkID
	set @QueryString=''
	set @i=0
	WHILE @@FETCH_STATUS = 0   
	BEGIN   
		   set @i=@i+1 
		   SET @QueryString = @QueryString + 'sum(case when A.Gender=''0'' and ALI.AgeLimitInfoPkID='+@AgeLimitPkID+' then 1 else 0 end) as F'+CONVERT(nvarchar,@i)+','
		   SET @QueryString = @QueryString + 'sum(case when ALI.AgeLimitInfoPkID='+@AgeLimitPkID+' then 1 else 0 end) as S'+CONVERT(nvarchar,@i)+','
		   FETCH NEXT FROM db_cursor INTO @AgeLimitPkID  
	END   

	CLOSE db_cursor   
	DEALLOCATE db_cursor
	set @QueryString = SUBSTRING(@QueryString,0,LEN(@QueryString))

	set @String='select A.DepartmentPkID,case when len(DI.DepartmentName)>30 then substring(DI.DepartmentName,0,30) else DI.DepartmentName end DepartmentName,H.ConfigValue as Employee , F.ConfigValue as Position,'+ @QueryString+'
	from hrmEmployeeInfo A
	left join hrmAgeLimitInfo ALI on (Year(getdate())-Year(A.Birthday)) between ALI.Age1 and ALI.Age2
	left join hrmDepartmentInfo DI on A.DepartmentPkID = DI.DepartmentPkID
	inner join (select * from smmConstants
    where ModuleID=''HRM'' and ConstType=''hrmMaleInfo'' ) M on A.Gender = M.ValueNum
	left join (select *  from smmConfig  where ModuleID = ''HRM'' and ConfigID = ''EmployeeName1'') H on M.ModuleID = H.ModuleID
    left join (select *  from smmConfig  where ModuleID = ''HRM'' and ConfigID = ''PositionName1'') F on M.ModuleID = F.ModuleID

	group by A.DepartmentPkID,DI.DepartmentName,H.ConfigValue,F.ConfigValue'
	exec (@String)
END
GO
