IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Award_PARA')
DROP PROC sphrm_Award_PARA
GO
create proc sphrm_Award_PARA

(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) with encryption

as

begin
SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@StartDate		datetime,
			@EndDate		datetime,
			@IsAward			nvarchar(1),
			@DateIs				nvarchar(1),
			@AwardTypeInfoPkID  nvarchar(16),
			@QueryString nvarchar(max)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( StartDate		datetime,
			   EndDate		datetime,
			   IsAward				nvarchar(1),
			   DateIs				nvarchar(1),
			   AwardTypeInfoPkID	nvarchar(16)
			    )
	EXEC sp_xml_removedocument @idoc

	SELECT @StartDate=StartDate,@EndDate = EndDate ,
	@IsAward = IsAward, @DateIs = DateIs, @AwardTypeInfoPkID = AwardTypeInfoPkID from #tmp
	
	SET @QueryString = 'select 
	A.*,B.AwardName,D.RegisterNo,C.PositionName,D.FirstName+''.''+SUBSTRING(D.LastName,1,1) as FirstName,E.AwardTypeInfoName, 
	A.UserName as EmployeeName from hrmAward A
	inner join hrmAwardInfo B on A.AwardInfoPkID=B.AwardInfoPkID
	inner join hrmEmployeeInfo D on A.EmployeeInfoPkID=D.EmployeeInfoPkID	
	left join hrmPositionInfo C on D.PositionPkID=C.PositionPkID	
	Left join hrmAwardTypeInfo E on A.AwardTypeInfoPkID=E.AwardTypeInfoPkID
	where 1=1 '
	if (isnull(@IsAward,'N')='Y')
		SET @QueryString = @QueryString + ' and A.AwardTypeInfoPkID = '''+@AwardTypeInfoPkID+''''
	if (ISNULL(@DateIs,'N') = 'Y')
		set @QueryString = @QueryString + ' and convert(nvarchar,A.GetCreatedDate,102) between convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@StartDate,102)+'''),102) and convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@EndDate,102)+'''),102)'
	--raiserror(@QueryString,16,1)
	exec(@QueryString)
END
GO
