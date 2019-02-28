IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoMeasures_PARA')
DROP PROC sphrm_EmployeeInfoMeasures_PARA
GO
create proc sphrm_EmployeeInfoMeasures_PARA

(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) with encryption

as

begin
SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@BeginDate		datetime,
			@FinishDate		datetime,
			@IsAlibi			nvarchar(1),
			@DateIs			nvarchar(1),
			@BreachPkID nvarchar(16),
			@QueryString nvarchar(max)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( BeginDate		datetime,
			   FinishDate		datetime,
			   IsAlibi			nvarchar(1),
			   DateIs			nvarchar(1),
			   BreachPkID nvarchar(16)
			    )
	EXEC sp_xml_removedocument @idoc

	SELECT @BeginDate=BeginDate , @FinishDate=FinishDate,
	@IsAlibi = IsAlibi, @DateIs = DateIs, @BreachPkID = BreachPkID from #tmp
	
	SET @QueryString = 'select 
	A.*,B.LastName,B.FirstName AS FirstName,A.UserName as EmployeeName,D.BreachName,E.PositionName,B.RegisterNo from hrmEmployeeInfoMeasures A 
	left join hrmEmployeeInfo As B on A.EmployeeInfoPkID = B.EmployeeInfoPkID	
	left join hrmBreachInfo As D on A.BreachPkID=D.BreachPkID
	left join hrmPositionInfo As E on B.PositionPkID=E.PositionPkID	
	where 1=1 '
	if (isnull(@IsAlibi,'N')='Y')
		SET @QueryString = @QueryString + ' and A.BreachPkID = '''+@BreachPkID+''''
	if (ISNULL(@DateIs,'N') = 'Y')
	set @QueryString = @QueryString + ' and convert(nvarchar,A.CreatedDate,102) between convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@BeginDate,102)+'''),102) and convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@FinishDate,102)+'''),102)'
	--raiserror(@QueryString,16,1)
	exec(@QueryString)
END
GO
